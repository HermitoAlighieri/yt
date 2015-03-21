Function Play($my_args, $my_input) {
    If (($my_input -like "https*") -or ($my_input -like "http*")) {
        $search = $my_input;
    } Else {
        $search = "ytsearch:" + $my_input;
    }
    If ($my_args) {
        Switch($my_args) {
            "-nv" {mpv $(youtube-dl -f 140 -g "$search");} #-f 140 ==> m4a | audio only | DASH audio | audio@128k
            "-na" {mpv $(youtube-dl -f 134 -g "$search");} #-f 134 ==> mp4 | 360p       | DASH video | video only
            "-hq" {mpv $(youtube-dl -f best -g "$search");} #-f best usually ==> 720p/800p 
            default {Write-Warning "Unknown argument!";}
        }
    } Else {
        mpv --ytdl-format="worst,webm,mp4" $(youtube-dl -g "$search");
    }
}


If ($args[0] -like "-*") {
    Play -my_args $args[0] -my_input $args[1];
} ElseIf ($args[0]) {
    Play -my_input $args[0];
} Else {
    Write-Warning "Error: you gave no arguments!";
}