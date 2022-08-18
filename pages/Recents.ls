Recents = m.comp do
	onclickAlbum: (album, page, event) !->
		m.route.set "/album/#{album.id}"
		$addRecent album

	itemView: (album, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: album.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{album.id}.jpg"
			onload: $onloadAnim
			onclick: @onclickAlbum.bind void album, page

	view: ->
		m ListPage,
			obj: $recents
			page: @
