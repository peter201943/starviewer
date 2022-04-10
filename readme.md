
[![MIT License](https://img.shields.io/github/license/peter201943/starviewer.svg?style=flat)](https://opensource.org/licenses/MIT)
[![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=flat&logo=godot-engine&color=grey)](https://godotengine.org/)
[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=flat&logo=github&logoColor=white&label=peter201943%2Fstarviewer)](https://github.com/peter201943/starviewer)

# StarViewer

## Contents
- [Contents](#contents)
- [About](#about)
- [Getting Started](#getting-started)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Major Files](#major-files)
  - [Accepting Changes](#accepting-changes)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)

## About

## Getting Started
1. See the [Releases Page](https://github.com/peter201943/starviewer/releases) for the latest HTML5 export.
2. Unzip the downloaded `starviewer.zip`
3. Modify the `settings.json` with the location of your `stars.json`
    ```json
    {
      "location": "https://your-server-here.domain/endpoint/filename.json"
    }
    ```
4. On your server, make sure you have your sound effect files and song files uploaded
5. Modify the `settings.json` with the mapping of your sound files:
    ```json
    {
      "music": "/path/to/song.ogg",
      "button.hover.sfx": "path/to/button_hover.wav",
      "button.press.sfx": "path/to/button_press.wav",
      // (any other sfx you add)
    }
    ```
6. On your server, upload the full contents of the starviewer folder (`index.html`, `index.js`, `index.pck`, `index.wasm`, `index.audio.worklet.js`, `star_provider.json`) to an appropriate path

## Roadmap
- [ ] REST Requests
- [ ] Stars JSON Parsing
- [ ] Load 3D Models Dynamically
- [ ] Load Texture Images Dynamically
- [ ] Apply Textures to Models Dynamically
- [ ] Settings JSON
- [ ] User Search Function
- [ ] Simple 3D Model Interactions
- [ ] Load Sound Effects from Folder at Runtime
- [ ] Load Music Dynamically
- [ ] Stylish UI Design
- [ ] Low Res + Dithering Shaders

## Contributing

### Prerequisites
- [Download Git for your Operating System](https://git-scm.com/)
- [Download Godot v3.4.4](https://godotengine.org/download)

### Installation
1. Clone the Repository
    ```bash
    git clone git@github.com:peter201943/starviewer.git
    ```
2. Open the Project (from Godot's launcher)

### Major Files
- `test_scene.tscn` (for local development)
- `starviewer.tscn` (for full app)

### Accepting Changes
This is a low-priority project for peter201943 and as such pull requests are not likely to be accepted.
You will be better served by forking it and continuing development of it on your own.

## License
Code distributed under the [MIT License](https://opensource.org/licenses/MIT). See [`LICENSE`](LICENSE) for more information.

Documentation distributed under the [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/).

This document released under [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/) by Peter Mangelsdorf.

## Contact
Peter James Mangelsdorf  
[![Outlook](https://img.shields.io/badge/Microsoft_Outlook-0078D4?style=flat&logo=microsoft-outlook&logoColor=white&label=peter.j.mangelsdorf)](mailto:peter.j.mangelsdorf@outlook.com)  
[![Discord](https://img.shields.io/badge/%3CServer%3E-%237289DA.svg?style=flat&logo=discord&logoColor=white&label=peter201943%238017)](https://discord.com/)  
[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=flat&logo=github&logoColor=white&label=peter201943)](https://github.com/peter201943/)  

## Acknowledgements
See **[Notes](notes/)** for links to articles, repositories, and programs.


