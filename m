Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFCv2 3/3] pci/vmd: Create irq map for irq nodes
Date: Fri,  2 Sep 2016 11:53:06 -0600
Message-Id: <1472838786-3441-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
References: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

This patch creates an irq map per VMD device msix vector (irq list), and
maps vmdirq nodes into the irq map. The goal is to be able to get a
reference for all vmd_irqs in the vmd_irq_list within a single page.

Each vmd_irq is tracked with the id allocator, and if the id allocation
fails (if many devices are connected), it will fall back to a normal
kzalloc.

Indexing/traversing will still be managed with list primitives, because
we still need the rcu protection.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/vmd.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index aa8d74e..c25fb46 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/idr.h>
 
 #include <asm/irqdomain.h>
 #include <asm/device.h>
@@ -41,8 +42,9 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @node:	list item for parent traversal.
  * @rcu:	RCU callback item for freeing.
  * @irq:	back pointer to parent.
- * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
+ * @instance:	ida instance which is the mapping index in the irq map
+ * @enabled:	true if driver enabled IRQ
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
  * a VMD IRQ using this structure.
@@ -51,8 +53,10 @@ struct vmd_irq {
 	struct list_head	node;
 	struct rcu_head		rcu;
 	struct vmd_irq_list	*irq;
-	bool			enabled;
 	unsigned int		virq;
+	int			instance;
+	bool			enabled;
+	u8			__pad[8];
 };
 
 /**
@@ -74,6 +78,9 @@ struct vmd_dev {
 
 	int msix_count;
 	struct vmd_irq_list	*irqs;
+	struct vmd_irq		*irq_map;
+	struct ida		*map_idas;
+#define VMD_IRQS_PER_MAP (PAGE_SIZE / sizeof(struct vmd_irq))
 
 	struct pci_sysdata	sysdata;
 	struct resource		resources[3];
@@ -96,6 +103,11 @@ static inline unsigned int index_from_irqs(struct vmd_dev *vmd,
 {
 	return irqs - vmd->irqs;
 }
+static inline unsigned int index_from_vmd_irq(struct vmd_dev *vmd,
+					      struct vmd_irq *vmd_irq)
+{
+	return ((void *)vmd_irq - (void *)vmd->irq_map) / PAGE_SIZE;
+}
 
 /*
  * Drivers managing a device in a VMD domain allocate their own IRQs as before,
@@ -201,16 +213,31 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 {
 	struct msi_desc *desc = arg->desc;
 	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
-	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+	struct vmd_irq *vmdirq;
+	struct vmd_irq_list *irq;
 	unsigned int index, vector;
-
-	if (!vmdirq)
-		return -ENOMEM;
+	int instance;
+
+	irq = vmd_next_irq(vmd, desc);
+	index = index_from_irqs(vmd, irq);
+	instance = ida_simple_get(&vmd->map_idas[index], 0, VMD_IRQS_PER_MAP,
+				  GFP_KERNEL);
+	if (instance < 0) {
+		vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+		if (!vmdirq) {
+			BUG_ON(1);
+			return -ENOMEM;
+		}
+	} else {
+		struct vmd_irq *base = (void *)vmd->irq_map + index * PAGE_SIZE;
+		vmdirq = &base[instance];
+		memset(vmdirq, 0, sizeof(*vmdirq));
+	}
 
 	INIT_LIST_HEAD(&vmdirq->node);
-	vmdirq->irq = vmd_next_irq(vmd, desc);
+	vmdirq->irq = irq;
 	vmdirq->virq = virq;
-	index = index_from_irqs(vmd, vmdirq->irq);
+	vmdirq->instance = instance;
 	vector = pci_irq_vector(vmd->dev, index);
 
 	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
@@ -221,6 +248,7 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 static void vmd_msi_free(struct irq_domain *domain,
 			struct msi_domain_info *info, unsigned int virq)
 {
+	struct vmd_dev *vmd = irq_get_handler_data(virq);
 	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
 	unsigned long flags;
 
@@ -229,9 +257,15 @@ static void vmd_msi_free(struct irq_domain *domain,
 	/* XXX: Potential optimization to rebalance */
 	raw_spin_lock_irqsave(&list_lock, flags);
 	vmdirq->irq->count--;
-	raw_spin_unlock_irqrestore(&list_lock, flags);
 
-	kfree_rcu(vmdirq, rcu);
+	if (vmdirq->instance < 0) {
+		raw_spin_unlock_irqrestore(&list_lock, flags);
+		kfree_rcu(vmdirq, rcu);
+	} else {
+		unsigned int index = index_from_vmd_irq(vmd, vmdirq);
+		ida_simple_remove(&vmd->map_idas[index], vmdirq->instance);
+		raw_spin_unlock_irqrestore(&list_lock, flags);
+	}
 }
 
 static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
@@ -694,8 +728,19 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!vmd->irqs)
 		return -ENOMEM;
 
+	/* devm_ doesn't provide the PAGE_SIZE alignment we want */
+	vmd->irq_map = kcalloc(vmd->msix_count, PAGE_SIZE, GFP_KERNEL);
+	if (!vmd->irq_map)
+		return -ENOMEM;
+
+	vmd->map_idas = devm_kcalloc(&dev->dev, vmd->msix_count,
+				     sizeof(*vmd->map_idas), GFP_KERNEL);
+	if (!vmd->map_idas)
+		return -ENOMEM;
+
 	for (i = 0; i < vmd->msix_count; i++) {
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		ida_init(&vmd->map_idas[i]);
 		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, 0, "vmd", &vmd->irqs[i]);
 		if (err)
@@ -716,12 +761,16 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
+	int i;
 
 	vmd_detach_resources(vmd);
 	pci_set_drvdata(dev, NULL);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
+	for (i = 0; i < vmd->msix_count; i++)
+		ida_destroy(&vmd->map_idas[i]);
+	kfree(vmd->irq_map);
 	vmd_teardown_dma_ops(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
-- 
1.8.3.1
