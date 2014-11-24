@MM.module "SnapshotApp", (SnapshotApp, App, Backbone, Marionette, $, _) ->

  class SnapshotApp.Router extends Marionette.AppRouter
    appRoutes:
      "mentees/:id/survey/:survey_id" : "show"

  API =
    show: (mentee_id, survey_id) ->
      new SnapshotApp.Show.Controller
        id: survey_id
        mentee_id: mentee_id


  App.vent.on "snapshot:show", (mentee, survey_id) ->
    App.navigate "mentees/#{mentee.id}/survey/#{survey_id}"
    API.show mentee.id, survey_id

  App.addInitializer ->
    new SnapshotApp.Router
      controller: API