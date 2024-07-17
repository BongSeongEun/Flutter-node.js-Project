const { pool } = require("../../data");
exports.index = async (page, size) => {
  const offset = (page - 1) * size;
  const query = `SELECT feed.*, u.name user_name, image_id FROM feed
 LEFT JOIN user u on u.id = feed.user_id
 LEFT JOIN files f on feed.image_id = f.id
 ORDER BY feed.id DESC
 LIMIT ? OFFSET ?`;
  return await pool(query, [size, offset]);
};
exports.create = async (user, image, name, content, price) => {
  const query = `
    INSERT INTO feed (user_id, image_id, name, content, price)
    VALUES (?, ?, ?, ?, ?)
  `;
  return await pool(query, [user, image, name, content, price]);
};
exports.show = async (id) => {
  const query = `SELECT feed.*, u.name user_name, image_id FROM feed
 LEFT JOIN user u on u.id = feed.user_id
 LEFT JOIN files f on feed.image_id = f.id
 WHERE feed.id = ?`;
  let result = await pool(query, [id]);
  return result.length < 0 ? null : result[0];
};
exports.update = async (name, content, price, id) => {
  const query = `UPDATE feed SET name = ? ,content = ?, price = ? WHERE id = ?`;
  return await pool(query, [name, content, price, id]);
};
exports.delete = async (id) => {
  return await pool(`DELETE FROM feed WHERE id = ?`, [id]);
};
