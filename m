Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940970AbcJGQZ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:57 -0400
Subject: [PATCH 09/10] PCI: rcar-gen2: Add register accessors
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:25:52 -0500
Message-ID: <20161007162552.23279.2875.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device-specific register accessors for consistency across host drivers.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-rcar-gen2.c |   61 ++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index cba27bc..b210ec0 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -107,6 +107,16 @@ struct rcar_pci {
 	unsigned long window_pci;
 };
 
+static u32 rcar_readl(struct rcar_pci *rcar, u32 offset)
+{
+	return ioread32(rcar->reg + offset);
+}
+
+static void rcar_writel(struct rcar_pci *rcar, u32 offset, u32 val)
+{
+	iowrite32(val, rcar->reg + offset);
+}
+
 /* PCI configuration space operations */
 static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 				       int where)
@@ -130,7 +140,7 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
 		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
 
-	iowrite32(val, rcar->reg + RCAR_AHBPCI_WIN1_CTR_REG);
+	rcar_writel(rcar, RCAR_AHBPCI_WIN1_CTR_REG, val);
 	return rcar->reg + (slot >> 1) * 0x100 + where;
 }
 
@@ -154,14 +164,14 @@ static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 {
 	struct rcar_pci *rcar = pw;
-	u32 status = ioread32(rcar->reg + RCAR_PCI_INT_STATUS_REG);
+	u32 status = rcar_readl(rcar, RCAR_PCI_INT_STATUS_REG);
 
 	if (status & RCAR_PCI_INT_ALLERRORS) {
 		dev_err(rcar->dev, "error irq: status %08x\n", status);
 
 		/* clear the error(s) */
-		iowrite32(status & RCAR_PCI_INT_ALLERRORS,
-			  rcar->reg + RCAR_PCI_INT_STATUS_REG);
+		rcar_writel(rcar, RCAR_PCI_INT_STATUS_REG,
+			    status & RCAR_PCI_INT_ALLERRORS);
 		return IRQ_HANDLED;
 	}
 
@@ -180,9 +190,9 @@ static void rcar_pci_setup_errirq(struct rcar_pci *rcar)
 		return;
 	}
 
-	val = ioread32(rcar->reg + RCAR_PCI_INT_ENABLE_REG);
+	val = rcar_readl(rcar, RCAR_PCI_INT_ENABLE_REG);
 	val |= RCAR_PCI_INT_ALLERRORS;
-	iowrite32(val, rcar->reg + RCAR_PCI_INT_ENABLE_REG);
+	rcar_writel(rcar, RCAR_PCI_INT_ENABLE_REG, val);
 }
 #else
 static inline void rcar_pci_setup_errirq(struct rcar_pci *rcar) { }
@@ -192,20 +202,19 @@ static inline void rcar_pci_setup_errirq(struct rcar_pci *rcar) { }
 static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 {
 	struct rcar_pci *rcar = sys->private_data;
-	void __iomem *reg = rcar->reg;
 	u32 val;
 	int ret;
 
 	pm_runtime_enable(rcar->dev);
 	pm_runtime_get_sync(rcar->dev);
 
-	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
+	val = rcar_readl(rcar, RCAR_PCI_UNIT_REV_REG);
 	dev_info(rcar->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
 
 	/* Disable Direct Power Down State and assert reset */
-	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
+	val = rcar_readl(rcar, RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
 	val |= RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST;
-	iowrite32(val, reg + RCAR_USBCTR_REG);
+	rcar_writel(rcar, RCAR_USBCTR_REG, val);
 	udelay(4);
 
 	/* De-assert reset and reset PCIAHB window1 size */
@@ -232,43 +241,43 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		val |= RCAR_USBCTR_PCIAHB_WIN1_256M;
 		break;
 	}
-	iowrite32(val, reg + RCAR_USBCTR_REG);
+	rcar_writel(rcar, RCAR_USBCTR_REG, val);
 
 	/* Configure AHB master and slave modes */
-	iowrite32(RCAR_AHB_BUS_MODE, reg + RCAR_AHB_BUS_CTR_REG);
+	rcar_writel(rcar, RCAR_AHB_BUS_CTR_REG, RCAR_AHB_BUS_MODE);
 
 	/* Configure PCI arbiter */
-	val = ioread32(reg + RCAR_PCI_ARBITER_CTR_REG);
+	val = rcar_readl(rcar, RCAR_PCI_ARBITER_CTR_REG);
 	val |= RCAR_PCI_ARBITER_PCIREQ0 | RCAR_PCI_ARBITER_PCIREQ1 |
 	       RCAR_PCI_ARBITER_PCIBP_MODE;
-	iowrite32(val, reg + RCAR_PCI_ARBITER_CTR_REG);
+	rcar_writel(rcar, RCAR_PCI_ARBITER_CTR_REG, val);
 
 	/* PCI-AHB mapping */
-	iowrite32(rcar->window_addr | RCAR_PCIAHB_PREFETCH16,
-		  reg + RCAR_PCIAHB_WIN1_CTR_REG);
+	rcar_writel(rcar, RCAR_PCIAHB_WIN1_CTR_REG,
+			rcar->window_addr | RCAR_PCIAHB_PREFETCH16);
 
 	/* AHB-PCI mapping: OHCI/EHCI registers */
 	val = rcar->mem_res.start | RCAR_AHBPCI_WIN_CTR_MEM;
-	iowrite32(val, reg + RCAR_AHBPCI_WIN2_CTR_REG);
+	rcar_writel(rcar, RCAR_AHBPCI_WIN2_CTR_REG, val);
 
 	/* Enable AHB-PCI bridge PCI configuration access */
-	iowrite32(RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG,
-		  reg + RCAR_AHBPCI_WIN1_CTR_REG);
+	rcar_writel(rcar, RCAR_AHBPCI_WIN1_CTR_REG,
+			RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG);
 	/* Set PCI-AHB Window1 address */
-	iowrite32(rcar->window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH,
-		  reg + PCI_BASE_ADDRESS_1);
+	rcar_writel(rcar, PCI_BASE_ADDRESS_1,
+			rcar->window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH);
 	/* Set AHB-PCI bridge PCI communication area address */
 	val = rcar->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
-	iowrite32(val, reg + PCI_BASE_ADDRESS_0);
+	rcar_writel(rcar, PCI_BASE_ADDRESS_0, val);
 
-	val = ioread32(reg + PCI_COMMAND);
+	val = rcar_readl(rcar, PCI_COMMAND);
 	val |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
 	       PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
-	iowrite32(val, reg + PCI_COMMAND);
+	rcar_writel(rcar, PCI_COMMAND, val);
 
 	/* Enable PCI interrupts */
-	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
-		  reg + RCAR_PCI_INT_ENABLE_REG);
+	rcar_writel(rcar, RCAR_PCI_INT_ENABLE_REG,
+			RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME);
 
 	if (rcar->irq > 0)
 		rcar_pci_setup_errirq(rcar);

