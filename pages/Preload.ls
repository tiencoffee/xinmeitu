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
		@tags =
			hunsha: "váy cưới"
			yongzhuang: "áo tắm"
			laladui: "cổ vũ"
			ribenshaofu: "thiếu nữ Nhật Bản"
			qipao: "sườn xám"
			jiepai: "ảnh đường phố"
			hefu: "kimono"
			qingchun: "thiếu niên"
			meitun: "mông đẹp"
			chenshan: "áo sơ mi"
			feitun: "mông mập"
			keai: "dễ thương"
			gudian: "cổ điển"
			laoshi: "giáo viên"
			shuishoufu: "bộ đồ thủy thủ"
			lanqiu: "bóng rổ"
			baoru: "vú to"
			waipai: "xa xứ"
			taiqiu: "bi-a"
			wumei: "quyến rũ"
			banluoyouwu: "nửa khỏa thân"
			ruanmei: "cô gái mềm mại"
			heiren: "người da đen"
			mingxing: "minh tinh"
			zazhi: "tạp chí"
			meitunshaofu: "thiếu nữ mông đẹp"
			liaokao: "xiềng xích"
			xinnian: "năm mới"
			gaogui: "cao quý"
			qingqumaoyi: "mại dâm"
			tianmei: "ngọt ngào"
			jipin: "xuất sắc"
			qingxin: "tươi mới"
			jinfa: "tóc vàng"
			changtongwa: "tất chân"
			buzhihuowucos: "cosplay Shiranui Mai"
			jianshenmeinyu: "người đẹp tập thể dục"
			yangguang: "ánh nắng"
			jiepaisiwa: "tất đường phố"
			hushizhifu: "đồng phục y tá"
			xueshengzhifu: "đồng phục học sinh"
			baisiluoli: "loli đồ trắng"
			heisiluoli: "loli đồ đen"
			yanjingniang: "cô gái đeo kính"
			qingquneiyi: "nội y"
			xingganmeinyu: "người đẹp gợi cảm"
			shaofu: "thiếu nữ"
			rentiyishu: "nghệ thuật cơ thể"
			siwazhifu: "đồng phục bít tất"
			heisiyouhuo: "lụa đen cám dỗ"
			qingchunshaonyu: "cô gái tuổi teen"
			ticaofu: "bộ đồ thể dục"
			qiaotun: "mông"
			qingquzhifu: "đồng phục sexy"
			chaoduanqun: "váy ngắn"
			bailingliren: "người đẹp cổ áo trắng"
			lianyiqun: "váy đầm"
			gaochayongzhuang: "áo tắm ngã ba cao"
			heisimeitui: "chân lụa màu đen"
			bangongshi: "văn phòng"
			duanfa: "tóc ngắn"
			meichuniang: "đầu bếp xinh đẹp"
			jiepaimeitui: "chân dài đường phố"
			gaogen: "giày cao gót"
			jinshenku: "quần ôm sát chân"
			jiemeihua: "hai chị em"
			yundongzhuang: "quần áo thể thao"
			zhiyezhuang: "trang phục công sở"
			haibianmeinyu: "người đẹp bên bờ biển"
			changqun: "váy dài"
			shishangmeinyu: "thời trang đẹp"
			qingqusiwa: "tất sexy"
			zhangtuimeinyu: "gái xinh hở chân"
			zhifu: "đồng phục"
			fengman: "đầy đặn"
			meitui: "chân đẹp"
			bijini: "bikini"
			ribenzhifu: "đồng phục Nhật Bản"
			weimei: "xinh đẹp"
			shengdan: "giáng sinh"
			hongsesiwa: "tất đỏ"
			ribenmengmeizi: "gái xinh Nhật Bản"
			ribenbijini: "bikini Nhật Bản"
			baotunqunmeinyu: "phụ nữ trong váy bó hông"
			siwaduanqun: "váy tất chân"
			changfameinyu: "người đẹp tóc dài"
			kongjiezhifu: "đồng phục tiếp viên"
			yisheng: "bác sĩ"
			heisizhifu: "đồng phục lụa đen"
			pingxiong: "ngực lép"
			yangyan: "quyến rũ"
			meixiong: "vẻ đẹp ngực"
			qingchunhushizhifu: "đồng phục y tá thuần túy"
			huwaimeinyu: "người đẹp ngoài trời"
			siwafeitun: "tất mông to"
			jiepaigaogen: "giày cao gót đường phố"
			zhongguobijinimeinyu: "người đẹp bikini Trung Quốc"
			zuqiubaobei: "em bé bóng đá"
			showgirl: "gái show"
			meishaonyu: "cô gái xinh đẹp"
			jiepaimeitun: "mông đường phố"
			hunxuemeinyu: "người đẹp lai"
			oumeisiwa: "tất Âu Mỹ"
			oumeizhifu: "đồng phục Âu Mỹ"
			oumeidaxiongmeinyu: "người đẹp vú to Âu Mỹ"
			gangguanwu: "múa cột"
			laozhaopian: "ảnh cũ"

	oncreate: !->
		texts = await Promise.all @files.map (file) ~>
			fetch "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-data/#file"
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
				name: @[name]?[val] or val
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
