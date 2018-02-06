Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35679 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbeBFUSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Feb 2018 15:18:50 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2] PCI: vmd: Use affinity to chain child device interrupts
Date: Tue,  6 Feb 2018 13:22:25 -0700
Message-Id: <20180206202225.1124-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Performance for devices in VMD domains suffer in NUMA environments if
we're not respecting the desired IRQ CPU affinity. This patch fixes
that by creating managed affinity irq vectors for the VMD device, and
then drivers registering their chained interrupts will be assigned the
h/w irq that most closely matches its desired IRQ affinity. A tie is
awarded to the lesser used vector.

Note, this only works for drivers that allocate their vectors with
PCI_IRQ_AFFINITY. All other drivers will be assigned the least used
vector without consideration for affinity.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Acked-by: Jon Derrick <jonathan.derrick@intel.com>
---
v1->v2:

  Added Jon's 'ack'.

  Update changelog subject.

 drivers/pci/host/vmd.c | 80 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 930a8fa08bd6..ac84676e79a4 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -166,10 +166,6 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
 	return 0;
 }
 
-/*
- * XXX: We can be even smarter selecting the best IRQ once we solve the
- * affinity problem.
- */
 static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *desc)
 {
 	int i, best = 1;
@@ -188,24 +184,61 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	return &vmd->irqs[best];
 }
 
+static struct vmd_irq_list *vmd_next_affinity_irq(struct vmd_dev *vmd,  const struct cpumask *dest)
+{
+	struct vmd_irq_list *irq = NULL;
+	const struct cpumask *vmd_mask;
+	unsigned long flags, match;
+	int i, best = 0;
+
+	if (!dest || vmd->msix_count < 2)
+		return NULL;
+
+	raw_spin_lock_irqsave(&list_lock, flags);
+	for (i = 1; i < vmd->msix_count; i++) {
+		struct cpumask tmp;
+
+		vmd_mask = pci_irq_get_affinity(vmd->dev, i);
+		cpumask_and(&tmp, vmd_mask, dest);
+		match = cpumask_weight(&tmp);
+		if (match >= best) {
+			if (match == best && irq &&
+			    (vmd->irqs[i].count >= irq->count))
+				continue;
+			irq = &vmd->irqs[i];
+			best = match;
+		}
+	}
+	if (irq)
+		irq->count++;
+	raw_spin_unlock_irqrestore(&list_lock, flags);
+
+	return irq;
+}
+
 static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 			unsigned int virq, irq_hw_number_t hwirq,
 			msi_alloc_info_t *arg)
 {
-	struct msi_desc *desc = arg->desc;
-	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
+	struct msi_desc *msidesc = arg->desc;
+	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(msidesc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
-	unsigned int index, vector;
+	struct irq_desc *desc = irq_to_desc(virq);
+	unsigned int vector;
 
 	if (!vmdirq)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&vmdirq->node);
-	vmdirq->irq = vmd_next_irq(vmd, desc);
-	vmdirq->virq = virq;
-	index = index_from_irqs(vmd, vmdirq->irq);
-	vector = pci_irq_vector(vmd->dev, index);
 
+	if (desc && irqd_affinity_is_managed(&desc->irq_data))
+		vmdirq->irq = vmd_next_affinity_irq(vmd,
+					desc->irq_common_data.affinity);
+	if (vmdirq->irq == NULL)
+		vmdirq->irq = vmd_next_irq(vmd, msidesc);
+
+	vmdirq->virq = virq;
+	vector = pci_irq_vector(vmd->dev, index_from_irqs(vmd, vmdirq->irq));
 	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
 			    handle_untracked_irq, vmd, NULL);
 	return 0;
@@ -233,9 +266,11 @@ static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
 
-	if (nvec > vmd->msix_count)
+	if (nvec > vmd->msix_count) {
+		if (vmd->msix_count > 1)
+			return vmd->msix_count - 1;
 		return vmd->msix_count;
-
+	}
 	memset(arg, 0, sizeof(*arg));
 	return 0;
 }
@@ -663,6 +698,14 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int i, err;
 
+	/*
+	 * The first vector is reserved for special use, so start affinity at
+	 * the second vector.
+	 */
+	struct irq_affinity affd = {
+		.pre_vectors = 1,
+	};
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
@@ -688,8 +731,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX);
+	/*
+	 * Reserve remaining vectors that IRQ affinity won't be able to assign.
+	 */
+	if ((vmd->msix_count - 1) > cpumask_weight(cpu_present_mask))
+		affd.post_vectors = vmd->msix_count -
+					cpumask_weight(cpu_present_mask) - 1;
+
+	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
+					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
-- 
2.14.3
