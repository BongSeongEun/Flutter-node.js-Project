const express = require("express");
const router = express.Router();

const multer = require("multer");
const upload = multer({ dest: "storage/" });

const verify = require("./middleware/jwtVerify");

const fileController = require("./api/file/controller");

const apiUserController = require("./api/user/controller");
const apiFeedController = require("./api/feed/controller");

//피드
router.get("/api/feed", verify, apiFeedController.index);
router.post("/api/feed", verify, apiFeedController.store);
router.get("/api/feed/:id", verify, apiFeedController.show);
router.put("/api/feed/:id", verify, apiFeedController.update);
router.delete("/api/feed/:id", verify, apiFeedController.destroy);

//사용자
router.post("/api/user/register", apiUserController.register);
router.post("/api/user/login", apiUserController.login);
router.get("/api/user/mypage", verify, apiUserController.mypage);

//파일
router.post("/api/file", upload.single("file"), fileController.upload);
router.get("/api/file/:id", fileController.download);

module.exports = router;

// // index에 들어있는 주소들을 여기로 옮김
// const express = require('express');
// const router = express.Router();
// const logging = require('./middleware/logging');
// const verify = require('./middleware/jwtVerify') //중간 토큰

// const multer = require('multer');
// const upload = multer({ dest: 'storage/'});

// // 웹에서 보여줄 페이지들의 controller
// const webController = require('./web/controller');
// const apiUserController = require('./api/user/controller');
// const apiFeedController = require('./api/feed/controller');
// const fileController = require('./api/file/controller');

// // 웹에서 보여줄 페이지 영역
// router.use(logging);
// router.post('/api/file', upload.single('file'), fileController.upload);
// router.get('./api/file/:id', fileController.download);

// router.get('/page/:page',webController.page);
// router.get('/sitemap', webController.sitemap);

// // 사용자 영역
// router.post('/api/user/register', apiUserController.register);
// router.get('/api/user/:id', apiUserController.userinfo);

// //페이지 영역 verify만 사용가능
// router.get('/api/feed', verify, apiFeedController.index);
// router.post('/api/feed', verify, apiFeedController.store);
// router.get('/api/feed/:id', verify, apiFeedController.show);
// router.post('/api/feed/:id', verify, apiFeedController.update);
// router.post('/api/feed:id/delete', verify, apiFeedController.destroy);

// module.exports = router; // 반드시 붙여줘야 내보낼수있음
