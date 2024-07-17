//중간에서 처리
//토큰을 받아온다음에 verify 사용
// 토큰검증
const jwt = require("jsonwebtoken");
const privatekey = "my-secret-key";

module.exports = async (req, res, next) => {
  const token = req.header("token");

  jwt.verify(token, process.env.JWT_KEY, function (err, decoded) {
    if (err) {
      return res.send(err);
    }
    req.user = decoded;
    next();
  });
};
