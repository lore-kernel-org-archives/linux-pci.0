Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41400 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751750AbdJPBnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Oct 2017 21:43:05 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/12] PCI / PM: Take SMART_SUSPEND driver flag into account
Date: Mon, 16 Oct 2017 03:29:47 +0200
Message-ID: <12906785.qsTjxC3pk6@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the PCI bus type take DPM_FLAG_SMART_SUSPEND into account in its
system suspend callbacks and make sure that all code that should not
run in parallel with pci_pm_runtime_resume() is executed in the "late"
phases of system suspend, freeze and poweroff transitions.

[Note that the pm_runtime_suspended() check in pci_dev_keep_suspended()
is an optimization, because if is not passed, all of the subsequent
checks may be skipped and some of them are much more overhead in
general.]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
---
 Documentation/power/pci.txt |    6 ++++
 drivers/pci/pci-driver.c    |   56 ++++++++++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -727,18 +727,25 @@ static int pci_pm_suspend(struct device
 
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
-		goto Fixup;
+		return 0;
 	}
 
 	/*
-	 * PCI devices suspended at run time need to be resumed at this point,
-	 * because in general it is necessary to reconfigure them for system
-	 * suspend.  Namely, if the device is supposed to wake up the system
-	 * from the sleep state, we may need to reconfigure it for this purpose.
-	 * In turn, if the device is not supposed to wake up the system from the
-	 * sleep state, we'll have to prevent it from signaling wake-up.
+	 * PCI devices suspended at run time may need to be resumed at this
+	 * point, because in general it may be necessary to reconfigure them for
+	 * system suspend.  Namely, if the device is expected to wake up the
+	 * system from the sleep state, it may have to be reconfigured for this
+	 * purpose, or if the device is not expected to wake up the system from
+	 * the sleep state, it should be prevented from signaling wakeup events
+	 * going forward.
+	 *
+	 * Also if the driver of the device does not indicate that its system
+	 * suspend callbacks can cope with runtime-suspended devices, it is
+	 * better to resume the device from runtime suspend here.
 	 */
-	pm_runtime_resume(dev);
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	    !pci_dev_keep_suspended(pci_dev))
+		pm_runtime_resume(dev);
 
 	pci_dev->state_saved = false;
 	if (pm->suspend) {
@@ -758,12 +765,16 @@ static int pci_pm_suspend(struct device
 		}
 	}
 
- Fixup:
-	pci_fixup_device(pci_fixup_suspend, pci_dev);
-
 	return 0;
 }
 
+static int pci_pm_suspend_late(struct device *dev)
+{
+	pci_fixup_device(pci_fixup_suspend, to_pci_dev(dev));
+
+	return pm_generic_suspend_late(dev);;
+}
+
 static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -872,6 +883,7 @@ static int pci_pm_resume(struct device *
 #else /* !CONFIG_SUSPEND */
 
 #define pci_pm_suspend		NULL
+#define pci_pm_suspend_late	NULL
 #define pci_pm_suspend_noirq	NULL
 #define pci_pm_resume		NULL
 #define pci_pm_resume_noirq	NULL
@@ -906,7 +918,8 @@ static int pci_pm_freeze(struct device *
 	 * devices should not be touched during freeze/thaw transitions,
 	 * however.
 	 */
-	pm_runtime_resume(dev);
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+		pm_runtime_resume(dev);
 
 	pci_dev->state_saved = false;
 	if (pm->freeze) {
@@ -1004,11 +1017,13 @@ static int pci_pm_poweroff(struct device
 
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
-		goto Fixup;
+		return 0;
 	}
 
 	/* The reason to do that is the same as in pci_pm_suspend(). */
-	pm_runtime_resume(dev);
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	    !pci_dev_keep_suspended(pci_dev))
+		pm_runtime_resume(dev);
 
 	pci_dev->state_saved = false;
 	if (pm->poweroff) {
@@ -1020,12 +1035,16 @@ static int pci_pm_poweroff(struct device
 			return error;
 	}
 
- Fixup:
-	pci_fixup_device(pci_fixup_suspend, pci_dev);
-
 	return 0;
 }
 
+static int pci_pm_poweroff_late(struct device *dev)
+{
+	pci_fixup_device(pci_fixup_suspend, to_pci_dev(dev));
+
+	return pm_generic_poweroff_late(dev);
+}
+
 static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -1124,6 +1143,7 @@ static int pci_pm_restore(struct device
 #define pci_pm_thaw		NULL
 #define pci_pm_thaw_noirq	NULL
 #define pci_pm_poweroff		NULL
+#define pci_pm_poweroff_late	NULL
 #define pci_pm_poweroff_noirq	NULL
 #define pci_pm_restore		NULL
 #define pci_pm_restore_noirq	NULL
@@ -1239,10 +1259,12 @@ static const struct dev_pm_ops pci_dev_p
 	.prepare = pci_pm_prepare,
 	.complete = pci_pm_complete,
 	.suspend = pci_pm_suspend,
+	.suspend_late = pci_pm_suspend_late,
 	.resume = pci_pm_resume,
 	.freeze = pci_pm_freeze,
 	.thaw = pci_pm_thaw,
 	.poweroff = pci_pm_poweroff,
+	.poweroff_late = pci_pm_poweroff_late,
 	.restore = pci_pm_restore,
 	.suspend_noirq = pci_pm_suspend_noirq,
 	.resume_noirq = pci_pm_resume_noirq,
Index: linux-pm/Documentation/power/pci.txt
===================================================================
--- linux-pm.orig/Documentation/power/pci.txt
+++ linux-pm/Documentation/power/pci.txt
@@ -980,6 +980,12 @@ positive value from pci_pm_prepare() if
 driver of the device returns a positive value.  That allows the driver to opt
 out from using the direct-complete mechanism dynamically.
 
+The DPM_FLAG_SMART_SUSPEND flag tells the PCI bus type that from the driver's
+perspective the device can be safely left in runtime suspend during system
+suspend.  That causes pci_pm_suspend(), pci_pm_freeze() and pci_pm_poweroff()
+to skip resuming the device from runtime suspend unless there are PCI-specific
+reasons for doing that.
+
 3.2. Device Runtime Power Management
 ------------------------------------
 In addition to providing device power management callbacks PCI device drivers
