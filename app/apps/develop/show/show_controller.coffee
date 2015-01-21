@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
        # onTap: _.bind(@saveDevelop, @)
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
        @menuRegion @category.develop_goals()

      @show @layout

    headerRegion: (category) ->
      headerView = @getHeaderView (category)
      @show headerView, region: @layout.headerRegion

    menuRegion: (goals) ->
      menuView = @getMenuView goals

      @listenTo menuView, "menu:item:clicked", (args) ->
        console.log args

      scrollComp = App.request "ion:scroll:component", menuView
      @show scrollComp, region: @layout.menuRegion

    getLayoutView: ->
      new Show.Layout

    getHeaderView: (category) ->
      new Show.Header
        model: category

    getMenuView: (goals) ->
      new Show.Menu
        collection: goals

    # saveDevelop: ->
    #   # Get ids of chosen goals and items
    #   chosen_goals = (new App.Entities.DevelopGoalsCollection(App.Entities.DevelopGoal.all().models)).getChosenIds().sort()
    #   chosen_items = (new App.Entities.DevelopItemsCollection(App.Entities.DevelopItem.all().models)).getChosenIds().sort()
    #   active_profile = @mentee.active_profile()
    #   # Get old ids in profiles
    #   old_goals = active_profile.get('develop_goal_ids').sort()
    #   old_items = active_profile.get('develop_item_ids').sort()
    #   # Check if there is a difference
    #   goal_diff = !_.isEqual(chosen_goals, old_goals)
    #   item_diff = !_.isEqual(chosen_items, old_items)
    #   if(goal_diff)
    #     active_profile.set('develop_goal_ids', chosen_goals)
    #   if(item_diff)
    #     active_profile.set('develop_item_ids', chosen_items)
    #   # If so save the new selections to the DB
    #   if goal_diff || item_diff
    #     active_profile.save()
      


    # lifeListRegion: ->
    #   new App.DevelopApp.LifeList.Controller
    #     region: @layout.lifeListRegion
    #     category: @category
    #     # categories: @categories

    # suggestedStepsRegion: ->
    #   new App.DevelopApp.SuggestedSteps.Controller
    #     region: @layout.stepsRegion
    #     goals: @category.develop_goals()
    #     # categories: @categories

    # planRegion: ->
    #   new App.DevelopApp.Plan.Controller
    #     region: @layout.planRegion

    # setupChosen: ->
    #   profile = @mentee.active_profile()
    #   # Chooose goals based on profile develop_goal_ids
    #   goals = (new App.Entities.DevelopGoalsCollection(App.Entities.DevelopGoal.all().models))
    #   goals.clearChosen()
    #   goals.chooseByIds profile.get('develop_goal_ids'), chooseNone: true

    #   # Choose items based on profile develop_item_ids
    #   items = (new App.Entities.DevelopItemsCollection(App.Entities.DevelopItem.all().models))
    #   items.clearChosen()
    #   items.chooseByIds profile.get('develop_item_ids'), chooseNone: true
