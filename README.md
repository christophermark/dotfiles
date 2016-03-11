# Dotfiles
Some things to remember and keep when getting dev environments up and running.

## Windows
#### Node
NPM's node-gyp requires Microsoft Visual Studio.
- Install Visual Studio Community 2015
 - Include the C++ package in a "custom" install
- Run `npm install -g -msvs_version=2015 node-gyp rebuild`

