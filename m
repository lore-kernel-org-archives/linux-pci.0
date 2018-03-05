Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:39797 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbeCEVUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 16:20:39 -0500
Date: Mon, 5 Mar 2018 21:58:31 +0100
From: Peter Wu <peter@lekensteyn.nl>
To: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20180305205831.GA1397@al>
References: <cover.1520068884.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520068884.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,

Sorry for the delay, I finally found some time to reviewd and test the
patches and found some issues (some of them might already be present in
v4.15 without your patches though, I did not try).

Test environment:
- Branch switcheroo_devlink_v2 (commit v4.15-20-gb33d50c5c6ad)
- Laptop: Clevo P651RA (nouveau uses PR3), lspci:
  00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
  01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM204M [GeForce GTX 965M] [10de:13d9] (rev a1)
  01:00.1 Audio device [0403]: NVIDIA Corporation GM204 High Definition Audio Controller [10de:0fbb] (rev a1)
- Distribution: Arch Linux x86_64
- Tested from (1) console and (2) Xorg 1.19.3-2 (Openbox)
- Booted with HDMI cable connected and nouveau/snd-hda-intel unloaded.

To check the runtime PM status, I used this "rpm-status" script:

    grep --color . /sys/bus/pci/devices/0000:00:01.0/{0000:01:00.0/,0000:01:00.1/,}power/control
    grep --color . /sys/bus/pci/devices/0000:00:01.0/{0000:01:00.0/,0000:01:00.1/,}power/runtime_{enabled,usage,active_kids,status}


To test audio output (via HDMI; DP port does not seem to support audio):

    speaker-test -Dhdmi:CARD=NVidia,DEV=0 -c2

Below I first list some issues, then some good news.

Issue 1 - GPU does not suspend on text console.
When present at the text console and an external monitor is connected
through HDMI or DP, the RPM counter is 1. Only when the cable is removed
(or when "echo off > /sys/class/drm/card1-HDMI-A-1/status"), the RPM
count drops to 0 and the GPU device suspends. When Xorg is started
(startx), the RPM counter also drops to 0 though.

Issue 2 - RPM counter for audio function drops below 0 on system sleep.
When both nouveau and snd-hda-intel are loaded and a HDMI (or DP?) cable
is connected, the RPM counter becomes one after suspend/resume. This
happens both with text console and Xorg.

Issue 3 - invalid PCI config reads to audio device if disconnected.
When no HDMI/DP cable is connected, the HDMI audio function will be
inaccessible after runtime/system resume. Assume nouveau loaded before
s/r, then loading snd-hda-intel will fail with:

    0]: pam_unix(sudo:session): session closed for user root
    hdaudio hdaudioC1D0: no AFG or MFG node found
    hdaudio hdaudioC1D1: no AFG or MFG node found
    hdaudio hdaudioC1D2: no AFG or MFG node found
    hdaudio hdaudioC1D3: no AFG or MFG node found
    hdaudio hdaudioC1D4: no AFG or MFG node found
    hdaudio hdaudioC1D5: no AFG or MFG node found
    hdaudio hdaudioC1D6: no AFG or MFG node found
    hdaudio hdaudioC1D7: no AFG or MFG node found
    snd_hda_intel 0000:01:00.1: no codecs initialized

After rmmod snd-hda-intel and system suspend/resume:

    pci 0000:01:00.1: restoring config space at offset 0x3c (was 0xffffffff, writing 0x200)
    pci 0000:01:00.1: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
    pci 0000:01:00.1: restoring config space at offset 0x34 (was 0xffffffff, writing 0x60)

This persists until removing both PCI devices and rescanning the root
port. (When no HDMI/DP cable is connected, the audio function will not
appear; remove+rescan is required to recover.)

Issue 4 - runtime_active_kids leak with audio function.
After the above issue, the audio device never entered the suspended
state even though the runtime_usage counter reached 0. It turned out
that runtime_active_kids was 4. Every time snd-hda-intel is loaded (and
fails to initialize due to the above issue), this counter is increased.

Issue 5 - audio breaks after system sleep or stopping Xorg.
When Xorg is stopped or the system sleep/resumes while speaker-test is
active (e.g. in GNU screen), audio stops playing and speaker-test exits.

Issue 6 - wrong pin status reported / no audio
(Possibly "working as expected" since audio is tied to GPU function.)
Scenario: HDMI cable is connected but GPU is unused
("echo off > /sys/class/drm/card1-HDMI-1-1/status" from console or
with "xrandr --output HDMI-A-1 --off"). hdajacksensetest reports no
HDMI pin presence even if connected, dmesg reports:

    nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1

Using "speaker-test", the program does not fail but no sound can be
heard either.

Issue 7 - nouveau: warning after unloading after stopping Xorg
(Issue in nouveau, likely not related to this patch set.)
After "xrandr --output HDMI-1-1 --mode 2560x1440" in Xorg, stopping Xorg
(and possibly "echo off > /sys/class/drm/card1-HDMI-A-1/status"),
removing nouveau triggered:

    WARNING: CPU: 7 PID: 5475 at drivers/gpu/drm/drm_mode_config.c:439 drm_mode_config_cleanup+0x1fa/0x260
    CPU: 7 PID: 5475 Comm: rmmod Not tainted 4.15.0testing-00020-gb33d50c5c6ad #55
    RIP: 0010:drm_mode_config_cleanup+0x1fa/0x260
    [..]
    Call Trace:
     nouveau_display_destroy+0x41/0x80 [nouveau]
     nouveau_drm_unload+0x6b/0xd0 [nouveau]
     drm_dev_unregister+0x3c/0xe0
     drm_put_dev+0x2e/0x60
     nouveau_drm_device_remove+0x37/0x50 [nouveau]
     pci_device_remove+0x36/0xb0
     device_release_driver_internal+0x160/0x230
     driver_detach+0x3a/0x70
     bus_remove_driver+0x58/0xd0
     pci_unregister_driver+0x3b/0x90
     nouveau_drm_exit+0x15/0x432 [nouveau]
     SyS_delete_module+0x16c/0x230

Issue 8 - acpi: sleeping function in atomic context.
(Issue is likely not related to this patch set.)
At some point I also got a BUG, nouveau was already unloaded and I ran:
"echo 1 | tee /sys/bus/pci/devices/0000:01:00.{0,1}/remove"

    BUG: sleeping function called from invalid context at /home/peter/linux/mm/slab.h:419
    in_atomic(): 1, irqs_disabled(): 0, pid: 4844, name: kworker/3:4
    INFO: lockdep is turned off.
    CPU: 3 PID: 4844 Comm: kworker/3:4 Tainted: G        W        4.15.0testing-00020-gb33d50c5c6ad #55
    Hardware name: Notebook                         P65_P67RGRERA/P65_P67RGRERA, BIOS 1.05.16 05/16/2016
    Workqueue: events_power_efficient srcu_invoke_callbacks
    Call Trace:
     dump_stack+0x5f/0x86
     ___might_sleep+0x20c/0x240
     kmem_cache_alloc_trace+0x4d/0x230
     acpi_ut_evaluate_object+0x68/0x23c
     ? srcu_invoke_callbacks+0xa2/0x150
     acpi_rs_get_prt_method_data+0x42/0xa2
     acpi_get_irq_routing_table+0x70/0x9f
     ? __slab_free+0x11c/0x380
     acpi_pci_irq_find_prt_entry+0x83/0x330
     ? srcu_invoke_callbacks+0xa2/0x150
     acpi_pci_irq_lookup+0x27/0x2e0
     acpi_pci_irq_disable+0x45/0xb0
     pci_release_dev+0x29/0x60
     device_release+0x2d/0x80
     kobject_put+0xb7/0x190
     __device_link_free_srcu+0x32/0x40
     srcu_invoke_callbacks+0xba/0x150
     process_one_work+0x273/0x670
     worker_thread+0x4a/0x400
     kthread+0x100/0x140
     ? process_one_work+0x670/0x670
     ? kthread_create_worker_on_cpu+0x50/0x50
     ? do_syscall_64+0x56/0x1a0
     ? SyS_exit_group+0x10/0x10

Issue 9 - potential memory corruption.
At some point (possibly after issue 7, but I am not fully sure), I saw
an artifact in the text console which would persist even when switching
between consoles. It was gone after system sleep/resume. If I remember
correctly, it looked like something from a Xorg session which I killed
before.

That was the bad news, the good news:
- Loading nouveau and snd-hda-intel (in any order) while RPM is enabled
  and the port was in D3cold works.
- RPM interaction between audio and GPU seems good, when audio resumes,
  the GPU RPM counter increments, when audio suspends it decrements.
- As the GPU enters D3cold, I can observe significant power savings
  through /sys/class/power_supply/BAT0/ (no regressions here).
- In a default configuration I have no audio function (see also nouveau
  bug https://bugs.freedesktop.org/show_bug.cgi?id=75985) so most of the
  above issues should not occur.

Hope it helps, and if desired you can add:
Tested-by: Peter Wu <peter@lekensteyn.nl>

For the following patches, you can also add my Reviewed-by:

    vga_switcheroo: Update PCI current_state on power change
    vga_switcheroo: Deduplicate power state tracking
    vga_switcheroo: Use device link for HDA controller
    vga_switcheroo: Let HDA autosuspend on mux change
    drm/nouveau: Runtime suspend despite HDA being unbound

The two other PCI patches look fine as well.

Kind regards,
Peter

On Sat, Mar 03, 2018 at 10:53:24AM +0100, Lukas Wunner wrote:
> Modernize vga_switcheroo by using a device link to enforce a runtime PM
> dependency from an HDA controller to the GPU it's integrated into, v2.
> 
> Changes since v1:
> 
> - Replace patch [1/7] to use pci_save_state() / pci_restore_state()
>   for consistency between runtime PM code path of bound and unbound
>   devices. (Rafael, Bjorn)
> 
> - Patch [5/7]: Drop an unnecessary initialization. (Bjorn)
>   Rephrase error message on failed link addition for clarity.
> 
> Link to v1:
> https://www.spinics.net/lists/dri-devel/msg165889.html
> 
> Testing on more machines would be greatly appreciated, particularly
> Nvidia Optimus or AMD PowerXpress.
> 
> The series is based on 4.16-rc3.  To test it on 4.15, you need to
> cherry-pick 7506dc798993 and 2fa6d6cdaf28.  For your convenience
> I've pushed a 4.15-based branch to:
> https://github.com/l1k/linux/commits/switcheroo_devlink_v2
> 
> Minimal test procedure:
> 
> - Note well: Recent Optimus require that a Mini-DP or HDMI cable is
>   plugged in on boot for the HDA device to be present.
> 
> - Check that HDA, GPU and root port autosuspend when not in use:
>   cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status  # HDA
>   cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status  # GPU
>   cat /sys/bus/pci/devices/0000:00:01.0/power/runtime_status  # Root Port
> 
> - Check that all three autoresume when accessing the HDA:
>   hdajacksensetest -c 1
> 
> - Unbind the HDA controller:
>   echo 0000:01:00.1 > /sys/bus/pci/drivers/snd_hda_intel/unbind
>   Wait for GPU to power off, then rebind the HDA controller:
>   echo 0000:01:00.1 > /sys/bus/pci/drivers/snd_hda_intel/bind
>   Check dmesg for errors, try accessing HDA with hdajacksensetest.
> 
> - If your laptop uses the root port's _PR3 to cut power to the GPU:
>   Unbind the GPU:
>   echo 0000:01:00.0 > /sys/bus/pci/drivers/{nouveau,amdgpu,radeon}/unbind
>   Allow runtime PM on the GPU:
>   echo auto > /sys/bus/pci/devices/0000:01:00.0/power/control
>   Wait for GPU to power off, then rebind it:
>   echo 0000:01:00.0 > /sys/bus/pci/drivers/{nouveau,amdgpu,radeon}/bind
>   Check dmesg for errors.  If you see any then we may need to perform
>   further actions in pci_pm_runtime_resume(), see patch [1/7].
> 
> Thanks,
> 
> Lukas
> 
> 
> Lukas Wunner (6):
>   PCI: Make pci_wakeup_bus() & pci_bus_set_current_state() public
>   vga_switcheroo: Update PCI current_state on power change
>   vga_switcheroo: Deduplicate power state tracking
>   vga_switcheroo: Use device link for HDA controller
>   vga_switcheroo: Let HDA autosuspend on mux change
>   drm/nouveau: Runtime suspend despite HDA being unbound
> 
> Rafael J. Wysocki (1):
>   PCI: Restore config space on runtime resume despite being unbound
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   2 -
>  drivers/gpu/drm/nouveau/nouveau_drm.c   |  46 ----------
>  drivers/gpu/drm/nouveau/nouveau_drv.h   |   1 -
>  drivers/gpu/drm/radeon/radeon_drv.c     |   2 -
>  drivers/gpu/vga/vga_switcheroo.c        | 152 ++++++++------------------------
>  drivers/pci/pci-driver.c                |  17 ++--
>  drivers/pci/pci.c                       |   8 +-
>  drivers/pci/quirks.c                    |  39 ++++++++
>  include/linux/pci.h                     |   2 +
>  include/linux/pci_ids.h                 |   1 +
>  include/linux/vga_switcheroo.h          |   6 --
>  include/sound/hdaudio.h                 |   3 -
>  sound/pci/hda/hda_intel.c               |  36 +++++---
>  sound/pci/hda/hda_intel.h               |   3 -
>  14 files changed, 117 insertions(+), 201 deletions(-)
> 
> -- 
> 2.15.1
> 
