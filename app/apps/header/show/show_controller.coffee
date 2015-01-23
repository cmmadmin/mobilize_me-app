@MM.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      { navItem } = options
      @layout = @getHeaderView()

      @listenTo @layout, "show", =>
        @leftButtonsRegion navItem.get('leftButtons')
        @rightButtonsRegion navItem.get('rightButtons')

        if navItem.get('showMentee')
          @centerRegion @getMenteeHeaderView()

      @show @layout

    leftButtonsRegion: (buttons) ->
      buttonsView = @getNavButtonsView(buttons)
      @show buttonsView, region: @layout.leftButtonsRegion

    rightButtonsRegion: (buttons) ->
      buttonsView = @getNavButtonsView(buttons)
      @show buttonsView, region: @layout.rightButtonsRegion

    centerRegion: (view) ->
      @show view, region: @layout.centerRegion

    getHeaderView: ->
      new Show.Header

    getNavButtonsView: (buttons) ->
      new Show.NavButtons
        collection: buttons

    getMenteeHeaderView: ->
      mentee = App.request "state:get", "current:mentee"
      new Show.MenteeHeader
        model: mentee