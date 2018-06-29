Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: n0000b.n000b@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
Date: Fri, 29 Jun 2018 10:34:40 +0200
Message-ID: <2518711.SfHWAsyaFM@aspire.rjw.lan>
In-Reply-To: <35587465.8Nave9aG7d@aspire.rjw.lan>
References: <35587465.8Nave9aG7d@aspire.rjw.lan>
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
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Make the patch work for PCI bridges without ACPI companion objects.

Since that doesn't really change the idea etc, but only makes the check
to be made earlier, I've added the Reviewed-by and Acked-by tags given to
the previous version.  If that's not right, please let me know.

---
 drivers/pci/pci-acpi.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -629,6 +629,15 @@ static bool acpi_pci_need_resume(struct
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 
+	/*
+	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
+	 * confuses the platform firmware, so avoid doing that, unless the
+	 * bridge has a driver that should take care of PM handling.
+	 */
+	if (pci_is_bridge(dev) && !dev->driver &&
+	    acpi_target_system_state() != ACPI_STATE_S0)
+		return true;
+
 	if (!adev || !acpi_device_power_manageable(adev))
 		return false;
 

