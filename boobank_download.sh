#!/usr/bin/env bash

LOGFILE="$0"
TMPLOG="/tmp/${LOGFILE##*/}.log"
TOPIC="${LOGFILE##*/}"

log_message () {
	if which logger > /dev/null; then
		LEVEL=$1
		shift
		logger -p user.$LEVEL -t $TOPIC "$@"
	fi
}

log_info () {
	log_message "info" "$@"
}

log_warning () {
	log_message "warn" "$@"
}

log_error () {
	log_message "err" "$@"
}

BANK="$1"
ACCOUNTS_DIR="$2"

log_info "begin : script $TOPIC"

log_info "bank to download = $BANK"
log_info "target folder = $ACCOUNTS_DIR"

export PYTHONIOENCODING=utf-8
FORMAT="ofx"

ACCOUNTS=$(boobank --no-header -q -b $BANK list -f csv | grep @$BANK | awk -F ';' '{print $1}')
log_info "--- ACCOUNTS $ACCOUNTS"
for ACCOUNT in $ACCOUNTS; do
	log_info "--- account $ACCOUNT"
	FILENAME="$ACCOUNTS_DIR/$ACCOUNT-"$(date +"%Y-%m-%d-%H-%M-%S")".$FORMAT"
	$WEBOOB_CMD boobank history "$ACCOUNT" -f "$FORMAT" -n 999 > "$FILENAME"
done

log_info "end : script $TOPIC"
