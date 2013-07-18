FileSys = require("fs")
Path = require("path")
LessC = require("less")

SMABSUtils = require("../SMABSUtils")

handlePhaseOptions = (phase, args) ->
  if not phase.options?
    console.log "\tno options"
    return

exports.doPhase = (phase, args) ->
  if not phase.srcDir?
    console.log "\t*** You must specify a source dir for this phase"
    return

  handlePhaseOptions(phase)

  files = []
  SMABSUtils.findAllOfType(args.rootDir + phase.srcDir, "less", true, (name, parDir, fullPath) ->
    files.push {
      name : name, par : parDir, path : fullPath
    }
  )
  console.log "\tAbout to compile #{files}"

  while files.length > 0
    f = files.pop()
    next args, phase, f.name, f.par, f.path

next = (args, phase, name, parDir, fullPath) ->
  compiledFile = parDir + "/" + Path.basename(name, ".less") + ".css"
  console.log "\tcompiling #{name} to #{compiledFile}"
  SMABSUtils.deleteFileIfExists(compiledFile)
  lessF = SMABSUtils.getFileContents(fullPath)

  LessC.render lessF, (e, css) ->
    if not css?
      console.log "\t*** " + e.toString()
      return
    FileSys.writeFileSync(compiledFile, css)