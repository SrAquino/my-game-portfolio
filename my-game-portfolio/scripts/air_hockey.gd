extends Node3D

signal interacted
signal interaction_available
signal interaction_unavailable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", interaction_area_in)
	connect("body_exited", interaction_area_out)
	connect("interacted", interacting)
	
	set_process_unhandled_input(false)

func interaction_area_in(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Entrou")
		emit_signal("interaction_available")
		set_process_unhandled_input(true)
		
func interaction_area_out(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Saiu")
		emit_signal("interaction_unavailable")
		set_process_unhandled_input(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action_pressed("Interact"):
		interacted.emit()

func interacting() -> void:
	print("interagiu")
