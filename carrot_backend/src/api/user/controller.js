const { register, find, findId, login } = require("./repository");
const jwt = require("./jwt");
const crypto = require("crypto");
/* 회원 가입 */
exports.register = async (req, res) => {
  const { email, password, name } = req.body;
  let { count } = await find(email);

  if (count > 0) {
    return res.send({ result: "fail", message: "중복된 이메일이 존재합니다." });
  }

  const result = await crypto.pbkdf2Sync(
    password,
    process.env.SALT_KEY,
    50,
    100,
    "sha512"
  );

  const { affectedRows, insertId } = await register(
    email,
    result.toString("base64"),
    name
  );

  if (affectedRows > 0) {
    const data = await jwt.jwtSign({ id: insertId, name });
    res.send({ result: "ok", access_token: data });
  } else {
    res.send({ result: "fail", message: "알 수 없는 오류" });
  }
};

/* 로그인 */
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    console.log("request body : ", req.body);

    // 비밀번호 해싱
    const hashedPassword = crypto
      .pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, "sha512")
      .toString("base64");

    // 로그인 시도
    const item = await login(email, hashedPassword);

    if (!item) {
      res.status(401).json({
        result: "fail",
        message: "일치하는 회원정보가 존재하지않습니다.",
      });
    } else {
      const data = await jwt.jwtSign({ id: item.id, name: item.name });
      res.json({ result: "ok", access_token: data });
    }
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ result: "fail", message: "서버 오류" });
  }
};

/* 마이페이지 */
exports.mypage = async (req, res) => {
  const user = req.user;
  console.log(user);
  const item = await findId(user.id);
  if (item == null) {
    res.send({ result: "fail", message: "알 수 없는 오류" });
  } else {
    res.send({ result: "ok", data: item });
  }
};
// const { register, find } = require("./repository");
// const jwt = require("./jwt");
// const crypto = require("crypto");

// /**회원가입 */
// exports.register = async (req, res) => {
//   const { email, password, name } = req.body;

//   let { count } = await find(email);

//   if (count > 0) {
//     return res.send({
//       result: "fail",
//       message: "중복된 이메일이 존재합니다.",
//     });
//   }

//   const result = await crypto.pbkdf2Sync(
//     password,
//     process.env.SALT_KEY,
//     50,
//     100,
//     "sha512"
//   );

//   const { affectedRows, insertId } = await register(
//     email,
//     result.toString("base64"),
//     name
//   );
//   if (affectedRows > 0) {
//     const data = await jwt.jwtSign({ id: insertId, name });
//     res.send({ access_token: data });
//   } else {
//     res.send({ result: "fail" });
//   }
// };

// // exports.userinfo = (req, res) => {
// //   const id = ctx.params.id;
// //   res.send(`${id} 님의 회원정보`);
// // }

// // /** 사용자 영역 분리 */
// exports.userinfo = (req, res) => {
//   const id = req.params.id;
//   res.send(`${id} 님의 회원정보`);
// };
