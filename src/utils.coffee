Promise = require 'bluebird'

cp = require 'child_process'
fs = require 'fs-extra'

asar = require 'asar'
path = require 'path'
dot = require 'dot'

module.exports = {

  exec: (cmd, args, options) ->
    # if process.platform isnt 'win32'
    #   args.unshift cmd
    #   cmd = 'wine'
    #
    #   args = args.map (arg) ->
    #     if arg[0] is '/'
    #       path.win32.normalize arg
    #     else
    #       arg

    new Promise (resolve, reject) ->
      cp.execFile cmd, args, options, (error, stdout, stderr) ->
        if error
          reject error
        else
          resolve stdout

  getPackageJson: (appDirectory) ->
    try
      JSON.parse asar.extractFile path.resolve(appDirectory, 'resources', 'app.asar'), 'package.json'
    catch error
      try
        require path.resolve appDirectory, 'resources', 'app', 'package.json'
      catch error
        throw new Error 'Neither the resources/app folder nor the resources/app.asar package were found.'

  getNuSpec: (opts) ->
    template = fs.readFileSync path.resolve __dirname, '..', 'resources', 'template.nuspec'
    template = dot.template template.toString()
    template opts

}
