extends KinematicBody2D

var motion : Vector2

func set_trajectory_angle(angle: float):
	angle = deg2rad(angle)
	motion.x =  sin(angle)
	motion.y = -cos(angle)
	self.rotate(angle)


func _physics_process(delta: float) -> void:
	motion = move_and_slide(motion)
