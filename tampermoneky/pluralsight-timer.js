// ==UserScript==
// @name PluralSight custom speeds
// @namespace https://techotom.wordpress.com
// @version 0.1
// @description more fasterer
// @author Tom
// @match https://app.pluralsight.com/player*
// @match https://app.pluralsight.com/course-player*
// @match https://app.pluralsight.com/projects/*
// @grant none
// ==/UserScript==
(function () {
    // some text
    'use strict';

    var console = console || {};
    var className = 'speed-selector';

    var playerSettings = JSON.parse(
        localStorage.getItem('ps-embeddable-player-settings'),
    );

    if (!playerSettings) {
        playerSettings = {};
    }

    playerSettings.volume = 1;
    playerSettings.preferredResolutions =
        {
            "mp4": {
                "height": 720,
                "width": 1280,
                "index": 0
            },
            "webm": {
                "height": 720,
                "width": 1280,
                "index": 0
            },
            "hls": {
                "height": 720,
                "width": 1280,
                "index": 5
            }
        };

    localStorage.setItem(
        'ps-embeddable-player-settings',
        JSON.stringify(playerSettings),
    );

    function resetBoldness() {
        var speedSelectors = document.getElementsByClassName(className);
        for (var i = 0; i < speedSelectors.length; i++) {
            var curr = speedSelectors[i];
            curr.style.fontWeight = 'normal';
        }
    }

    function appendSpeedControl(div, speed) {
        var speedAnchor = document.createElement("a");
        speedAnchor.style.display = "block";
        speedAnchor.style.cursor = "pointer";
        speedAnchor.onclick = function () {
            // FIXME this doesn't work to change the speed on-the-fly as of
            // 2019-Nov-25. There's an `onSeek` function (line 26131 of the
            // formatted, minified 0.0.70 embeddable-player code) that is capable of
            // changing the speed if you use the debugger to change the value of
            // playbackSpeed. Getting inside the closure seems to be a challenge
            // though. Otherwise, we need to find a way to make the player read the
            // fresh values from localStorage. It does change the speed if you
            // refresh the page though. Not ideal but it works.
            var playerSettings = JSON.parse(
                localStorage.getItem('ps-embeddable-player-settings'),
            );

            if (!playerSettings) {
                playerSettings = {};
            }

            playerSettings.playbackSpeed = speed;
            localStorage.setItem(
                'ps-embeddable-player-settings',
                JSON.stringify(playerSettings),
            );
            getPlayPauseButton().click();
            getPlayPauseButton().click();
            // force page refresh
            window.location.reload();
            resetBoldness();
            this.style.fontWeight = 'bold';
        };
        speedAnchor.classList.add('speed-selector');
        var label = document.createTextNode(speed + "x");
        speedAnchor.appendChild(label);
        div.appendChild(speedAnchor);
    }

    function getPlayPauseButton() {
        var playBtn = document.querySelectorAll('[data-text="Play (k)"] button')[0]
        if (playBtn) {
            return playBtn
        }
        var pauseBtn = document.querySelectorAll(
            '[data-text="Pause (k)"] button',
        )[0]
        if (pauseBtn) {
            return pauseBtn
        }
        throw new Error(
            'Cannot find the play/pause button. The UI has ' +
            'probably changed and we need a code update to follow it.',
        )
    }

    var body = document.getElementsByTagName('body')[0];
    var div = document.createElement("div");
    div.style.position = "fixed";
    div.style.margin = "1em";
    div.style.fontSize = "1.5em";
    div.style.background = "#black !important";
    div.style.zIndex = "2147483638";
    div.style.width = "3em";
    div.style.marginTop = "20em";
    div.style.opacity = ".8";
    appendSpeedControl(div, 1);
    appendSpeedControl(div, 1.6);
    appendSpeedControl(div, 1.8);
    appendSpeedControl(div, 2);
    appendSpeedControl(div, 2.1);
    appendSpeedControl(div, 2.2);
    appendSpeedControl(div, 2.3);
    appendSpeedControl(div, 2.4);
    appendSpeedControl(div, 2.5);
    appendSpeedControl(div, 2.6);
    appendSpeedControl(div, 2.7);
    appendSpeedControl(div, 2.8);
    appendSpeedControl(div, 3);
    appendSpeedControl(div, 3.2);
    appendSpeedControl(div, 3.5);
    body.insertBefore(div, body.childNodes[0]);
})();
