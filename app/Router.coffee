App.Router.map ->
	@resource 'home' 
	@resource 'subreddits', ->
		@resource 'subreddit', { path: ':subreddit_id'}, ->
			@resource 'subredditThread', {path: ':subredditthread_id'}

App.SubredditRoute = Ember.Route.extend
	model: (params) ->
		App.Subreddit.find params.subreddit_id

	setupController: (controller, model) ->
		model.loadThreads()
		
	serialize: (model) ->
		{subreddit_id: model.get('id')}

App.SubredditThreadRoute = Ember.Route.extend
	model: (params) ->
		App.SubredditThread.find params.subredditthread_id

	setupController: (controller, model) ->
		#model.loadThreads()
		
	serialize: (model) ->
		{subredditthread_id: model.get('id')}

