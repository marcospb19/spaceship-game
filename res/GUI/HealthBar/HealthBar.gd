extends HBoxContainer

onready var number = $Count/Background/Number
onready var gauge = $Gauge

func reset():
	hide()
	reset_value()

func define_max_value(val):
	gauge.max_value = val

func set_to_max_value():
	number.text = str(gauge.max_value)
	gauge.value = gauge.max_value

func set_gauge_min():
	number.text = str(gauge.min_value)
	gauge.value = gauge.min_value

func set_value(val):
	number.text = str(val)
	gauge.value = val

func get_value():
	return gauge.value

func reset_value():
	number.text = ""
	gauge.value = 0

func show():
	visible = true

func hide():
	visible = false