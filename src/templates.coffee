Wrench = require 'wrench'
Util = require 'util'
FileSys = require 'fs'

saveTemplate = (name, templateDir, fromDir) ->
  console.log "\tSaving template #{name}"
  tmplDir = templateDir + "/" + name
  Wrench.copyDirSyncRecursive(fromDir, tmplDir, {
    forceDelete: true,
    excludeHiddenUnix: true
  })
  console.log "\t...Template saved"

getTemplate = (name, templateDir, toDir) ->
  console.log "\tSaving template #{name}"
  tmplDir = templateDir + "/" + name

  if not FileSys.existsSync(tmplDir)
    console.log "\t...Template does not exist"
    return

  Wrench.copyDirSyncRecursive(tmplDir, toDir, {
    forceDelete: true,
    excludeHiddenUnix: true
  })
  console.log "\t...Template loaded"

checkConf = (conf) ->
  if not conf? then return false

  if not conf.templatesDir?
    console.log "\t*** You must specify a templates directory in the build conf"
    return false

  true

exports.doSaveTemplate = (name, dir, args, conf) ->
  if not checkConf(conf) then return

  if not name? or not dir?
    console.log "\t*** You must specify a name and a directory to create the template from"

  saveTemplate(name, args.rootDir + conf.templatesDir, dir)

exports.doGetTemplate = (name, dir, args, conf) ->
  if not checkConf(conf) then return

  if not name? or not dir?
    console.log "\t*** You must specify a name and a directory to load this template to"

  getTemplate(name, args.rootDir + conf.templatesDir, dir)



