#!/bin/zsh

cecho(){
    bold=$(tput bold)
    green=$(tput setaf 2)
    reset=$(tput sgr0)
    echo $bold$green"$1"$reset
}

isSpotifyRunning() {
    if [ "$(osascript -e 'application "Spotify" is running')" = "false" ]; then
        return 1
    else
        return 0
    fi
}

showArtist() {
    echo $(osascript -e 'tell application "Spotify" to artist of current track as string')
}

showAlbum() {
    echo $(osascript -e 'tell application "Spotify" to album of current track as string')
}

showTrack() {
    echo $(osascript -e 'tell application "Spotify" to name of current track as string')
}

showState() {
    echo $(osascript -e 'tell application "Spotify" to player state as string')
}

showDuration() {
    echo $(osascript -e 'tell application "Spotify"
            set durSec to (duration of current track / 1000) as text
            set tM to (round (durSec / 60) rounding down) as text
            if length of ((durSec mod 60 div 1) as text) is greater than 1 then
                set tS to (durSec mod 60 div 1) as text
            else
                set tS to ("0" & (durSec mod 60 div 1)) as text
            end if
            set myTime to tM as text & ":" & tS as text
            end tell
            return myTime')
}

getDurationSeconds() {
    echo $(osascript -e 'tell application "Spotify" to (duration of current track / 1000) as integer')
}

showPosition() {
    echo $(osascript -e 'tell application "Spotify"
            set pos to player position
            set nM to (round (pos / 60) rounding down) as text
            if length of ((round (pos mod 60) rounding down) as text) is greater than 1 then
                set nS to (round (pos mod 60) rounding down) as text
            else
                set nS to ("0" & (round (pos mod 60) rounding down)) as text
            end if
            set nowAt to nM as text & ":" & nS as text
            end tell
            return nowAt')
}

getPositionSeconds() {
    echo $(osascript -e 'tell application "Spotify" to player position as integer')
}

showProgress() {
    duration=$(getDurationSeconds)
    position=$(getPositionSeconds)
    progress=$(echo "scale=4; $position / $duration" | bc)
    progressInt=$(echo "($progress * 24) / 1" | bc)

    case $progressInt in
        24) echo "███" ;;
        23) echo "██▉" ;;
        22) echo "██▊" ;;
        21) echo "██▋" ;;
        20) echo "██▌" ;;
        19) echo "██▍" ;;
        18) echo "██▎" ;;
        17) echo "██▏" ;;
        16) echo "██ " ;;
        15) echo "█▉ " ;;
        14) echo "█▊ " ;;
        13) echo "█▋ " ;;
        12) echo "█▌ " ;;
        11) echo "█▍ " ;;
        10) echo "█▎ " ;;
        9)  echo "█▏ " ;;
        8)  echo "█  " ;;
        7)  echo "▉  " ;;
        6)  echo "▊  " ;;
        5)  echo "▋  " ;;
        4)  echo "▌  " ;;
        3)  echo "▍  " ;;
        2)  echo "▎  " ;;
        1)  echo "▏  " ;;
        *)  echo "   " ;;
    esac
}

showStatus () {
    if isSpotifyRunning; then
        state=$(showState)
        cecho "Spotify is currently $state."
        duration=$(showDuration)
        position=$(showPosition)
        progress=$(showProgress)

        echo -e $reset"Artist: $(showArtist)\nAlbum: $(showAlbum)\nTrack: $(showTrack)\nPosition: $position / $duration\nProgress: $progress"
    fi
}

showStatusMini() {
    if isSpotifyRunning; then
        progress=$(showProgress)
        artist=$(showArtist)
        track=$(showTrack)
        statusLine="#[fg=#f38ba8,bg=#49507a,bold]$progress#[fg=#49507a,bg=#a6e3a1,bold] $artist  $track"
        # statusLine="$progress $artist - $track"
        
        # Truncate if longer than 35 characters
        # if [ ${#statusLine} -gt 35 ]; then
        #     statusLine="${statusLine:0:32}..."
        # fi
        if [ ${#statusLine} -gt 90 ]; then # 32 + 58 (the 58 is the length of the color explination)
            statusLine="${statusLine:0:87}..."
        fi
        
        echo $statusLine
    fi
}

# showStatus
showStatusMini
