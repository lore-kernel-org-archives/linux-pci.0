Return-Path: <SRS0=Ark7=Y5=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=Ark7=Y5=wunner.de=lukas@kernel.org>
Message-Id: <cover.1484486499.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Jan 2017 21:03:45 +0100
Subject: [PATCH v5 0/8] Runtime PM for Thunderbolt on Macs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Chen Yu <yu.c.chen@intel.com>, Lee Jones <lee.jones@linaro.org>
List-ID: <linux-pci.vger.kernel.org>

Power down Thunderbolt controllers on Macs when nothing is plugged in
to save around 2W per controller.

For background info please see the cover letter of v3:
https://lkml.org/lkml/2016/12/17/56


Patches [1/8] to [3/8] need an ack from Bjorn and/or Rafael.
Patches [4/8] to [6/8] need an ack from Rafael.
Patches [7/8] to [8/8] need an ack from Andreas.


Changes since v4:

- Patch [2/8] has been reviewed by Mika. (Thanks!)

- Patch [3/8] now uses a separate helper function instead of stuffing
  its code into pci_dev_check_d3cold(), as requested by Mika.

As usual the patches can be reviewed/fetched on GitHub:
https://github.com/l1k/linux/commits/thunderbolt_runpm_v5

Thanks,

Lukas


Chen Yu (1):
  PM / sleep: Define constant for direct_complete

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
 drivers/pci/pci.c            |  27 +++-
 drivers/pci/pci.h            |   2 +
 drivers/pci/probe.c          |  34 +++++
 drivers/thunderbolt/Kconfig  |   3 +-
 drivers/thunderbolt/Makefile |   4 +-
 drivers/thunderbolt/nhi.c    |   5 +
 drivers/thunderbolt/power.c  | 355 +++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h  |  37 +++++
 drivers/thunderbolt/switch.c |   9 ++
 drivers/thunderbolt/tb.c     |  13 ++
 drivers/thunderbolt/tb.h     |   2 +
 include/linux/pci.h          |   1 +
 include/linux/pm.h           |   7 +
 include/linux/pm_runtime.h   |   7 +
 16 files changed, 513 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

-- 
2.11.0
