Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: teika kazura <teika@gmx.com>, Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
Date: Thu, 16 Aug 2018 12:56:46 +0200
Message-ID: <6401388.2t0qD3iTOr@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 26112ddc254c (PCI / ACPI / PM: Resume bridges w/o drivers on
suspend-to-RAM) attempted to fix a functional regression resulting
from commit c62ec4610c40 (PM / core: Fix direct_complete handling
for devices with no callbacks) by resuming PCI bridges without
drivers (that is, "parallel PCI" ones) during system-wide suspend if
the target system state is not ACPI S0 (working state).

That turns out insufficient, however, as it is reported that, at
least in one case, the platform firmware gets confused if a PCIe
root port is suspended before entering the ACPI S3 sleep state.

For this reason, drop the driver check from acpi_pci_need_resume()
and resume all bridges (including PCIe ports with drivers) during
system-wide suspend if the target system state is not ACPI S0.

[If the target system state is ACPI S0, it means suspend-to-idle
 and the platform firmware is not going to be invoked to actually
 suspend the system, so there is no need to resume the bridges in
 that case.]

Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
Reported-by: teika kazura <teika@gmx.com>
Tested-by: teika kazura <teika@gmx.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200675
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+: 26112ddc254c (PCI / ACPI / PM: Resume bridges ...)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -632,13 +632,11 @@ static bool acpi_pci_need_resume(struct
 	/*
 	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend over
 	 * system-wide suspend/resume confuses the platform firmware, so avoid
-	 * doing that, unless the bridge has a driver that should take care of
-	 * the PM handling.  According to Section 16.1.6 of ACPI 6.2, endpoint
+	 * doing that.  According to Section 16.1.6 of ACPI 6.2, endpoint
 	 * devices are expected to be in D3 before invoking the S3 entry path
 	 * from the firmware, so they should not be affected by this issue.
 	 */
-	if (pci_is_bridge(dev) && !dev->driver &&
-	    acpi_target_system_state() != ACPI_STATE_S0)
+	if (pci_is_bridge(dev) && acpi_target_system_state() != ACPI_STATE_S0)
 		return true;
 
 	if (!adev || !acpi_device_power_manageable(adev))
