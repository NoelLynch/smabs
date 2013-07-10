FileSys = require("fs")
SMABSFileSys = require("./SMABSUtils")

AssembleFilesPhase = require("./phases/AssembleFilesPhase")
CoffeeScriptCompilePhase = require("./phases/CoffeeScriptCompilePhase")
MinifyJSPhase = require("./phases/MinifyJSPhase")

args = {
  buildJSON : "build.json",
  rootDir : "./",
  target : ""
}

processArgs = ->
  console.log("processing args")
  r = true
  process.argv.forEach((val, idx, array) =>
    switch val
      when "-b" then args.buildJSON = array[idx + 1]
      when "-w" then args.rootDir = array[idx + 1]
      when "-t" then args.target = array[idx + 1]
      when "-h"
        doHelp()
        r = false
  )

  console.log("\targs processing done\n\n")

  r

doHelp = ->
  console.log("\n\n**************************")
  console.log("\n\nsmabs : (SMall Ass Build System)")
  console.log("usage")
  console.log("\t-b filename, specifies the json config file, default is build.json")
  console.log("\t-w working directory, specifies the working directory, default is .")
  console.log("\t-t target name, specifies the target to execute, default can be defined in build.json or else attempts an 'all' target ")
  console.log("\n\n**************************")

getTargetPhases = (name, conf) ->
  if conf.targets[name]? then return conf.targets[name]
  []

run = ->
  console.log("\n\n...smabs starting...\n\n")
  r = processArgs()
  console.log r
  if not r then return

  conf = loadBuildConf()
  if not conf? then return

  #console.log conf

  if args.target.length is 0
    if conf.defaultTarget? then args.target = conf.defaultTarget

  if args.target.length is 0
    console.log "*** You must specify a target either in the build.json or via the command line -t"
    return

  console.log "Running Target : '#{args.target}'\n"

  targetPhases = getTargetPhases(args.target, conf)

  console.log "Target phases #{targetPhases}\n\n"

  for phase in targetPhases
    if conf.phases[phase]?
      p = conf.phases[phase]
      console.log "executing phase '#{phase}' : type = #{p.type}"

      #console.log p

      switch p.type
        when "assemble" then AssembleFilesPhase.doPhase(p, args)
        when "coffeeCompile" then CoffeeScriptCompilePhase.doPhase(p, args)
        when "minifyJS" then MinifyJSPhase.doPhase(p, args)

      console.log "...Phase complete\n\n"
    else
      console.log "\t*** No phase defined for #{phase}"


loadBuildConf = ->
  if not FileSys.existsSync(args.rootDir + args.buildJSON)
    console.log "*** Cannot locate a build config file, usually this is build.json in the working directory, see -h for details"
    return null

  conf = FileSys.readFileSync(args.rootDir + args.buildJSON, "utf8")
  JSON.parse(conf)

run()



