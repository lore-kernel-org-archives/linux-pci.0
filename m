Return-Path: <SRS0=HrOF=YA=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=HrOF=YA=wunner.de=lukas@kernel.org>
Message-Id: <cover.1481926599.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 17 Dec 2016 15:39:39 +0100
Subject: [PATCH v3 0/7] Runtime PM for Thunderbolt on Macs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>, Amir Levy <amir.jer.levy@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-ID: <linux-pci.vger.kernel.org>

Power down Thunderbolt controllers on Macs when nothing is plugged in
to save around 2W per controller.

Apple provides an ACPI-based (but nonstandard) mechanism to cut power
and signal hotplug during powerdown.  The usual way to implement such
nonstandard mechanisms seems to be a struct dev_pm_domain.
E.g. vga_switcheroo uses that for Optimus GPUs which control power
with ACPI DSMs.  Hence this third iteration of the series uses that
as well.  In v2 a more complicated approach was employed wherein power
control was exerted by a PCIe port service driver instead.

All the prep work went into 4.9 and 4.10, shrinking this series to just
7 patches:

- The actual "meat" of the series (to borrow a term from Bjorn) is in
  patches [6/7] and [7/7].  These two need an ack from Andreas.

- Patches [1/7] to [3/7] need an ack from Bjorn (and possibly Rafael or
  Mika).  They're fairly small and just add a bit to struct pci_dev
  signifying that a device is part of a Thunderbolt daisy chain, then
  use that bit to modify runtime PM for PCIe ports.  I'm also cc'ing
  Tomas and Amir at Intel Israel, if you guys have comments please shout.

- Patches [4/7] and [5/7] need an ack from Rafael.  Their sole purpose
  is to avoid a gratuitous WARN splat when assigning the struct
  dev_pm_domain.

I've pushed the patches to GitHub to ease reviewing/fetching:
https://github.com/l1k/linux/commits/thunderbolt_runpm_v3

Link to the previous iteration (v2, May 2016):
http://www.spinics.net/lists/linux-pci/msg51158.html

Thanks,

Lukas


Lukas Wunner (7):
  PCI: Recognize Thunderbolt devices
  PCI: Allow runtime PM on Thunderbolt ports
  PCI: Don't block runtime PM for Thunderbolt host hotplug ports
  Revert "PM / Runtime: Remove the exported function
    pm_children_suspended()"
  PM: Make requirements of dev_pm_domain_set() more precise
  thunderbolt: Power down controller when idle
  thunderbolt: Runtime suspend NHI when idle

 drivers/base/power/common.c  |  15 +-
 drivers/base/power/runtime.c |   3 +-
 drivers/pci/pci.c            |  20 ++-
 drivers/pci/pci.h            |   2 +
 drivers/pci/probe.c          |  34 +++++
 drivers/thunderbolt/Kconfig  |   3 +-
 drivers/thunderbolt/Makefile |   4 +-
 drivers/thunderbolt/nhi.c    |   5 +
 drivers/thunderbolt/power.c  | 356 +++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h  |  37 +++++
 drivers/thunderbolt/switch.c |   9 ++
 drivers/thunderbolt/tb.c     |  13 ++
 drivers/thunderbolt/tb.h     |   2 +
 include/linux/pci.h          |   1 +
 include/linux/pm_runtime.h   |   7 +
 15 files changed, 500 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

-- 
2.10.2
