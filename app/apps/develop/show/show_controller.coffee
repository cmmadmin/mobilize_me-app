@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'develop'
      ]

    initialize: (options) ->
      @layout = @getLayoutView()

      @show @layout

    getLayoutView: ->
      new Show.Layout