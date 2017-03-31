#!/usr/bin/env mksh
# Backup private files, in encfs dir

fr=~/.pri
to=~/pri
key=('pickfire@riseup.net') # The first key is the recipient

# backup directory:files to be backed up
files=("$HOME/.ssh/id_rsa*" "$HOME/.mutt/pass*" "$HOME/usr/doc/links.*" "$HOME/.mutt/alias")

getopts r arg # r: reverse

# Prepare for battle
mount | grep -qo "$to" || encfs $fr $to || { rmdir $to; exit 1; }

if [ "$arg" != "r" ]; then
  # Prepare for future
  for k in ${key[*]}; do
    mkdir -p $to/gpg/$key
    [ -f $to/gpg/$key/pubkey.asc ] || gpg -a --export $key > $to/gpg/$key/pubkey.asc
    [ -f $to/gpg/$key/seckey.asc ] || gpg -a --export-secret-keys $key > $to/gpg/$key/seckey.asc
  done

  cp ~/.ssh/id_rsa* -t $to/d/
  cp ~/.mutt/pass* ~/usr/doc/links.* -t $to/d/
  cp ~/.mutt/alias $to/c/

  gpg -er ${key[0]} -o $to/d/weechat.gpg ~/.weechat/sec.conf

  # Sudo mode
  for k in $(sudo find /var/lib/tor -mindepth 2 -type f | grep -o 'tor.*'); do
    mkdir -p $(dirname $to/$k) && sudo cat /var/lib/$k | tee $to/$k | return
  done
else
  # Reverse operation
  echo mkdir -p ~/.ssh ~/.mutt ~/usr/doc

  for i in ${files[*]}; do
    f=${i#*:}
    echo cp $to/d/${f##*/} -t ${f%/*}
  done

  echo cp $to/d/id_rsa* -t ~/.ssh/
  echo cp $to/d/pass* -t ~/.mutt/
  echo cp $to/d/links.* -t ~/usr/doc/
  echo cp $to/c/alias ~/.mutt/
fi

# Never forget
sync && fusermount -u $to && rmdir $to
