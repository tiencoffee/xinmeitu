Country = m.comp do
	oninit: !->
		@country = $countries.list[@attrs.key]
		@country.list = $albums.list.filter (.country is @country)
		@country.total = Math.ceil @country.list.length / @country.chunk

	onremove: !->
		@country.list = void

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
			obj: @country
			page: @
