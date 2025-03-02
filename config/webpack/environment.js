const { environment } = require("@rails/webpacker");

module.exports = environment;

// コンソールに出力
console.log("******** config/webpack/environment.js ********");
console.log("NODE_OPTIONS:", process.env.NODE_OPTIONS);
console.log("***********************************************");
