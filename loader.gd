class_name Loader extends Node

@export var loading_bar: Range
@export var percentage_label: Label
@export var load_path: String

var load_progress: Array

func load_resource(path: String):
	load_path = path
	ResourceLoader.load_threaded_request(load_path)
	ResourceLoader.load_threaded_get_status(load_path, load_progress)
	while true:
		if loading_bar: loading_bar.value = load_progress[0] * ((loading_bar.max_value - loading_bar.min_value) / loading_bar.max_value)
		if percentage_label: percentage_label.text = str(int(load_progress[0])) + "%"
		if load_progress[0] >= 1.0: break
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(load_path))
