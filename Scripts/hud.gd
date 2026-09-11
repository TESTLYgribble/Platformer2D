extends Control

@onready var health_box: HBoxContainer = $HealthBox
@onready var coin_box:HBoxContainer = $CoinBox
var coin_count: int = 0

func _ready() -> void:
	var player = get_tree().current_scene.get_node("PlayerBody")
	if player:
		if player.has_signal("update_health"):
			player.update_health.connect(update_health_display)

		if "player_health" in player:
			update_health_display(player.player_health)
			
	var coins: Array = get_tree().current_scene.find_children("*Coin*","",true,false)
	for coin in coins:
		if coin:
			if coin.has_signal("coinCollected"):
				coin.coinCollected.connect(update_coin_display)

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

func update_coin_display() -> void:
	if coin_box.get_child_count() < 2:
		return
		
	coin_count += 1
	var coin_count_label = coin_box.get_child(0) as Label
	if coin_count_label:
		coin_count_label.text = str(coin_count) + "x"
	
