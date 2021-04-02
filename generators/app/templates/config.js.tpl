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
      type: "checkbox",
      name: "features",
      message: "checkbox type",
      choices: [
        {
          name: "value1",
          value: "value1",
          checked: true,
        },
        {
          name: "value2",
          value: "value2",
          checked: true,
        },
      ],
    },
    {
      type: "confirm",
      name: "features2",
      message: "confirm type",
      default: true,
      // when: (answers) => !answers.features.includes("includeBootstrap"),
    },
    {
      type: "input",
      name: "features3",
      message: "input type",
    },
  ],
  filesToRender: [
    {
      input: "package.json.tpl",
      output: "package.json",
    },
  ],
  filesToCopy: [
    {
      when: "typescript",
      input: "tsconfig.json.tpl",
      output: "tsconfig.json",
    },
  ],
  dirsToCreate: [],
};
