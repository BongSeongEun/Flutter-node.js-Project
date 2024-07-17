require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser"); // 서버설정이라 index에서 사용
const hbs = require("express-hbs");
const path = require("path");
const app = express(); // 객체를 만들고 앱이라고 저장
const port = process.env.PORT || 3000; // 포트 출력 저장
//const port = 3001; // 포트 출력 저장
//process.env.PORT 가 없을경우 3000

//핸들바 설정
app.engine(
  "hbs",
  hbs.express4({
    defaultLayout: __dirname + "/views/layouts/web",
  })
);
app.set("view engine", "hbs");
app.set("views", __dirname + "/views");

// public 디렉토리를 서버의 정적파일 이렉토리로 쓰겠다
app.use(express.static("public"));

// 분리된 라우터 파링 로드하는 부분
const router = require("./src/router");

// JSON 형식의 본문을 처리하기 위하나 미들웨이
// post 처리를 위한 body-parser 설정 부분
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 분리된 라우터 파일 로드하는 부분
app.use("/", router);

app.listen(port, () => {
  console.log(`웹서버 구동... ${port}`);
});
