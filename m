Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61055 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752719AbdFLVET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2017 17:04:19 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 4/8] ACPI / PM: Clean up device wakeup enable/disable code
Date: Mon, 12 Jun 2017 22:51:07 +0200
Message-ID: <21723904.gpIm5LkHCV@aspire.rjw.lan>
In-Reply-To: <1615075.mBkoKApGGc@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan> <1615075.mBkoKApGGc@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The wakeup.flags.enabled flag in struct acpi_device is not used
consistently, as there is no reason why it should only apply
to the enabling/disabling of the wakeup GPE, so put the invocation
of acpi_enable_wakeup_device_power() under it too.

Moreover, it is not necessary to call
acpi_enable_wakeup_devices() and acpi_disable_wakeup_devices() for
suspend-to-idle, so don't do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   19 ++++++++-----------
 drivers/acpi/sleep.c     |    4 ++--
 2 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -688,26 +688,23 @@ static int acpi_device_wakeup(struct acp
 		acpi_status res;
 		int error;
 
+		if (adev->wakeup.flags.enabled)
+			return 0;
+
 		error = acpi_enable_wakeup_device_power(adev, target_state);
 		if (error)
 			return error;
 
-		if (adev->wakeup.flags.enabled)
-			return 0;
-
 		res = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-		if (ACPI_SUCCESS(res)) {
-			adev->wakeup.flags.enabled = 1;
-		} else {
+		if (ACPI_FAILURE(res)) {
 			acpi_disable_wakeup_device_power(adev);
 			return -EIO;
 		}
-	} else {
-		if (adev->wakeup.flags.enabled) {
-			acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-			adev->wakeup.flags.enabled = 0;
-		}
+		adev->wakeup.flags.enabled = 1;
+	} else if (adev->wakeup.flags.enabled) {
+		acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
 		acpi_disable_wakeup_device_power(adev);
+		adev->wakeup.flags.enabled = 0;
 	}
 	return 0;
 }
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -658,19 +658,19 @@ static int acpi_freeze_begin(void)
 
 static int acpi_freeze_prepare(void)
 {
-	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
+
 	return 0;
 }
 
 static void acpi_freeze_restore(void)
 {
-	acpi_disable_wakeup_devices(ACPI_STATE_S0);
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
+
 	acpi_enable_all_runtime_gpes();
 }
 
