Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: n0000b.n000b@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
Date: Tue, 26 Jun 2018 12:06:01 +0200
Message-ID: <35587465.8Nave9aG7d@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
handling for devices with no callbacks) introduced a system suspend
regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
port) to stay in D3 over suspend-to-RAM, which is a side effect of
setting power.direct_complete for the children of that bridge that
have no PM callbacks.

On the majority of systems PCI bridges are not allowed to be
runtime-suspended (the power/control sysfs attribute is set to "on"
for them by default), but user space can change that setting and if
it does so and a given bridge has no children with PM callbacks, the
direct_complete optimization will be applied to it and it will stay
in suspend over system suspend.  Apparently, that confuses the
platform firmware on the affected machine and that may very well
happen elsewhere, so avoid the direct_complete optimization for
PCI bridges with no drivers (if there is a driver, it should take
care of the PM handling) on suspend-to-RAM altogether (that should
not matter for suspend-to-idle as platform firmware is not involved
in it).

Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
Reported-by: n0000b.n000b@gmail.com
Tested-by: n0000b.n000b@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -638,6 +638,14 @@ static bool acpi_pci_need_resume(struct
 	if (acpi_target_system_state() == ACPI_STATE_S0)
 		return false;
 
+	/*
+	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
+	 * confuses the platform firmware, so avoid doing that, unless the
+	 * bridge has a driver that should take care of PM handling.
+	 */
+	if (pci_is_bridge(dev) && !dev->driver)
+		return true;
+
 	return !!adev->power.flags.dsw_present;
 }
 

