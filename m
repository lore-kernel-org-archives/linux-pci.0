Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFCv2 2/3] vmd: eliminate index member from irq list
Date: Fri,  2 Sep 2016 11:53:05 -0600
Message-Id: <1472838786-3441-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
References: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Use math to discover the irq list index number relative to the irq list
head.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/vmd.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 9320216..aa8d74e 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -58,13 +58,11 @@ struct vmd_irq {
 /**
  * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
  * @irq_list:	the list of irq's the VMD one demuxes to.
- * @index:	index into the VMD MSI-X table; used for message routing.
  * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
-	unsigned int		index;
 	unsigned int		count;
 };
 
@@ -93,6 +91,12 @@ static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
 	return container_of(bus->sysdata, struct vmd_dev, sysdata);
 }
 
+static inline unsigned int index_from_irqs(struct vmd_dev *vmd,
+					   struct vmd_irq_list *irqs)
+{
+	return irqs - vmd->irqs;
+}
+
 /*
  * Drivers managing a device in a VMD domain allocate their own IRQs as before,
  * but the MSI entry for the hardware it's driving will be programmed with a
@@ -105,9 +109,11 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
 	struct vmd_irq_list *irq = vmdirq->irq;
+	struct vmd_dev *vmd = irq_data_get_irq_handler_data(data);
 
 	msg->address_hi = MSI_ADDR_BASE_HI;
-	msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_DEST_ID(irq->index);
+	msg->address_lo = MSI_ADDR_BASE_LO |
+			  MSI_ADDR_DEST_ID(index_from_irqs(vmd, irq));
 	msg->data = 0;
 }
 
@@ -196,6 +202,7 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	struct msi_desc *desc = arg->desc;
 	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+	unsigned int index, vector;
 
 	if (!vmdirq)
 		return -ENOMEM;
@@ -203,10 +210,10 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	INIT_LIST_HEAD(&vmdirq->node);
 	vmdirq->irq = vmd_next_irq(vmd, desc);
 	vmdirq->virq = virq;
+	index = index_from_irqs(vmd, vmdirq->irq);
+	vector = pci_irq_vector(vmd->dev, index);
 
-	irq_domain_set_info(domain, virq,
-			    pci_irq_vector(vmd->dev, vmdirq->irq->index),
-			    info->chip, vmdirq,
+	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
 			    handle_untracked_irq, vmd, NULL);
 	return 0;
 }
@@ -689,7 +696,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	for (i = 0; i < vmd->msix_count; i++) {
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		vmd->irqs[i].index = i;
 		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, 0, "vmd", &vmd->irqs[i]);
 		if (err)
-- 
1.8.3.1
