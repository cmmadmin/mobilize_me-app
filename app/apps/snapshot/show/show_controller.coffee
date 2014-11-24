@MM.module "SnapshotApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application
    navItem: ->
      leftButtons: [
        type: 'Back'
      ]
      rightButtons: [        
        type: 'Info'
        promptId: =>
          'snapshot_' + @survey.get('title').toLowerCase().split(' ').join('_')
      ]

    initialize: (options) ->
      { id, mentee_id } = options
      @mentee = App.request "mentees:entity", mentee_id
      @survey = App.Models.Survey.all().get(id)

      @updateProfile @mentee

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @mainRegion @survey

      @show @layout

    mainRegion: (survey) ->
      surveyView = @getSurveyView(survey)

      @listenTo surveyView, 'complete', @completeSurvey
      @listenTo surveyView, 'savenclose', @saveAndCloseSurvey

      @show surveyView, region: @layout.mainRegion

    getLayoutView: ->
      new Show.Layout

    getSurveyView: (survey) ->
      new App.Views.SurveyView
        survey: survey
        title: survey.get('title')
        showCompleteBtn: false

    saveAndCloseSurvey: =>
      profile = MM.request "get:current:profile"
      profile.save()

      Backbone.history.navigate('mentees/' + @mentee.get('id'), trigger: true)

    completeSurvey: =>
      profile = MM.request "get:current:profile"
      profile.save()

    updateProfile: (mentee) ->
      if profile = mentee.active_profile()
        @profileController or= new App.Controllers.ProfileController(profile: profile)
        @profileController.setProfile(profile)
      else
        console.error("Data error: Mentee is missing an active profile")

    closeProfile: ->
      if @profileController
        @profileController.close();
        @profileController = null;