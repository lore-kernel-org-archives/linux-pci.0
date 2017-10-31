Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52368 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbdJaWlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 18:41:07 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: [PATCH v3 15/17] PCI: dwc: Make cpu_addr_fixup take struct dw_pcie as argument
Date: Tue, 31 Oct 2017 23:39:33 +0100
Message-Id: <20171031223936.27549-16-niklas.cassel@axis.com>
In-Reply-To: <20171031223936.27549-1-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to hard code the cpu to bus address fixup mask.
The PCIe controller has a global address on the AXI bus, however,
from the perspective of the PCIe controller, its base starts at 0x0,
so the local address is 0x0. To get the bus address, simply subtract
the global address from the cpu address. The global address is taken
from device tree.

Also for ARTPEC-7, hard coding the cpu to bus address fixup mask is
not possible, since it uses a High Address Bits Look Up Table, which
means that it can, at runtime, map the PCIe window to an arbitrary
address in the 32-bit address space.

This also fixes a bug for ARTPEC-6, where the cpu to bus address
fixup mask previously was off by one (GENMASK(27, 0), rather than
GENMASK(28, 0)), which is another reason why the it is a good idea
to calculate the mask by using values from device tree.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
V3:
* No change.

 drivers/pci/dwc/pci-dra7xx.c      |  2 +-
 drivers/pci/dwc/pcie-artpec6.c    | 18 ++++++++++++++----
 drivers/pci/dwc/pcie-designware.c |  2 +-
 drivers/pci/dwc/pcie-designware.h |  2 +-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index b4c204aa932a..4d5cff76e64a 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -109,7 +109,7 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
-static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
+static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
 {
 	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
 }
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 413683d7bd9d..e5b5665786ab 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -69,8 +69,6 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define PHY_STATUS			0x118
 #define  PHY_COSPLLLOCK			BIT(0)
 
-#define ARTPEC6_CPU_TO_BUS_ADDR		GENMASK(27, 0)
-
 static u32 artpec6_pcie_readl(struct artpec6_pcie *artpec6_pcie, u32 offset)
 {
 	u32 val;
@@ -84,9 +82,21 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 	regmap_write(artpec6_pcie->regmap, offset, val);
 }
 
-static u64 artpec6_pcie_cpu_addr_fixup(u64 pci_addr)
+static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
 {
-	return pci_addr & ARTPEC6_CPU_TO_BUS_ADDR;
+	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
+	struct pcie_port *pp = &pci->pp;
+	struct dw_pcie_ep *ep = &pci->ep;
+
+	switch (artpec6_pcie->mode) {
+	case DW_PCIE_RC_TYPE:
+		return pci_addr - pp->cfg0_base;
+	case DW_PCIE_EP_TYPE:
+		return pci_addr - ep->phys_base;
+	default:
+		dev_err(pci->dev, "UNKNOWN device type\n");
+	}
+	return pci_addr;
 }
 
 static int artpec6_pcie_establish_link(struct dw_pcie *pci)
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 88abdddee2ad..800be7a4f087 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -149,7 +149,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 	u32 retries, val;
 
 	if (pci->ops->cpu_addr_fixup)
-		cpu_addr = pci->ops->cpu_addr_fixup(cpu_addr);
+		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
 		dw_pcie_prog_outbound_atu_unroll(pci, index, type, cpu_addr,
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 24edac035160..cca5a81c1c74 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -205,7 +205,7 @@ struct dw_pcie_ep {
 };
 
 struct dw_pcie_ops {
-	u64	(*cpu_addr_fixup)(u64 cpu_addr);
+	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
 	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-- 
2.14.2
