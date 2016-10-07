Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGQVY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:21:24 -0400
Subject: [PATCH 3/5] PCI: aardvark: Swap order of advk_write() reg/val
 arguments
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Oct 2016 11:21:14 -0500
Message-ID: <20161007162114.22668.11180.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of advk_writel() arguments to match the "dev, pos, val" order
used by pci_write_config_word() and other drivers.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |  109 +++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 3d629d4..af6312a 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -214,7 +214,7 @@ static u32 advk_readl(struct advk_pcie *advk, u64 reg)
 	return readl(advk->base + reg);
 }
 
-static void advk_writel(struct advk_pcie *advk, u32 val, u64 reg)
+static void advk_writel(struct advk_pcie *advk, u64 reg, u32 val)
 {
 	writel(val, advk->base + reg);
 }
@@ -257,14 +257,14 @@ static void advk_pcie_set_ob_win(struct advk_pcie *advk,
 				 u32 mask_ls, u32 remap_ms,
 				 u32 remap_ls, u32 action)
 {
-	advk_writel(advk, match_ls, OB_WIN_MATCH_LS(win_num));
-	advk_writel(advk, match_ms, OB_WIN_MATCH_MS(win_num));
-	advk_writel(advk, mask_ms, OB_WIN_MASK_MS(win_num));
-	advk_writel(advk, mask_ls, OB_WIN_MASK_LS(win_num));
-	advk_writel(advk, remap_ms, OB_WIN_REMAP_MS(win_num));
-	advk_writel(advk, remap_ls, OB_WIN_REMAP_LS(win_num));
-	advk_writel(advk, action, OB_WIN_ACTIONS(win_num));
-	advk_writel(advk, match_ls | BIT(0), OB_WIN_MATCH_LS(win_num));
+	advk_writel(advk, OB_WIN_MATCH_LS(win_num), match_ls);
+	advk_writel(advk, OB_WIN_MATCH_MS(win_num), match_ms);
+	advk_writel(advk, OB_WIN_MASK_MS(win_num), mask_ms);
+	advk_writel(advk, OB_WIN_MASK_LS(win_num), mask_ls);
+	advk_writel(advk, OB_WIN_REMAP_MS(win_num), remap_ms);
+	advk_writel(advk, OB_WIN_REMAP_LS(win_num), remap_ls);
+	advk_writel(advk, OB_WIN_ACTIONS(win_num), action);
+	advk_writel(advk, OB_WIN_MATCH_LS(win_num), match_ls | BIT(0));
 }
 
 static void advk_pcie_setup_hw(struct advk_pcie *advk)
@@ -280,98 +280,98 @@ static void advk_pcie_setup_hw(struct advk_pcie *advk)
 	reg = advk_readl(advk, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
 	reg |= ((PCIE_CORE_MODE_DIRECT & CTRL_MODE_MASK) << CTRL_MODE_SHIFT);
-	advk_writel(advk, reg, CTRL_CONFIG_REG);
+	advk_writel(advk, CTRL_CONFIG_REG, reg);
 
 	/* Set PCI global control register to RC mode */
 	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg |= (IS_RC_MSK << IS_RC_SHIFT);
-	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, PCIE_CORE_CTRL0_REG, reg);
 
 	/* Set Advanced Error Capabilities and Control PF0 register */
 	reg = PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV;
-	advk_writel(advk, reg, PCIE_CORE_ERR_CAPCTL_REG);
+	advk_writel(advk, PCIE_CORE_ERR_CAPCTL_REG, reg);
 
 	/* Set PCIe Device Control and Status 1 PF0 register */
 	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
 		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
 		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
-	advk_writel(advk, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
+	advk_writel(advk, PCIE_CORE_DEV_CTRL_STATS_REG, reg);
 
 	/* Program PCIe Control 2 to disable strict ordering */
 	reg = PCIE_CORE_CTRL2_RESERVED |
 		PCIE_CORE_CTRL2_TD_ENABLE;
-	advk_writel(advk, reg, PCIE_CORE_CTRL2_REG);
+	advk_writel(advk, PCIE_CORE_CTRL2_REG, reg);
 
 	/* Set GEN2 */
 	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg &= ~PCIE_GEN_SEL_MSK;
 	reg |= SPEED_GEN_2;
-	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, PCIE_CORE_CTRL0_REG, reg);
 
 	/* Set lane X1 */
 	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg &= ~LANE_CNT_MSK;
 	reg |= LANE_COUNT_1;
-	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, PCIE_CORE_CTRL0_REG, reg);
 
 	/* Enable link training */
 	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg |= LINK_TRAINING_EN;
-	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, PCIE_CORE_CTRL0_REG, reg);
 
 	/* Enable MSI */
 	reg = advk_readl(advk, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_MSI_ENABLE;
-	advk_writel(advk, reg, PCIE_CORE_CTRL2_REG);
+	advk_writel(advk, PCIE_CORE_CTRL2_REG, reg);
 
 	/* Clear all interrupts */
-	advk_writel(advk, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
-	advk_writel(advk, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
-	advk_writel(advk, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
+	advk_writel(advk, PCIE_ISR0_REG, PCIE_ISR0_ALL_MASK);
+	advk_writel(advk, PCIE_ISR1_REG, PCIE_ISR1_ALL_MASK);
+	advk_writel(advk, HOST_CTRL_INT_STATUS_REG, PCIE_IRQ_ALL_MASK);
 
 	/* Disable All ISR0/1 Sources */
 	reg = PCIE_ISR0_ALL_MASK;
 	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
-	advk_writel(advk, reg, PCIE_ISR0_MASK_REG);
+	advk_writel(advk, PCIE_ISR0_MASK_REG, reg);
 
-	advk_writel(advk, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
+	advk_writel(advk, PCIE_ISR1_MASK_REG, PCIE_ISR1_ALL_MASK);
 
 	/* Unmask all MSI's */
-	advk_writel(advk, 0, PCIE_MSI_MASK_REG);
+	advk_writel(advk, PCIE_MSI_MASK_REG, 0);
 
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
-	advk_writel(advk, reg, HOST_CTRL_INT_MASK_REG);
+	advk_writel(advk, HOST_CTRL_INT_MASK_REG, reg);
 
 	reg = advk_readl(advk, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_OB_WIN_ENABLE;
-	advk_writel(advk, reg, PCIE_CORE_CTRL2_REG);
+	advk_writel(advk, PCIE_CORE_CTRL2_REG, reg);
 
 	/* Bypass the address window mapping for PIO */
 	reg = advk_readl(advk, PIO_CTRL);
 	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
-	advk_writel(advk, reg, PIO_CTRL);
+	advk_writel(advk, PIO_CTRL, reg);
 
 	/* Start link training */
 	reg = advk_readl(advk, PCIE_CORE_LINK_CTRL_STAT_REG);
 	reg |= PCIE_CORE_LINK_TRAINING;
-	advk_writel(advk, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+	advk_writel(advk, PCIE_CORE_LINK_CTRL_STAT_REG, reg);
 
 	advk_pcie_wait_for_link(advk);
 
 	reg = PCIE_CORE_LINK_L0S_ENTRY |
 		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
-	advk_writel(advk, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+	advk_writel(advk, PCIE_CORE_LINK_CTRL_STAT_REG, reg);
 
 	reg = advk_readl(advk, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
 		PCIE_CORE_CMD_MEM_IO_REQ_EN;
-	advk_writel(advk, reg, PCIE_CORE_CMD_STATUS_REG);
+	advk_writel(advk, PCIE_CORE_CMD_STATUS_REG, reg);
 }
 
 static void advk_pcie_check_pio_status(struct advk_pcie *advk)
@@ -443,8 +443,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	}
 
 	/* Start PIO */
-	advk_writel(advk, 0, PIO_START);
-	advk_writel(advk, 1, PIO_ISR);
+	advk_writel(advk, PIO_START, 0);
+	advk_writel(advk, PIO_ISR, 1);
 
 	/* Program the control register */
 	reg = advk_readl(advk, PIO_CTRL);
@@ -453,18 +453,18 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		reg |= PCIE_CONFIG_RD_TYPE0;
 	else
 		reg |= PCIE_CONFIG_RD_TYPE1;
-	advk_writel(advk, reg, PIO_CTRL);
+	advk_writel(advk, PIO_CTRL, reg);
 
 	/* Program the address registers */
 	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
-	advk_writel(advk, reg, PIO_ADDR_LS);
-	advk_writel(advk, 0, PIO_ADDR_MS);
+	advk_writel(advk, PIO_ADDR_LS, reg);
+	advk_writel(advk, PIO_ADDR_MS, 0);
 
 	/* Program the data strobe */
-	advk_writel(advk, 0xf, PIO_WR_DATA_STRB);
+	advk_writel(advk, PIO_WR_DATA_STRB, 0xf);
 
 	/* Start the transfer */
-	advk_writel(advk, 1, PIO_START);
+	advk_writel(advk, PIO_START, 1);
 
 	ret = advk_pcie_wait_pio(advk);
 	if (ret < 0)
@@ -498,8 +498,8 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_SET_FAILED;
 
 	/* Start PIO */
-	advk_writel(advk, 0, PIO_START);
-	advk_writel(advk, 1, PIO_ISR);
+	advk_writel(advk, PIO_START, 0);
+	advk_writel(advk, PIO_ISR, 1);
 
 	/* Program the control register */
 	reg = advk_readl(advk, PIO_CTRL);
@@ -508,12 +508,12 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 		reg |= PCIE_CONFIG_WR_TYPE0;
 	else
 		reg |= PCIE_CONFIG_WR_TYPE1;
-	advk_writel(advk, reg, PIO_CTRL);
+	advk_writel(advk, PIO_CTRL, reg);
 
 	/* Program the address registers */
 	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
-	advk_writel(advk, reg, PIO_ADDR_LS);
-	advk_writel(advk, 0, PIO_ADDR_MS);
+	advk_writel(advk, PIO_ADDR_LS, reg);
+	advk_writel(advk, PIO_ADDR_MS, 0);
 
 	/* Calculate the write strobe */
 	offset      = where & 0x3;
@@ -521,13 +521,13 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	data_strobe = GENMASK(size - 1, 0) << offset;
 
 	/* Program the data register */
-	advk_writel(advk, reg, PIO_WR_DATA);
+	advk_writel(advk, PIO_WR_DATA, reg);
 
 	/* Program the data strobe */
-	advk_writel(advk, data_strobe, PIO_WR_DATA_STRB);
+	advk_writel(advk, PIO_WR_DATA_STRB, data_strobe);
 
 	/* Start the transfer */
-	advk_writel(advk, 1, PIO_START);
+	advk_writel(advk, PIO_START, 1);
 
 	ret = advk_pcie_wait_pio(advk);
 	if (ret < 0)
@@ -640,7 +640,7 @@ static void advk_pcie_irq_mask(struct irq_data *d)
 
 	mask = advk_readl(advk, PCIE_ISR0_MASK_REG);
 	mask |= PCIE_ISR0_INTX_ASSERT(hwirq);
-	advk_writel(advk, mask, PCIE_ISR0_MASK_REG);
+	advk_writel(advk, PCIE_ISR0_MASK_REG, mask);
 }
 
 static void advk_pcie_irq_unmask(struct irq_data *d)
@@ -651,7 +651,7 @@ static void advk_pcie_irq_unmask(struct irq_data *d)
 
 	mask = advk_readl(advk, PCIE_ISR0_MASK_REG);
 	mask &= ~PCIE_ISR0_INTX_ASSERT(hwirq);
-	advk_writel(advk, mask, PCIE_ISR0_MASK_REG);
+	advk_writel(advk, PCIE_ISR0_MASK_REG, mask);
 }
 
 static int advk_pcie_irq_map(struct irq_domain *h,
@@ -703,8 +703,8 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *advk)
 
 	msi_msg_phys = virt_to_phys(&advk->msi_msg);
 
-	advk_writel(advk, lower_32_bits(msi_msg_phys), PCIE_MSI_ADDR_LOW_REG);
-	advk_writel(advk, upper_32_bits(msi_msg_phys), PCIE_MSI_ADDR_HIGH_REG);
+	advk_writel(advk, PCIE_MSI_ADDR_LOW_REG, lower_32_bits(msi_msg_phys));
+	advk_writel(advk, PCIE_MSI_ADDR_HIGH_REG, upper_32_bits(msi_msg_phys));
 
 	advk->msi_domain =
 		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
@@ -783,12 +783,12 @@ static void advk_pcie_handle_msi(struct advk_pcie *advk)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		advk_writel(advk, BIT(msi_idx), PCIE_MSI_STATUS_REG);
+		advk_writel(advk, PCIE_MSI_STATUS_REG, BIT(msi_idx));
 		msi_data = advk_readl(advk, PCIE_MSI_PAYLOAD_REG) & 0xFF;
 		generic_handle_irq(msi_data);
 	}
 
-	advk_writel(advk, PCIE_ISR0_MSI_INT_PENDING, PCIE_ISR0_REG);
+	advk_writel(advk, PCIE_ISR0_REG, PCIE_ISR0_MSI_INT_PENDING);
 }
 
 static void advk_pcie_handle_int(struct advk_pcie *advk)
@@ -801,7 +801,7 @@ static void advk_pcie_handle_int(struct advk_pcie *advk)
 	status = val & ((~mask) & PCIE_ISR0_ALL_MASK);
 
 	if (!status) {
-		advk_writel(advk, val, PCIE_ISR0_REG);
+		advk_writel(advk, PCIE_ISR0_REG, val);
 		return;
 	}
 
@@ -814,8 +814,7 @@ static void advk_pcie_handle_int(struct advk_pcie *advk)
 		if (!(status & PCIE_ISR0_INTX_ASSERT(i)))
 			continue;
 
-		advk_writel(advk, PCIE_ISR0_INTX_ASSERT(i),
-			    PCIE_ISR0_REG);
+		advk_writel(advk, PCIE_ISR0_REG, PCIE_ISR0_INTX_ASSERT(i));
 
 		virq = irq_find_mapping(advk->irq_domain, i);
 		generic_handle_irq(virq);
@@ -834,7 +833,7 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 	advk_pcie_handle_int(advk);
 
 	/* Clear interrupt */
-	advk_writel(advk, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
+	advk_writel(advk, HOST_CTRL_INT_STATUS_REG, PCIE_IRQ_CORE_INT);
 
 	return IRQ_HANDLED;
 }

