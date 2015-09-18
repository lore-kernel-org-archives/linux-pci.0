Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59335 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751929AbbIRAkh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 20:40:37 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: [PATCH] PCI / PM: Update runtime PM documentation for PCI devices
Date: Fri, 18 Sep 2015 03:08:40 +0200
Message-ID: <2256432.RWZW2V6rYx@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Section 3.2 "Device Runtime Power Management" of pci.txt has become
outdated, so update it to correctly reflect the current code flow.

Also update the comment in local_pci_probe() to document the fact
that pm_runtime_put_noidle() is not the only runtime PM helper
function that can be used to decrement the device's runtime PM
usage counter in .probe().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/pci.txt |   51 ++++++++++++++++++++++++++++++++------------
 drivers/pci/pci-driver.c    |    7 +++---
 2 files changed, 42 insertions(+), 16 deletions(-)

Index: linux-pm/Documentation/power/pci.txt
===================================================================
--- linux-pm.orig/Documentation/power/pci.txt
+++ linux-pm/Documentation/power/pci.txt
@@ -979,20 +979,45 @@ every time right after the runtime_resum
 (alternatively, the runtime_suspend() callback will have to check if the
 device should really be suspended and return -EAGAIN if that is not the case).
 
-The runtime PM of PCI devices is disabled by default.  It is also blocked by
-pci_pm_init() that runs the pm_runtime_forbid() helper function.  If a PCI
-driver implements the runtime PM callbacks and intends to use the runtime PM
-framework provided by the PM core and the PCI subsystem, it should enable this
-feature by executing the pm_runtime_enable() helper function.  However, the
-driver should not call the pm_runtime_allow() helper function unblocking
-the runtime PM of the device.  Instead, it should allow user space or some
-platform-specific code to do that (user space can do it via sysfs), although
-once it has called pm_runtime_enable(), it must be prepared to handle the
+The runtime PM of PCI devices is enabled by default by the PCI core.  PCI
+device drivers do not need to enable it and should not attempt to do so.
+However, it is blocked by pci_pm_init() that runs the pm_runtime_forbid()
+helper function.  In addition to that, the runtime PM usage counter of
+each PCI device is incremented by local_pci_probe() before executing the
+probe callback provided by the device's driver.
+
+If a PCI driver implements the runtime PM callbacks and intends to use the
+runtime PM framework provided by the PM core and the PCI subsystem, it needs
+to decrement the device's runtime PM usage counter in its probe callback
+function.  If it doesn't do that, the counter will always be different from
+zero for the device and it will never be runtime-suspended.  The simplest
+way to do that is by calling pm_runtime_put_noidle(), but if the driver
+wants to schedule an autosuspend right away, for example, it may call
+pm_runtime_put_autosuspend() instead for this purpose.  Generally, it
+just needs to call a function that decrements the devices usage counter
+from its probe routine to make runtime PM work for the device.
+
+It is important to remember that the driver's runtime_suspend() callback
+may be executed right after the usage counter has been decremented, because
+user space may already have cuased the pm_runtime_allow() helper function
+unblocking the runtime PM of the device to run via sysfs, so the driver must
+be prepared to cope with that.
+
+The driver itself should not call pm_runtime_allow(), though.  Instead, it
+should let user space or some platform-specific code do that (user space can
+do it via sysfs as stated above), but it must be prepared to handle the
 runtime PM of the device correctly as soon as pm_runtime_allow() is called
-(which may happen at any time).  [It also is possible that user space causes
-pm_runtime_allow() to be called via sysfs before the driver is loaded, so in
-fact the driver has to be prepared to handle the runtime PM of the device as
-soon as it calls pm_runtime_enable().]
+(which may happen at any time, even before the driver is loaded).
+
+When the driver's remove callback runs, it has to balance the decrementation
+of the device's runtime PM usage counter at the probe time.  For this reason,
+if it has decremented the counter in its probe callback, it must run
+pm_runtime_get_noresume() in its remove callback.  [Since the core carries
+out a runtime resume of the device and bumps up the device's usage counter
+before running the driver's remove callback, the runtime PM of the device
+is effectively disabled for the duration of the remove execution and all
+runtime PM helper functions incrementing the device's usage counter are
+then effectively equivalent to pm_runtime_get_noresume().]
 
 The runtime PM framework works by processing requests to suspend or resume
 devices, or to check if they are idle (in which cases it is reasonable to
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -299,9 +299,10 @@ static long local_pci_probe(void *_ddi)
 	 * Unbound PCI devices are always put in D0, regardless of
 	 * runtime PM status.  During probe, the device is set to
 	 * active and the usage count is incremented.  If the driver
-	 * supports runtime PM, it should call pm_runtime_put_noidle()
-	 * in its probe routine and pm_runtime_get_noresume() in its
-	 * remove routine.
+	 * supports runtime PM, it should call pm_runtime_put_noidle(),
+	 * or any other runtime PM helper function decrementing the usage
+	 * count, in its probe routine and pm_runtime_get_noresume() in
+	 * its remove routine.
 	 */
 	pm_runtime_get_sync(dev);
 	pci_dev->driver = pci_drv;

