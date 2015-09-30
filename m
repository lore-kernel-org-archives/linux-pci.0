Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49163 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750947AbbI3AQK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 20:16:10 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM / sleep: Drop pm_request_idle() from pm_generic_complete()
Date: Wed, 30 Sep 2015 02:44:29 +0200
Message-ID: <4970284.9k6NVjxDce@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The pm_request_idle() in pm_generic_complete() is pointless as it is
called with the runtime PM usage counter different from zero (bumped
up by the core during the prepare phase of system suspend) and the
core calls pm_runtime_put() for all devices after executing their
complete callbacks, so drop it.

This allows the PCI PM layer to use pm_generic_complete() too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/7291251/ .

---
 drivers/base/power/generic_ops.c |    6 ------
 drivers/pci/pci-driver.c         |    9 ++-------
 2 files changed, 2 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/base/power/generic_ops.c
===================================================================
--- linux-pm.orig/drivers/base/power/generic_ops.c
+++ linux-pm/drivers/base/power/generic_ops.c
@@ -296,11 +296,5 @@ void pm_generic_complete(struct device *
 
 	if (drv && drv->pm && drv->pm->complete)
 		drv->pm->complete(dev);
-
-	/*
-	 * Let runtime PM try to suspend devices that haven't been in use before
-	 * going into the system-wide sleep state we're resuming from.
-	 */
-	pm_request_idle(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -686,13 +686,8 @@ static int pci_pm_prepare(struct device
 
 static void pci_pm_complete(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-
-	pci_dev_complete_resume(pci_dev);
-
-	if (drv && drv->pm && drv->pm->complete)
-		drv->pm->complete(dev);
+	pci_dev_complete_resume(to_pci_dev(dev));
+	pm_generic_complete(dev);
 }
 
 #else /* !CONFIG_PM_SLEEP */

