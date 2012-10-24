Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38773 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964799Ab2JXGyU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Oct 2012 02:54:20 -0400
From: Huang Ying <ying.huang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>
Subject: [BUGFIX 2/2] PCI/PM: Resume device before shutdown
Date: Wed, 24 Oct 2012 14:54:14 +0800
Message-Id: <1351061654-8339-2-git-send-email-ying.huang@intel.com>
In-Reply-To: <1351061654-8339-1-git-send-email-ying.huang@intel.com>
References: <1351061654-8339-1-git-send-email-ying.huang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some actions during shutdown need device to be in D0 state, such as
MSI shutdown etc, so resume device before shutdown.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/pci/pci-driver.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -398,6 +398,8 @@ static void pci_device_shutdown(struct d
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pm_runtime_resume(dev);
+
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 	pci_msi_shutdown(pci_dev);
@@ -408,16 +410,6 @@ static void pci_device_shutdown(struct d
 	 * continue to do DMA
 	 */
 	pci_disable_device(pci_dev);
-
-	/*
-	 * Devices may be enabled to wake up by runtime PM, but they need not
-	 * be supposed to wake up the system from its "power off" state (e.g.
-	 * ACPI S5).  Therefore disable wakeup for all devices that aren't
-	 * supposed to wake up the system at this point.  The state argument
-	 * will be ignored by pci_enable_wake().
-	 */
-	if (!device_may_wakeup(dev))
-		pci_enable_wake(pci_dev, PCI_UNKNOWN, false);
 }
 
 #ifdef CONFIG_PM
