Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 00/10] PCI: Allow D3cold for PCIe hierarchies
Date: Thu, 13 Sep 2018 17:33:12 +0300
Message-Id: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

This patch series aims to allow PCIe hierarchies enter D3cold both during
system sleep and runtime, including PCIe hotplug ports.

The motivation of this series are recent systems such as Lenovo Thinkpad X1
Carbon 6th gen and upcoming Dell laptops where the Thunderbolt controller
is always present in the system (pretty much like what Apple systems have
been doing for years). Because it is always present it consumes energy so
it is important to power it off when idle.

The PCIe root port hosting the Thunderbolt controller and all the connected
external PCIe devices includes a standard ACPI power resource and related
methods _PR3, _PR0, _PRW and _DSW that take care of the actual transition
to D3cold and back to D0.

With current kernels entering system sleep states leaves the root port into
D3hot which means the ACPI power resource is still on. This is bad when
system enters suspend-to-idle (all these systems are s2idle only) because
the BIOS is not involved and the devices are effectively left on, consuming
battery unnecessarily.

Patches 1-4 add D3cold support for system sleep and the subsequent patches
do the same for runtime PM.

In case someone wants to try out runtime PM, the xHCI controller that is
part of the PCIe switch below the root port needs to have runtime PM
"unblocked" manually (this will be automatic in future).

For Thinkpad:

  # echo auto > /sys/bus/pci/devices/0000:3b:00.0/power/control

For Dell:

  # echo auto > /sys/bus/pci/devices/0000:39:00.0/power/control

Note if the root port enters D3cold, running things like 'lspci' brings it
back t0 D0 (because PCI config space is not accessible in D3cold) so if one
wants to check out the power state without accidentally bringing the device
back into D0 needs to do that indirectly. If the root port is 1d.0 power
state can be checked:

  # cat /sys/bus/pci/devices/0000:00:1d.0/power/runtime_status
  suspended
  # cat /sys/bus/pci/devices/0000:00:1d.0/firmware_node/real_power_state
  D3cold

Even if this again revolves around Thunderbolt I think these apply to any
PCIe system supporting D3cold.

These patches apply on top of pci.git pci/hotplug. The previus version of
the series can be viewed here:

  https://www.spinics.net/lists/linux-acpi/msg83841.html

Changes from v1:

  * Updated comment in patch [1/10] according what Rafael suggested
  * Added empty line in patch [2/10]
  * Check for !pciehp_poll_mode in [4/10]
  * Use DPM_FLAG_NEVER_SKIP instead of DPM_FLAG_SMART_PREPARE which
    simplifies patch [5/10] signicantly 
  * Use const in acpi_data_get_property() and change int -> unsigned int
    in patch [9/10]
  * Added tags 

Mika Westerberg (10):
  PCI: Do not skip power managed bridges in pci_enable_wake()
  PCI / ACPI: Enable wake automatically for power managed bridges
  PCI: pciehp: Disable hotplug interrupt during suspend
  PCI: pciehp: Do not handle events if interrupts are masked
  PCI: portdrv: Resume upon exit from system suspend if left runtime suspended
  PCI: portdrv: Add runtime PM hooks for port service drivers
  PCI: pciehp: Implement runtime PM callbacks
  PCI/PME: Implement runtime PM callbacks
  ACPI / property: Allow multiple property compatible _DSD entries
  PCI / ACPI: Whitelist D3 for more PCIe hotplug ports

 drivers/acpi/property.c           | 97 ++++++++++++++++++++++---------
 drivers/acpi/x86/apple.c          |  2 +-
 drivers/gpio/gpiolib-acpi.c       |  2 +-
 drivers/pci/hotplug/pciehp.h      |  2 +
 drivers/pci/hotplug/pciehp_core.c | 37 ++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 16 ++++-
 drivers/pci/pci-acpi.c            | 57 +++++++++++++++++-
 drivers/pci/pci.c                 | 18 +++++-
 drivers/pci/pci.h                 |  3 +
 drivers/pci/pcie/pme.c            | 27 +++++++++
 drivers/pci/pcie/portdrv.h        |  4 ++
 drivers/pci/pcie/portdrv_core.c   | 20 +++++++
 drivers/pci/pcie/portdrv_pci.c    | 14 ++---
 include/acpi/acpi_bus.h           |  8 ++-
 include/linux/acpi.h              |  9 +++
 15 files changed, 273 insertions(+), 43 deletions(-)

-- 
2.18.0
