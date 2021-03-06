extends Reference
class_name Funcs

static func is_html() -> bool:
	return OS.get_name() == "HTML5"
	
static func is_mobile() -> bool:
	return OS.get_name() in ["Android", "iOS"]

static func get_random_array_element(array: Array):
	var randomizer = RandomNumberGenerator.new()
	return array[randomizer.randi_range(0, array.size() -1)]
		
static func get_resources_data(preloader: ResourcePreloader) -> Dictionary:
	var data = {}
	for resource_name in preloader.get_resource_list():
		data[resource_name] = preloader.get_resource(resource_name)
	return data

# Given a preloader with 1 file, it returns a list of all other resources
# in the directory of that 1 file.
static func preloderer_get_dir_list(preloader: ResourcePreloader, include_subfolders: = true) -> Dictionary:
	var default_resource: = preloader.get_resource(preloader.get_resource_list()[0])		
	var paths: Array = get_content_in_path(
		default_resource.resource_path.get_base_dir(), true, include_subfolders)
	var list = {}
	for path in paths:
		list[path.get_file().trim_suffix('.' + path.get_extension())] = path
	return list

static func get_content_in_path(path: String, ignore_dot_import: = true, recrusive: = false) -> Array:
	var dir: = Directory.new()
	var content: = []
	if dir.open(path) == OK and dir.list_dir_begin(true, true) == OK:
		var filename: String = dir.get_next()
		while filename:
			if not OS.is_debug_build():
				filename = filename.replace('.import', '')
			if !(ignore_dot_import and filename.ends_with(".import") and OS.is_debug_build()):
				if dir.current_is_dir() and recrusive:
					content.append_array(get_content_in_path(
						path.plus_file(filename), ignore_dot_import, recrusive))
				else:
					content.append(path.plus_file(filename))
			filename = dir.get_next()
	return content
	
#static func generate_board_styles(path: String, output: String):
#	var dir = Directory.new()
#	if dir.open(path) == OK:
#		dir.list_dir_begin(true, true)
#		var file: String = dir.get_next()
#		while file:
#			if dir.current_is_dir():
#				generate_board_styles(path.plus_file(file), output)
#			elif ResourceLoader.exists(path.plus_file(file)):
#				var texture = load(path.plus_file(file))
#				if texture is Texture:
#					var board_style = BoardStyleTexture.new()
#					board_style.board_texture = texture
#					ResourceSaver.save(
#						output.plus_file(file.get_file() + ".tres"),
#						board_style)
#			file = dir.get_next()
