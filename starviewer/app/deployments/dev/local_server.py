# Simple script to make the contents of a local folder accessible via a browser
import http.server
import socketserver
port = 8003
handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(("", port), handler) as httpd:
  print(f"serving this directory at https://localhost:{port}")
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print("shutting down")
    httpd.shutdown()
