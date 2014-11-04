@MM.module "DevelopApp.SuggestedSteps", (SuggestedSteps, App, Backbone, Marionette, $, _) ->

  class SuggestedSteps.Controller extends App.Controllers.Application
    initialize: (options) ->
      { goals } = options
      # categories or= App.request "develop_category:entities"
      # parentFunc = ->
        # categories
      # chosenCategories = new App.Entities.ChosenDevelopCategoriesCollection(null, parent: parentFunc)

      @layout = @getLayoutView()
      # @collectionView = @getCollectionView(chosenCategories)

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()

      @listenTo @layout, "show", =>
        @goalsRegion goals

      @show @layout
      
      # @show @collectionView
      # scrollComp = App.request "ion:scroll:component", @collectionView
      # @show scrollComp, options

    goalsRegion: (goals) ->
      goalsView = @getGoalsView goals

      scrollComp = App.request "ion:scroll:component", goalsView
      @show scrollComp, region: @layout.goalsRegion

    getGoalsView: (goals) ->
      new SuggestedSteps.Goals
        collection: goals

    getLayoutView: ->
      new SuggestedSteps.Layout