extends CharacterBody2D
class_name Player

var dir: Vector2
@export var base_speed = 200
@export var health = 5

@onready var sprite: Sprite2D = $Sprite2D
@onready var gun: weapon = $Parts/Weapon

#inputs
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		gun.shoot()

#muove, cameralimit
func _physics_process(delta: float) -> void:
	dir = Input.get_vector("left","right", "up", "down").normalized()
	velocity = dir * base_speed
	move_and_slide()
	camera_limit()

func damage_player(amt):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("damage")
	health -= amt*99999
	if health <= 0:
		await get_tree().create_timer(1.5).timeout
		get_tree().quit()

@onready var camera: Camera2D = get_tree().current_scene.find_child("Camera2D")
var camera_x_length = 384
var camera_y_length = 216

func camera_limit():
	if global_position.x < (camera.global_position.x - camera_x_length/2):
		global_position.x = (camera.global_position.x - camera_x_length/2)
	
	if global_position.x > (camera.global_position.x + camera_x_length/2):
		global_position.x = (camera.global_position.x + camera_x_length/2)
	
	if global_position.y < (camera.global_position.y - camera_y_length/2):
		global_position.y = (camera.global_position.y - camera_y_length/2)
	
	if global_position.y > (camera.global_position.y + camera_y_length/2):
		global_position.y = (camera.global_position.y + camera_y_length/2)
