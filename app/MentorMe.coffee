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
        MentorMe.collections.mentees.fetch()
        MentorMe.router.navigate('/', true)
        $('#tbModal').one 'hidden', ->
          MentorMe.loginPanel.remove()
          MentorMe.loginOpen = false
        $('#tbModal').modal('hide');
      # @vent.bind 'mentee:addJournalEntry' (e, mentee, data) ->
      #   Mentee = require 'models/Mentee'
      #   JournalEntry = require 'models/JournalEntry'
      #   je = new JournalEntry()
      #   
  MentorMe.rootRoute = "#mentees"

  MentorMe.addInitializer ->
    # Import views
    HomePage = MentorMe.Views.HomePage
    LoginPanel = MentorMe.Views.LoginView
    Router = MentorMe.Routers.Router
    
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
      lifelist_categories: new LifelistCategories()
      lifelists: new Lifelists()
      bootstrap: (update) ->
        MentorMe.vent.trigger('bootstrap:loaded')
        @mentees.reset(update.mentees)
        @editions.reset(update.editions)
        @lifelist_categories.reset(update.lifelist_categories)
        @lifelists.reset(update.lifelists)

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
    @loginPanel = new LoginPanel()
    @router = new Router(controller: new AppController())

    @appLayout = new AppLayout(el: "#mentor_me_app")
    # @appLayout.on "render", ->
    #   @mainRegion.show(MentorMe.homePage)

    # TODO: Listen in better place
    @initEvents()

    Object.freeze? this
  MentorMe.addInitializer ->
    # Load helper for use in views
    MentorMe.Helpers.ViewHelper

    $(document).ajaxError (e, xhr, settings, exception) ->
      if (xhr.status == 401)
        application.router.login()

    $(->
      FastClick.attach(document.body);
    )

  MentorMe.on "initialize:after", ->
    # Start Backbone router after bootstrap
    MentorMe.execute "when:fetched", MentorMe.collections, =>
      @startHistory()
      @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  MentorMe
