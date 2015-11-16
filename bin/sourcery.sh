function test_within_func_outside {
    echo ${BASH_SOURCE}
    echo ${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}
}
