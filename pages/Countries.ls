Countries = m.comp do
	itemView: (country, page) ->
		m \.relative.aspect-2-3.text-center.opacity-0.tap,
			key: country.id
			onclick: !~>
				m.route.set "/country/#{country.id}"
			m \img.w-full.h-full.object-cover,
				src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{country.thumb}.jpg"
				onload: $onloadParentAnim
			m \.absolute.bottom-0.w-full.py-1.text-sm.leading-4.bg-gray-800.bg-opacity-75,
				country.name

	view: ->
		m ListPage,
			obj: $countries
			page: @
