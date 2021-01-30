function pr_bar ()
{
    local -i i maxraw scaled
    raw=$1
    maxraw=$2
    (( scaled=(MAXBAR*raw)/maxraw ))

    # гарантированный минимальный размер
    (( raw > 0 && scaled == 0 )) && scaled=1

    for ((i=0; i < scaled; i++)) ; do printf '#' ; done
    printf '\n'
}