@MM.module "DevelopApp", (DevelopApp, App, Backbone, Marionette, $, _) ->

  class DevelopApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:mentee_id/develop/:category": "list"
      "mentees/:mentee_id/develop/:category/:item_id": "show"

  API =
    list: (mentee_id, category) ->
      # App.vent.trigger "nav:choose", "Admin"
      new DevelopApp.List.Controller
        mentee_id: mentee_id
        develop_category: category

    show: (mentee_id, category, item_id) ->
      new DevelopApp.Show.Controller
        mentee_id: mentee_id
        develop_category: category
        item_id: item_id

  App.addInitializer ->
    new DevelopApp.Router
      controller: API

  App.vent.on "develop:world_track:clicked", (mentee, develop_menu_item) ->
    App.navigate "mentees/#{mentee.id}/develop/world_track"
    API.list mentee.id, "world_track"

  App.vent.on "develop:mobilizer_track:clicked", (mentee, develop_menu_item) ->
    App.navigate "mentees/#{mentee.id}/develop/mobilizer_track"
    API.list mentee.id, "mobilizer_track"

  App.vent.on "develop:multiplier_track:clicked", (mentee, develop_menu_item) ->
    App.navigate "mentees/#{mentee.id}/develop/multiplier_track"
    API.list mentee.id, "multiplier_track"

  App.vent.on "develop:show", (mentee, develop_category, model) ->
    category = model.develop_goal().develop_category()
    App.navigate "mentees/#{mentee.id}/develop/#{develop_category}/#{model.id}"
    API.show mentee.id, develop_category, model.id