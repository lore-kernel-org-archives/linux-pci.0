Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: [PATCH] Revert "PCI/PM: Remove pci_pm_complete()"
Date: Thu, 28 May 2015 04:12:58 +0200
Message-ID: <2708462.WpN2O508C5@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    
Revert commit 84822b158fd3 "PCI/PM: Remove pci_pm_complete()" that
removed the execution of the device driver's ->complete callback
from the PCI bus type.
    
That was a mistake, because those callbacks are not executed at all
now even if present.
    
Fixes: 84822b158fd3 "PCI/PM: Remove pci_pm_complete()"
Cc: 3.13+ <stable@vger.kernel.org> # 3.13+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210de553..75c6aaec5c9b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -669,10 +669,18 @@ static int pci_pm_prepare(struct device *dev)
 	return pci_dev_keep_suspended(to_pci_dev(dev));
 }
 
+static void pci_pm_complete(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+
+	if (drv && drv->pm && drv->pm->complete)
+		drv->pm->complete(dev);
+}
 
 #else /* !CONFIG_PM_SLEEP */
 
 #define pci_pm_prepare	NULL
+#define pci_pm_complete	NULL
 
 #endif /* !CONFIG_PM_SLEEP */
 
@@ -1203,6 +1211,7 @@ static int pci_pm_runtime_idle(struct device *dev)
 
 static const struct dev_pm_ops pci_dev_pm_ops = {
 	.prepare = pci_pm_prepare,
+	.complete = pci_pm_complete,
 	.suspend = pci_pm_suspend,
 	.resume = pci_pm_resume,
 	.freeze = pci_pm_freeze,

