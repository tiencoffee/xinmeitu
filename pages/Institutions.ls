Institutions = m.comp do
	itemView: (institution, page) ->
		m \.relative.aspect-2-3.text-center.opacity-0.tap,
			key: institution.id
			onclick: !~>
				m.route.set "/institution/#{institution.id}"
			m \img.w-full.h-full.object-cover,
				src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{institution.thumb}.jpg"
				onload: $onloadParentAnim
			m \.absolute.bottom-0.w-full.py-1.text-sm.leading-4.bg-gray-800.bg-opacity-75,
				institution.name

	view: ->
		m ListPage,
			obj: $institutions
			page: @
