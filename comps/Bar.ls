Bar = m.comp do
	oninit: !->
		@isOpen = no

	onbeforeupdate: !->
		@attrs.prev ?= {}
		@attrs.more ?= {}
		@attrs.next ?= {}
		route = m.route.get!
		now = (new Date)toTimeString!substring 0 5
		duration = (new Date performance.now! - 288e5)toTimeString!substring 0 5
		@tiles =
			* text: "Album"
				icon: \album-collection
				disabled: route is \/albums
				onclick: !~>
					m.route.set \/albums
			* text: "Người mẫu"
				icon: \people-dress-simple
				disabled: route is \/models
				onclick: !~>
					m.route.set \/models
			* text: "Tổ chức"
				icon: \camcorder
				disabled: route is \/institutions
				onclick: !~>
					m.route.set \/institutions
			* text: "Thẻ"
				icon: \tags
				disabled: route is \/tags
				onclick: !~>
					m.route.set \/tags
			* text: "#now | #duration"
				icon: \clock
			* text: "Quốc gia"
				icon: \earth-asia
				disabled: route is \/countries
				onclick: !~>
					m.route.set \/countries
		@tiles ++= @parseTiles @attrs.tiles

	parseTiles: (tiles) ->
		tiles = ($castArr tiles ? [])flat!
		tiles2 = []
		size = 0
		for tile in tiles
			if tile?
				if typeof tile is \number
					until size % 3 is tile
						size++
						tiles2.push void
				else if tile.span
					size += tile.span
					tiles2.push tile
				else
					size++
					tiles2.push tile
			else
				size++
				tiles2.push void
		tiles2

	onclickMore: (event) !->
		not= @isOpen

	view: ->
		m \.absolute.bottom-0.w-full,
			class: m.class do
				"opacity-0": @attrs.invisible and not @isOpen
			m \.fixed.bottom-0.w-full.border-t.border-black.flex.bg-gray-800.z-10,
				m Tile,
					disabled: if @isOpen => history.state else @attrs.prev.disabled
					icon: @isOpen and \arrow-left or \angle-left
					onclick: @isOpen and history~back or @attrs.prev.onclick
					@isOpen and "Quay lại" or "Trước"
				m Tile,
					icon: @attrs.more.icon ? "angle-#{@isOpen and \down or \up}"
					onclick: @onclickMore
					@attrs.more.text ? "Thêm"
				m Tile,
					disabled: not @isOpen and @attrs.next.disabled
					icon: @isOpen and \arrow-right or \angle-right
					onclick: @isOpen and history~forward or @attrs.next.onclick
					@isOpen and "Đi tiếp" or "Sau"
			if @isOpen
				m \.fixed.top-0.bottom-24.w-full.flex.items-end.bg-gray-800.bg-opacity-75.anim--overlay,
					m \.w-full.border-t.border-black.bg-gray-800.anim--slideUp,
						m \.grid.grid-cols-3,
							@tiles.map (tile) ~>
								if tile
									m Tile,
										disabled: tile.disabled
										icon: tile.icon
										onclick: tile.onclick and (event) !~>
											@isOpen = no
											tile.onclick event
										tile.text
								else
									m Tile
