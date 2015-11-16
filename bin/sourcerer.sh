echo $0
echo $_
echo ${BASH_SOURCE}
echo ${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}

cur_file="${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"
cur_dir="$(dirname "${cur_file}")"
source "${cur_dir}/sourcery.sh"

function test_within_func_inside {
    echo ${BASH_SOURCE}
    echo ${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}
}

echo "Testing within function inside"
test_within_func_inside

echo "Testing within function outside"
test_within_func_outside
