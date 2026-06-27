extends Node2D
class_name animation_controller

var player: Player
var animation_player: AnimationPlayer
var inclination = 10

func _ready() -> void:
	player = get_parent()
	animation_player = get_parent().find_child("AnimationPlayer")
	
	animation_player.play("Thrusters")

func _process(delta: float) -> void:
	if animation_player.current_animation == "thrusters":
		if player.dir.y < 0:
			player.sprite.rotation_degrees = -inclination
		elif player.dir.y > 0:
			player.sprite.rotation_degrees = inclination
		else:
			player.sprite.rotation_degrees = 0
		
		if player.dir.x < 0:
			player.sprite.rotation_degrees = inclination

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "damage":
		animation_player.play("thrusters")
