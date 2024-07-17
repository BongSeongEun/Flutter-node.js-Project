// repository와 분리
const repository = require("./repository");

exports.upload = async (req, res) => {
  const file = req.file;

  const { affectedRows, insertId } = await repository.create(
    file.originalname,
    file.path,
    file.size
  );

  if (affectedRows > 0) {
    return res.send({ result: "ok", id: insertId });
  }
  return res.send({ result: "fali" });
};

exports.download = async (req, res) => {
  const { id } = req.params;

  const item = await repository.show(id);

  if (item == null) {
    return res.send({ result: "fail" });
  }
  res.download(item.file_path, item.original_name, (err) => {
    if (err) {
      res.send({ result: "error", message: err.message });
    }
  });
};

// const { pool } = require('../../data/index')

// //비동기 async
// exports.upload = async (req, res) => {
//   const file = req.file;

//   const query = `INSERT INTO files
//   (original_name, file_path, file_size) VALUES (?,?,?)`;

//   /* db라는파일안에 pool이라는 함수 */
//   const { affectedRows, insertId} = await pool(query, [file.originalname, file.path, file.size]);
//   if(affectedRows > 0) {
//     return res.send({ result: 'ok', id: insertId})
//   }
//   return res.send({result: 'fail'})
// };

// /** 직접생각해보고 작성할 수 있어야함 */
// exports.download = async (req, res) => {
//   const { id } = req.params;
//   const result = await pool(`SELECT * FROM files WHERE id = ?`, [id]);
//   if(result.length < 1) {
//     return res.send({result:'fail'})
//   }

//   /** 외울필요없음 */
//   const item = result[0];
//   res.download(item.file_path, item.original_name, (err) => {
//     if (err) {
//       res.send({ result: "error", message: err.message });
//     }
//   });
// }
