extends Spatial

"""
Builds a star from a model and a texture.

Model and Texture are externally-loaded files.

HELP: https://github.com/godotengine/godot/issues/24768

Will attempt to build self on instantiation, so make sure assets are known before attempting to build!

Parents the Model (GLTF) to itself.

Then assigns the Texture as a mesh to the model.

Does NOT care about #instances or who it belongs to - set these within the star viewer scene?
(Question does exist about who should be instantiating the stars).
((The Viewer! And the Viewer specifically should ebt he only one checking for the user stars)).

DOES handle networking.
"""

# var importer = SceneImporterGLTF.new()
# var root = importer.import_gltf("user://example.glb")

# var flags = 0
# var bake_fps = 1000
# 
# var gstate = load("res://addons/godot_gltf/GLTFState.gdns").new()
# var gltf = load("res://addons/godot_gltf/PackedSceneGLTF.gdns").new()
# var instance = gltf.import_gltf_scene(path, flags, bake_fps, gstate)
