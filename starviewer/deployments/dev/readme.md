
# Dev

The "development" deployment, used for local testing and enhancement of the StarViewer app.

Handy scripts which get included in the "Dev Export" to allow local testing (in a web browser).

Includes a basic Python script to allow local hosting of the game on a port.

Includes a `settings.json` tailored for dev testing.

NOT included in the "Prod" export.

Run either the `run.cmd` (Windows) or `run.sh` (Linux/Mac) to test the server.

Make sure you are running this from an **exported build** of the game, not from within the project folder itself!

NOTE: Because Godot does not have a way of automatically including certain files when it exports,
it is necessary to manually copy the scripts/files included in here and paste them into the
`.export/` folder when a new build is made.
