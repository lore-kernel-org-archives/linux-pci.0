Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM / PCI: Do not resume any devices in pci_pm_prepare()
Date: Mon, 25 Sep 2017 01:33:13 +0200
Message-ID: <1877076.QiUpNxchJO@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It should not be necessary to resume devices with ignore_children set
in pci_pm_prepare(), because they should be resumed explcitly by
their children drivers during suspend if need be and they will be
resumed by pci_pm_suspend() after that anyway, so avoid doing that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -680,13 +680,6 @@ static int pci_pm_prepare(struct device
 {
 	struct device_driver *drv = dev->driver;
 
-	/*
-	 * Devices having power.ignore_children set may still be necessary for
-	 * suspending their children in the next phase of device suspend.
-	 */
-	if (dev->power.ignore_children)
-		pm_runtime_resume(dev);
-
 	if (drv && drv->pm && drv->pm->prepare) {
 		int error = drv->pm->prepare(dev);
 		if (error)
