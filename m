Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:36864 "EHLO
        10.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbeA3U7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 15:59:35 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id BABA89A6A5
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 21:59:33 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v6 08/11] PCI: endpoint: Add the function number as argument to EPC ops
Date: Tue, 30 Jan 2018 21:56:56 +0100
Message-Id: <c4063e68827e608cab3d0d90b785e4bd7d84b3bb.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch updates the prototype of most handlers from 'struct
pci_epc_ops' so the EPC library can now support multi-function devices.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/dwc/pcie-designware-ep.c          | 20 +++++----
 drivers/pci/endpoint/functions/pci-epf-test.c | 41 ++++++++++--------
 drivers/pci/endpoint/pci-epc-core.c           | 62 ++++++++++++++++-----------
 include/linux/pci-epc.h                       | 43 +++++++++++--------
 4 files changed, 96 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index d53d5f168363..7a573d8bb62d 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -39,7 +39,7 @@ static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	dw_pcie_writel_dbi(pci, reg, 0x0);
 }
 
-static int dw_pcie_ep_write_header(struct pci_epc *epc,
+static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
 				   struct pci_epf_header *hdr)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -112,7 +112,8 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
 	return 0;
 }
 
-static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
+static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
+				 enum pci_barno bar)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -124,7 +125,8 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
 	clear_bit(atu_index, &ep->ib_window_map);
 }
 
-static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
+static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
+			      enum pci_barno bar,
 			      dma_addr_t bar_phys, size_t size, int flags)
 {
 	int ret;
@@ -163,7 +165,8 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
-static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
+static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
+				  phys_addr_t addr)
 {
 	int ret;
 	u32 atu_index;
@@ -178,7 +181,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
 	clear_bit(atu_index, &ep->ob_window_map);
 }
 
-static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
+static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
+			       phys_addr_t addr,
 			       u64 pci_addr, size_t size)
 {
 	int ret;
@@ -194,7 +198,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
 	return 0;
 }
 
-static int dw_pcie_ep_get_msi(struct pci_epc *epc)
+static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
 {
 	int val;
 	u32 lower_addr;
@@ -214,7 +218,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc)
 	return val;
 }
 
-static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
+static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
 {
 	int val;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -226,7 +230,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
 	return 0;
 }
 
-static int dw_pcie_ep_raise_irq(struct pci_epc *epc,
+static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
 				enum pci_epc_irq_type type, u8 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index f9308c2f22e6..7bacca8daec6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -104,7 +104,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, src_phys_addr, reg->src_addr, reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
+			       reg->size);
 	if (ret) {
 		dev_err(dev, "failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -119,7 +120,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_src_map_addr;
 	}
 
-	ret = pci_epc_map_addr(epc, dst_phys_addr, reg->dst_addr, reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
+			       reg->size);
 	if (ret) {
 		dev_err(dev, "failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -128,13 +130,13 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 	memcpy(dst_addr, src_addr, reg->size);
 
-	pci_epc_unmap_addr(epc, dst_phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
 
 err_dst_addr:
 	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
 
 err_src_map_addr:
-	pci_epc_unmap_addr(epc, src_phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
 
 err_src_addr:
 	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
@@ -164,7 +166,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, phys_addr, reg->src_addr, reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
+			       reg->size);
 	if (ret) {
 		dev_err(dev, "failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -186,7 +189,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
@@ -215,7 +218,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, phys_addr, reg->dst_addr, reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
+			       reg->size);
 	if (ret) {
 		dev_err(dev, "failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -242,7 +246,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
@@ -260,11 +264,11 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq)
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	reg->status |= STATUS_IRQ_RAISED;
-	msi_count = pci_epc_get_msi(epc);
+	msi_count = pci_epc_get_msi(epc, epf->func_no);
 	if (irq > msi_count || msi_count <= 0)
-		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
 	else
-		pci_epc_raise_irq(epc, PCI_EPC_IRQ_MSI, irq);
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
 }
 
 static void pci_epf_test_cmd_handler(struct work_struct *work)
@@ -291,7 +295,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
 		goto reset_handler;
 	}
 
@@ -326,11 +330,11 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	if (command & COMMAND_RAISE_MSI_IRQ) {
-		msi_count = pci_epc_get_msi(epc);
+		msi_count = pci_epc_get_msi(epc, epf->func_no);
 		if (irq > msi_count || msi_count <= 0)
 			goto reset_handler;
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, PCI_EPC_IRQ_MSI, irq);
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
 		goto reset_handler;
 	}
 
@@ -358,7 +362,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		if (epf_test->reg[bar]) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-			pci_epc_clear_bar(epc, bar);
+			pci_epc_clear_bar(epc, epf->func_no, bar);
 		}
 	}
 }
@@ -380,7 +384,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
-		ret = pci_epc_set_bar(epc, bar, epf_bar->phys_addr,
+		ret = pci_epc_set_bar(epc, epf->func_no, bar,
+				      epf_bar->phys_addr,
 				      epf_bar->size, flags);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
@@ -433,7 +438,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	ret = pci_epc_write_header(epc, header);
+	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
 		dev_err(dev, "configuration header write failed\n");
 		return ret;
@@ -447,7 +452,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	ret = pci_epc_set_msi(epc, epf->msi_interrupts);
+	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index cd7d4788b94d..5bb1852b8e1c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -141,25 +141,26 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
 /**
  * pci_epc_raise_irq() - interrupt the host system
  * @epc: the EPC device which has to interrupt the host
+ * @func_no: the endpoint function number in the EPC device
  * @type: specify the type of interrupt; legacy or MSI
  * @interrupt_num: the MSI interrupt number
  *
  * Invoke to raise an MSI or legacy interrupt
  */
-int pci_epc_raise_irq(struct pci_epc *epc, enum pci_epc_irq_type type,
-		      u8 interrupt_num)
+int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
+		      enum pci_epc_irq_type type, u8 interrupt_num)
 {
 	int ret;
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
 	if (!epc->ops->raise_irq)
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	ret = epc->ops->raise_irq(epc, type, interrupt_num);
+	ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	return ret;
@@ -169,22 +170,23 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
 /**
  * pci_epc_get_msi() - get the number of MSI interrupt numbers allocated
  * @epc: the EPC device to which MSI interrupts was requested
+ * @func_no: the endpoint function number in the EPC device
  *
  * Invoke to get the number of MSI interrupts allocated by the RC
  */
-int pci_epc_get_msi(struct pci_epc *epc)
+int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
 {
 	int interrupt;
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
 
 	if (!epc->ops->get_msi)
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	interrupt = epc->ops->get_msi(epc);
+	interrupt = epc->ops->get_msi(epc, func_no);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	if (interrupt < 0)
@@ -199,17 +201,18 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msi);
 /**
  * pci_epc_set_msi() - set the number of MSI interrupt numbers required
  * @epc: the EPC device on which MSI has to be configured
+ * @func_no: the endpoint function number in the EPC device
  * @interrupts: number of MSI interrupts required by the EPF
  *
  * Invoke to set the required number of MSI interrupts.
  */
-int pci_epc_set_msi(struct pci_epc *epc, u8 interrupts)
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 {
 	int ret;
 	u8 encode_int;
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
@@ -218,7 +221,7 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 interrupts)
 	encode_int = order_base_2(interrupts);
 
 	spin_lock_irqsave(&epc->lock, flags);
-	ret = epc->ops->set_msi(epc, encode_int);
+	ret = epc->ops->set_msi(epc, func_no, encode_int);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	return ret;
@@ -228,22 +231,24 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 /**
  * pci_epc_unmap_addr() - unmap CPU address from PCI address
  * @epc: the EPC device on which address is allocated
+ * @func_no: the endpoint function number in the EPC device
  * @phys_addr: physical address of the local system
  *
  * Invoke to unmap the CPU address from PCI address.
  */
-void pci_epc_unmap_addr(struct pci_epc *epc, phys_addr_t phys_addr)
+void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
+			phys_addr_t phys_addr)
 {
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return;
 
 	if (!epc->ops->unmap_addr)
 		return;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	epc->ops->unmap_addr(epc, phys_addr);
+	epc->ops->unmap_addr(epc, func_no, phys_addr);
 	spin_unlock_irqrestore(&epc->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
@@ -251,26 +256,27 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 /**
  * pci_epc_map_addr() - map CPU address to PCI address
  * @epc: the EPC device on which address is allocated
+ * @func_no: the endpoint function number in the EPC device
  * @phys_addr: physical address of the local system
  * @pci_addr: PCI address to which the physical address should be mapped
  * @size: the size of the allocation
  *
  * Invoke to map CPU address with PCI address.
  */
-int pci_epc_map_addr(struct pci_epc *epc, phys_addr_t phys_addr,
-		     u64 pci_addr, size_t size)
+int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
+		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
 {
 	int ret;
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
 	if (!epc->ops->map_addr)
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	ret = epc->ops->map_addr(epc, phys_addr, pci_addr, size);
+	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	return ret;
@@ -280,22 +286,23 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 /**
  * pci_epc_clear_bar() - reset the BAR
  * @epc: the EPC device for which the BAR has to be cleared
+ * @func_no: the endpoint function number in the EPC device
  * @bar: the BAR number that has to be reset
  *
  * Invoke to reset the BAR of the endpoint device.
  */
-void pci_epc_clear_bar(struct pci_epc *epc, int bar)
+void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, int bar)
 {
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return;
 
 	if (!epc->ops->clear_bar)
 		return;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	epc->ops->clear_bar(epc, bar);
+	epc->ops->clear_bar(epc, func_no, bar);
 	spin_unlock_irqrestore(&epc->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
@@ -303,26 +310,27 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 /**
  * pci_epc_set_bar() - configure BAR in order for host to assign PCI addr space
  * @epc: the EPC device on which BAR has to be configured
+ * @func_no: the endpoint function number in the EPC device
  * @bar: the BAR number that has to be configured
  * @size: the size of the addr space
  * @flags: specify memory allocation/io allocation/32bit address/64 bit address
  *
  * Invoke to configure the BAR of the endpoint device.
  */
-int pci_epc_set_bar(struct pci_epc *epc, enum pci_barno bar,
+int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, enum pci_barno bar,
 		    dma_addr_t bar_phys, size_t size, int flags)
 {
 	int ret;
 	unsigned long irq_flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
 	if (!epc->ops->set_bar)
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, irq_flags);
-	ret = epc->ops->set_bar(epc, bar, bar_phys, size, flags);
+	ret = epc->ops->set_bar(epc, func_no, bar, bar_phys, size, flags);
 	spin_unlock_irqrestore(&epc->lock, irq_flags);
 
 	return ret;
@@ -332,6 +340,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 /**
  * pci_epc_write_header() - write standard configuration header
  * @epc: the EPC device to which the configuration header should be written
+ * @func_no: the endpoint function number in the EPC device
  * @header: standard configuration header fields
  *
  * Invoke to write the configuration header to the endpoint controller. Every
@@ -339,19 +348,20 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
  * configuration header would be written. The callback function should write
  * the header fields to this dedicated location.
  */
-int pci_epc_write_header(struct pci_epc *epc, struct pci_epf_header *header)
+int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
+			 struct pci_epf_header *header)
 {
 	int ret;
 	unsigned long flags;
 
-	if (IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
 	if (!epc->ops->write_header)
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	ret = epc->ops->write_header(epc, header);
+	ret = epc->ops->write_header(epc, func_no, header);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f7a04e1af112..e58e2de8936b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -39,17 +39,20 @@ enum pci_epc_irq_type {
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
-	int	(*write_header)(struct pci_epc *pci_epc,
+	int	(*write_header)(struct pci_epc *epc, u8 func_no,
 				struct pci_epf_header *hdr);
-	int	(*set_bar)(struct pci_epc *epc, enum pci_barno bar,
+	int	(*set_bar)(struct pci_epc *epc, u8 func_no,
+			   enum pci_barno bar,
 			   dma_addr_t bar_phys, size_t size, int flags);
-	void	(*clear_bar)(struct pci_epc *epc, enum pci_barno bar);
-	int	(*map_addr)(struct pci_epc *epc, phys_addr_t addr,
-			    u64 pci_addr, size_t size);
-	void	(*unmap_addr)(struct pci_epc *epc, phys_addr_t addr);
-	int	(*set_msi)(struct pci_epc *epc, u8 interrupts);
-	int	(*get_msi)(struct pci_epc *epc);
-	int	(*raise_irq)(struct pci_epc *pci_epc,
+	void	(*clear_bar)(struct pci_epc *epc, u8 func_no,
+			     enum pci_barno bar);
+	int	(*map_addr)(struct pci_epc *epc, u8 func_no,
+			    phys_addr_t addr, u64 pci_addr, size_t size);
+	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no,
+			      phys_addr_t addr);
+	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
+	int	(*get_msi)(struct pci_epc *epc, u8 func_no);
+	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u8 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
@@ -124,17 +127,21 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
-int pci_epc_write_header(struct pci_epc *epc, struct pci_epf_header *hdr);
-int pci_epc_set_bar(struct pci_epc *epc, enum pci_barno bar,
+int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
+			 struct pci_epf_header *hdr);
+int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
+		    enum pci_barno bar,
 		    dma_addr_t bar_phys, size_t size, int flags);
-void pci_epc_clear_bar(struct pci_epc *epc, int bar);
-int pci_epc_map_addr(struct pci_epc *epc, phys_addr_t phys_addr,
+void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, int bar);
+int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
+		     phys_addr_t phys_addr,
 		     u64 pci_addr, size_t size);
-void pci_epc_unmap_addr(struct pci_epc *epc, phys_addr_t phys_addr);
-int pci_epc_set_msi(struct pci_epc *epc, u8 interrupts);
-int pci_epc_get_msi(struct pci_epc *epc);
-int pci_epc_raise_irq(struct pci_epc *epc, enum pci_epc_irq_type type,
-		      u8 interrupt_num);
+void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
+			phys_addr_t phys_addr);
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
+int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
+int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
+		      enum pci_epc_irq_type type, u8 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 struct pci_epc *pci_epc_get(const char *epc_name);
-- 
2.11.0
