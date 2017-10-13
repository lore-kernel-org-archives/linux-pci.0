Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: [PATCH 09/10] PCI: dwc: make cpu_addr_fixup take struct dw_pcie as argument
Date: Fri, 13 Oct 2017 18:09:12 +0200
Message-Id: <20171013160914.3220-10-niklas.cassel@axis.com>
In-Reply-To: <20171013160914.3220-1-niklas.cassel@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to hard code the cpu to bus fixup address.
By calculating the sum of sizes of config, io and mem,
from device tree, we know how big the PCIe window is.

The bus address has to be inside of this range, so all bits in
the cpu address that are higher than this range, are the ones
that we need to clear to get the local bus address.

Also for ARTPEC-7, hard coding the cpu fixup address is
not possible, since it uses a High Address Bits Look Up Table,
which means that it can, at runtime, map the PCIe window
to an arbitrary address in the 32-bit address space.

This also fixes a bug for ARTPEC-6, where the cpu_fixup_address
previously masked one bit too many. (Another reason why
it should be calculated from device tree.)

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pci-dra7xx.c      |  2 +-
 drivers/pci/dwc/pcie-artpec6.c    | 42 +++++++++++++++++++++++++++++++++++----
 drivers/pci/dwc/pcie-designware.c |  2 +-
 drivers/pci/dwc/pcie-designware.h |  2 +-
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 34427a6a15af..a93bafc72fa0 100644
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
index 21ea9ffef784..1e113dbea1da 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -32,6 +32,7 @@ struct artpec6_pcie {
 	struct regmap		*regmap;	/* DT axis,syscon-pcie */
 	void __iomem		*phy_base;	/* DT phy */
 	enum dw_pcie_device_mode mode;
+	u64 cpu_fixup_mask;
 };
 
 struct artpec_pcie_of_data {
@@ -69,8 +70,6 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define PHY_STATUS			0x118
 #define  PHY_COSPLLLOCK			BIT(0)
 
-#define ARTPEC6_CPU_TO_BUS_ADDR		GENMASK(27, 0)
-
 static u32 artpec6_pcie_readl(struct artpec6_pcie *artpec6_pcie, u32 offset)
 {
 	u32 val;
@@ -84,9 +83,42 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 	regmap_write(artpec6_pcie->regmap, offset, val);
 }
 
-static u64 artpec6_pcie_cpu_addr_fixup(u64 pci_addr)
+static void artpec6_pcie_calc_cpu_fixup_mask(struct artpec6_pcie *artpec6_pcie)
 {
-	return pci_addr & ARTPEC6_CPU_TO_BUS_ADDR;
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct dw_pcie_ep *ep = &pci->ep;
+	u64 size;
+	u64 mask;
+	int msb;
+
+	switch (artpec6_pcie->mode) {
+	case DW_PCIE_RC_TYPE:
+		size = pp->cfg0_size + pp->cfg1_size + pp->io_size +
+			pp->mem_size;
+		break;
+	case DW_PCIE_EP_TYPE:
+		size = ep->addr_size;
+		break;
+	default:
+		dev_err(pci->dev, "UNKNOWN device type\n");
+		return;
+	}
+	/* Calculate the mask (which can have potential holes). */
+	mask = size - 1;
+	/* Find the mask's msb. */
+	msb = fls64(mask);
+	/* Use the msb to generate a new mask without any holes. */
+	mask = (1ULL << msb) - 1;
+	artpec6_pcie->cpu_fixup_mask = mask;
+	dev_dbg(pci->dev, "Using cpu fixup mask: 0x%llx\n", mask);
+}
+
+static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
+{
+	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
+
+	return pci_addr & artpec6_pcie->cpu_fixup_mask;
 }
 
 static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
@@ -190,6 +222,7 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
 
+	artpec6_pcie_calc_cpu_fixup_mask(artpec6_pcie);
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
@@ -231,6 +264,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
 	enum pci_barno bar;
 
+	artpec6_pcie_calc_cpu_fixup_mask(artpec6_pcie);
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
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
index f56d040afde4..897e190f8e24 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -203,7 +203,7 @@ struct dw_pcie_ep {
 };
 
 struct dw_pcie_ops {
-	u64	(*cpu_addr_fixup)(u64 cpu_addr);
+	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
 	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-- 
2.11.0
