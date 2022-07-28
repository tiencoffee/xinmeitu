Album = m.comp do
	oninit: !->
		@album = $albums.list[@attrs.key]
		@photo = void
		@abort = void
		@err = void
		@loadData!

	loadData: !->
		unless @album.photos.length
			@err = void
			m.redraw!
			@abort = new AbortController
			try
				text = await m.fetch "https://cdn.jsdelivr.net/gh/xinmeitu/main/data/albums/#{@album.id}",
					signal: @abort.signal
			catch @err
				throw
			@album.photos = text.split \\n .map (val, i) ~>
				id: i
				name: val
				loaded: void
				rotate: no
				scroll: void
			m.redraw!
		@setIndex @album.index

	setIndex: (index, noPreload) !->
		if 0 <= index < @album.photos.length
			@album.index = index
			@photo = @album.photos[index]
			unless noPreload
				@preloadImg @photo
				for i from index - 10 to index + 10
					if photo = @album.photos[i]
						@preloadImg photo
			m.redraw!

	preloadImg: (photo, force) !->
		if photo.loaded is void or force
			photo.loaded = 0
			img = new Image
			img.importance = photo is @photo and \high or \low
			img.src = "https://cloud.xinmeitulu.com/WE+cavOf/cayPhu/xQaYcwIngH+Oo03VzszltR5IojpEjQiU8F3RWeiXMrgWOhRLuqTx1gpUQsj7X4sPwmFMH#{photo.name}"
			img.onload = @onloadImg.bind void img, photo
			img.onerror = @onerrorImg.bind void img, photo

	onloadImg: (img, photo, event) !->
		photo.loaded = yes
		photo.rotate = img.width / img.height > 1.2
		if photo.rotate
			width = img.height / img.width * innerHeight
		else
			width = img.width / img.height * innerHeight
		photo.scroll = Math.floor (width - innerWidth) / 2
		if photo is @photo
			m.redraw!

	onerrorImg: (img, photo, event) !->
		photo.loaded = no
		if photo is @photo
			m.redraw!

	onclickViewer: (event) !->
		{x, y} = event
		x2 = x / innerWidth
		y2 = y / innerHeight
		if x > 16 and x2 < 0.33
			if y2 > 0.75
				if @album.index > 0
					$mark 0 innerHeight * 0.75 20 innerHeight / 4
					@setIndex @album.index - 1
			else if y2 > 0.5
				if @album.index < @album.photos.length - 1
					$mark 0 innerHeight / 2 20 innerHeight / 4
					@setIndex @album.index + 1
			else if y2 > 0.25
				not= @photo.rotate

	onscrollViewer: (event) !->
		event.redraw = no
		if @photo.loaded
			if @photo.scroll >= 0
				@photo.scroll = viewerEl.scrollLeft

	onloadPhoto: (event) !->
		event.redraw = no
		if @photo.scroll < 0
			viewerEl.style.paddingLeft = -@photo.scroll + \px
		else
			viewerEl.scrollLeft = @photo.scroll

	onclickPrev: (event) !->
		@setIndex @album.index - 1

	onclickNext: (event) !->
		@setIndex @album.index + 1

	oninputSwiper: (val) !->
		@setIndex val, yes

	onchangeSwiper: (val) !->
		@setIndex val

	onremove: !->
		@abort?abort!

	tilesBar: ->
		* * text: @album.institution.name
				icon: \video
				onclick: !~>
					m.route.set "/institution/#{@album.institution.id}"
			* text: @album.country.name
				icon: \globe
				onclick: !~>
					m.route.set "/country/#{@album.country.id}"
			@album.models.map (model) ~>
				text: model.name or \---
				icon: \person-dress-simple
				onclick: !~>
					m.route.set "/model/#{model.id}"
			@album.tags.map (tag) ~>
				text: tag.name
				icon: \tag
				onclick: !~>
					m.route.set "/tag/#{tag.id}"
			0

	view: ->
		m \.h-full,
			if @photo
				m.fragment do
					m \.w-full.h-full.overflow-auto#viewerEl,
						onclick: @onclickViewer
						onscroll: @onscrollViewer
						switch @photo.loaded
						| yes
							m \img.origin-top-left#photoEl,
								class: m.class do
									"photoEl--rotate-#{@photo.rotate and \yes or \no}"
								src: "https://cloud.xinmeitulu.com/WE+cavOf/cayPhu/xQaYcwIngH+Oo03VzszltR5IojpEjQiU8F3RWeiXMrgWOhRLuqTx1gpUQsj7X4sPwmFMH#{@photo.name}"
								onload: @onloadPhoto
						| no
							m Info,
								icon: \square-exclamation
								text: "Ảnh lỗi"
								action:
									m Tile,
										icon: \rotate-right
										onclick: !~>
											@preloadImg @photo, yes
										"Thử lại"
						| 0
							m Info,
								spin: yes
								icon: \loader
								text: "Đang tải"
						else
							m Info,
								icon: \image
								text: "Chưa tải"
					m Swiper,
						len: @album.photos.length
						value: @album.index
						oninput: @oninputSwiper
						onchange: @onchangeSwiper
			else if @err
				m Info,
					icon: \square-exclamation
					text: "Tải lỗi"
					action:
						m Tile,
							icon: \rotate-right
							onclick: @loadData
							"Thử lại"
			else
				m Info,
					spin: yes
					icon: \loader
					text: "Đang tải"
			m Bar,
				invisible: yes
				prev:
					disabled: @album.index is 0
					onclick: @onclickPrev
				next:
					disabled: @album.index is @album.photos.length - 1
					onclick: @onclickNext
				more:
					text: "#{@album.index + 1} / #{@album.photos.length}"
				tiles: @tilesBar!
