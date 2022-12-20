extends Popup
class_name Tooltip

var origin = ""
var slot = ""
var disabled = false
export var owner_path: NodePath
export var delay: float = 0.5


var _timer: Timer
onready var owner_node = get_node(owner_path)

func _ready():
	owner_node.connect("mouse_entered",self,"_on_mouse_entered")
	owner_node.connect("mouse_exited",self,"_on_mouse_exited")
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout",self,"_on_timout")

func _physics_process(delta):
	if visible:
		#var border = get_viewport().size
		#print(border)
		#print(get_viewport_rect().size)
		#print(get_viewport().get_mouse_position())
		#print(get_global_transform_with_canvas().origin)
		
		if get_viewport().get_mouse_position().y > get_viewport_rect().size.y - rect_size.y:
			rect_global_position = get_global_mouse_position() + Vector2(2,- rect_size.y - 2)
		else:
			rect_global_position = get_global_mouse_position() + Vector2(2,2)

		

func _on_mouse_entered():
	if not disabled:
		_timer.start(delay)
	

func _on_mouse_exited():
	custom_hide()

func _on_timout():
	custom_show()

func custom_hide():
	_timer.stop()
	hide()
	
func custom_show():
	_timer.stop()
	if get_viewport().get_mouse_position().y > get_viewport_rect().size.y - rect_size.y:
		rect_global_position = get_global_mouse_position() + Vector2(2,- rect_size.y - 2)
	else:
		rect_global_position = get_global_mouse_position() + Vector2(2,2)
	show()
