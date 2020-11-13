const jwt = require("jsonwebtoken");

exports.handler = async event => {
  let encodedToken = getEncodedToken(event.authorizationToken);
  try {
    jwt.verify(encodedToken, "your-256-bit-secret");
    return generatePolicy('user', 'Allow', event.methodArn,{
      name: "ali kadir",
      age: 31
    });
  } catch (err) {
    console.log('gelen event ',event);
    console.log(err);
    return generatePolicy('user', 'Deny', event.methodArn);
  }
};

const getEncodedToken = header => {
  return header.split(" ")[1];
};



const generatePolicy = (principalId, effect, resource,context) => {
    var authResponse = {};
    
    authResponse.principalId = principalId;
    if (effect && resource) {
        var policyDocument = {};
        policyDocument.Version = '2012-10-17'; 
        policyDocument.Statement = [];
        var statementOne = {};
        statementOne.Action = 'execute-api:Invoke'; 
        statementOne.Effect = effect;
        statementOne.Resource = resource;
        policyDocument.Statement[0] = statementOne;
        authResponse.policyDocument = policyDocument;
    }
    
    authResponse.context = context;
    return authResponse;
}


const denyAllPolicy = () => {
  return {
    principalId: "*",
    policyDocument: {
      Version: "2012-10-17",
      Statement: [
        {
          Action: "*",
          Effect: "Deny",
          Resource: "*"
        }
      ]
    }
  };
};






const allowPolicy = methodArn => {
  return {
    principalId: "*",
    policyDocument: {
      Version: "2012-10-17",
      Statement: [
        {
          Action: "*",
          Effect: "Allow",
          Resource: "*"
        }
      ]
    },
    context:{
      name: "ali kadir",
      age: 31
    }
  };
};
