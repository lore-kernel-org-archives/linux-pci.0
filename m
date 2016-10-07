Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933163AbcJGQap (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:30:45 -0400
Subject: [PATCH 4/7] PCI: designware: Export dw_pcie_readl_rc(),
 dw_pcie_writel_rc()
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:30:40 -0500
Message-ID: <20161007163040.24388.29925.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163009.24388.11253.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163009.24388.11253.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Export dw_pcie_readl_rc() and dw_pcie_writel_rc().  Many other drivers can
use these instead of implementing their own versions.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |    4 ++--
 drivers/pci/host/pcie-designware.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 041b5da..5ee8772 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -141,7 +141,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
+u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
 	if (pp->ops->readl_rc)
 		return pp->ops->readl_rc(pp, reg);
@@ -149,7 +149,7 @@ static inline u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 	return readl(pp->dbi_base + reg);
 }
 
-static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
+void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
 	if (pp->ops->writel_rc)
 		pp->ops->writel_rc(pp, reg, val);
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index c413848..a567ea2 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -72,6 +72,8 @@ struct pcie_host_ops {
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
 };
 
+u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg);
+void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val);
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);

