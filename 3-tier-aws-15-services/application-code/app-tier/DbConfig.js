const AWS = require('aws-sdk');

const secretsManager = new AWS.SecretsManager({
  region: process.env.AWS_REGION || 'ap-south-1'
});

async function getDatabaseConfig() {
  const secretName = process.env.DB_SECRET_NAME || 'rds-mysql-secret';

  // 1. Try reading from AWS Secrets Manager
  try {
    const data = await secretsManager.getSecretValue({ SecretId: secretName }).promise();
    if ('SecretString' in data) {
      const secrets = JSON.parse(data.SecretString);
      return {
        host: secrets.host || secrets.DB_HOST,
        user: secrets.username || secrets.DB_USER,
        password: secrets.password || secrets.DB_PWD,
        database: secrets.dbname || secrets.DB_DATABASE || secrets.database || 'webappdb'
      };
    }
  } catch (err) {
    console.warn(`Secrets Manager lookup for "${secretName}" failed (${err.message}). Using environment variables.`);
  }

  // 2. Fallback to environment variables
  return {
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'admin',
    password: process.env.DB_PWD || 'SuperadminPassword',
    database: process.env.DB_DATABASE || 'webappdb'
  };
}

module.exports = getDatabaseConfig;
