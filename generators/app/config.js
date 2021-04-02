module.exports = {
  options: {
    "skip-install": {
      desc: "跳过下载node_modules",
      type: Boolean,
      required: false,
    },
  },
  prompts: [
    {
      type: "input",
      name: "appname",
      message: "请输入要生成的 generate 的 name : ",
    },
  ],
  filesToRender: [
    {
      input: "package.json.tpl",
      output: "package.json",
    },
    {
      input: "README.md.tpl",
      output: "README.md",
    },
  ],
  filesToCopy: [
    {
      input: "gitignore.tpl",
      output: ".gitignore",
    },
    {
      input: "npmignore.tpl",
      output: ".npmignore",
    },
    {
      input: "index.js.tpl",
      output: "generators/app/index.js",
    },
    {
      input: "config.js.tpl",
      output: "generators/app/config.js",
    },
  ],
  dirsToCreate: ["generators/app", "generators/app/templates"],
};
