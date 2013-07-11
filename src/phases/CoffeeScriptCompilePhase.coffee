FileSys = require("fs")
Path = require("path")
CoffeeScript = require("coffee-script")

SMABSFileSys = require("../SMABSUtils")

handlePhaseOptions = (phase, args) ->
  if not phase.options?
    console.log "\tno options"
    return

exports.doPhase = (phase, args) ->
  if not phase.srcDir?
    console.log "You must specify a source dir for this phase"
    return

  handlePhaseOptions(phase)

  SMABSFileSys.findAllOfType(args.rootDir + phase.srcDir, "coffee", true, (name, parDir, fullPath) ->
    compiledFile = parDir + "/" + Path.basename(name, ".coffee") + ".js"
    console.log "\tcompiling #{name} to #{compiledFile}"
    SMABSFileSys.deleteFileIfExists(compiledFile)
    coffeeIn = FileSys.readFileSync(fullPath, "utf8")
    jsOut = CoffeeScript.compile(coffeeIn, { bare : true })

    FileSys.writeFileSync(compiledFile, jsOut)
  )