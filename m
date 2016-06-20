Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/3] vmd: Separate MSI and MSI-x vector sharing
Date: Mon, 20 Jun 2016 09:39:53 -0600
Message-Id: <1466437193-17043-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
References: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

From: Keith Busch <keith.busch@intel.com>

Child devices in a VMD domain that want to use MSI are slowing down
MSI-x using devices sharing the same vectors. This moves all MSI usage
to a single VMD vector, and MSI-x devices can share the rest.

Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index a651eb0..e88b417 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -169,11 +169,14 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
  * XXX: We can be even smarter selecting the best IRQ once we solve the
  * affinity problem.
  */
-static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd)
+static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *desc)
 {
-	int i, best = 0;
+	int i, best = 1;
 	unsigned long flags;
 
+	if (!desc->msi_attrib.is_msix || vmd->msix_count == 1)
+		return &vmd->irqs[0];
+
 	raw_spin_lock_irqsave(&list_lock, flags);
 	for (i = 1; i < vmd->msix_count; i++)
 		if (vmd->irqs[i].count < vmd->irqs[best].count)
@@ -188,14 +191,15 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 			unsigned int virq, irq_hw_number_t hwirq,
 			msi_alloc_info_t *arg)
 {
-	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(arg->desc)->bus);
+	struct msi_desc *desc = arg->desc;
+	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
 
 	if (!vmdirq)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&vmdirq->node);
-	vmdirq->irq = vmd_next_irq(vmd);
+	vmdirq->irq = vmd_next_irq(vmd, desc);
 	vmdirq->virq = virq;
 
 	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector, info->chip,
-- 
1.8.3.1
