extends Area2D

func _ready():
	# Connect the area entered signal
	body_entered.connect(_on_body_entered)
	
	# Add some visual effects
	var tween = create_tween()
	tween.tween_property($Sprite, "scale", Vector2(1.2, 1.2), 0.5)
	tween.tween_property($Sprite, "scale", Vector2(1.0, 1.0), 0.5)
	tween.set_loops()

func _on_body_entered(body):
	if body.name == "Player":
		# Player picked up the sword
		pickup_sword()

func pickup_sword():
	# Add sword to inventory
	GlobalGameData.inventory.append("Victory Sword")
	
	# Show pickup message
	var pickup_label = Label.new()
	pickup_label.text = "Picked up Victory Sword!"
	pickup_label.add_theme_color_override("font_color", Color(0, 1, 0))
	pickup_label.position = global_position + Vector2(0, -50)
	get_tree().current_scene.add_child(pickup_label)
	
	# Remove pickup label after delay
	await get_tree().create_timer(2.0).timeout
	pickup_label.queue_free()
	
	# Remove the sword drop
	queue_free()
