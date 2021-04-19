const Generator = require("yeoman-generator");
const remote = require("yeoman-remote");
const config = require("./config.js");
const mkdirp = require("mkdirp");
const path = require("path");
const _ = require("lodash");

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    // This method adds support for a `--babel` flag
    for (let optionName in config.options) {
      this.option(optionName, config.options[optionName]);
    }

    // This makes `appname` a required argument.
    this.argument("appname", {
      type: String,
      required: false,
    });

    // this.config.set("appname", this.options.appname);

    // this.fs.read(this.templatePath('__tests__/index.js'));
    // this.pkg = this.fs.readJSON(this.destinationPath('package.json'), {});
    // this.fs.exists(this.destinationPath('.babelrc'))
    // JSON.parse(this.fs.read(this.destinationPath('.babelrc')))
    // this.fs.write(this.destinationPath('.babelrc'), (JSON.stringify(result) + '\n'));
    // this.fs.writeJSON('package.json', _.merge(pkgJsonFields, this.pkg));
  }

  prompting() {
    return this.prompt(config.prompts).then((answers) => {
      this.answers = answers;

      // this.config.set("typescript", this.answers.typescript);
      // this.config.set("react", this.answers.react);
    });
  }

  writing() {
    const templateData = {
      appname: this.options.appname || this.appname, // Default to current folder name
      typescript: this.answers.typescript,
    };
    // from github
    const copy = (input, output) => {
      this.fs.copy(
        // this.templatePath(input),
        input,
        this.destinationPath(output)
        // this.destinationRoot()
      );
    };
    // from local template using EJS
    const copyTpl = (input, output, data) => {
      this.fs.copyTpl(
        this.templatePath(input),
        this.destinationPath(output),
        data
      );
    };

    // Make Dirs
    config.dirsToCreate.forEach((item) => {
      mkdirp(item);
    });

    // Merge Files
    config.filesToMerge.forEach((file) => {
      let fileJSON = this.fs.readJSON(file.file);
      fileJSON = _.merge(fileJSON, file.default || {});
      for (let keyData in templateData) {
        if (templateData[keyData] && file[keyData])
          fileJSON = _.merge(fileJSON, file[keyData] || {});
      }
      this.fs.writeJSON(file.file, fileJSON);
    });

    // Render Files
    config.filesToRender.forEach((file) => {
      if (!file.if || templateData[file.if]) {
        copyTpl(file.input, file.output, templateData);
      }
    });

    // Get Remote Templates
    var done = this.async();
    remote("Zhang-Ying-Zi", "generator-zyz-<%= appname %>-source", (err, cachePath) => {
      // Copy Files
      config.filesToCopy.forEach((file) => {
        if (!file.if || templateData[file.if]) {
          copy(path.join(cachePath, file.input), file.output);
        }
      });

      done();
    });
  }

  install() {
    if (!this.options["skip-install"]) {
      this.npmInstall();
    }
  }
};
