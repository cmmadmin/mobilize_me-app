@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Controller extends App.Controllers.Application
    initialize: (options) ->
      { category } = options

      @layout = @getLayoutView()
      # @categories = App.request "develop_category:entities"
      # @collectionView = @getCollectionView categories

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()
      # @show @collectionView

      @listenTo @layout, "show", =>
        @goalsRegion category.develop_goals()

      @show @layout

      # @show @collectionView
      # scrollComp = App.request "ion:scroll:component", @collectionView
      # @show scrollComp, options

    goalsRegion: (goals) ->
      goalsView = @getGoalsView goals

      scrollComp = App.request "ion:scroll:component", goalsView
      @show scrollComp, region: @layout.goalsRegion

    getGoalsView: (goals) ->
      new LifeList.Goals
        collection: goals

    getLayoutView: ->
      new LifeList.Layout