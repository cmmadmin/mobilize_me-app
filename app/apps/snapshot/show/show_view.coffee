@MM.module "SnapshotApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "snapshot/show/show_layout"
    className: "full-page padded-page"
      
    regions:
      mainRegion:   "#surveyMain"