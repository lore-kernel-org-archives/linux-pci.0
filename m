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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Alexander Gordeev <agordeev@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC Patch V1 09/12] genirq: Move msi_list from struct pci_dev to struct device
Date: Thu,  9 Jul 2015 16:00:44 +0800
Message-Id: <1436428847-8886-10-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move msi_list from struct pci_dev into struct device, so we could support
non-PCI-device based generic MSI interrupts.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/base/core.c    |    3 +++
 drivers/pci/msi.c      |    3 +--
 include/linux/device.h |    4 ++++
 include/linux/msi.h    |    2 +-
 include/linux/pci.h    |    1 -
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dafae6d2f7ac..18e2a89aa138 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -662,6 +662,9 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
 	set_dev_node(dev, -1);
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	INIT_LIST_HEAD(&dev->msi_list);
+#endif
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6497608545e2..0050ad436718 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -900,7 +900,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 		return;
 
 	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
-	desc = first_msi_entry(dev);
+	desc = first_pci_msi_entry(dev);
 
 	pci_msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
@@ -1044,7 +1044,6 @@ EXPORT_SYMBOL(pci_msi_enabled);
 
 void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
-	INIT_LIST_HEAD(&dev->msi_list);
 }
 
 /**
diff --git a/include/linux/device.h b/include/linux/device.h
index 5a31bf3a4024..22227e7fe463 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -713,6 +713,7 @@ struct device_dma_parameters {
  * 		along with subsystem-level and driver-level callbacks.
  * @pins:	For device pin management.
  *		See Documentation/pinctrl.txt for details.
+ * @msi_list:	Hosts MSI descriptors
  * @numa_node:	NUMA node this device is close to.
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
@@ -776,6 +777,9 @@ struct device {
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	struct list_head	msi_list;
+#endif
 
 #ifdef CONFIG_NUMA
 	int		numa_node;	/* NUMA node this device is close to */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index cfbd2afeaf64..57fe766a14bf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -45,7 +45,7 @@ struct msi_desc {
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		(&(desc)->dev.dev)
-#define dev_to_msi_list(dev)		(&to_pci_dev((dev))->msi_list)
+#define dev_to_msi_list(dev)		(&(dev)->msi_list)
 #define first_msi_entry(dev)		\
 	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
 #define for_each_msi_entry(desc, dev)	\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a8fb59..fbf245f5eba7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -366,7 +366,6 @@ struct pci_dev {
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
 #ifdef CONFIG_PCI_MSI
-	struct list_head msi_list;
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd *vpd;
-- 
1.7.10.4

