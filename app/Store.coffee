###
App.CustomAdapter = DS.Adapter.extend
	url: 'http://reddit.com/'
	find: (store, type, id) ->
		if type == App.Subreddit
			$.getJSON "#{@url}r/#{id}.json?jsonp=?", (data) ->
                store.load(type, id, data.data);
				

	findAll: (store, type) ->
		$.getJSON("http://www.reddit.com/r/webdev/.json?jsonp=?", (data) -> console.log data)

App.CustomAdapter.map App.Subreddit,
	children: 
		embedded: 'always'

App.Store = DS.Store.extend
	revision: 12
	adapter: App.CustomAdapter
	###

App.SubredditThread = Ember.Object.extend
	image: (->
		return @url

	).property('url')

App.SubredditThread.reopenClass
	store: {}

	find: (id) ->
		if not @store[id]
			@store[id] = App.SubredditThread.create({id: id})
		@store[id]


App.Subreddit = Ember.Object.extend
	threads: []

	isLoaded: false

	loadThreads: ->
		$.getJSON("http://www.reddit.com/r/#{@id}.json?jsonp=?").then (response) =>
			threads = []
			threads.push(App.SubredditThread.create(child.data)) for child in response.data.children
			@setProperties { threads: threads }
	
App.Subreddit.reopenClass
	store: {}

	find: (id) ->
		if not @store[id]
			@store[id] = App.Subreddit.create({id: id})
		@store[id]


	