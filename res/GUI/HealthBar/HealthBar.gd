extends HBoxContainer

onready var number = $Count/Background/Number
onready var gauge  = $Gauge

func _ready():
	gauge.max_value = 100

func reset():
	hide()
	set_empty()

# Increase
func increase_value(val):
	set_value(gauge.value + val)

func increase_percentage(val: float):
	set_value(gauge.value + gauge.max_value * (val/100))

# Decrease
func decrease_value(val):
	set_value(gauge.value - val)

func decrease_percentage(val: float):
	set_value(gauge.value - gauge.max_value * (val/100))

# Set
func set_value(val):
	# Set the value
	gauge.value = val
	# Update the text
	number.text = str(gauge.value)

func set_max_value(val):
	gauge.max_value = val

func set_percentage(val: float):
	set_value(gauge.max_value * (val/100))

func set_full():
	set_value(gauge.max_value)

func set_empty():
	set_value(gauge.min_value)

# Get
func get_value():
	return gauge.value

func get_max_value():
	return gauge.max_value

func get_percentage():
	return gauge.value * (100.0 / gauge.max_value)

# Visibility
func toggle():
	visible = not visible

func show():
	visible = true

func hide():
	visible = false
