Tag = m.comp do
	oninit: !->
		@tag = $tags.list[@attrs.key]
		@tag.list = $albums.list.filter (album) ~>
			album.tags.includes @tag
		@tag.total = Math.ceil @tag.list.length / @tag.chunk

	onclickAlbum: (album, page, event) !->
		m.route.set "/album/#{album.id}"
		$addRecent album

	onremove: !->
		@tag.list = void

	itemView: (item, page) ->
		m \img.w-full.aspect-2-3.object-cover.opacity-0.tap,
			key: item.id
			src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{item.id}.jpg"
			onload: $onloadAnim
			onclick: @onclickAlbum.bind void item, page

	view: ->
		m ListPage,
			obj: @tag
			page: @
