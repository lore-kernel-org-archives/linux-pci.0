Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v14 02/12] PCI: endpoint: Add MSI-X interfaces
Date: Thu, 19 Jul 2018 10:32:12 +0200
Message-Id: <494cacd98920e58d40da29a4330da33d34374023.1531922095.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
References: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
References: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCI_EPC_IRQ_MSIX type.

Add MSI-X callbacks signatures to the ops structure.

Add sysfs interface for set/get MSI-X capability maximum number.

Update documentation accordingly.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Moved pci_epc_raise_irq() signature changes to patch file #3.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Nothing changed, just to follow the patch set version.
Change v5->v6:
 - Nothing changed, just to follow the patch set version.
Change v6->v7:
 - Nothing changed, just to follow the patch set version.
Change v7->v8:
 - Re-sending the patch series.
Change v8->v9:
 - Nothing changed, just to follow the patch set version.
Change v9->v10:
 - Updated documentation.
Change v10->v11:
 - Nothing changed, just to follow the patch set version.
Change v11->v12:
 - Nothing changed, just to follow the patch set version.
Change v12->v13:
 - Re-sending the patch series.
Change v13->v14:
 - Nothing changed, just to follow the patch set version.

 .../PCI/endpoint/function/binding/pci-test.txt     |  2 +
 drivers/pci/endpoint/pci-ep-cfs.c                  | 24 +++++++++
 drivers/pci/endpoint/pci-epc-core.c                | 57 ++++++++++++++++++++++
 include/linux/pci-epc.h                            |  9 ++++
 include/linux/pci-epf.h                            |  1 +
 5 files changed, 93 insertions(+)

diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
index 3b68b95..cd76ba4 100644
--- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
@@ -15,3 +15,5 @@ subsys_id	 : don't care
 interrupt_pin	 : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
 msi_interrupts	 : Should be 1 to 32 depending on the number of MSI interrupts
 		   to test
+msix_interrupts	 : Should be 1 to 2048 depending on the number of MSI-X
+		   interrupts to test
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 018ea34..d1288a0 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -286,6 +286,28 @@ static ssize_t pci_epf_msi_interrupts_show(struct config_item *item,
 		       to_pci_epf_group(item)->epf->msi_interrupts);
 }
 
+static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
+					     const char *page, size_t len)
+{
+	u16 val;
+	int ret;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret)
+		return ret;
+
+	to_pci_epf_group(item)->epf->msix_interrupts = val;
+
+	return len;
+}
+
+static ssize_t pci_epf_msix_interrupts_show(struct config_item *item,
+					    char *page)
+{
+	return sprintf(page, "%d\n",
+		       to_pci_epf_group(item)->epf->msix_interrupts);
+}
+
 PCI_EPF_HEADER_R(vendorid)
 PCI_EPF_HEADER_W_u16(vendorid)
 
@@ -327,6 +349,7 @@ CONFIGFS_ATTR(pci_epf_, subsys_vendor_id);
 CONFIGFS_ATTR(pci_epf_, subsys_id);
 CONFIGFS_ATTR(pci_epf_, interrupt_pin);
 CONFIGFS_ATTR(pci_epf_, msi_interrupts);
+CONFIGFS_ATTR(pci_epf_, msix_interrupts);
 
 static struct configfs_attribute *pci_epf_attrs[] = {
 	&pci_epf_attr_vendorid,
@@ -340,6 +363,7 @@ static struct configfs_attribute *pci_epf_attrs[] = {
 	&pci_epf_attr_subsys_id,
 	&pci_epf_attr_interrupt_pin,
 	&pci_epf_attr_msi_interrupts,
+	&pci_epf_attr_msix_interrupts,
 	NULL,
 };
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index b0ee427..7d77bd0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -218,6 +218,63 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 
 /**
+ * pci_epc_get_msix() - get the number of MSI-X interrupt numbers allocated
+ * @epc: the EPC device to which MSI-X interrupts was requested
+ * @func_no: the endpoint function number in the EPC device
+ *
+ * Invoke to get the number of MSI-X interrupts allocated by the RC
+ */
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
+{
+	int interrupt;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return 0;
+
+	if (!epc->ops->get_msix)
+		return 0;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	interrupt = epc->ops->get_msix(epc, func_no);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	if (interrupt < 0)
+		return 0;
+
+	return interrupt + 1;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_msix);
+
+/**
+ * pci_epc_set_msix() - set the number of MSI-X interrupt numbers required
+ * @epc: the EPC device on which MSI-X has to be configured
+ * @func_no: the endpoint function number in the EPC device
+ * @interrupts: number of MSI-X interrupts required by the EPF
+ *
+ * Invoke to set the required number of MSI-X interrupts.
+ */
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+{
+	int ret;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    interrupts < 1 || interrupts > 2048)
+		return -EINVAL;
+
+	if (!epc->ops->set_msix)
+		return 0;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_set_msix);
+
+/**
  * pci_epc_unmap_addr() - unmap CPU address from PCI address
  * @epc: the EPC device on which address is allocated
  * @func_no: the endpoint function number in the EPC device
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 243eaa5..89f079f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -17,6 +17,7 @@ enum pci_epc_irq_type {
 	PCI_EPC_IRQ_UNKNOWN,
 	PCI_EPC_IRQ_LEGACY,
 	PCI_EPC_IRQ_MSI,
+	PCI_EPC_IRQ_MSIX,
 };
 
 /**
@@ -30,6 +31,10 @@ enum pci_epc_irq_type {
  *	     capability register
  * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
  *	     the MSI capability register
+ * @set_msix: ops to set the requested number of MSI-X interrupts in the
+ *	     MSI-X capability register
+ * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
+ *	     from the MSI-X capability register
  * @raise_irq: ops to raise a legacy or MSI interrupt
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
@@ -48,6 +53,8 @@ struct pci_epc_ops {
 			      phys_addr_t addr);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no);
+	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
+	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u8 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
@@ -144,6 +151,8 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u8 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 4e77649..ec02f587 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -119,6 +119,7 @@ struct pci_epf {
 	struct pci_epf_header	*header;
 	struct pci_epf_bar	bar[6];
 	u8			msi_interrupts;
+	u16			msix_interrupts;
 	u8			func_no;
 
 	struct pci_epc		*epc;
-- 
2.7.4
