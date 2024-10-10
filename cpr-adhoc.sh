#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash git gh ncurses asdf-vm vscode openssl readline sqlite xz zlib
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/270dace49bc95a7f88ad187969179ff0d2ba20ed.tar.gz

set -o errexit    # abort on failed command
set -o nounset    # abort on unbounded variable
set -o pipefail   # show errors downpipe


center () {
	col=$(tput cols)
	str="${1}"
	printf "\n%*s\n" $(((${#str}+$col)/2)) "$str"
}

prompt='MusicCPR Ad Hoc Dev Script'
attribution="Matt Wolffe - @mfwolffe on github"

center "${prompt}"
center "${attribution}"

asdf plugin add python
asdf install python 3.12.3

asdf plugin add nodejs
asdf install nodejs 22.3.0

prompt='CONFIGURING GITHUB AUTH'
subprompt='Please enter the login information as requested in the following lines:'

center "${prompt}"
center "${subprompt}"
gh auth login


GHUSER=$(awk '/account/ {print $7}' <<< $(gh auth status))
echo "${GHUSER}"

PROJDIR="$HOME/Github/"

if [ ! -d "${PROJDIR}" ]; then
	mkdir "${PROJDIR}" && cd "{PROJDIR}"
	git clone https://github.com/Lab-Lab-Lab/CPR-Music-Backend-${GHUSER} ./backend
	git clone https://github.com/Lab-Lab-Lab/CPR-Music-${GHUSER} ./frontend
fi

