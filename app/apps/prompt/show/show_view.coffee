@MM.module "PromptApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Prompt extends App.Views.Layout
    template: "prompt/show/prompt"
    className: "prompt"

    events: 
      'click': 'hideInfo'

    hideInfo: (e) ->
      $('#prompt-region').hide()