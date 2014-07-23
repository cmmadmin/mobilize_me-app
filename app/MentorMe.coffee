###
 * Application Bootstrapper
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM = do (Backbone, Marionette) ->

  MentorMe = new Marionette.Application

    currentUser: null

    loginOpen: false

    initEvents: ->
      @vent.bind "authentication:logged_in", ->
        MentorMe.navigate("mentees", true)

      @vent.bind "authentication:logged_out", ->
        MentorMe.navigate(MentorMe.rootRoute, true)
      # @vent.bind 'mentee:addJournalEntry' (e, mentee, data) ->
      #   Mentee = require 'models/Mentee'
      #   JournalEntry = require 'models/JournalEntry'
      #   je = new JournalEntry()
      #   
  MentorMe.rootRoute = "login"

  MentorMe.addRegions
    headerRegion: "#header-region"
    mainRegion:    "#content"
    footerRegion: "#pageFooter"
    promptRegion: "#prompt-region"

  MentorMe.on "initialize:before", (options) ->
    MentorMe.environment = options.environment

  MentorMe.addInitializer ->
    # Import views
    HomePage = MentorMe.Views.HomePage
    
    AppController = MentorMe.Controllers.AppController
    AppLayout = MentorMe.Views.AppLayout

    #Import collections
    Mentees = MentorMe.Collections.Mentees
    Questions = MentorMe.Collections.Questions
    Editions = MentorMe.Collections.Editions
    Lifelists = MentorMe.Collections.Lifelists
    LifelistCategories = MentorMe.Collections.LifelistCategories

    # Initialize collections
    @collections = 
      mentees: new Mentees()
      editions: new Editions()
      develop_categories: new MentorMe.Entities.DevelopCategoriesCollection()
      curriculums: new MentorMe.Entities.DevelopCurriculumsCollection()

      bootstrap: (update) ->
        MentorMe.vent.trigger('bootstrap:loaded')
        @mentees.reset(update.mentees)
        @editions.reset(update.editions)
        @develop_categories.reset(update.develop_categories)
        @curriculums.reset(update.develop_curriculums)

    # TODO: Use proper server bootstrap
    # Bootstrap initial data
    # @collections.mentees.fetch();
    # @collections.questions.fetch();
    ApplicationConfig = MentorMe.Config.ApplicationConfig
    sync = $.ajax(
      url: ApplicationConfig.SERVER_URL + 'users/data'
      context: @collections
    )
    sync.done(@collections.bootstrap, @collections)
    @collections._fetch = sync

    # Initialize views
    # @loginPanel = new LoginPanel()

    @appLayout = new AppLayout(el: "#mentor_me_app")
    # @appLayout.on "render", ->
    #   @mainRegion.show(MentorMe.homePage)

    # TODO: Listen in better place
    @initEvents()

    # Object.freeze? this
  MentorMe.addInitializer ->
    # Load helper for use in views
    MentorMe.Helpers.ViewHelper

    $(document).ajaxError (e, xhr, settings, exception) ->
      if (xhr.status == 401)
        MentorMe.startHistory(silent:true)
        MentorMe.vent.trigger "user:notauthenticated"

  MentorMe.addInitializer ->
    MentorMe.module("HeaderApp").start()
        
  MentorMe.reqres.setHandler "default:region", -> MentorMe.mainRegion
  MentorMe.reqres.setHandler "concern", (concern) -> MentorMe.Concerns[concern]

  MentorMe.on "initialize:after", ->
    # Start Backbone router after bootstrap
    MentorMe.execute "when:fetched", MentorMe.collections, =>
      @startHistory()
      @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  MentorMe.vent.on "header:shown", ->
    _.defer ->
      MentorMe.mainRegion.$el.addClass('with-header')
  MentorMe.vent.on "header:hidden", ->
    _.defer ->
      MentorMe.mainRegion.$el.removeClass('with-header')

  MentorMe
