Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:57951 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBRIio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Feb 2018 03:38:44 -0500
Message-Id: <cover.1518941072.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 18 Feb 2018 09:38:32 +0100
Subject: [PATCH 0/7] Modernize vga_switcheroo by using device link for HDA
To: dri-devel@lists.freedesktop.org
Cc: Peter Wu <peter@lekensteyn.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pierre Moreau <pierre.morrow@free.fr>,
        Bastien Nocera <hadess@hadess.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Modernize vga_switcheroo by using a "device link" to enforce a runtime PM
dependency from an HDA controller to the GPU it's integrated into.
Remove thereby obsoleted code and fix a bunch of bugs.
Device links were introduced in v4.10.

Users might see a small power saving if the discrete GPU is in use and
its HDA controller is not, because the HDA controller is now allowed
to runtime suspend to D3hot.  Probing and accessing the HDA controller
while the GPU is in D3cold should be very robust, unlike before.
Under the hood things become quite a bit leaner.

Also, this series gets us one step closer to supporting runtime PM on
muxed laptops such as the MacBook Pro because it fixes a deadlock
occurring when runtime resuming the discrete GPU on switching the mux.
(The deadlock occurs in vga_switcheroo_set_dynamic_switch() and that
function is obsoleted and removed by this series.)

The meat of the series is in patch [5/7], read its commit message for
details.  The other patches contain prep and cleanup work.

Patches [1/7], [2/7] and [5/7] require an ack from Bjorn (and Rafael?),
patch [5/7] requires an ack from Takashi.
Additionally I'd appreciate a Tested-by and/or Acked-by from Peter Wu,
the resident Nvidia Optimus expert, and from Alex for AMD PowerXpress
because my own testing only covers the MacBook Pro.
Testing and comments from anyone else are most welcome of course.

The series is based on 4.16-rc1.  To test it on 4.15, you need to
cherry-pick 7506dc798993 and 2fa6d6cdaf28.  For your convenience
I've pushed a 4.15-based branch to:
https://github.com/l1k/linux/commits/switcheroo_devlink_v1

Minimal test procedure for non-Macs:

- Note well: Recent Optimus require that a Mini-DP or HDMI cable is
  plugged in on boot for the HDA device to be present.

- Check that HDA, GPU and root port autosuspend when not in use:
  cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status  # HDA
  cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status  # GPU
  cat /sys/bus/pci/devices/0000:00:01.0/power/runtime_status  # Root Port

- Check that all three autoresume when accessing the HDA:
  hdajacksensetest -c 1

- Unbind the HDA controller:
  echo 0000:01:00.1 > /sys/bus/pci/drivers/snd_hda_intel/unbind
  Wait for GPU to power off, then rebind the HDA controller:
  echo 0000:01:00.1 > /sys/bus/pci/drivers/snd_hda_intel/bind
  Check dmesg for errors, try accessing HDA with hdajacksensetest.

- If your laptop uses the root port's _PR3 to cut power to the GPU:
  Unbind the GPU:
  echo 0000:01:00.0 > /sys/bus/pci/drivers/{nouveau,amdgpu,radeon}/unbind
  Allow runtime PM on the GPU:
  echo auto > /sys/bus/pci/devices/0000:01:00.0/power/control
  Wait for GPU to power off, then rebind it:
  echo 0000:01:00.0 > /sys/bus/pci/drivers/{nouveau,amdgpu,radeon}/bind
  Check dmesg for errors.  If you see any then we may need to perform
  further actions in pci_pm_runtime_resume(), see patch [1/7].

Thanks,

Lukas

Lukas Wunner (7):
  PCI: Restore BARs on runtime resume despite being unbound
  PCI: Make pci_wakeup_bus() & pci_bus_set_current_state() public
  vga_switcheroo: Update PCI current_state on power change
  vga_switcheroo: Deduplicate power state tracking
  vga_switcheroo: Use device link for HDA controller
  vga_switcheroo: Let HDA autosuspend on mux change
  drm/nouveau: Runtime suspend despite HDA being unbound

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   2 -
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  46 ----------
 drivers/gpu/drm/nouveau/nouveau_drv.h   |   1 -
 drivers/gpu/drm/radeon/radeon_drv.c     |   2 -
 drivers/gpu/vga/vga_switcheroo.c        | 152 ++++++++------------------------
 drivers/pci/pci-driver.c                |   8 +-
 drivers/pci/pci.c                       |  10 +--
 drivers/pci/pci.h                       |   1 +
 drivers/pci/quirks.c                    |  39 ++++++++
 include/linux/pci.h                     |   2 +
 include/linux/pci_ids.h                 |   1 +
 include/linux/vga_switcheroo.h          |   6 --
 include/sound/hdaudio.h                 |   3 -
 sound/pci/hda/hda_intel.c               |  36 +++++---
 sound/pci/hda/hda_intel.h               |   3 -
 15 files changed, 114 insertions(+), 198 deletions(-)

-- 
2.15.1
