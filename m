Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFC 1/2] vmd: eliminate vmd_vector member from list type
Date: Tue, 30 Aug 2016 15:04:56 -0600
Message-Id: <1472591097-19712-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1472591097-19712-1-git-send-email-jonathan.derrick@intel.com>
References: <1472591097-19712-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Eliminate unused vmd and vector members from vmd_irq_list and discover
the vector using pci_irq_vector().

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/vmd.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 4c0eac7..9320216 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -58,15 +58,12 @@ struct vmd_irq {
 /**
  * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
  * @irq_list:	the list of irq's the VMD one demuxes to.
- * @vmd_vector:	the h/w IRQ assigned to the VMD.
  * @index:	index into the VMD MSI-X table; used for message routing.
  * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
-	struct vmd_dev		*vmd;
-	unsigned int		vmd_vector;
 	unsigned int		index;
 	unsigned int		count;
 };
@@ -207,8 +204,10 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	vmdirq->irq = vmd_next_irq(vmd, desc);
 	vmdirq->virq = virq;
 
-	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector, info->chip,
-			    vmdirq, handle_untracked_irq, vmd, NULL);
+	irq_domain_set_info(domain, virq,
+			    pci_irq_vector(vmd->dev, vmdirq->irq->index),
+			    info->chip, vmdirq,
+			    handle_untracked_irq, vmd, NULL);
 	return 0;
 }
 
@@ -690,10 +689,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	for (i = 0; i < vmd->msix_count; i++) {
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		vmd->irqs[i].vmd_vector = pci_irq_vector(dev, i);
 		vmd->irqs[i].index = i;
-
-		err = devm_request_irq(&dev->dev, vmd->irqs[i].vmd_vector,
+		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, 0, "vmd", &vmd->irqs[i]);
 		if (err)
 			return err;
-- 
1.8.3.1
