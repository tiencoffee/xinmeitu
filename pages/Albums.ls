Albums = m.comp do
	oninit: !->
		@objList = SeededShuffle.shuffle $albums.list, (new Date!toLocaleDateString!), yes

	onclickAlbum: (album, page, event) !->
		m.route.set "/album/#{album.id}"
		$addRecent album

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
			onload: $onloadAnim
			onclick: @onclickAlbum.bind void album, page

	view: ->
		m ListPage,
			obj: $albums
			objList: @objList
			page: @
