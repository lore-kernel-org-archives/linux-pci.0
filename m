Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:37425 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCCJx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Mar 2018 04:53:57 -0500
Message-Id: <cover.1520068884.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 3 Mar 2018 10:53:24 +0100
Subject: [PATCH v2 0/7] Modernize vga_switcheroo by using device link for HDA
To: dri-devel@lists.freedesktop.org
Cc: Peter Wu <peter@lekensteyn.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        nouveau@lists.freedesktop.org, Imre Deak <imre.deak@intel.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        Raphael Doursenaud <rdoursenaud@free.fr>,
        Martin Lopatar <lopin@dataplex.cz>,
        Daniel Drake <dan@reactivated.net>,
        Denis Lisov <dennis.lissov@gmail.com>, zigarrre@gmail.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Modernize vga_switcheroo by using a device link to enforce a runtime PM
dependency from an HDA controller to the GPU it's integrated into, v2.

Changes since v1:

- Replace patch [1/7] to use pci_save_state() / pci_restore_state()
  for consistency between runtime PM code path of bound and unbound
  devices. (Rafael, Bjorn)

- Patch [5/7]: Drop an unnecessary initialization. (Bjorn)
  Rephrase error message on failed link addition for clarity.

Link to v1:
https://www.spinics.net/lists/dri-devel/msg165889.html

Testing on more machines would be greatly appreciated, particularly
Nvidia Optimus or AMD PowerXpress.

The series is based on 4.16-rc3.  To test it on 4.15, you need to
cherry-pick 7506dc798993 and 2fa6d6cdaf28.  For your convenience
I've pushed a 4.15-based branch to:
https://github.com/l1k/linux/commits/switcheroo_devlink_v2

Minimal test procedure:

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


Lukas Wunner (6):
  PCI: Make pci_wakeup_bus() & pci_bus_set_current_state() public
  vga_switcheroo: Update PCI current_state on power change
  vga_switcheroo: Deduplicate power state tracking
  vga_switcheroo: Use device link for HDA controller
  vga_switcheroo: Let HDA autosuspend on mux change
  drm/nouveau: Runtime suspend despite HDA being unbound

Rafael J. Wysocki (1):
  PCI: Restore config space on runtime resume despite being unbound

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   2 -
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  46 ----------
 drivers/gpu/drm/nouveau/nouveau_drv.h   |   1 -
 drivers/gpu/drm/radeon/radeon_drv.c     |   2 -
 drivers/gpu/vga/vga_switcheroo.c        | 152 ++++++++------------------------
 drivers/pci/pci-driver.c                |  17 ++--
 drivers/pci/pci.c                       |   8 +-
 drivers/pci/quirks.c                    |  39 ++++++++
 include/linux/pci.h                     |   2 +
 include/linux/pci_ids.h                 |   1 +
 include/linux/vga_switcheroo.h          |   6 --
 include/sound/hdaudio.h                 |   3 -
 sound/pci/hda/hda_intel.c               |  36 +++++---
 sound/pci/hda/hda_intel.h               |   3 -
 14 files changed, 117 insertions(+), 201 deletions(-)

-- 
2.15.1
