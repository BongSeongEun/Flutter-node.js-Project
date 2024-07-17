const repository = require("./respository");

/** 피드 목록 보기  */
exports.index = async (req, res) => {
  const { page = 1, size = 20 } = req.query;
  const items = await repository.index(page, size);
  res.send({ result: "ok", data: items });
};
exports.store = async (req, res) => {
  const body = req.body;
  const user = req.user;
  console.log(user);

  const result = await repository.create(
    user.id,
    body.imageId,
    body.name,
    body.content,
    body.price
  );
  if (result.affectedRows > 0) {
    res.send({ result: "ok", data: result.insertId });
  } else {
    res.send({ result: "fail", message: "오류가 발생하였습니다." });
  }
};
exports.show = async (req, res) => {
  const id = req.params.id;
  const user = req.user;

  const item = await repository.show(id);
  item["is_me"] = user.id == item.user_id;
  res.send({ result: "ok", data: item });
};
exports.update = async (req, res) => {
  const id = req.params.id;
  const body = req.body;
  const user = req.user;
  const item = await repository.show(id);
  if (user.id !== item.user_id) {
    res.send({ result: "fail", message: "타인의 글을 수정할 수 없습니다." });
  }
  const result = await repository.update(
    body.name,
    body.content,
    body.price,
    id
  );
  if (result.affectedRows > 0) {
    res.send({ result: "ok", data: body });
  } else {
    res.send({ result: "fail", message: "오류가 발생하였습니다." });
  }
};
exports.destroy = async (req, res) => {
  const id = req.params.id;
  const user = req.user;
  const item = await repository.show(id);
  const result = await repository.delete(id);
  if (user.id !== item.user_id) {
    res.send({ result: "fail", message: "타인의 글을 삭제 할수 없습니다." });
  } else {
    res.send({ result: "ok", data: id });
  }
};
