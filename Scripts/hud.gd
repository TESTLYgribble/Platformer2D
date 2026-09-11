extends Control

@onready var health_box: HBoxContainer = $HealthBox

func _ready() -> void:
	var player = get_node_or_null("../PlayerBody")
	if player:
		if player.has_signal("update_health"):
			player.update_health.connect(update_health_display)

		if "player_health" in player:
			update_health_display(player.player_health)

func update_health_display(current_health: int) -> void:
	if health_box.get_child_count() == 0:
		return

	var template_icon = health_box.get_child(0)
	for i in range(health_box.get_child_count() - 1, 0, -1):
		health_box.get_child(i).queue_free()
	template_icon.visible = (current_health > 0)

	for i in range(current_health - 1):
		var new_heart = template_icon.duplicate()
		health_box.add_child(new_heart)
