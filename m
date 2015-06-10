Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49000 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbbFJIxD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Jun 2015 04:53:03 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: [Patch v3 1/4] PCI: Add hooks to allocate/free IRQ resources when binding/unbinding driver
Date: Wed, 10 Jun 2015 16:54:58 +0800
Message-Id: <1433926501-22956-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add two hook points pcibios_{alloc|free}_irq() into PCI core, which will
be called when binding/unbinding PCI device drivers. Then PCI arch code
may hook into these two points to allocate IRQ resources on demand and
free them when not used anymore.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c |   26 ++++++++++++++++++++------
 include/linux/pci.h      |    2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210de553..52a880ca1768 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -388,18 +388,31 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	return error;
 }
 
+int __weak pcibios_alloc_irq(struct pci_dev *dev)
+{
+	return 0;
+}
+
+void __weak pcibios_free_irq(struct pci_dev *dev)
+{
+}
+
 static int pci_device_probe(struct device *dev)
 {
-	int error = 0;
-	struct pci_driver *drv;
-	struct pci_dev *pci_dev;
+	int error;
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = to_pci_driver(dev->driver);
+
+	error = pcibios_alloc_irq(pci_dev);
+	if (error < 0)
+		return error;
 
-	drv = to_pci_driver(dev->driver);
-	pci_dev = to_pci_dev(dev);
 	pci_dev_get(pci_dev);
 	error = __pci_device_probe(drv, pci_dev);
-	if (error)
+	if (error) {
+		pcibios_free_irq(pci_dev);
 		pci_dev_put(pci_dev);
+	}
 
 	return error;
 }
@@ -415,6 +428,7 @@ static int pci_device_remove(struct device *dev)
 			drv->remove(pci_dev);
 			pm_runtime_put_noidle(dev);
 		}
+		pcibios_free_irq(pci_dev);
 		pci_dev->driver = NULL;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8dc4c6e..f50d16a04abc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1656,6 +1656,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 void pcibios_penalize_isa_irq(int irq, int active);
+int pcibios_alloc_irq(struct pci_dev *dev);
+void pcibios_free_irq(struct pci_dev *dev);
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 extern struct dev_pm_ops pcibios_pm_ops;
-- 
1.7.10.4

