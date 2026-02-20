
dl()
{
cd
. ./to_download.sh
: > ../url.txt
vim ../url.txt
./curls.sh
}

# 色定義
RESET="\e[0m"
GREEN="\e[32m"
CYAN="\e[36m"

echo '========'
echo
echo 'cd ; . ./to_download.sh ; cat /dev/null > ../url.txt ; vim ../url.txt ; ./curls.sh'
echo
echo ' or '
echo
echo -e " ${CYAN}dl${GREEN} # bash function${RESET}"
echo
echo '========'
