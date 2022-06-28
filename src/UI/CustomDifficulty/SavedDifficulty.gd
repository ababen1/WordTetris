extends HBoxContainer
class_name UISavedDifficulty

signal play(difficulty)
signal delete(difficulty)
signal load_difficulty(difficulty)
signal save_to_disk(difficulty)

var difficulty: DifficultyResource setget set_difficulty

func _ready() -> void:
	$Play.connect("pressed", self, "emit_signal", ["play"])
	$Load.connect("pressed", self, "emit_signal", ["load_difficulty"])
	$Save.connect("pressed", self, "emit_signal", ["save_to_disk"])
	$Delete.connect("pressed", self, "emit_signal", ["delete"])
	

func set_difficulty(val: DifficultyResource) -> void:
	difficulty = val
	$Name.text = difficulty.name