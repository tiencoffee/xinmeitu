Country = m.comp do
	oninit: !->
		@country = $countries.list[@attrs.key]
		@country.list = $albums.list.filter (.country is @country)
		@country.total = Math.ceil @country.list.length / @country.chunk

	onclickAlbum: (album, page, event) !->
		m.route.set "/album/#{album.id}"
		$addRecent album

	onremove: !->
		@country.list = void

	itemView: (item, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: item.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{item.id}.jpg"
			onload: $onloadAnim
			onclick: @onclickAlbum.bind void item, page

	view: ->
		m ListPage,
			obj: @country
			page: @
