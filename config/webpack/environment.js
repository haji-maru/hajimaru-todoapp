const { environment } = require("@rails/webpacker");

module.exports = environment;

// コンソールに出力
console.log("******** config/webpack/environment.js ********"); // どのファイルから出力されているかわかりやすいように追記
console.log("NODE_OPTIONS:", process.env.NODE_OPTIONS);
console.log("***********************************************");
