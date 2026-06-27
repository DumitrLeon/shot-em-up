extends Area2D

var projectile_speed
var player_pos: Vector2
var starting_pos: Vector2
var travelling = false
var damage_amt

func travel(target, starting_target, speed, damage):
	damage_amt = damage
	projectile_speed = speed
	starting_pos = starting_target
	player_pos = target
	travelling = true

func _physics_process(delta: float) -> void:
	if travelling:
		check_limits(global_position)
		var dir = (player_pos - starting_pos).normalized()
		global_position += dir * projectile_speed * delta

var limits_x = Vector2(-80, 1000)
var limits_y = Vector2(-150, 150)
func check_limits(pos):
	if (pos.x < limits_x.x) or (pos.x > limits_x.y):
		queue_free()
	if (pos.y < limits_y.x) or (pos.y > limits_y.y):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage_player(damage_amt)
		queue_free()
