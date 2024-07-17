/* 웹 사이트 들어갈때 보이는 페이지 */
 /**
  * 이용약관, 개인정보 처리방침 동의
  * 정보성 페이지
  * /page/:page 사용법
  * @param page {'terms', 'page'} 중 하나
  */
exports.page = (req, res) => { 
  let name = req.params.name; 
  let content;
  switch (page) {
    case 'terms':
      content = '이용약관';
      break;
    case 'policy':
      content = '개인정보는 아주 중요합니다.';
      break;
  }
  res.send('page.hbs',{content});
//   res.render('page.hbs', { context: content});
  };

 exports.sitemap = (req, res) => {
  res.send('sitemap');
 };