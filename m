Return-Path: <SRS0=aNbu=YW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=aNbu=YW=wunner.de=lukas@kernel.org>
Message-Id: <cover.1483806825.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 8 Jan 2017 09:41:45 +0100
Subject: [PATCH v4 0/8] Runtime PM for Thunderbolt on Macs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Amir Levy <amir.jer.levy@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

Power down Thunderbolt controllers on Macs when nothing is plugged in
to save around 2W per controller.

For details see the cover letter of v3:
https://lkml.org/lkml/2016/12/17/56


Patches [1/7] to [3/7] need an ack from Bjorn (and possibly Rafael or
Mika).  Patches [4/7] to [6/7] need an ack from Rafael.


Changes since v3:

- Additional patch [6/8] by Chen Yu to define a DPM_DIRECT_COMPLETE macro.
  I had expected this to land in v4.10 but it didn't.

- Rework patch [7/8] ("thunderbolt: Power down controller when idle")
  according to Andy Shevchenko's feedback:  Drop unnecessary #ifdef pr_fmt,
  add explanatory comments, rename goto labels.

- Fix error path if the upstream bridge cannot be found.

The patches are also browseable on GitHub:
https://github.com/l1k/linux/commits/thunderbolt_runpm_v4

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
 drivers/pci/pci.c            |  20 ++-
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
 16 files changed, 506 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

-- 
2.11.0
