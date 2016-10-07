# Dotfiles
**Currently a Work-In-Progress until I get symlinks and an installation script working.** <br>
Some things to remember and keep when getting dev environments up and running.

#### Terminal formatting
- Color Profile: HomeBrew
- Text Color: White
- Text Size: 14 pt
- When the shell exits: close the window

## Atom Installation
1) Install Atom <br>
2) Install packages below (atom doesn't have a config file for installed packages) <br>
3) Copy over config files from the `.atom` directory here <br>

#### Atom Packages
- nuclide
- docblockr
- file-icons
- minimap
- minimap-git-diff
- pigments
- project-manager

#### Atom Themes
**UI Theme** <br>
Atom Dark

**Syntax Theme** <br>
Base16 Tomorrow Dark

**Misc. Styling** <br>
See my `styles.less` file in the `.atom` directory

#### TODO
Sync installed packages via "starred" repos.
https://discuss.atom.io/t/bower-style-package-json-to-import-install-packages-across-devices/11587/2

## Karabiner key mappings
Use the private.xml file in the Karabiner directory

## Windows
#### Node
NPM's node-gyp requires Microsoft Visual Studio.
- Install Visual Studio Community 2015
 - Include the C++ package in a "custom" install
- Run `npm install -g -msvs_version=2015 node-gyp rebuild`
