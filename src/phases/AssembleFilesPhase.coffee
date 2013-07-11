FileSys = require("fs")
SMABSFileSys = require("../SMABSUtils")

verifyPhase = (phase, args) ->
  if not phase.files? and not phase.dirs?
    console.log("\t*** No files or dirs specified for phase : #{phase.name}")
    return false

  if not phase.dst?
    console.log("\t*** No destination specified for phase : #{phase.name}")
    return false

  return true

handlePhaseOptions = (phase, args) ->
  if not phase.options?
    console.log "\tno options"
    return

  if phase.options.archiveExisting is true
    console.log "\tBacking up existing destination"
    SMABSFileSys.copyFile(args.rootDir + phase.dst, args.rootDir + phase.dst + "_OLD")

  if phase.options.overwriteTarget is true
    console.log "\tDeleting existing destination"
    SMABSFileSys.deleteFileIfExists(args.rootDir + phase.dst)

exports.doPhase = (phase, args) ->
  if not verifyPhase(phase, args) then return false

  handlePhaseOptions(phase, args)

  theTarget = args.rootDir + phase.dst

  if phase.files?
    for part in phase.files
      console.log "\tassembling #{part} into #{phase.dst}"
      partF = FileSys.readFileSync(args.rootDir + part, "utf8")
      FileSys.appendFileSync(theTarget, partF)

  if phase.dirs?
    for dir in phase.dirs
      if dir.src? and dir.ext?
        console.log "\texamining #{args.rootDir + dir.src} for #{dir.ext}"
        SMABSFileSys.findAllOfType(args.rootDir + dir.src, dir.ext, true, (name, dir, path) ->
          console.log "\tassembling #{name} from dir #{dir} into #{phase.dst}"
          partF = FileSys.readFileSync(path, "utf8")
          FileSys.appendFileSync(theTarget, partF)
        )
      else
        console.log "\t*** No src dir or ext specified for dir entry #{dir}"
  else
    console.log "\tNo dirs to load from"

  true
