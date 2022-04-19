extends Node
class_name StarViewerModels

"""
TODO not implemented
TODO docs missing
"""

var endpoint: String
var models: Array

func get(model_name):
  """
  Connects over a network and downloads the model data for loading.
  Will cache results over time in the `.models` array.
  """
  assert(endpoint.length() > 4, "`StarViewerModels.endpoint` not set, cannot connect to network")
  assert(false, "TODO `StarViewerModels.get()` not implemented")
