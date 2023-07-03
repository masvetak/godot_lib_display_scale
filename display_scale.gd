extends Node

enum SCALE_FACTOR {
	SCALE_FACTOR_AUTO = 0,
	SCALE_FACTOR_50,
	SCALE_FACTOR_75,
	SCALE_FACTOR_100,
	SCALE_FACTOR_125,
	SCALE_FACTOR_150,
	SCALE_FACTOR_175,
	SCALE_FACTOR_200,
	SCALE_FACTOR_225,
	SCALE_FACTOR_250,
	SCALE_FACTOR_275,
	SCALE_FACTOR_300,
}

@export var scale_factor: SCALE_FACTOR = SCALE_FACTOR.SCALE_FACTOR_AUTO:
	set(value):
		scale_factor = value
		_set_display_scale(scale_factor)

# ------------------------------------------------------------------------------
# Build-in methods
# ------------------------------------------------------------------------------

func _ready() -> void:
	get_window().content_scale_factor = _get_auto_display_scale()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_EQUAL:
				if event.ctrl_pressed:
					@warning_ignore("int_as_enum_without_cast")
					scale_factor = scale_factor + 1
					if scale_factor > SCALE_FACTOR.size() - 1:
						scale_factor = SCALE_FACTOR.SCALE_FACTOR_300
					_set_display_scale(scale_factor)
			if event.keycode == KEY_MINUS:
				if event.ctrl_pressed:
					@warning_ignore("int_as_enum_without_cast")
					scale_factor = scale_factor - 1
					if scale_factor < 0:
						scale_factor = SCALE_FACTOR.SCALE_FACTOR_AUTO
					_set_display_scale(scale_factor)

# ------------------------------------------------------------------------------
# Private methods
# ------------------------------------------------------------------------------

func _get_auto_display_scale() -> float:
	var screen_size: Vector2 = DisplayServer.screen_get_size()
	
	if screen_size == Vector2.ZERO:
		return 1.0
	
	var smallest_dimension = min(screen_size.x, screen_size.y)
	if DisplayServer.screen_get_dpi() >= 192 and smallest_dimension >= 1400:
		return 2.0
	elif smallest_dimension >= 1700:
		return 1.5
	elif smallest_dimension <= 800:
		return 0.75
	return 1.0

func _set_display_scale(display_scale: int) -> void:
	match display_scale:
		SCALE_FACTOR.SCALE_FACTOR_AUTO:
			get_window().content_scale_factor = _get_auto_display_scale()
		SCALE_FACTOR.SCALE_FACTOR_50:
			get_window().content_scale_factor = 0.50
		SCALE_FACTOR.SCALE_FACTOR_75:
			get_window().content_scale_factor = 0.75
		SCALE_FACTOR.SCALE_FACTOR_100:
			get_window().content_scale_factor = 1.00
		SCALE_FACTOR.SCALE_FACTOR_125:
			get_window().content_scale_factor = 1.25
		SCALE_FACTOR.SCALE_FACTOR_150:
			get_window().content_scale_factor = 1.50
		SCALE_FACTOR.SCALE_FACTOR_175:
			get_window().content_scale_factor = 1.75
		SCALE_FACTOR.SCALE_FACTOR_200:
			get_window().content_scale_factor = 2.00
		SCALE_FACTOR.SCALE_FACTOR_225:
			get_window().content_scale_factor = 2.25
		SCALE_FACTOR.SCALE_FACTOR_250:
			get_window().content_scale_factor = 2.50
		SCALE_FACTOR.SCALE_FACTOR_275:
			get_window().content_scale_factor = 2.75
		SCALE_FACTOR.SCALE_FACTOR_300:
			get_window().content_scale_factor = 3.00
		_:
			get_window().content_scale_factor = _get_auto_display_scale()
