@MM.module "DevelopApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: 'develop'
      ]

    initialize: (options) ->
      { mentee_id, develop_category } = options
      @layout = @getLayoutView()

      @mentee = App.request "mentees:entity", mentee_id 
      category_name = switch develop_category
        when "world_track" then "World Christian Track"
        when "mobilizer_track" then "Mobilizer Track"
        when "multiplier_track" then "Multiplier Track"
        else ""
      categories = new Backbone.Collection(App.request("develop_category:entities").where(edition_id: @mentee.active_profile().get('edition_id')))
      @category = categories.findWhere(title: category_name)

      @listenTo @layout, "show", =>
        @headerRegion @category
        @menuRegion @mentee, develop_category, @category.develop_goals()

      @show @layout

    headerRegion: (category) ->
      headerView = @getHeaderView (category)
      @show headerView, region: @layout.headerRegion

    menuRegion: (mentee, develop_category, goals) ->
      menuView = @getMenuView goals

      @listenTo menuView, "menu:item:clicked", (model) ->
        App.vent.trigger "develop:show", mentee, develop_category, model

      scrollComp = App.request "ion:scroll:component", menuView
      @show scrollComp, region: @layout.menuRegion

    getLayoutView: ->
      new List.Layout

    getHeaderView: (category) ->
      new List.Header
        model: category

    getMenuView: (goals) ->
      new List.Menu
        collection: goals