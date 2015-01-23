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
      showMentee: true

    initialize: (options) ->
      { mentee_id, develop_category, item_id} = options
      @layout = @getLayoutView()

      @mentee = App.request "mentees:entity", mentee_id
      @develop_item = App.request "develop_item:entity", item_id
      category_name = switch develop_category
        when "world_track" then "World Christian Track"
        when "mobilizer_track" then "Mobilizer Track"
        when "multiplier_track" then "Multiplier Track"
        else ""
      categories = new Backbone.Collection(App.request("develop_category:entities").where(edition_id: @mentee.active_profile().get('edition_id')))
      @category = categories.findWhere(title: category_name)
      @goal = @develop_item.develop_goal()


      @listenTo @layout, "show", =>
        @headerRegion @category
        @goalRegion @goal
        @itemRegion @develop_item
        @footerRegion @mentee

      @show @layout

    headerRegion: (category) ->
      headerView = @getHeaderView category
      @show headerView, region: @layout.headerRegion

    goalRegion: (goal) ->
      goalView = @getGoalView goal
      @show goalView, region: @layout.goalRegion

    itemRegion: (develop_item) ->
      itemView = @getItemView develop_item
      @show itemView, region: @layout.itemRegion

    footerRegion: (mentee) ->
      footerView = @getFooterView mentee
      @show footerView, region: @layout.footerRegion

    getLayoutView: ->
      new Show.Layout

    getHeaderView: (category) ->
      new Show.Header
        model: category

    getGoalView: (goal) ->
      new Show.Goal
        model: goal

    getItemView: (develop_item) ->
      new Show.Item
        model: develop_item

    getFooterView: (mentee) ->
      new Show.Footer
        model: mentee