ListPage = m.comp do
	oninit: !->
		@list = []
		@obj = @attrs.obj
		@page = @attrs.page
		@objList = @attrs.objList or @obj.list
		@setIndex @obj.index

	setIndex: (index) !->
		if 0 <= index < @obj.total
			@obj.index = index
			start = index * @obj.chunk
			end = start + @obj.chunk
			@list = @objList.slice start, end
			m.redraw!

	onclickPrev: (event) !->
		@setIndex @obj.index - 1

	onclickNext: (event) !->
		@setIndex @obj.index + 1

	onchangeSwiper: (val) !->
		@setIndex val

	view: ->
		m \.h-full.flex.items-end,
			m \.mb-24.grid.grid-cols-4,
				@list.map (item) ~>
					@page.itemView item, @
			m Swiper,
				len: @obj.total
				value: @obj.index
				onchange: @onchangeSwiper
			m Bar,
				prev:
					disabled: @obj.index is 0
					onclick: @onclickPrev
				next:
					disabled: @obj.index is @obj.total - 1
					onclick: @onclickNext
				more:
					text: "#{@obj.index + 1} / #{@obj.total}"
				tiles: @page.tilesBar? @
