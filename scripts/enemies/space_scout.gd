extends Enemy

var can_shoot = true
var shooting_time = 1.5

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	health = 3
	damage = 1
	speed = 60.0
	projectile_speed = 100.0

var timer = 0.0
func _process(delta: float) -> void:
	look_at_player()
	check_limits(global_position)
	
	if timer >= shooting_time:
		timer = 0.0
		if can_shoot:
			shoot()
	timer += delta

@onready var projectile = $Projectile
func shoot():
	var player_pos = player.global_position
	
	var shoot:Area2D = projectile.duplicate()
	get_tree().current_scene.add_child(shoot)
	shoot.global_position = $Body/Marker2D.global_position
	shoot.visible = true
	shoot.monitoring = true
	shoot.travel(player_pos, global_position, projectile_speed, damage)

func look_at_player():
	var enemy_pos = global_position
	var player_pos = player.global_position
	if player_pos.x < (enemy_pos.x - 10):
		can_shoot = true
		var dir = (player_pos - enemy_pos).normalized()
		var rotation = rad_to_deg(dir.angle()) + 180
		$Body.rotation_degrees = rotation
	else:
		can_shoot = false
		$Body.rotation = lerp_angle($Body.rotation, deg_to_rad(0.0), 0.1)

var limits_x = Vector2(-80, 1000)
var limits_y = Vector2(-150, 150)
func check_limits(pos):
	if (pos.x < limits_x.x) or (pos.x > limits_x.y):
		queue_free()
	if (pos.y < limits_y.x) or (pos.y > limits_y.y):
		queue_free()

func _physics_process(delta: float) -> void:
	velocity = Vector2(-speed, 0)
	move_and_slide()

func damage_enemy(amt):
	$AnimationPlayer.play("damaged")
	health -= 1
	check_health()

func check_health():
	if health <= 0:
		queue_free()
