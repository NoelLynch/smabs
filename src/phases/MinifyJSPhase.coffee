FileSys = require("fs")
UglifyJS = require("uglify-js")
SMABSFileSys = require("../SMABSUtils")
MkDirP = require("mkdirp")

handlePhaseOptions = (phase, args) ->
  if not phase.options?
    console.log "\tno options"
    return

verifyPhase = (phase, args) ->
  if not phase.srcDir?
    console.log "\t*** No srcDir specified for phase, this is the directory to load the js from"
    return false

  if not phase.outDir?
    console.log "\t*** No outDir specified for phase, this is the directory to output the minified js to"
    return false

  true

exports.doPhase = (phase, args) ->
  if not verifyPhase(phase, args) then return false

  handlePhaseOptions(phase, args)

  MkDirP.sync(args.rootDir + phase.outDir)

  SMABSFileSys.findAllOfType(args.rootDir + phase.srcDir, "js", true, (name, dir, path) ->
    console.log "\tMinifying #{name} to "

    outF = args.rootDir + "/" + phase.outDir + "/" + name
    SMABSFileSys.deleteFileIfExists(outF)
    ug = UglifyJS.minify(path)
    #console.log ug

    FileSys.writeFileSync(outF, ug.code)
  )

  true



