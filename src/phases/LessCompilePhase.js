// Generated by CoffeeScript 1.4.0
var FileSys, LessC, Path, SMABSUtils, handlePhaseOptions, next;

FileSys = require("fs");

Path = require("path");

LessC = require("less");

SMABSUtils = require("../SMABSUtils");

handlePhaseOptions = function(phase, args) {
  if (!(phase.options != null)) {
    console.log("\tno options");
  }
};

exports.doPhase = function(phase, args) {
  var f, files, _results;
  if (!(phase.srcDir != null)) {
    console.log("You must specify a source dir for this phase");
    return;
  }
  handlePhaseOptions(phase);
  files = [];
  SMABSUtils.findAllOfType(args.rootDir + phase.srcDir, "less", true, function(name, parDir, fullPath) {
    return files.push({
      name: name,
      par: parDir,
      path: fullPath
    });
  });
  _results = [];
  while (files.length > 0) {
    f = files.pop();
    _results.push(next(args, phase, f.name, f.par, f.path));
  }
  return _results;
};

next = function(args, phase, name, parDir, fullPath) {
  var compiledFile, lessF;
  compiledFile = parDir + "/" + Path.basename(name, ".less") + ".css";
  console.log("\tcompiling " + name + " to " + compiledFile);
  SMABSUtils.deleteFileIfExists(compiledFile);
  lessF = SMABSUtils.getFileContents(fullPath);
  return LessC.render(lessF, function(e, css) {
    return FileSys.writeFileSync(compiledFile, css);
  });
};