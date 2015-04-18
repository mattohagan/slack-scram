module.exports = function (req, res, next) {
  var userName = req.body.user_name;
  var text = req.body.text;
  
  var botPayload = {
    text : 'Yo ' + userName + '!'
  };

  console.log(req.body);

  console.log('---------------');
  console.log(req.body.text);

  // avoid infinite loop
  if (userName !== 'slackbot') {
    return res.status(200).json(botPayload);
  } else {
    return res.status(200).end();
  }
}
