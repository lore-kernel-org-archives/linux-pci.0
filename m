Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:52123 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeCJGJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Mar 2018 01:09:54 -0500
Date: Sat, 10 Mar 2018 07:09:51 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Peter Wu <peter@lekensteyn.nl>
Cc: dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        nouveau@lists.freedesktop.org, Imre Deak <imre.deak@intel.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        Raphael Doursenaud <rdoursenaud@free.fr>,
        Martin Lopatar <lopin@dataplex.cz>,
        Daniel Drake <dan@reactivated.net>,
        Denis Lisov <dennis.lissov@gmail.com>, zigarrre@gmail.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Modernize vga_switcheroo by using device link for
 HDA
Message-ID: <20180310060951.GA25550@wunner.de>
References: <cover.1520068884.git.lukas@wunner.de>
 <20180305205831.GA1397@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180305205831.GA1397@al>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Peter,

thanks a million for the extensive testing and reviewing.

I'll go through the issues you've found below, but it appears to me
that they're all either in the "works as intended" category or are
caused by something unrelated to this series:


On Mon, Mar 05, 2018 at 09:58:31PM +0100, Peter Wu wrote:
> Issue 1 - GPU does not suspend on text console.
> When present at the text console and an external monitor is connected
> through HDMI or DP, the RPM counter is 1. Only when the cable is removed
> (or when "echo off > /sys/class/drm/card1-HDMI-A-1/status"), the RPM
> count drops to 0 and the GPU device suspends. When Xorg is started
> (startx), the RPM counter also drops to 0 though.

Yes, that behavior is intended:  The GPU device is kept resumed as
long as it has an active crtc, and it has an active crtc if it's
used as text console.


> Issue 2 - RPM counter for audio function drops below 0 on system sleep.
> When both nouveau and snd-hda-intel are loaded and a HDMI (or DP?) cable
> is connected, the RPM counter becomes one after suspend/resume. This
> happens both with text console and Xorg.

Which RPM counter becomes one?  That of the GPU?  If so, it would be
caused by the GPU activating a crtc on hotplug to light up the display,
hence staying resumed.

I don't quite understand what you mean by "RPM counter for audio
function drops below 0 on system sleep".  I've gone through the HDA
code and don't see an unbalanced pm_runtime_get / _put.  However the
PM core changes the usage count a couple of times over a system sleep
cycle by acquiring/releasing a runtime PM ref or enabling/disabling
runtime PM (see drivers/base/power/main.c), maybe that's what you
observed.


> Issue 3 - invalid PCI config reads to audio device if disconnected.
> When no HDMI/DP cable is connected, the HDMI audio function will be
> inaccessible after runtime/system resume. Assume nouveau loaded before
> s/r, then loading snd-hda-intel will fail with:
> 
>     hdaudio hdaudioC1D0: no AFG or MFG node found
>     hdaudio hdaudioC1D1: no AFG or MFG node found
>     hdaudio hdaudioC1D2: no AFG or MFG node found
>     hdaudio hdaudioC1D3: no AFG or MFG node found
>     hdaudio hdaudioC1D4: no AFG or MFG node found
>     hdaudio hdaudioC1D5: no AFG or MFG node found
>     hdaudio hdaudioC1D6: no AFG or MFG node found
>     hdaudio hdaudioC1D7: no AFG or MFG node found
>     snd_hda_intel 0000:01:00.1: no codecs initialized

Okay, that's really bad, but it appears to be caused by the BIOS
hiding the audio function on resume if no cable is connected.
I've attached 3 patches to this bugzilla to fix this issue:
https://bugs.freedesktop.org/show_bug.cgi?id=75985

I've extensively tested system sleep in conjunction with the
switcheroo_devlink patches and the above never occurred on my
machine because the audio function is never hidden.

I don't consider this issue a blocker for the switcheroo_devlink
patches because I would expect it to occur regardless.  Quite to
the contrary, the switcheroo_devlink patches are a requirement to
fix the issue because the audio function needs to be exposed
either from the GPU driver or a PCI quirk applied to the GPU,
and the audio function needs to delay resume until that has
happened, which is achieved by the device link.


> Issue 4 - runtime_active_kids leak with audio function.
> After the above issue, the audio device never entered the suspended
> state even though the runtime_usage counter reached 0. It turned out
> that runtime_active_kids was 4. Every time snd-hda-intel is loaded (and
> fails to initialize due to the above issue), this counter is increased.

Yes, the codec devices are created as children of the HDA device
and keep it awake because initialization failed.  This won't occur
once issue 3 is fixed.


> Issue 5 - audio breaks after system sleep or stopping Xorg.
> When Xorg is stopped or the system sleep/resumes while speaker-test is
> active (e.g. in GNU screen), audio stops playing and speaker-test exits.

That is odd, I don't have an explanation for this but suspect a bug
in the sound code.


> Issue 6 - wrong pin status reported / no audio
> (Possibly "working as expected" since audio is tied to GPU function.)
> Scenario: HDMI cable is connected but GPU is unused
> ("echo off > /sys/class/drm/card1-HDMI-1-1/status" from console or
> with "xrandr --output HDMI-A-1 --off"). hdajacksensetest reports no
> HDMI pin presence even if connected, dmesg reports:
> 
>     nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1

Interesting, and yes, that would seem to be working as expected.


> Issue 7 - nouveau: warning after unloading after stopping Xorg
> (Issue in nouveau, likely not related to this patch set.)
> After "xrandr --output HDMI-1-1 --mode 2560x1440" in Xorg, stopping Xorg
> (and possibly "echo off > /sys/class/drm/card1-HDMI-A-1/status"),
> removing nouveau triggered:
> 
>     WARNING: CPU: 7 PID: 5475 at drivers/gpu/drm/drm_mode_config.c:439 drm_mode_config_cleanup+0x1fa/0x260

Okay, the driver was unloaded while the connector was still active.
You should also see a "connector HDMI-1-1 leaked!" message in dmesg.
I thought I had fixed this two years ago with commit 523872f6b072
("drm/nouveau: Turn off CRTCs on driver unload").  Either that commit
didn't work as it should or the issue reappeared.  :-(

So yes, it's a bug, but unrelated to the switcheroo_devlink patches.


> Issue 8 - acpi: sleeping function in atomic context.
> (Issue is likely not related to this patch set.)
> At some point I also got a BUG, nouveau was already unloaded and I ran:
> "echo 1 | tee /sys/bus/pci/devices/0000:01:00.{0,1}/remove"
> 
>     BUG: sleeping function called from invalid context at /home/peter/linux/mm/slab.h:419

Wow, that would seem to be a bug in ACPI code, sorry, I'm clueless
about that one. :-)

Once again thanks and let me know if unhiding the audio function
as per the patches I attached to the above-linked bugzilla fixes
issue 3.

Lukas
