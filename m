Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI / PM: Do not clear state_saved for devices that remain suspended
Date: Fri, 18 May 2018 10:17:42 +0200
Message-ID: <11415287.ki0m5Bqgns@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The state_saved flag should not be cleared in pci_pm_suspend() if the
given device is going to remain suspended, or the device's config
space will not be restored properly during the subsequent resume.

Namely, if the device is going to stay in suspend, both the late
and noirq callbacks return early for it, so if its state_saved flag
is cleared in pci_pm_suspend(), it will remain unset throughout the
remaining part of suspend and resume and pci_restore_state() called
for the device going forward will return without doing anything.

For this reason, change pci_pm_suspend() to only clear state_saved
if the given device is not going to remain suspended.  [This is
analogous to what commit ae860a19f37c (PCI / PM: Do not clear
state_saved in pci_pm_freeze() when smart suspend is set) did for
hibernation.]

Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -753,10 +753,11 @@ static int pci_pm_suspend(struct device
 	 * better to resume the device from runtime suspend here.
 	 */
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev))
+	    !pci_dev_keep_suspended(pci_dev)) {
 		pm_runtime_resume(dev);
+		pci_dev->state_saved = false;
+	}
 
-	pci_dev->state_saved = false;
 	if (pm->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 		int error;
