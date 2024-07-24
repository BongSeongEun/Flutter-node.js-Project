const repository = require("./repository");
exports.index = async (req, res) => {
  if (!req.user || !req.user.id) {
    return res.status(401).json({ result: "error", message: "Unauthorized" });
  }

  const userId = req.user.id;
  const { page = 1, size = 10, keyword = "", category = "" } = req.query;
  const trimmedKeyword = keyword.trim().toLowerCase();
  const trimmedCategory = category.trim().toLowerCase();

  try {
    const items = await repository.index(
      page,
      size,
      trimmedKeyword,
      trimmedCategory
    );

    console.log("Repository returned items:", items); // 디버깅을 위한 로그 유지

    // 데이터가 배열인지 객체인지 확인
    let itemsArray = [];
    if (Array.isArray(items)) {
      itemsArray = items;
    } else if (typeof items === "object" && items !== null) {
      itemsArray = [items];
    } else {
      console.error("Unexpected data format:", items);
      return res.status(500).json({
        result: "error",
        message: "Unexpected data format from repository",
      });
    }

    const modifiedItems = itemsArray.map((item) => ({
      ...item,
      is_me: userId === item.user_id,
    }));
    res.json({ result: "ok", data: modifiedItems });
  } catch (error) {
    console.error("Error fetching feed:", error);
    res.status(500).json({
      result: "error",
      message: "Internal Server Error: " + error.message,
    });
  }
};

exports.store = async (req, res) => {
  const body = req.body;
  const user = req.user;
  const result = await repository.create(
    user.id,
    body.title,
    body.content,
    body.price,
    body.imageId,
    body.tag,
    body.category
  );
  if (result.affectedRows > 0) {
    res.send({ result: "ok", data: result.insertId });
  } else {
    res.send({ result: "fail", message: "오류가발생하였습니다." });
  }
};
exports.show = async (req, res) => {
  const id = req.params.id;
  const user = req.user;
  const item = await repository.show(id);
  const modifiedItem = {
    ...item,
    writer: {
      id: item.user_id,
      name: item.user_name,
      profile_id: item.user_profile,
    },
  };
  delete modifiedItem.user_id;
  delete modifiedItem.user_name;
  delete modifiedItem.user_profile;
  modifiedItem["is_me"] = user.id == item.user_id;
  res.send({ result: "ok", data: modifiedItem });
};
exports.update = async (req, res) => {
  const id = req.params.id;
  const body = req.body;
  const user = req.user;
  const price = 0;
  const item = await repository.show(id);
  if (user.id !== item.user_id) {
    res.send({ result: "fail", message: "타인의글을수정할수없습니다." });
  }
  const result = await repository.update(
    body.title,
    body.content,
    price,
    body.imageId,
    id,
    body.tag,
    body.category
  );
  if (result.affectedRows > 0) {
    res.send({ result: "ok", data: body });
  } else {
    res.send({ result: "fail", message: "오류가발생하였습니다." });
  }
};
exports.delete = async (req, res) => {
  const id = req.params.id;
  const user = req.user;
  const item = await repository.show(id);
  if (user.id !== item.user_id) {
    res.send({ result: "fail", message: "타인의글을삭제할수없습니다." });
  } else {
    await repository.delete(id);
    res.send({ result: "ok", data: id });
  }
};
