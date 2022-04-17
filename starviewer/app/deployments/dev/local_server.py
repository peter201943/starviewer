# Simple script to make the contents of a local folder accessible via a browser
import http.server
import socketserver
from os import getcwd
port = 8005
handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(("", port), handler) as httpd:
  print(f"StarViewer: Serving \"{getcwd()}\" at \"localhost:{port}\"")
  print("StarViewer: Kill with ctrl+c at any time")
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print("StarViewer: Shutting Down")
    httpd.shutdown()
