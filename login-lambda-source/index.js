const jwt = require("jsonwebtoken");

exports.handler = async function (event, context, callback) {
  const token = await jwt.sign(
    { data: JSON.parse(event.body) },
    "your-256-bit-secret"
  );
  var response = {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json; charset=utf-8",
    },
    body: JSON.stringify({ status: "success", token }),
  };
  callback(null, response);
};
