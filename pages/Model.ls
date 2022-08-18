Model = m.comp do
	oninit: !->
		@model = $models.list[@attrs.key]
		@model.list = $albums.list.filter (album) ~>
			album.models.includes @model
		@model.total = Math.ceil @model.list.length / @model.chunk

	onclickAlbum: (album, page, event) !->
		m.route.set "/album/#{album.id}"
		$addRecent album

	onremove: !->
		@model.list = void

	itemView: (item, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: item.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{item.id}.jpg"
			onload: $onloadAnim
			onclick: @onclickAlbum.bind void item, page

	view: ->
		m ListPage,
			obj: @model
			page: @
