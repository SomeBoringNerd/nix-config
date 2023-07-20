# copy everything to the nixos folder
sudo cp ../nix-config/* /etc/nixos/ -r

# remove irrelevant files
sudo rm /etc/nixos/apply.sh
sudo rm /etc/nixos/pull.sh
sudo rm /etc/nixos/README.adoc

echo moved everything, run "sudo nixos-rebuild switch --flake /etc/nixos#MAIN" to apply