Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50882 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965203Ab2I1Vu5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Sep 2012 17:50:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM list <linux-pm@vger.kernel.org>
Subject: [RFD][PATCH 7/7] PM / ACPI: Take device PM QoS flags into account
Date: Fri, 28 Sep 2012 23:56:52 +0200
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>,
	linux-pci@vger.kernel.org,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	mark gross <markgross@thegnar.org>
References: <201209282351.10663.rjw@sisk.pl>
In-Reply-To: <201209282351.10663.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209282356.52558.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make ACPI power management routines and PCI power management
routines depending on ACPI take device PM QoS flags into account
when deciding what power state to put the device into.

In particular, after this change acpi_pm_device_sleep_state() will
not return ACPI_STATE_D3_COLD as the deepest available low-power
state if PM_QOS_FLAG_NO_POWER_OFF is requested for the device and it
will not require remote wakeup to work for the device in the returned
low-power state if there is at least one PM QoS flags request for the
device, but PM_QOS_FLAG_REMOTE_WAKEUP is not requested for it.

Accordingly, acpi_pci_set_power_state() will refuse to put the
device into D3cold if PM_QOS_FLAG_NO_POWER_OFF is requested for it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c   |   16 ++++++++++++----
 drivers/pci/pci-acpi.c |    8 +++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

Index: linux/drivers/pci/pci-acpi.c
===================================================================
--- linux.orig/drivers/pci/pci-acpi.c
+++ linux/drivers/pci/pci-acpi.c
@@ -17,6 +17,7 @@
 
 #include <linux/pci-acpi.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 #include "pci.h"
 
 static DEFINE_MUTEX(pci_acpi_pm_notify_mtx);
@@ -257,11 +258,16 @@ static int acpi_pci_set_power_state(stru
 		return -ENODEV;
 
 	switch (state) {
+	case PCI_D3cold:
+		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
+				PM_QOS_FLAGS_ALL) {
+			error = -EBUSY;
+			break;
+		}
 	case PCI_D0:
 	case PCI_D1:
 	case PCI_D2:
 	case PCI_D3hot:
-	case PCI_D3cold:
 		error = acpi_bus_set_power(handle, state_conv[state]);
 	}
 
Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 #include <asm/io.h>
 
@@ -711,6 +712,7 @@ int acpi_pm_device_sleep_state(struct de
 	struct acpi_device *adev;
 	char acpi_method[] = "_SxD";
 	unsigned long long d_min, d_max;
+	bool wakeup = false;
 
 	if (d_max_in < ACPI_STATE_D0 || d_max_in > ACPI_STATE_D3)
 		return -EINVAL;
@@ -718,6 +720,8 @@ int acpi_pm_device_sleep_state(struct de
 		printk(KERN_DEBUG "ACPI handle has no context!\n");
 		return -ENODEV;
 	}
+	if (dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) == PM_QOS_FLAGS_ALL)
+		d_max_in = ACPI_STATE_D3_HOT;
 
 	acpi_method[2] = '0' + acpi_target_sleep_state;
 	/*
@@ -737,8 +741,14 @@ int acpi_pm_device_sleep_state(struct de
 	 * NOTE: We rely on acpi_evaluate_integer() not clobbering the integer
 	 * provided -- that's our fault recovery, we ignore retval.
 	 */
-	if (acpi_target_sleep_state > ACPI_STATE_S0)
+	if (acpi_target_sleep_state > ACPI_STATE_S0) {
 		acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);
+		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
+			&& adev->wakeup.sleep_state >= acpi_target_sleep_state;
+	} else if (dev_pm_qos_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP) !=
+			PM_QOS_FLAGS_NONE) {
+		wakeup = adev->wakeup.flags.valid;
+	}
 
 	/*
 	 * If _PRW says we can wake up the system from the target sleep state,
@@ -747,9 +757,7 @@ int acpi_pm_device_sleep_state(struct de
 	 * (ACPI 3.x), it should return the maximum (lowest power) D-state that
 	 * can wake the system.  _S0W may be valid, too.
 	 */
-	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) && adev->wakeup.flags.valid &&
-	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
+	if (wakeup) {
 		acpi_status status;
 
 		acpi_method[3] = 'W';

