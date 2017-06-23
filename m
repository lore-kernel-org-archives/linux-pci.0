Return-Path: <SRS0=l13N=54=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=l13N=54=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: linux-pci@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI / PM: Avoid using device_may_wakeup() for runtime PM
Date: Fri, 23 Jun 2017 02:48:59 +0200
Message-ID: <2883450.A8OIi7Gmb8@aspire.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

pci_target_state() calls device_may_wakeup() which checks whether
or not the device may wake up the system from sleep states, but
pci_target_state() is used for runtime PM too.

Since runtime PM is expected to always enable remote wakeup if
possible, modify pci_target_state() to take additional argument
indicating whether or not it should look for a state from which
the device can signal wakeup and pass "true" to it from the code
related to runtime PM.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1982,12 +1982,13 @@ EXPORT_SYMBOL(pci_wake_from_d3);
 /**
  * pci_target_state - find an appropriate low power state for a given PCI dev
  * @dev: PCI device
+ * @wakeup: Whether or not wakeup functionality will be enabled for the device.
  *
  * Use underlying platform code to find a supported low power state for @dev.
  * If the platform can't manage @dev, return the deepest state from which it
  * can generate wake events, based on any available PME info.
  */
-static pci_power_t pci_target_state(struct pci_dev *dev)
+static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
 	pci_power_t target_state = PCI_D3hot;
 
@@ -2024,7 +2025,7 @@ static pci_power_t pci_target_state(stru
 	if (dev->current_state == PCI_D3cold)
 		target_state = PCI_D3cold;
 
-	if (device_may_wakeup(&dev->dev)) {
+	if (wakeup) {
 		/*
 		 * Find the deepest state from which the device can generate
 		 * wake-up events, make it the target state and enable device
@@ -2050,13 +2051,14 @@ static pci_power_t pci_target_state(stru
  */
 int pci_prepare_to_sleep(struct pci_dev *dev)
 {
-	pci_power_t target_state = pci_target_state(dev);
+	bool wakeup = device_may_wakeup(&dev->dev);
+	pci_power_t target_state = pci_target_state(dev, wakeup);
 	int error;
 
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
+	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
 
@@ -2089,7 +2091,7 @@ EXPORT_SYMBOL(pci_back_from_sleep);
  */
 int pci_finish_runtime_suspend(struct pci_dev *dev)
 {
-	pci_power_t target_state = pci_target_state(dev);
+	pci_power_t target_state = pci_target_state(dev, true);
 	int error;
 
 	if (target_state == PCI_POWER_ERROR)
@@ -2128,7 +2130,7 @@ bool pci_dev_run_wake(struct pci_dev *de
 		return false;
 
 	/* PME-capable in principle, but not from the intended sleep state */
-	if (!pci_pme_capable(dev, pci_target_state(dev)))
+	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
 		return false;
 
 	while (bus->parent) {
@@ -2163,9 +2165,10 @@ EXPORT_SYMBOL_GPL(pci_dev_run_wake);
 bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
 {
 	struct device *dev = &pci_dev->dev;
+	bool wakeup = device_may_wakeup(dev);
 
 	if (!pm_runtime_suspended(dev)
-	    || pci_target_state(pci_dev) != pci_dev->current_state
+	    || pci_target_state(pci_dev, wakeup) != pci_dev->current_state
 	    || platform_pci_need_resume(pci_dev)
 	    || (pci_dev->dev_flags & PCI_DEV_FLAGS_NEEDS_RESUME))
 		return false;
@@ -2183,7 +2186,7 @@ bool pci_dev_keep_suspended(struct pci_d
 	spin_lock_irq(&dev->power.lock);
 
 	if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
-	    !device_may_wakeup(dev))
+	    !wakeup)
 		__pci_pme_active(pci_dev, false);
 
 	spin_unlock_irq(&dev->power.lock);
