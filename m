Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: [RFC 1/4] PCI: Add hooks to allocate/free IRQ resources when binding/unbinding driver
Date: Thu,  7 May 2015 11:12:51 +0800
Message-Id: <1430968374-29286-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add two hook points pcibios_{alloc|free}_irq() into PCI core, which will
be called when binding/unbinding PCI device drivers. Then PCI arch code
may hook into these two points to allocate IRQ resources on demand and
free them when not used anymore.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/pci-driver.c |   33 +++++++++++++++++++++++----------
 include/linux/pci.h      |    2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210de553..8af4a671686f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -388,18 +388,30 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	return error;
 }
 
-static int pci_device_probe(struct device *dev)
+int __weak pcibios_alloc_irq(struct pci_dev *dev)
 {
-	int error = 0;
-	struct pci_driver *drv;
-	struct pci_dev *pci_dev;
+	return dev->irq;
+}
 
-	drv = to_pci_driver(dev->driver);
-	pci_dev = to_pci_dev(dev);
-	pci_dev_get(pci_dev);
-	error = __pci_device_probe(drv, pci_dev);
-	if (error)
-		pci_dev_put(pci_dev);
+void __weak pcibios_free_irq(struct pci_dev *dev)
+{
+}
+
+static int pci_device_probe(struct device *dev)
+{
+	int error;
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = to_pci_driver(dev->driver);
+
+	error = pcibios_alloc_irq(pci_dev);
+	if (error >= 0) {
+		pci_dev_get(pci_dev);
+		error = __pci_device_probe(drv, pci_dev);
+		if (error) {
+			pcibios_free_irq(pci_dev);
+			pci_dev_put(pci_dev);
+		}
+	}
 
 	return error;
 }
@@ -415,6 +427,7 @@ static int pci_device_remove(struct device *dev)
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

