#!/usr/bin/env bash
# Download anime to nas every weekend if present
# Usage: anime.sh 'One Piece'

#-------------------------------------------------------------
# Variables
#-------------------------------------------------------------

# Download
usr='HorribleSubs'
vid="${1:-One Piece}"
res='1080p'
cmd='aria2c --seed-time=0'

# Destination
ser=192.168.1.150:/mnt/HD/HD_a2/ftp/ivan
nas=/mnt
loc=/video/$(echo ${vid/ /_} | tr [A-Z] [a-z])
tmp=/tmp/anime/${vid// /_}

# Globals
url='http://www.nyaa.se/?page=search&term='
key="%5B${usr}%5D+${vid/ /+}+${res}"

#-------------------------------------------------------------
# Main
#-------------------------------------------------------------

# Mount and change directory
mkdir -p ${nas} && mountpoint -q ${nas} || sudo mount ${ser} ${nas}
mkdir -p ${nas}${loc} && cd ${nas}${loc}

# Get the search result once
mkdir -p ${tmp%/*} && curl -x '' -sL ${url}${key} -o ${tmp}

# Get last episode and check
last_episode=$(ls * | sed -n "s/\[$usr\] $vid - \([0-9]*\) \[$res.*/\1/p" | tail -n1)
latest_video=$(sed "s/\[$usr\] $vid - \([0-9]*\) \[$res.*/\n\1/" ${tmp} | tail -n1)

for (( last_episode+=1 ; last_episode <= latest_video ; last_episode+=1 )); do
  # Get the url of the download link
  link=$(grep -sho "[^<]* $last_episode " ${tmp} | xurls \
    | sed 's/&#38;/\&/; s/view/download/; s|^.*//|https://|')

  echo $last_episode $link
  # Download the link
  ${cmd} "${link}" && notify-send "${vid}" "Episode $latest_video downloaded"
done && { rm -f *.torrent; exit 0; }
