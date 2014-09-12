https = require('https');

module.exports =
  class Gist

    constructor: ->
      @public = true
      @description = ''
      @files = {}

    create: (cb) ->
      options =
        hostname: 'api.github.com'
        path: '/gists'
        method: 'POST'
        headers:
          'User-Agent': "Atom"

      request = https.request options, (response) ->
        response.setEncoding 'utf8'
        body = ''

        response.on 'data', (data) ->
          body += data
        response.on 'end', ->
          cb JSON.parse(body)

      request.write JSON.stringify @
      request.end()
