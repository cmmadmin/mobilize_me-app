@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.JournalEntry extends Model
    urlRoot: ->
      Collection.serverUrl('mentees') + '/' + @get('mentee_id') + '/journal_entries'

    # TODO: Replace with backbone relational
    mentee: ->
      return App.collections.getOrFetch(@get('mentee_id'))

  Mentee = require('./Mentee')

  JournalEntry.has().one('mentee', 
    model: Mentee
    inverse: 'journal_entries'
  )