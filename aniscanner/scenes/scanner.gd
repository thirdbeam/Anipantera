extends TextureRect


@onready var camera := $".."

func _ready():
	camera.camera_permission_granted.connect(_on_camera_permission_granted)
	camera.frame_available.connect(_on_frame_available)
	camera.request_camera_permission()

func _on_camera_permission_granted() -> void:
	var cameras : Array[CameraInfo]= camera.get_all_cameras()
	if cameras.is_empty():
		return

	var cam: CameraInfo = cameras[0]
	var request := FeedRequest.new().set_camera_id(cam.get_camera_id()).set_width(1280).set_height(720).set_auto_upright(true)        # rotate frames automatically — no manual rotation needed

	camera.start(request)

func _on_frame_available(frame: FrameInfo) -> void:
	var img := frame.get_image()
	texture = ImageTexture.create_from_image(img)
