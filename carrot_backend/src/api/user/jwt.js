// const generateToken = require("./jwt");
// exports.register = async (req, res) => {
//   try {
//     const userInfo = { id: 1, name: "홍길동" };
//     const token = await generateToken(userInfo);
//     res.json({ result: "ok", access_token: token });
//   } catch (error) {
//     res.status(500).json({ result: "error", message: "토큰 발급실패" });
//   }
// };
// exports.phone = (req, res) => {
//   res.send("인증번호 발송");
// };
// exports.phoneVerify = (req, res) => {
//   res.send("인증번호 검증");
// };
// exports.show = (req, res) => {
//   res.send("마이페이지");
// };
// exports.update = (req, res) => {
//   res.send("마이페이지 수정");
// };
const jwt = require("jsonwebtoken");
const util = require("util");
// jwt.sign함수를비동기적으로사용할수있게변환
const signAsync = util.promisify(jwt.sign);
const privateKey = process.env.JWT_KEY;
// payload를받아토큰을생성하는함수
async function generateToken(payload) {
  return await signAsync(payload, privateKey);
}
module.exports = generateToken;
