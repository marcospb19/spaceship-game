extends HBoxContainer

onready var number = $Count/Background/Number
onready var gauge = $Gauge

func reset():
	hide()
	reset_value()

func define_max_value(val):
	gauge.max_value = val

func set_to_max_value():
	set_value(gauge.max_value)

func set_gauge_min():
	set_value(gauge.min_value)

func increase_value(val):
	set_value(gauge.value + val)

func increase_value_percentually(val):
	set_value(gauge.value + ((gauge.max_value) * (val/100)))

func decrease_value(val):
	set_value(gauge.value - val)

func decrease_value_percentually(val):
	set_value(gauge.value - ((gauge.max_value) * (val/100)))

func reset_value():
	set_value(0)

func set_number():
	number.text = str(gauge.value)

func set_value(val):
	gauge.value = val
	set_number()

func get_value():
	return gauge.value

func show():
	visible = true

func hide():
	visible = false