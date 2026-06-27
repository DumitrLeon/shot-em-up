extends Area2D
class_name Projectile

var damage

var travelling := false
var projectile_speed: float = 0.0

func travel(speed):
	travelling = true
	projectile_speed = speed

func _physics_process(delta: float) -> void:
	if travelling:
		position += transform.x * projectile_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if not (body is Player):
		var impact: CPUParticles2D = $Impact
		if impact:
			impact.reparent($"../..")
			impact.emitting = true
			if body is Enemy:
				body.damage_enemy(damage)
			queue_free()
