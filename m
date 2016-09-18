Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <cover.1474130360.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 18 Sep 2016 05:39:20 +0200
Subject: [PATCH v2 0/5] PCI PM refinements
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's the second installment of this series, based on feedback from
Rafael. (Thanks!)

To reiterate, these refinements are meant to speed up and reduce power
consumption when entering and leaving system sleep and when shutting
down the system.  For details, please refer to the cover letter of v1:
http://www.spinics.net/lists/linux-pci/msg53702.html

As usual I've pushed the patches to GitHub in case anyone prefers
reviewing in a GUI:
https://github.com/l1k/linux/commits/pci_pm_refinements_v2


Changes since v1:

* Patch [1/5] now sports an ack by Rafael.

* Patch [2/5]:
  * In acpi_pci_get_power_state(), only check for ACPI_STATE_UNKNOWN
    instead of ACPI_STATE_D0 and ACPI_STATE_D3_COLD.
  * Move the change to pci_update_current_state() to new patch [3/5].

* Patch [3/5]:
  * Instead of solely relying on the platform firmware to report D3cold,
    also probe the vendor ID and assume D3cold if it can't be read.
    This should ensure proper detection of D3cold on pre-ACPI 4.0
    platforms (which will never report anything deeper than D3hot)
    as well as for devices with nonstandard PM mechanisms.
  * The two existing workarounds for D3cold are removed from
    pci_update_current_state(), as explained in the commit message.

* Patch [5/5]:
  * Disable runtime PM on the device to prevent it from being runtime
    resumed during the remainder of the shutdown process.

Thanks,

Lukas


Lukas Wunner (5):
  PCI: Afford direct-complete to devices with nonstandard PM
  PCI: Query platform firmware for device power state
  PCI: Recognize D3cold in pci_update_current_state()
  PCI: Avoid unnecessary resume after direct-complete
  PCI: Avoid unnecessary resume on shutdown

 drivers/pci/pci-acpi.c   | 22 ++++++++++++++++++++
 drivers/pci/pci-driver.c | 24 ++++++++++++++++++++--
 drivers/pci/pci.c        | 52 ++++++++++++++++++++++++++++++++----------------
 drivers/pci/pci.h        |  3 +++
 4 files changed, 82 insertions(+), 19 deletions(-)

-- 
2.9.3

