Institution = m.comp do
	oninit: !->
		@institution = $institutions.list[@attrs.key]
		@institution.list = $albums.list.filter (.institution is @institution)
		@institution.total = Math.ceil @institution.list.length / @institution.chunk

	onclickAlbum: (album, page, event) !->
		m.route.set "/album/#{album.id}"
		$addRecent album

	onremove: !->
		@institution.list = void

	itemView: (item, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: item.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{item.id}.jpg"
			onload: $onloadAnim
			onclick: @onclickAlbum.bind void item, page

	view: ->
		m ListPage,
			obj: @institution
			page: @
