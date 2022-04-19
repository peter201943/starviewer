extends Node
class_name StarViewerTextures

"""
TODO not implemented
TODO docs missing
"""

var endpoint: String
var textures: Array

func get(texture_name):
  """
  Connects over a network and downloads the texture data for loading.
  Will cache results over time in the `.textures` array.
  """
  assert(endpoint.length() > 4, "`StarViewerTextures.endpoint` not set, cannot connect to network")
  assert(false, "TODO `StarViewerTextures.get()` not implemented")
