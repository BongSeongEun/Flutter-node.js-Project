const { pool } = require("../../database");

exports.index = async (page, size, keyword, category) => {
  const offset = (page - 1) * size;
  let query = `SELECT feed.*, u.name AS user_name, image_id
                FROM feed
                LEFT JOIN user u ON u.id = feed.user_id
                LEFT JOIN files f ON feed.image_id = f.id
                WHERE category = ?`;

  const params = [category];

  if (keyword) {
    query += ` AND (LOWER(feed.title) LIKE ? OR LOWER(feed.content) LIKE ?)`;
    const keywordParam = `%${keyword}%`;
    params.push(keywordParam, keywordParam);
  }

  query += ` ORDER BY feed.id DESC LIMIT ? OFFSET ?`;
  params.push(`${size}`, `${offset}`); // size와 offset을 숫자로 전달

  try {
    const rows = await pool.query(query, params);
    return rows; // 배열로 반환됨
  } catch (error) {
    console.error("Database query error:", error);
    throw error;
  }
};

exports.create = async (user, title, content, price, image, tag, category) => {
  const query = `INSERT INTO feed (user_id, title, content, price, image_id, tag, category) VALUES (?,?,?,?,?,?,?)`;
  const imageId = image === undefined ? null : image;
  return await pool.query(query, [
    `${user}`,
    `${title}`,
    `${content}`,
    0,
    `${imageId}`,
    `${tag}`,
    `${category}`,
  ]);
};

exports.show = async (id) => {
  const query = `SELECT feed.*, u.name user_name, u.profile_id
    user_profile, image_id FROM feed
    LEFT JOIN user u on u.id = feed.user_id
    LEFT JOIN files f1 on feed.image_id = f1.id
    LEFT JOIN files f2 on u.profile_id = f2.id
    WHERE feed.id = ?`;
  let result = await pool.query(query, [id]);
  return result.length < 0 ? null : result[0];
};

exports.update = async (title, content, price, imgid, id, tag, category) => {
  const query = `UPDATE feed SET title = ? ,content = ?, image_id = ?, tag = ?, category = ? WHERE id = ?`;
  return await pool.query(query, [
    `${title}`,
    `${content}`,
    `${imgid}`,
    `${tag}`,
    `${category}`,
    `${id}`,
  ]);
};

exports.delete = async (id) => {
  return await pool.query(`DELETE FROM feed WHERE id = ?`, [id]);
};
