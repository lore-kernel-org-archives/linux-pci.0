Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQah (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:30:37 -0400
Subject: [PATCH 3/7] PCI: designware: Swap order of dw_pcie_writel_rc()
 reg/val arguments
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:30:25 -0500
Message-ID: <20161007163025.24388.56898.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163009.24388.11253.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163009.24388.11253.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of dw_pcie_writel_rc() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c      |    2 +-
 drivers/pci/host/pcie-designware.c |   46 ++++++++++++++++++------------------
 drivers/pci/host/pcie-designware.h |    2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index b29e9d6..f559b49 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -435,7 +435,7 @@ static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 	return val;
 }
 
-static inline void exynos_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
+static inline void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
 	exynos_pcie_sideband_dbi_w_mode(pp, true);
 	writel(val, pp->dbi_base + reg);
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index c5b54a3..041b5da 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -149,10 +149,10 @@ static inline u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 	return readl(pp->dbi_base + reg);
 }
 
-static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
+static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
 	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, val, reg);
+		pp->ops->writel_rc(pp, reg, val);
 	else
 		writel(val, pp->dbi_base + reg);
 }
@@ -217,20 +217,20 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 		dw_pcie_writel_unroll(pp, index,
 			PCIE_ATU_ENABLE, PCIE_ATU_UNR_REGION_CTRL2);
 	} else {
-		dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
-						PCIE_ATU_VIEWPORT);
-		dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr),
-						PCIE_ATU_LOWER_BASE);
-		dw_pcie_writel_rc(pp, upper_32_bits(cpu_addr),
-						PCIE_ATU_UPPER_BASE);
-		dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr + size - 1),
-						PCIE_ATU_LIMIT);
-		dw_pcie_writel_rc(pp, lower_32_bits(pci_addr),
-						PCIE_ATU_LOWER_TARGET);
-		dw_pcie_writel_rc(pp, upper_32_bits(pci_addr),
-						PCIE_ATU_UPPER_TARGET);
-		dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
-		dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+		dw_pcie_writel_rc(pp, PCIE_ATU_VIEWPORT,
+				  PCIE_ATU_REGION_OUTBOUND | index);
+		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_BASE,
+				  lower_32_bits(cpu_addr));
+		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_BASE,
+				  upper_32_bits(cpu_addr));
+		dw_pcie_writel_rc(pp, PCIE_ATU_LIMIT,
+				  lower_32_bits(cpu_addr + size - 1));
+		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_TARGET,
+				  lower_32_bits(pci_addr));
+		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_TARGET,
+				  upper_32_bits(pci_addr));
+		dw_pcie_writel_rc(pp, PCIE_ATU_CR1, type);
+		dw_pcie_writel_rc(pp, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 	}
 
 	/*
@@ -835,7 +835,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		dev_err(pp->dev, "num-lanes %u: invalid value\n", pp->lanes);
 		return;
 	}
-	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
+	dw_pcie_writel_rc(pp, PCIE_PORT_LINK_CONTROL, val);
 
 	/* set link width speed control register */
 	val = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
@@ -854,30 +854,30 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	}
-	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
 	/* setup RC BARs */
-	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
-	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0x00000004);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0x00000000);
 
 	/* setup interrupt pins */
 	val = dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
-	dw_pcie_writel_rc(pp, val, PCI_INTERRUPT_LINE);
+	dw_pcie_writel_rc(pp, PCI_INTERRUPT_LINE, val);
 
 	/* setup bus numbers */
 	val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
 	val |= 0x00010100;
-	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
+	dw_pcie_writel_rc(pp, PCI_PRIMARY_BUS, val);
 
 	/* setup command register */
 	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
+	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
 
 	/*
 	 * If the platform provides ->rd_other_conf, it means the platform
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 60cbc68..c413848 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -55,7 +55,7 @@ struct pcie_port {
 
 struct pcie_host_ops {
 	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
-	void (*writel_rc)(struct pcie_port *pp, u32 val, u32 reg);
+	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
 	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
 	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
 	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,

