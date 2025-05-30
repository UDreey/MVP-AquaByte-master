extends ScrollContainer

@export var text_node : RichTextLabel
@export_range(1,100000,0.1) var credits_time : float = 1 
@export_range(0,100000,0.1) var margin_increment : float = 0

@onready var margin : MarginContainer = $MarginContainer

func _ready() -> void:
	$MarginContainer/RichTextLabel.push_font_size(20)
	var tween = create_tween()
	
	await get_tree().create_timer(0.01).timeout
	
	var text_box_size = text_node.size.y
	print("text_box_size: ", text_box_size)
	
	var window_size = DisplayServer.window_get_size().y
	margin.add_theme_constant_override("margin_top", window_size + margin_increment)
	margin.add_theme_constant_override("margin_bottom", window_size + margin_increment)
	
	var scroll_amount = ceil(text_box_size * 3/4 + window_size + margin_increment)
	
	tween.tween_property(
		self,
		"srcoll_vertical",
		scroll_amount,
		credits_time
	)
	
	tween.finished.connect(_acabou_creditos)
	tween.play()
	
func _acabou_creditos() -> void:
	print("acabou!")
