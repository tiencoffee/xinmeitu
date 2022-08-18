Models = m.comp do
	itemView: (model, page) ->
		m \.relative.aspect-2-3.text-center.opacity-0.tap,
			key: model.id
			onclick: !~>
				m.route.set "/model/#{model.id}"
			m \img.w-full.h-full.object-cover,
				src: "https://cdn.jsdelivr.net/gh/tiencoffee/xinmeitu-poster/#{model.thumb}.jpg"
				onload: $onloadParentAnim
			m \.absolute.bottom-0.w-full.py-1.text-sm.leading-4.bg-gray-800.bg-opacity-75,
				model.name

	view: ->
		m ListPage,
			obj: $models
			page: @
