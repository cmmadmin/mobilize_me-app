@MM.module "DevelopApp.LifeList", (LifeList, App, Backbone, Marionette, $, _) ->

  class LifeList.Controller extends App.Controllers.Application
    initialize: (options) ->
      { categories } = options
      # @categories = App.request "develop_category:entities"
      @collectionView = @getCollectionView categories

      # @listenTo @collectionView, 'childview:category:toggled', ->
      #   scrollComp.getMainView().resize()
      # @show @collectionView

      # @show @collectionView
      scrollComp = App.request "ion:scroll:component", @collectionView
      @show scrollComp, options

    getCollectionView: (categories) ->
      new LifeList.Categories
        collection: categories