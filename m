Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Alexander Gordeev <agordeev@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC Patch V1 12/12] genirq, PCI: Move alloc_msi_entry() from PCI MSI code into generic MSI code
Date: Thu,  9 Jul 2015 16:00:47 +0800
Message-Id: <1436428847-8886-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move alloc_msi_entry() from PCI MSI code into generic MSI code, so it
could be reused by other generic MSI drivers.
Also introduce free_msi_entry() for completeness.

This is suggested by Stuart Yoder <stuart.yoder@freescale.com>.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/msi.c   |   16 ++--------------
 include/linux/msi.h |    2 ++
 kernel/irq/msi.c    |   17 +++++++++++++++++
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 260c1653701d..373d96e06cbd 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -406,18 +406,6 @@ static void free_msi_irqs(struct pci_dev *dev)
 	}
 }
 
-static struct msi_desc *alloc_msi_entry(struct pci_dev *dev)
-{
-	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return NULL;
-
-	INIT_LIST_HEAD(&desc->list);
-	desc->dev = &dev->dev;
-
-	return desc;
-}
-
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
 	if (!(dev->dev_flags & PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG))
@@ -572,7 +560,7 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 	struct msi_desc *entry;
 
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(dev);
+	entry = alloc_msi_entry(&dev->dev);
 	if (!entry)
 		return NULL;
 
@@ -700,7 +688,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 	int i;
 
 	for (i = 0; i < nvec; i++) {
-		entry = alloc_msi_entry(dev);
+		entry = alloc_msi_entry(&dev->dev);
 		if (!entry) {
 			if (!i)
 				iounmap(base);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f6845bc83774..c10ec5687efa 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -67,6 +67,8 @@ static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 }
 #endif /* CONFIG_PCI_MSI */
 
+struct msi_desc *alloc_msi_entry(struct device *dev);
+void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7bf1f1bbb7fa..7e6512b9dc1f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -18,6 +18,23 @@
 /* Temparory solution for building, will be removed later */
 #include <linux/pci.h>
 
+struct msi_desc *alloc_msi_entry(struct device *dev)
+{
+	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return NULL;
+
+	INIT_LIST_HEAD(&desc->list);
+	desc->dev = dev;
+
+	return desc;
+}
+
+void free_msi_entry(struct msi_desc *entry)
+{
+	kfree(entry);
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;
-- 
1.7.10.4

