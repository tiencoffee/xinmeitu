Model = m.comp do
	oninit: !->
		@model = $models.list[@attrs.key]
		@model.list = $albums.list.filter (album) ~>
			album.models.includes @model
		@model.total = Math.ceil @model.list.length / @model.chunk

	onremove: !->
		@model.list = void

	itemView: (item, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: item.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{item.id}.jpg"
			onload: (event) !~>
				{target} = event
				setTimeout !~>
					target.classList
						..remove \opacity-0
						..add \anim--zoomIn
				, $random 200
			onclick: !~>
				m.route.set "/album/#{item.id}"

	view: ->
		m ListPage,
			obj: @model
			page: @
