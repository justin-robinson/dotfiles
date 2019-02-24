date_math_hours() {
    if [[ -z ${IS_BETA_HOST} ]] && [[ -z ${IS_GAMMA_HOST} ]]; then
        date -v ${1}H +%s
    else
        date --date="${1} hours" +%s
    fi
}