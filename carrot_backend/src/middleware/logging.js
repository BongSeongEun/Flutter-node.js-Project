module.exports = (req, res, next) => {
  let clientIp = req.ip;
  console.log(`${clientIp.replace("::ffff:", "")} : ${req.path}`);
  next();
};
