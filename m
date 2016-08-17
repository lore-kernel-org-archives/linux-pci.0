Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45242 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbcHQT7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 15:59:55 -0400
Subject: [PATCH v6 1/4] PCI: designware: Return data directly from
 dw_pcie_readl_rc()
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: jszhang@marvell.com, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 17 Aug 2016 14:59:50 -0500
Message-ID: <20160817195950.10418.13098.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dw_pcie_readl_rc() reads a u32 value.  Previously we stored that value in
space supplied by the caller.  Return the u32 value directly instead.

This makes the calling code read better and makes it obvious that the
caller need not initialize the storage.  In the following example it isn't
clear whether "val" is initialized before being used:

  dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
  if (val & PCI_COMMAND_MEMORY)
    ...

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c      |    9 ++++++---
 drivers/pci/host/pcie-designware.c |   20 ++++++++++----------
 drivers/pci/host/pcie-designware.h |    3 +--
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 2199761..490f8b6 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -425,12 +425,15 @@ static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
 		exynos_pcie_msi_init(pp);
 }
 
-static inline void exynos_pcie_readl_rc(struct pcie_port *pp,
-					void __iomem *dbi_base, u32 *val)
+static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp,
+				       void __iomem *dbi_base)
 {
+	u32 val;
+
 	exynos_pcie_sideband_dbi_r_mode(pp, true);
-	*val = readl(dbi_base);
+	val = readl(dbi_base);
 	exynos_pcie_sideband_dbi_r_mode(pp, false);
+	return val;
 }
 
 static inline void exynos_pcie_writel_rc(struct pcie_port *pp,
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..1f6bd6d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -115,12 +115,12 @@ int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
+static inline u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
 	if (pp->ops->readl_rc)
-		pp->ops->readl_rc(pp, pp->dbi_base + reg, val);
-	else
-		*val = readl(pp->dbi_base + reg);
+		return pp->ops->readl_rc(pp, pp->dbi_base + reg);
+
+	return readl(pp->dbi_base + reg);
 }
 
 static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
@@ -169,7 +169,7 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
-	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+	val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
 }
 
 static struct irq_chip dw_msi_irq_chip = {
@@ -720,7 +720,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	u32 val;
 
 	/* set the number of lanes */
-	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
+	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (pp->lanes) {
 	case 1:
@@ -742,7 +742,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
 
 	/* set link width speed control register */
-	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
+	val = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
 	switch (pp->lanes) {
 	case 1:
@@ -765,19 +765,19 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
 
 	/* setup interrupt pins */
-	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
+	val = dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
 	dw_pcie_writel_rc(pp, val, PCI_INTERRUPT_LINE);
 
 	/* setup bus numbers */
-	dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS, &val);
+	val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
 	val |= 0x00010100;
 	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
 
 	/* setup command register */
-	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
+	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b..74a8fc6 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -57,8 +57,7 @@ struct pcie_port {
 };
 
 struct pcie_host_ops {
-	void (*readl_rc)(struct pcie_port *pp,
-			void __iomem *dbi_base, u32 *val);
+	u32 (*readl_rc)(struct pcie_port *pp, void __iomem *dbi_base);
 	void (*writel_rc)(struct pcie_port *pp,
 			u32 val, void __iomem *dbi_base);
 	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);

