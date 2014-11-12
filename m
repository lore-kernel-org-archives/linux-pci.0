Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59410 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaKLDYz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:24:55 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW00LBWPHHUW30@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Nov 2014 12:24:53 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: exynos: Remove unnecessary return statement
Date: Wed, 12 Nov 2014 12:25:38 +0900
Message-id: <002901cffe28$544504b0$fccf0e10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes the following checkpatch warning.

  WARNING: void function return statements are not generally useful

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-exynos.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index c5d0ca3..41ab139 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -312,7 +312,6 @@ static void exynos_pcie_assert_reset(struct pcie_port *pp)
 	if (exynos_pcie->reset_gpio >= 0)
 		devm_gpio_request_one(pp->dev, exynos_pcie->reset_gpio,
 				GPIOF_OUT_INIT_HIGH, "RESET");
-	return;
 }
 
 static int exynos_pcie_establish_link(struct pcie_port *pp)
@@ -388,7 +387,6 @@ static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
 
 	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
 	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
-	return;
 }
 
 static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
@@ -400,7 +398,6 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
 		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT,
 	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
-	return;
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -429,7 +426,6 @@ static void exynos_pcie_msi_init(struct pcie_port *pp)
 	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_EN_LEVEL);
 	val |= IRQ_MSI_ENABLE;
 	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_LEVEL);
-	return;
 }
 
 static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
@@ -438,8 +434,6 @@ static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		exynos_pcie_msi_init(pp);
-
-	return;
 }
 
 static inline void exynos_pcie_readl_rc(struct pcie_port *pp,
@@ -448,7 +442,6 @@ static inline void exynos_pcie_readl_rc(struct pcie_port *pp,
 	exynos_pcie_sideband_dbi_r_mode(pp, true);
 	*val = readl(dbi_base);
 	exynos_pcie_sideband_dbi_r_mode(pp, false);
-	return;
 }
 
 static inline void exynos_pcie_writel_rc(struct pcie_port *pp,
@@ -457,7 +450,6 @@ static inline void exynos_pcie_writel_rc(struct pcie_port *pp,
 	exynos_pcie_sideband_dbi_w_mode(pp, true);
 	writel(val, dbi_base);
 	exynos_pcie_sideband_dbi_w_mode(pp, false);
-	return;
 }
 
 static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-- 
1.7.9.5


