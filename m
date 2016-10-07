Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936176AbcJGQXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:23:15 -0400
Subject: [PATCH 1/7] PCI: iproc: Rename accessors
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Fri, 07 Oct 2016 11:23:11 -0500
Message-ID: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename iproc_pcie_read_reg() to iproc_readl() and iproc_pcie_write_reg() to
iproc_writel() for consistency with other drivers.  Uninline them; there's
no performance issue here, and the compiler can inline them if it's
worthwhile.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index e167b2f..f1ae9e1 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -135,8 +135,7 @@ static inline u16 iproc_pcie_reg_offset(struct iproc_pcie *pcie,
 	return pcie->reg_offsets[reg];
 }
 
-static inline u32 iproc_pcie_read_reg(struct iproc_pcie *pcie,
-				      enum iproc_pcie_reg reg)
+static u32 iproc_readl(struct iproc_pcie *pcie, enum iproc_pcie_reg reg)
 {
 	u16 offset = iproc_pcie_reg_offset(pcie, reg);
 
@@ -146,8 +145,8 @@ static inline u32 iproc_pcie_read_reg(struct iproc_pcie *pcie,
 	return readl(pcie->base + offset);
 }
 
-static inline void iproc_pcie_write_reg(struct iproc_pcie *pcie,
-					enum iproc_pcie_reg reg, u32 val)
+static void iproc_writel(struct iproc_pcie *pcie, enum iproc_pcie_reg reg,
+			 u32 val)
 {
 	u16 offset = iproc_pcie_reg_offset(pcie, reg);
 
@@ -189,8 +188,8 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 		if (slot > 0 || fn > 0)
 			return NULL;
 
-		iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_IND_ADDR,
-				     where & CFG_IND_ADDR_MASK);
+		iproc_writel(pcie, IPROC_PCIE_CFG_IND_ADDR,
+			     where & CFG_IND_ADDR_MASK);
 		offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_IND_DATA);
 		if (iproc_pcie_reg_is_invalid(offset))
 			return NULL;
@@ -212,7 +211,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
 		(where & CFG_ADDR_REG_NUM_MASK) |
 		(1 & CFG_ADDR_CFG_TYPE_MASK);
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
+	iproc_writel(pcie, IPROC_PCIE_CFG_ADDR, val);
 	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
 	if (iproc_pcie_reg_is_invalid(offset))
 		return NULL;
@@ -231,12 +230,12 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
 	u32 val;
 
 	if (pcie->type == IPROC_PCIE_PAXC) {
-		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
+		val = iproc_readl(pcie, IPROC_PCIE_CLK_CTRL);
 		val &= ~PAXC_RESET_MASK;
-		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
+		iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
 		udelay(100);
 		val |= PAXC_RESET_MASK;
-		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
+		iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
 		udelay(100);
 		return;
 	}
@@ -245,14 +244,14 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
 	 * Select perst_b signal as reset source. Put the device into reset,
 	 * and then bring it out of reset
 	 */
-	val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
+	val = iproc_readl(pcie, IPROC_PCIE_CLK_CTRL);
 	val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
 		~RC_PCIE_RST_OUTPUT;
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
+	iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
 	udelay(250);
 
 	val |= RC_PCIE_RST_OUTPUT;
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
+	iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
 	msleep(100);
 }
 
@@ -270,7 +269,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 	if (pcie->type == IPROC_PCIE_PAXC)
 		return 0;
 
-	val = iproc_pcie_read_reg(pcie, IPROC_PCIE_LINK_STATUS);
+	val = iproc_readl(pcie, IPROC_PCIE_LINK_STATUS);
 	if (!(val & PCIE_PHYLINKUP) || !(val & PCIE_DL_ACTIVE)) {
 		dev_err(pcie->dev, "PHY or data link is INACTIVE!\n");
 		return -ENODEV;
@@ -331,7 +330,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 
 static void iproc_pcie_enable(struct iproc_pcie *pcie)
 {
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
+	iproc_writel(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
 }
 
 /**

