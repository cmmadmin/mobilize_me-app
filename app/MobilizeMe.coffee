###
 * Application Bootstrapper
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###
@MM = do (Backbone, Marionette) ->

  MobilizeMe = new Marionette.Application

    currentUser: null

    loginOpen: false

    initEvents: ->
      # Check for not authenticated errors
      $(document).ajaxError (e, xhr, settings, exception) ->
        if (xhr.status == 401)
          MobilizeMe.vent.trigger "session:notauthenticated"

      @vent.bind "session:loaded", (sessionExists) =>
        @sessionLoaded = true
        if sessionExists
          @goHome() unless @getCurrentRoute()
        else
          @goRoot()
        @hideSplash()

      @vent.bind "authentication:logged_out session:notauthenticated", =>
        @sessionLoaded = true
        MobilizeMe.navigate(MobilizeMe.rootRoute, true) unless @isCurrentRouteRoot()
        @hideSplash()

      $(document).on "pause", =>
        @vent.trigger "app:pause"
      $(document).on "resume", =>
        @vent.trigger "app:resume"
  
    goHome: ->
      # MobilizeMe.startHistory()
      MobilizeMe.navigate("mentees", trigger: true)
    goRoot: ->
      MobilizeMe.navigate(MobilizeMe.rootRoute, true)
    # Are we at home or login page already?
    isCurrentRouteRoot: ->
      Backbone.history.fragment == "home" or Backbone.history.fragment == "login"
    hideSplash: ->
      if @sessionLoaded && @deviceReady
        navigator.splashscreen.hide() if navigator.splashscreen?

  MobilizeMe.rootRoute = "home"

  MobilizeMe.addRegions
    headerRegion: "#header-region"
    mainRegion:    "#content"
    footerRegion: "#pageFooter"
    promptRegion: "#prompt-region"

  MobilizeMe.on "initialize:before", (options) ->
    MobilizeMe.environment = options.environment

  MobilizeMe.addInitializer ->
    # Import views
    # HomePage = MobilizeMe.Views.HomePage
    
    # AppController = MobilizeMe.Controllers.AppController
    AppLayout = MobilizeMe.Views.AppLayout

    # #Import collections
    # Mentees = MobilizeMe.Collections.Mentees
    # Questions = MobilizeMe.Collections.Questions
    # Editions = MobilizeMe.Collections.Editions
    # Lifelists = MobilizeMe.Collections.Lifelists
    # LifelistCategories = MobilizeMe.Collections.LifelistCategories

    # # Initialize collections
    # @collections = 
    #   mentees: new Mentees()
    #   editions: new Editions()
    #   develop_categories: new MobilizeMe.Entities.DevelopCategoriesCollection()
    #   curriculums: new MobilizeMe.Entities.DevelopCurriculumsCollection()

    #   bootstrap: (update) ->
    #     MobilizeMe.vent.trigger('bootstrap:loaded')
    #     @mentees.reset(update.mentees)
    #     @editions.reset(update.editions)
    #     @develop_categories.reset(update.develop_categories)
    #     @curriculums.reset(update.develop_curriculums)

    # TODO: Use proper server bootstrap
    # Bootstrap initial data
    # @collections.mentees.fetch();
    # @collections.questions.fetch();
    

    # Initialize views
    # @loginPanel = new LoginPanel()

    @appLayout = new AppLayout(el: "#mentor_me_app")
    @initEvents()

  MobilizeMe.addInitializer ->
    MobilizeMe.module("HeaderApp").start()

  MobilizeMe.addInitializer ->
    # sync = $.ajax(
    #   url: MobilizeMe.Config.ApplicationConfig.SERVER_URL + 'users/data'
    #   context: @collections
    # )
    # sync.then(@collections.bootstrap, @collections)
    # # sync.then(@goHome, MobilizeMe)
    # @collections._fetch = sync
        
  MobilizeMe.reqres.setHandler "default:region", -> MobilizeMe.mainRegion
  MobilizeMe.reqres.setHandler "concern", (concern) -> MobilizeMe.Concerns[concern]

  MobilizeMe.on "initialize:after", ->
  #   # Start Backbone router after bootstrap
  #   MobilizeMe.execute "when:fetched", MobilizeMe.collections, =>
    @startHistory()

  MobilizeMe.vent.on "header:shown", ->
    _.defer ->
      MobilizeMe.mainRegion.$el.addClass('with-header')
  MobilizeMe.vent.on "header:hidden", ->
    _.defer ->
      MobilizeMe.mainRegion.$el.removeClass('with-header')

  # Wait for device to be ready
  $(document).on "deviceready", ->
    MobilizeMe.deviceReady = true
    MobilizeMe.hideSplash()

  MobilizeMe
