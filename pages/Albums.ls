Albums = m.comp do
	tilesBar: (page) ->
		* * text: "Trang ngẫu nhiên"
				icon: \shuffle
				onclick: !~>
					index = $random $albums.total - 1
					page.setIndex index

	itemView: (album, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: album.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{album.id}.jpg"
			onload: (event) !~>
				{target} = event
				setTimeout !~>
					target.classList
						..remove \opacity-0
						..add \anim--zoomIn
				, $random 200
			onclick: !~>
				m.route.set "/album/#{album.id}"

	view: ->
		m ListPage,
			obj: $albums
			page: @
