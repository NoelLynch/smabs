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

  filesR = FileSys.readdirSync(args.rootDir + phase.srcDir)

  files = []
  for f in filesR
    if Path.extname(f) is ".less" then files.push { name : Path.basename(f), par : Path.dirname(f), path : Path.dirname(f) + "/" + Path.basename(f) }

  while files.length > 0
    f = files.pop()
    next args, phase, f.name, f.par, f.path

next = (args, phase, name, parDir, fullPath) ->
  compiledFile = parDir + "/" + Path.basename(name, ".less") + ".css"
  console.log "\tcompiling #{fullPath} to #{compiledFile}"
  SMABSUtils.deleteFileIfExists(compiledFile)
  lessF = SMABSUtils.getFileContents(fullPath)

  if lessF is null
    console.log "\t*** Could not read file #{fullPath}, name : #{name}, base : #{parDir}"
    return

  LessC.render lessF, (e, css) ->
    if not css?
      console.log "\t*** Error compiling #{fullPath}, Cause : " + e.toString()
      return
    FileSys.writeFileSync(compiledFile, css)