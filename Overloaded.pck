GDPC                �                                                                      !   X   res://.godot/exported/133200997/export-1bd87d18993b442b6a1e0f363988a43b-pause_menu.scn  �&      )      X�8ɗK�(/_�y�e    P   res://.godot/exported/133200997/export-33affca80cef57b98e9a49ef38b4c31b-wall.scn       �      *D�����`�2���ܻ    P   res://.godot/exported/133200997/export-3b67292cc8e1b4d7c72481acf55c65ca-gun.scn �6      	      ���4�/���zZ~�a~    T   res://.godot/exported/133200997/export-717c53d4e4fb1a12afd9d37db6e2f7ce-ennemy.scn         �      �A#�>Xv_m��ϤK�    T   res://.godot/exported/133200997/export-8fb24b680e044a4347ed3a6558dd9f25-bullet.scn  �/      r      p�H1��o�5�r��;�    X   res://.godot/exported/133200997/export-d6d25315201adfaf861973976855fd24-level_base.scn  p      �	      �mYx�o��eo��    P   res://.godot/exported/133200997/export-dbe59258b6e7c5860bca2a5bbd0223c3-main.scn�>      �      �xj#;Cc��HUl9�    T   res://.godot/exported/133200997/export-e6d031b4b01e7311dce0bbd1f2b58226-player.scn  �      �      fM̔��AGgɈ1x�    ,   res://.godot/global_script_class_cache.cfg  PS             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex@B      �      �Yz=������������       res://.godot/uid_cache.bin  0W      �      p�������'�=�0E       res://icon.svg  pS      �      C��=U���^Qu��U3       res://icon.svg.import    O      �       R�[�п;�v��)
:       res://project.binary�X            ����Zl�$�A��$��    $   res://src/ennemies/ennemy/ennemy.gd         �      <t��l(#_�W=g�p    ,   res://src/ennemies/ennemy/ennemy.tscn.remap �O      c       ���(;�2����Bq9�       res://src/global/debug.gd   �      �      *;�;�%H)���&A�       res://src/global/vars.gd�      =       �6�oxG������ݣ    (   res://src/levels/level_base/Camera2D.gd �      R      �QᴉL+q0#�@ �    ,   res://src/levels/level_base/level_base.gd          H      ܠ�a/�Z��{�(���    4   res://src/levels/level_base/level_base.tscn.remap   PP      g       4苸��H!�|�fF��[    ,   res://src/levels/obstables/wall.tscn.remap  �P      a       �y�����m�c�       res://src/main.gd    =      �      ��p��x��h�Ԫ�(h7       res://src/main.tscn.remap   �R      a       6�-�	��6��s�M�       res://src/player/player.gd  �            ��W�Cv$V�!O�{�    $   res://src/player/player.tscn.remap  0Q      c       tq����)�*C�q^�F�    (   res://src/ui/pause_menu/pause_menu.gd   0%      y       ���Kw%��/�l-a��    ,   res://src/ui/pause_menu/pause_menu.gdshader �%      �       }�S�k^	�I����    0   res://src/ui/pause_menu/pause_menu.tscn.remap   �Q      g       ��`#�Շ�g,+��;    $   res://src/weapons/bullet/bullet.gd  �-      �      3:ǀ$X�@����+�(�    ,   res://src/weapons/bullet/bullet.tscn.remap  R      c       �'x~��$�8�+���        res://src/weapons/bullet/gun.gd 04      �      ��AnǊ���O� ء��    (   res://src/weapons/bullet/gun.tscn.remap �R      `       ;�.��EK~r���$g                extends CharacterBody2D

var life = 5
var speed = 200.0
var target : Node2D
var is_pushed = 0

func _process(delta):
	var direction = global_position.direction_to(target.position)
	if is_pushed > 1:
		velocity =  direction * speed * (-is_pushed)
		is_pushed /= 2
	else:
		velocity = direction * speed
		is_pushed = 0
	look_at(target.global_position)
	move_and_slide()


func take_damage():
	life -= 1
	if life <= 0:
		queue_free()

func get_pushed(direction: Vector2, force: float):
	is_pushed = force
          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script $   res://src/ennemies/ennemy/ennemy.gd ��������      local://CircleShape2D_jbhn6 e         local://PackedScene_5t758 �         CircleShape2D          �*�A         PackedScene          	         names "         Ennemy    script    CharacterBody2D 
   ColorRect    offset_left    offset_top    offset_right    offset_bottom    color    ColorRect2    CollisionShape2D    shape    	   variants    	                  ��     �A     �?          �?     @A     ��     �@                 �?                node_count             nodes     4   ��������       ����                            ����                                                	   ����                                             
   
   ����                   conn_count              conns               node_paths              editable_instances              version             RSRC    extends Node

func print(args) -> void:
	if not OS.is_debug_build():
		return
	var stack = get_stack()
	if stack.size() > 1:
		stack = stack[1]
	else:
		stack = ["UNKNOWN", "0", "_"]
	var display_string = "[DEBUG] (%s:%s %s) : " % [
				stack["source"].replace("res://", ""),
				str(stack["line"]),
				stack["function"],
			]
	if args is Array:
		print(display_string, "%s %s" % [
			"\n\t\t-",
			"\n\t\t- ".join(args),
		])
	else:
		print(display_string, "%s" % [
			args,
		])
              extends Node

var zoom = 1.0
var spawn_scale = Vector2.ZERO

   extends Camera2D


var zoom_min = Vector2(.2, .2)
var zoom_max = Vector2(2, 2)
var zoom_speed = Vector2(.05, .05)
var zoom_target = zoom

# ZOOM with mouse wheel is for debug purpose,
# zoom will be handled for special moment

func set_custom_zoom():
	#zoom_target = Vars.zoom
	Vars.zoom = zoom_target
	Vars.spawn_scale = zoom_target
	#Vars.spawn_scale.x = zoom_target
	#Vars.spawn_scale.y = zoom_target
	#Vars.spawn_scale.x = 2.0
	#Vars.spawn_scale.y = 2.0

func _process(delta):
	zoom = lerp(zoom, zoom_target, .2)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if zoom_target > zoom_min:
					zoom_target -= zoom_speed
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if zoom_target < zoom_max:
					zoom_target += zoom_speed
			set_custom_zoom()
              extends Node

const ENNEMI = preload("res://src/ennemies/ennemy/ennemy.tscn")


func spawn():
	var new_ennemi = ENNEMI.instantiate()
	new_ennemi.target = %Player
	%PathFollow2D.progress_ratio = randf()
	new_ennemi.global_position = %PathFollow2D.global_position
	add_child(new_ennemi)


func _on_spawn_timer_timeout():
	spawn()
        RSRC                    PackedScene            ��������                                            	      resource_local_to_scene    resource_name    bake_interval    _data    point_count    script    custom_solver_bias    size 	   _bundled       Script *   res://src/levels/level_base/level_base.gd ��������   PackedScene    res://src/player/player.tscn ۃ�lXg   Script (   res://src/levels/level_base/Camera2D.gd ��������   PackedScene "   res://src/weapons/bullet/gun.tscn �e0�X�$   PackedScene %   res://src/levels/obstables/wall.tscn /^]�+A      local://Curve2D_s2wf1 �         local://RectangleShape2D_k4vd6 p         local://PackedScene_wnpfd �         Curve2D                   points %                        ��  ��                  XD  ��                  XD  $D                  ��  &D                  ��  ��                  RectangleShape2D       
      B   B         PackedScene          	         names "         Level    script    Node    Player    unique_name_in_owner 	   position 	   Camera2D    Gun    Path2D    curve    PathFollow2D    SpawnTimer 
   wait_time 
   autostart    Timer    Wall    Wall2    Wall3    Wall4    RigidBody2D    metadata/_edit_group_ 
   ColorRect    offset_right    offset_bottom    color    CollisionShape2D    shape    _on_spawn_timer_timeout    timeout    	   variants                                
     �C  �C                  
     ��  ��          
     ��  ��)   �������?         
     @B  @B
     <D  @B
     @B  
D
     <D  
D
     �C  �B      B   ��?s��>��3?  �?
     �A  �A               node_count             nodes     �   ��������       ����                      ���                                      ����                    ���                           ����               	                 
   
   ����                                 ����      	                     ���   
                        ���   
                        ���   
                        ���   
                              ����                                ����                                      ����                         conn_count             conns                                      node_paths              editable_instances              version             RSRC      RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled           local://RectangleShape2D_nyrqk +         local://PackedScene_fq2jk \         RectangleShape2D       
     �B  �B         PackedScene          	         names "         Wall    StaticBody2D 
   ColorRect    anchors_preset    anchor_left    anchor_top    anchor_right    anchor_bottom    offset_left    offset_top    offset_right    offset_bottom    grow_horizontal    grow_vertical    color    CollisionShape2D    shape    	   variants                   ?     @�     @B         ��X>��?��?  �?                node_count             nodes     /   ��������       ����                      ����                                        	      
                                                ����                   conn_count              conns               node_paths              editable_instances              version             RSRC               extends CharacterBody2D

const SPEED = 600
#const ACCELERATION = 1000
#const FRICTION = 600
#const INERTIA = 300

var input = Vector2.ZERO

#func get_input_direction():
	#input.x = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	#input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))


func _process(_delta):
	%Path2D.scale.x = 1 / Vars.spawn_scale.x
	%Path2D.scale.y = 1 / Vars.spawn_scale.y
	#%Path2D.set_scale(Vars.spawn_scale)
	#%Path2D.set_scale(Vector2(2,2))

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	#velocity = direction * lerp(10, SPEED, .4)
	#Debug.print(direction)
	look_at(global_position + direction)
	if move_and_slide():
		for collisions in get_slide_collision_count():
			var collision = get_slide_collision(collisions)
			if collision.get_collider() is RigidBody2D:
				collision.get_collider().apply_force(collision.get_normal() * -1500)
               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://src/player/player.gd ��������      local://CircleShape2D_614yr \         local://PackedScene_ffixc �         CircleShape2D            �A         PackedScene          	         names "         Player    script    CharacterBody2D 
   ColorRect    anchors_preset    anchor_left    anchor_top    anchor_right    anchor_bottom    offset_left    offset_top    offset_right    offset_bottom    grow_horizontal    grow_vertical    color    ColorRect2    CollisionShape2D    shape    	   variants                             ?     ��     �A         ��?��?��?  �?     @A     ��     �@     �?          �?                node_count             nodes     P   ��������       ����                            ����                                 	      
                                                      ����                                 	      
               	                  
                     ����                   conn_count              conns               node_paths              editable_instances              version             RSRC          extends Control


func _process(delta):
	if visible:
		%CanvasLayer.visible = true
	else:
		%CanvasLayer.visible = false
       shader_type canvas_item;

uniform sampler2D blurry : hint_screen_texture, filter_linear_mipmap;
uniform float amount : hint_range(0.0, 100.0);


void fragment() {
	vec4 color = textureLod(blurry, SCREEN_UV, amount);
	COLOR = color;
}
      RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    shader    shader_parameter/amount    script 	   _bundled       Script &   res://src/ui/pause_menu/pause_menu.gd ��������   Shader ,   res://src/ui/pause_menu/pause_menu.gdshader ��������      local://ShaderMaterial_7xspd �         local://PackedScene_56qgk �         ShaderMaterial                   )   ffffff�?         PackedScene          	         names "      
   PauseMenu    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    CanvasLayer    unique_name_in_owner    visible 
   ColorRect 	   material    MarginContainer    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom    VBoxContainer    Button $   theme_override_font_sizes/font_size    text    Button2    	   variants                        �?                                                   ?     �     p�     C     pB   $         Return to fight!    
   Quit game       node_count             nodes     s   ��������       ����                                                          	   	   ����   
                             ����                                                        ����            	      	      	      	      
                                                  ����                          ����                                      ����                               conn_count              conns               node_paths              editable_instances              version             RSRC       extends Area2D

const SPEED = 1200.0
const SCOPE = 3000
const IMPACT = 20.0
var distance = 0

func _process(delta):
	var direction = Vector2.from_angle(global_rotation)
	position += direction * SPEED * delta
	distance += SPEED * delta
	if distance > SCOPE:
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		#queue_free()
		body.take_damage()
	if body.has_method("get_pushed"):
		body.get_pushed(Vector2.from_angle(global_rotation), IMPACT)
      RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script #   res://src/weapons/bullet/bullet.gd ��������      local://RectangleShape2D_3majc e         local://PackedScene_m255u �         RectangleShape2D       
     @A  �@         PackedScene          	         names "         Bullet 
   top_level    script    Area2D 
   ColorRect    offset_left    offset_top    offset_right    offset_bottom 	   rotation    CollisionShape2D    shape    _on_body_entered    body_entered    	   variants                            ��      �     �@      @   �YN�                node_count             nodes     %   ��������       ����                                  ����                           	                  
   
   ����                   conn_count             conns                                       node_paths              editable_instances              version             RSRC              extends Area2D

var ROF = 4.0 # bullets / second
const BULLET = preload("res://src/weapons/bullet/bullet.tscn")


func _ready():
	Debug.print(%ShootTimer.wait_time)
	%ShootTimer.wait_time = 1 / ROF
	Debug.print(%ShootTimer.wait_time)
	
func _physics_process(delta):
	var ennemis_in_range : Array[Node2D] = get_overlapping_bodies()
	if ennemis_in_range.size() > 0:
		#Debug.print("Ennemy!")
		var target = ennemis_in_range.front()
		#look_at(target.global_position)


func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %Cannon.global_position
	new_bullet.global_rotation = %Cannon.global_rotation
	%Cannon.add_child(new_bullet)


func _on_shoot_timer_timeout():
	shoot()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script     res://src/weapons/bullet/gun.gd ��������      local://RectangleShape2D_muyqo b         local://PackedScene_a806l �         RectangleShape2D       
     LD   C         PackedScene          	         names "         Gun    script    Area2D 
   ColorRect    anchors_preset    anchor_left    anchor_top    anchor_right    anchor_bottom    offset_left    offset_top    offset_right    offset_bottom    grow_horizontal    grow_vertical    color    CollisionShape2D 	   position    shape    ShootTimer    unique_name_in_owner 
   autostart    Timer    Cannon 	   Marker2D    _on_shoot_timer_timeout    timeout    	   variants                             ?     �A     ��     @B     �@                       �?
     �C                    
     @B          node_count             nodes     I   ��������       ����                            ����                                 	      
                                                      ����      	      
                     ����                                 ����                         conn_count             conns                                      node_paths              editable_instances              version             RSRC       extends Node

enum State {OPENING, PLAYING, PAUSED, GAME_OVER}

var game_state = State.OPENING


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
		
func pause_game():
	if game_state == State.PAUSED:
		%PauseMenu.hide()
		Engine.time_scale = 1
		game_state = State.PLAYING
	else:
		%PauseMenu.show()
		Engine.time_scale = 0.2
		game_state = State.PAUSED
        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://src/main.gd ��������   PackedScene ,   res://src/levels/level_base/level_base.tscn �X��&�q,   PackedScene (   res://src/ui/pause_menu/pause_menu.tscn c^U*W�      local://PackedScene_mc6nx �         PackedScene          	         names "         Main    script    Node    Level 
   PauseMenu    unique_name_in_owner    visible    	   variants                                                      node_count             nodes        ��������       ����                      ���                      ���                               conn_count              conns               node_paths              editable_instances              version             RSRC              GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://krdinhmth32b"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 [remap]

path="res://.godot/exported/133200997/export-717c53d4e4fb1a12afd9d37db6e2f7ce-ennemy.scn"
             [remap]

path="res://.godot/exported/133200997/export-d6d25315201adfaf861973976855fd24-level_base.scn"
         [remap]

path="res://.godot/exported/133200997/export-33affca80cef57b98e9a49ef38b4c31b-wall.scn"
               [remap]

path="res://.godot/exported/133200997/export-e6d031b4b01e7311dce0bbd1f2b58226-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-1bd87d18993b442b6a1e0f363988a43b-pause_menu.scn"
         [remap]

path="res://.godot/exported/133200997/export-8fb24b680e044a4347ed3a6558dd9f25-bullet.scn"
             [remap]

path="res://.godot/exported/133200997/export-3b67292cc8e1b4d7c72481acf55c65ca-gun.scn"
[remap]

path="res://.godot/exported/133200997/export-dbe59258b6e7c5860bca2a5bbd0223c3-main.scn"
               list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
          	   �	���)%   res://src/ennemies/ennemy/ennemy.tscn�X��&�q,+   res://src/levels/level_base/level_base.tscn/^]�+A$   res://src/levels/obstables/wall.tscnۃ�lXg   res://src/player/player.tscnc^U*W�'   res://src/ui/pause_menu/pause_menu.tscne�@���3$   res://src/weapons/bullet/bullet.tscn�e0�X�$!   res://src/weapons/bullet/gun.tscnz&�[�H   res://src/main.tscn�e�~K�:
   res://icon.svg   ECFG	      application/config/name      
   Overloaded     application/run/main_scene         res://src/main.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     autoload/Debug$         *res://src/global/debug.gd     autoload/Vars$         *res://src/global/vars.gd   "   display/window/size/viewport_width         #   display/window/size/viewport_height      X  !   physics/2d/default_gravity_vector                          