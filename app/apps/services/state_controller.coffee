MM.module "ServicesApp", (Services, App, Backbone, Marionette, $, _) ->

  class Services.State extends App.Controllers.Application

    initialize: ->
      @_initState()
      @_initEvents()

    _initState: ->
      @state = {
        "current:mentee": null
      }

    _initEvents: ->
      App.commands.setHandler "state:set", _.bind(@set, @)
      App.reqres.setHandler "state:get", _.bind(@get, @)
      App.commands.setHandler "state:reset", @_initState
      App.vent.on "mentee:selected", (model) =>
        @set "current:mentee", model

    set: (key, value) ->
      @state[key] = value

    get: (key) ->
      console.log "state: ", @state
      @state[key]
