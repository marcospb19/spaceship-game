extends Node

var projectile_resources := preload("res://Weapons/Projectiles/Fireball.tscn")
var projectiles_node: Node2D
var firing_interval := 0.8
var can_fire := true

onready var timer = $Timer

func reload_gun():
	can_fire = true
	print("Gun reloaded!!")

func setup_weapon(firing_field: Node2D):
	projectiles_node = firing_field

func _ready():
	timer.set_wait_time(firing_interval)
	print(timer)

func _process(delta):
	print(timer)

func fire(position: Vector2 , angle: float , spaceship_speed: Vector2):
	if not can_fire:
		print("Can\'t fire")
		return
	
	var radians_angle = deg2rad(angle)
	var projectile = projectile_resources.instance()
	projectile.set_projectile_trajectory(
			position + Vector2(cos(radians_angle) , sin(radians_angle)) * 93,
			angle,
			spaceship_speed
	)
	projectiles_node.add_child(projectile)
	
	print("Fire In The Hole!")
	
	# print("Timer = " , $Timer)
	# timer.start()
	can_fire = false
	print("Also reloading gun here")
