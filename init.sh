# Ask for the administrator password upfront.
sudo -v

##########################
### Get info from user ###
##########################
computer_name=' '
user_name=' '
user_email=' '

echo -n "What would you like your computer to be known as on the network? ex:Joe's Macbook  "
read computer_name

echo -n 'What is your git username?  '
read user_name

echo -n 'What is your git email address?  '
read user_email

#########################
### Install XCode CLI ###
#########################

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi



#######################################
### Change ownership of /usr/local/ ###
#######################################

#echo '*** gaining ownership of /usr/local/ ***'
#sudo chmod a+w /usr/local/

# echo '*** creating code skeleton directory ***'
# mkdir -p $HOME/code/go/src/github.com/tylerferraro

##############################
### Software Installations ###
##############################

echo '*** install homebrew ***'
ruby -e "$(curl -#fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

#echo '*** install erlang ***'
#brew install erlang

#echo '*** install elixir ***'
#brew install elixir

echo '*** install git ***'
brew install git

#echo '*** install gnupg2 ***'
#brew install gnupg2

echo '*** install heroku ***'
brew install heroku

echo '*** install heroku-toolbelt ***'
brew install heroku-toolbelt

echo '*** install node/npm ***'
brew install node

echo '*** install openssl ***'
brew install openssl

echo '*** install postgresql ***'
brew install postgresql
# brew install postgis

#echo '*** set postgresql to run at startup ***'
brew services start postgresql

echo '*** install redis ***'
brew install redis

echo '*** set redis to run at startup ***'
brew services start redis

echo '*** install s3cmd ***'
brew install s3cmd

echo '*** install tmux ***'
brew install tmux

echo '*** install tree ***'
brew install tree

#echo '*** install vim ***'
#brew install vim

echo '*** install wget ***'
brew install wget

echo '*** install imagemagick ***'
brew install imagemagick

brew install truncate
brew install git-when-merged
brew install markdown

echo '*** install hub` ***'
brew install hub

echo '*** change default cask install location to ~/Applications ***'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

echo '*** install 1password ***'
brew cask install 1password

echo '*** install alfred ***'
brew cask install alfred

echo '*** install anvil ***'
brew cask install anvil

echo '*** install charles ***'
brew cask install charles

echo '*** install dash ***'
brew cask install dash

echo '*** install google chrome ***'
brew cask install google-chrome

echo '*** install flux ***'
brew cask install flux

echo '*** install iterm2 ***'
brew cask install iterm2

echo '*** install mou ***'
brew cask install mou

echo '*** install slack ***'
brew cask install slack

echo '*** install sketchup ***'
brew cask install sketchup

echo '*** install evernote ***'
brew cask install evernote

echo '*** install skitch ***'
brew cask install skitch

echo '*** install transmission ***'
brew cask install transmission

echo '*** install plex ***'
brew cask install plex-media-server
brew cask install plex-media-player

echo '*** install harvest ***'
brew cask install harvest

echo '*** install postman ***'
brew cask install postman

echo '*** install meld ***'
brew cask install meld

echo '*** install tableplus ***'
brew cask install tableplus


#echo '*** install skype ***'
#brew cask install skype

echo '*** install synergy ***'
brew cask install synergy

echo '*** install vlc ***'
brew cask install vlc

echo '*** install sublime text 3 ***'
brew tap caskroom/versions
brew cask install sublime-text

brew cask install sublime-merge

brew cask install amazon-music

brew cask install envkey

brew cask install zoom

echo ""
echo "****************************"
echo "NO INSTALLS FOR"
echo ""
echo "todoist"
echo "amphetamine"
echo "day one"

echo ""
echo "****************************"
echo ""
echo '*** cleaning up cask installs ***'
brew cask cleanup



#########################
### Computer Settings ###
#########################

# Set computer name
echo '*** set computer name ***'
sudo scutil --set ComputerName $computer_name
sudo scutil --set HostName $computer_name
sudo scutil --set LocalHostName $computer_name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $computer_name

# Set standby delay to 12 hours
echo '*** set standby delay ***'
sudo pmset -a standbydelay 43200

# Disable the warning before emptying the Trash
echo '*** disable warning before emptying the trash ***'
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
echo '*** show the ~/Library folder ***'
chflags nohidden ~/Library

# Speed up Mission Control animations
echo '*** speed up mission control animations ***'
defaults write com.apple.dock expose-animation-duration -float 0.2

# Prevent Time Machine from prompting to use new hard drives as backup volume
echo '*** stop time machine from asking about new drives ***'
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable Dashboard
#echo '*** disable dashboard ***'
#defaults write com.apple.dashboard mcx-disabled -bool true

# Make Dock icons of hidden applications translucent
echo '*** make hidden app icons translucent ***'
defaults write com.apple.dock showhidden -bool true

# Disable prompt when quitting iterm2
echo '*** Disable prompt when quitting iterm2 ***'
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Don’t automatically rearrange Spaces based on most recent use
echo '*** stop automatically rearranging spaces based on time ***'
defaults write com.apple.dock mru-spaces -bool false

# Menu bar: hide the Time Machine and User icons
#echo '*** hide the time machine and user icons from the menu bar ***'
#for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#  defaults write "${domain}" dontAutoLoad -array \
#    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
#    "/System/Library/CoreServices/Menu Extras/User.menu"
#done

# Set sidebar icon size to medium
echo '*** set sidebar icons in finder to medium size ***'
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# expand save prompt
echo '*** expand save prompt ***'
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# quit printer app when there are no pending jobs
echo '*** quit printer app when there are no pending jobs ***'
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# save to disk instead of iCloud by default
echo '*** set default save location to disk instead of icloud ***'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# check for updates daily
echo '*** check for Apple updates daily ***'
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# disable smart quotes, auto-correct spelling, and smart dashes
echo '*** disable smart quotes, auto-correct spelling, and smart dashes ***'
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# prevent Photos from opening when inserting external media
#echo '*** prevent photos from opening when instering drives ***'
#defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# disable hibernate
echo '*** disable hibernate ***'
sudo pmset -a hibernatemode 0

# disable sudden motion sensor
echo '*** disable the sudden motion sensor ***'
sudo pmset -a sms 0

# increase Bluetooth sound quality
echo '*** increase bluetooth sound quality ***'
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# disable press-and-hold for special keys
echo '*** disable special key press-and-hold ***'
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# disable auto-brightness on keyboard and screen
#echo '*** disable auto-brightness ***'
#sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
#sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

# create folder for screenshots in documents
echo '*** create folder for screenshots in documents ***'
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots"

# enable font rendering on non-apple displays
echo '*** enable font rendering on non-apple displays ***'
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# show full path in finder
echo '*** show full path in finder ***'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# disable warning when changing file extension
echo '*** disable warning when changing file extension ***'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# disable .DS_Store on network drives
echo '*** prevent creation of .DS_Store on network drives ***'
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# enable snap to grid for desktop and icon view
echo '*** enable snap to grid ***'
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# set column view as default
echo '*** set column view as default in finder ***'
defaults write com.apple.finder FXPreferredViewStyle Clmv

# set dock icons to 48px
echo '*** set dock icons to 48px ***'
defaults write com.apple.dock tilesize -int 48

# disable focus ring
echo '*** disable focus ring ***'
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# show battery percentage
echo '*** show battery percentage ***'
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

#disable gatekeeper
echo '*** disable gatekeeper ***'
sudo spctl --master-disable

# disable npm progress bar (doubles install speed)
echo '*** disable npm progress bar ***'
npm set progress=false

# set tap-to-click
echo '*** enable tap-to-click ***'
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

# change crash reporter to notification
echo '*** change crash reporter to notification ***'
defaults write com.apple.CrashReporter UseUNC 1

# create global .gitignore
echo '*** create global .gitignore ***'
curl -# https://raw.githubusercontent.com/denishaskin/env-init/master/assets/gitignore.txt > ~/.gitignore

# set git user info and credentials
echo '*** set git user info and credentials ***'
git config --global user.name $user_name
git config --global user.email $user_email
git config --global credential.helper osxkeychain

# update PATH
echo '*** update path ***'
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# Disable local Time Machine snapshots
echo '*** disable local time machine snapshots ***'
sudo tmutil disablelocal



#############################
### Sublime Text Settings ###
#############################

# open sublime to initialize filepaths
echo '*** open sublime to initialize filepaths ***'
subl

# set vim as default text editor in git
echo '*** set sublime text as default text editor in git ***'
git config --global core.editor subl -nw

#set sublime as default text editor os-wide
echo '*** set sublime text as default text editor os-wide ***'
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
'{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.3;}'

# set sublime packages
echo '*** set sublime packages ***'
curl -# https://raw.githubusercontent.com/denishaskin/env-init/master/assets/sublime-packages > /Users/$USER/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

# download sublime package manager
echo '*** download sublime package manager ***'
curl -# https://sublime.wbond.net/Package%20Control.sublime-package > /Users/$USER/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package

# set sublime settings
echo '*** set sublime preferences ***'
curl -# https://raw.githubusercontent.com/denishaskin/env-init/master/assets/sublime-preferences > /Users/$USER/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings



#######################
### install ohmyzsh ###
#######################

#echo '*** set vim config ***'
#curl -# https://raw.githubusercontent.com/tylerferraro/env-init/master/assets/vimrc > ~/.vimrc

echo '*** set ohmyzsh config ***'
curl -# https://raw.githubusercontent.com/denishaskin/env-init/master/assets/zshrc > ~/.zshrc

echo '*** set tmux config ***'
curl -# https://raw.githubusercontent.com/denishaskin/env-init/master/assets/tmux.conf > ~/.tmux.conf

echo '*** install rvm ***'
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --rails

echo '*** generate ssh key ***'
ssh-keygen -t rsa -b 4096 -C "$user_email"

echo '*** adding generated key to agent ***'
ssh-add ~/.ssh/id_rsa

echo '*** install ohmyzsh ***'
sh -c "$(curl -#fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

############################
### install tmux plugins ###
############################

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#########################
### set ohmyzsh theme ###
#########################

echo '*** set ohmyzsh theme ***'
curl -# https://raw.githubusercontent.com/denishaskin/env-init/master/assets/genzume.zsh-theme > ~/.oh-my-zsh/themes/genzume.zsh-theme

# TODO
# todoist
# remap Control-Shift-Down to not be Mission Control, or whatever it is
# My .gitconfig changes
# pex
# sublime text packages
# sublime text snippets
# dbvisualizer configuration
