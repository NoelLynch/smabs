FileSys = require "fs"
FindIt = require("findit")
Path = require('path')

exports.getFileContents = (path) ->
  if not FileSys.existsSync(path) then return null

  return FileSys.readFileSync(path, "utf-8")

exports.deleteFileIfExists = (path) ->
  if FileSys.existsSync(path)
    FileSys.unlinkSync(path)

exports.findAllOfType = (rootDir, ext, filesOnly, cb) ->
  extT = ".#{ext}"

  files = FindIt.sync(rootDir)
  for file in files
    nameExt = Path.basename(file)
    if Path.extname(nameExt) is extT
      cb nameExt, Path.dirname(file), file

exports.copyFile = (from, to, overwrite) ->
  if not FileSys.existsSync(from) then return

  if not overwrite and FileSys.existsSync(to) then return

  exports.deleteFileIfExists(to)

  data = FileSys.readFileSync(from)
  FileSys.writeFileSync(to, data)
