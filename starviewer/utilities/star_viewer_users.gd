extends Node
class_name StarViewerUsers

"""
TODO not implemented
TODO docs missing
"""

var endpoint: String
var users: Array

func get(user_name):
  """
  Connects over a network and downloads the user data for loading.
  Will cache results over time in the `.users` array.
  """
  assert(endpoint.length() > 4, "`StarViewerUsers.endpoint` not set, cannot connect to network")
  assert(false, "TODO `StarViewerUsers.get()` not implemented")
