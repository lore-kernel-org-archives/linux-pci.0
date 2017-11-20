Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/18] PCI: designware-ep: Add generic function for raising MSI irq
Date: Mon, 20 Nov 2017 14:32:09 +0100
Message-Id: <20171120133222.27771-7-niklas.cassel@axis.com>
In-Reply-To: <20171120133222.27771-1-niklas.cassel@axis.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a generic function for raising MSI irqs that can be used by all
DWC based controllers.

Note that certain controllers, like DRA7xx, have a special convenience
register for raising MSI irqs that doesn't require you to explicitly map
the MSI address. Therefore, it is likely that certain drivers will
not use this generic function, even if they can.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/dwc/pcie-designware.h    |  9 +++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 700ed2f4becf..c5aa1cac5041 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -282,6 +282,41 @@ static const struct pci_epc_ops epc_ops = {
 	.stop			= dw_pcie_ep_stop,
 };
 
+int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
+			     u8 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
+	u16 msg_ctrl, msg_data;
+	u32 msg_addr_lower, msg_addr_upper;
+	u64 msg_addr;
+	bool has_upper;
+	int ret;
+
+	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
+	msg_ctrl = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
+	msg_addr_lower = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
+	if (has_upper) {
+		msg_addr_upper = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
+		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_64);
+	} else {
+		msg_addr_upper = 0;
+		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
+	}
+	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
+	ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
+				  epc->mem->page_size);
+	if (ret)
+		return ret;
+
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
+
+	dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
+
+	return 0;
+}
+
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 37dfad8d003f..24edac035160 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -106,6 +106,8 @@
 #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
 #define MSI_MESSAGE_ADDR_L32		0x54
 #define MSI_MESSAGE_ADDR_U32		0x58
+#define MSI_MESSAGE_DATA_32		0x58
+#define MSI_MESSAGE_DATA_64		0x5C
 
 /*
  * Maximum number of MSI IRQs can be 256 per controller. But keep
@@ -338,6 +340,7 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
+int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 interrupt_num);
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
 #else
 static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
@@ -353,6 +356,12 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
 
+static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
+					   u8 interrupt_num)
+{
+	return 0;
+}
+
 static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 }
-- 
2.14.2
