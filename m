Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbcJLNSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:18:11 -0400
Subject: [PATCH v2 03/10] PCI: designware: Simplify pcie_host_ops.readl_rc()
 and .writel_rc() interfaces
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:18:07 -0500
Message-ID: <20161012131807.26443.18264.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct pcie_host_ops.readl_rc() and .writel_rc() function pointers
allow a driver to override the default DesignWare register accessors.

Make the signature of the override functions the same as the default
accessors.  This makes the default dw_pcie_readl_rc() and the corresponding
override more structurally similar: both will compute the final register
address with "pp->dbi_base + reg".  Previously dw_pcie_readl_rc() computed
the address and passed it to the override.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c      |   10 ++++------
 drivers/pci/host/pcie-designware.c |    4 ++--
 drivers/pci/host/pcie-designware.h |    5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 2e2d7f0..b29e9d6 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -425,22 +425,20 @@ static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
 		exynos_pcie_msi_init(pp);
 }
 
-static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp,
-				       void __iomem *dbi_base)
+static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
 	u32 val;
 
 	exynos_pcie_sideband_dbi_r_mode(pp, true);
-	val = readl(dbi_base);
+	val = readl(pp->dbi_base + reg);
 	exynos_pcie_sideband_dbi_r_mode(pp, false);
 	return val;
 }
 
-static inline void exynos_pcie_writel_rc(struct pcie_port *pp,
-					u32 val, void __iomem *dbi_base)
+static inline void exynos_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 {
 	exynos_pcie_sideband_dbi_w_mode(pp, true);
-	writel(val, dbi_base);
+	writel(val, pp->dbi_base + reg);
 	exynos_pcie_sideband_dbi_w_mode(pp, false);
 }
 
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 7ce4f75..6a28eb1 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -144,7 +144,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 static inline u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
 	if (pp->ops->readl_rc)
-		return pp->ops->readl_rc(pp, pp->dbi_base + reg);
+		return pp->ops->readl_rc(pp, reg);
 
 	return readl(pp->dbi_base + reg);
 }
@@ -152,7 +152,7 @@ static inline u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 {
 	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, val, pp->dbi_base + reg);
+		pp->ops->writel_rc(pp, val, reg);
 	else
 		writel(val, pp->dbi_base + reg);
 }
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index c8e5bc6..60cbc68 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -54,9 +54,8 @@ struct pcie_port {
 };
 
 struct pcie_host_ops {
-	u32 (*readl_rc)(struct pcie_port *pp, void __iomem *dbi_base);
-	void (*writel_rc)(struct pcie_port *pp,
-			u32 val, void __iomem *dbi_base);
+	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
+	void (*writel_rc)(struct pcie_port *pp, u32 val, u32 reg);
 	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
 	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
 	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,

