const CryptoJS = require('crypto-js');

// Read environment variables
const OIDC_CLIENT_PWD = process.env.OIDC_CLIENT_PWD;
const INTERNAL_SECRET = process.env.INTERNAL_SECRET;

// if (!OIDC_CLIENT_PWD || !INTERNAL_SECRET) {
//   console.error('Error: OIDC_CLIENT_PWD and INTERNAL_SECRET must be provided');
//   process.exit(1);
// }

// Encryption
const encryptedValue = CryptoJS.AES.encrypt(OIDC_CLIENT_PWD, INTERNAL_SECRET).toString();
console.log(`${encryptedValue}`);

// // Decryption (for verification)
// const decryptedValue = CryptoJS.AES.decrypt(encryptedValue, INTERNAL_SECRET).toString(CryptoJS.enc.Utf8);
// console.log(`Decrypted Value: ${decryptedValue}`);


