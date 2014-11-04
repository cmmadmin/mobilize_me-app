@MM.module "DevelopApp", (DevelopApp, App, Backbone, Marionette, $, _) ->

  class DevelopApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id/develop": "show"

  API =
    show: (id, category) ->
      # App.vent.trigger "nav:choose", "Admin"
      new DevelopApp.Show.Controller
        mentee_id: id
        develop_category: category

  App.addInitializer ->
    new DevelopApp.Router
      controller: API

  App.vent.on "develop:world_track:clicked", (mentee, develop_menu_item) ->
    App.navigate "mentees/#{mentee.id}/develop/world_track"
    API.show mentee.id, "world_track"

  App.vent.on "develop:mobilizer_track:clicked", (mentee, develop_menu_item) ->
    App.navigate "mentees/#{mentee.id}/develop/mobilizer_track"
    API.show mentee.id, "mobilizer_track"

  App.vent.on "develop:multiplier_track:clicked", (mentee, develop_menu_item) ->
    App.navigate "mentees/#{mentee.id}/develop/multiplier_track"
    API.show mentee.id, "multiplier_track"
