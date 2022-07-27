Preload = m.comp do
	oninit: !->
		@count = 0
		@files =
			\countries.txt
			\institutions.txt
			\models.txt
			\tags.txt
			\albums.csv
		@countries =
			zhongguodalumeinyu: "Trung Quốc"
			ribenmeinyu: "Nhật Bản"
			taiwanmeinyu: "Đài Loan"
			hanguomeinyu: "Hàn Quốc"
			taiguomeinyu: "Thái Lan"
			oumeimeinyu: "Âu Mỹ"

	oncreate: !->
		texts = await Promise.all @files.map (file) ~>
			fetch "https://cdn.jsdelivr.net/gh/xinmeitu/main/data/#file"
				.then (.text!)
				.then (text) ~>
					@count++
					m.redraw!
					text
		$countries := @parseText \countries texts.0
		$institutions := @parseText \institutions texts.1
		$models := @parseText \models texts.2
		$tags := @parseText \tags texts.3
		$albums := @parseAlbum texts.4
		m.route document.body, \/albums,
			"/albums": Albums
			"/countries": Countries
			"/institutions": Institutions
			"/models": Models
			"/tags": Tags
			"/album/:key": Album
			"/country/:key": Country
			"/institution/:key": Institution
			"/model/:key": Model
			"/tag/:key": Tag

	parseText: (name, text) ->
		index = 0
		chunk = 20
		list = text
			.split \\n
			.map (val, i) ~>
				id: i
				name: if @[name] => @[name][val] else val
				index: 0
				chunk: 20
				list: void
				total: 0
				thumb: void
		total = Math.ceil list.length / chunk
		{index, chunk, list, total}

	parseAlbum: (text) ->
		index = 0
		chunk = 20
		list = Papa.parse text,
			delimeter: \|
			newline: \\n
			header: yes
			fastMode: yes
		.data
		total = Math.ceil list.length / chunk
		for album, i in list
			album.id = i
			if album.country = $countries.list[album.country]
				album.country.thumb ?= i
			if album.institution = $institutions.list[album.institution]
				album.institution.thumb ?= i
			album.models = album.models
				.split \,
				.filter Boolean
				.map ($models.list.)
			for model in album.models
				$models.list[model.id]?thumb ?= i
			album.tags = album.tags
				.split \,
				.filter Boolean
				.map ($tags.list.)
			for tag in album.tags
				$tags.list[tag.id]?thumb ?= i
			+= album.pic
			album.index = 0
			album.photos = []
		{index, chunk, list, total}

	view: ->
		m Info,
			spin: yes
			icon: \loader
			text: "Đang tải: #@count / #{@files.length}"
