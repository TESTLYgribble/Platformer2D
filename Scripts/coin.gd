extends Node2D
signal coinCollected()
@onready var coinSprite = $coinSprite
func _ready() -> void:
	coinSprite.play("default")
	
func _on_coin_area_body_entered(body: Node2D) -> void:
	if body == get_tree().current_scene.get_node("PlayerBody"):
		coinCollected.emit()
		queue_free()
