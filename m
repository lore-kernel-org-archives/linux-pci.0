Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43642 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728912AbeIRUzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 16:55:31 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <lorenzo.pieralisi@arm.com>
CC: <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 5/5] PCI: cadence: Add MSI-X capability to EP driver
Date: Tue, 18 Sep 2018 16:21:45 +0100
Message-ID: <1537284105-23519-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add set_msix and get_msix functions to driver, and handle
PCI_EPC_IRQ_MSIX request in raise_irq.  BAR4 is used for
the MSI-X vectors.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 129 ++++++++++++++++++++++++++++++-
 drivers/pci/controller/pcie-cadence.h    |   7 ++
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 1248d75..dbe76ab 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -16,6 +16,7 @@
 #define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
+#define CDNS_PCIE_EP_MSIX_BAR			0x4
 
 /**
  * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
@@ -255,6 +256,65 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 	return mme;
 }
 
+static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 val, reg;
+
+	reg = cap + PCI_MSIX_FLAGS;
+	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
+	if (!(val & PCI_MSIX_FLAGS_ENABLE))
+		return -EINVAL;
+
+	val &= PCI_MSIX_FLAGS_QSIZE;
+
+	return val;
+}
+
+static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u16 interrupts)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 val, reg, tblsize, b, cfg, ap, ctrl;
+
+	/* Check that the BAR has already been configured, and is large
+	 * enough, and fail if not.
+	 */
+	b = CDNS_PCIE_EP_MSIX_BAR;
+	if (b < BAR_4)
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
+	else
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
+	cfg = cdns_pcie_readl(pcie, reg);
+	ctrl = CDNS_PCIE_LM_EP_FUNC_BAR_CFG_VAL(b, cfg);
+	if (!(ctrl & CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS))
+		return -EINVAL;
+	ap = CDNS_PCIE_LM_EP_FUNC_BAR_APERTURE_VAL(b, cfg);
+	tblsize = fls64(interrupts * 32 - 1);
+	/* Need (1<<tblsize)*2 bytes for vector table + PBA table */
+	if (ap + 6 <  tblsize)
+		return -EINVAL;
+
+	reg = cap + PCI_MSIX_FLAGS;
+	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
+	val &= ~PCI_MSIX_FLAGS_QSIZE;
+	val |= interrupts;
+	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
+
+	/* Set MSIX BAR and offset */
+	reg = cap + PCI_MSIX_TABLE;
+	cdns_pcie_ep_fn_writel(pcie, fn, reg, b);
+
+	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
+	reg = cap + PCI_MSIX_PBA;
+	cdns_pcie_ep_fn_writel(pcie, fn, reg, (1UL << tblsize) | b);
+
+	return 0;
+}
+
 static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 				     u8 intx, bool is_asserted)
 {
@@ -366,8 +426,69 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
+static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
+				      u16 interrupt_num)
+{
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u16 flags;
+	u64 pci_addr_mask = 0xff;
+	u16 tbl_offset = 0;
+	u32 bar_addr_upper, bar_addr_lower;
+	u32 msg_addr_upper, msg_addr_lower;
+	u32 msg_data;
+	u64 tbl_addr, msg_addr;
+	void __iomem *msix_tbl;
+
+	/* Check whether the MSI-X feature has been enabled by the PCI host. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSIX_FLAGS);
+	if (!(flags & PCI_MSIX_FLAGS_ENABLE))
+		return -EINVAL;
+	/* We want local address, not address on host. Table is at offset 0 */
+	bar_addr_lower = cdns_pcie_readl(pcie,
+		CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, CDNS_PCIE_EP_MSIX_BAR));
+	bar_addr_upper = cdns_pcie_readl(pcie,
+		CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, CDNS_PCIE_EP_MSIX_BAR));
+
+	tbl_addr = ((u64)bar_addr_upper) << 32 | bar_addr_lower;
+	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
+	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
+	msix_tbl = phys_to_virt(tbl_addr);
+	if (!msix_tbl)
+		return -EINVAL;
+
+	msg_addr_lower = readl(msix_tbl + PCI_MSIX_ENTRY_LOWER_ADDR);
+	msg_addr_upper = readl(msix_tbl + PCI_MSIX_ENTRY_UPPER_ADDR);
+	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
+
+	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	if (msg_data & 0x1)
+		return -EINVAL;
+
+	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_DATA);
+
+	iounmap(msix_tbl);
+
+	/* Set the outbound region if needed. */
+	if (unlikely(ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
+		     ep->irq_pci_fn != fn)) {
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region(pcie, fn, 0,
+					      false,
+					      ep->irq_phys_addr,
+					      msg_addr & ~pci_addr_mask,
+					      pci_addr_mask + 1);
+		ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
+		ep->irq_pci_fn = fn;
+	}
+	writel(msg_data, ep->irq_cpu_addr + (msg_addr & pci_addr_mask));
+
+	return 0;
+}
+
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	u32 link_status;
@@ -384,6 +505,9 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 	case PCI_EPC_IRQ_MSI:
 		return cdns_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
 
+	case PCI_EPC_IRQ_MSIX:
+		return cdns_pcie_ep_send_msix_irq(ep, fn, interrupt_num);
+
 	default:
 		break;
 	}
@@ -430,6 +554,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	.unmap_addr	= cdns_pcie_ep_unmap_addr,
 	.set_msi	= cdns_pcie_ep_set_msi,
 	.get_msi	= cdns_pcie_ep_get_msi,
+	.set_msix	= cdns_pcie_ep_set_msix,
+	.get_msix	= cdns_pcie_ep_get_msix,
 	.raise_irq	= cdns_pcie_ep_raise_irq,
 	.start		= cdns_pcie_ep_start,
 };
@@ -501,6 +627,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	}
 
 	epc_set_drvdata(epc, ep);
+	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;
 
 	if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
 		epc->max_functions = 1;
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index 4bb2733..946f6ee 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -52,6 +52,12 @@
 	(GENMASK(7, 5) << ((b) * 8))
 #define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
 	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG_VAL(b, c) \
+	(((c) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK((b) % 4)) \
+						>> (((b) % 4) * 8 + 5))
+#define CDNS_PCIE_LM_EP_FUNC_BAR_APERTURE_VAL(b, c) \
+	(((c) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK((b) % 4)) \
+							>> (((b) % 4) * 8))
 
 /* Endpoint Function Configuration Register */
 #define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)
@@ -93,6 +99,7 @@
 #define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
 
 #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
+#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
 
 /*
  * Root Port Registers (PCI configuration space for the root port function)
-- 
1.9.0
