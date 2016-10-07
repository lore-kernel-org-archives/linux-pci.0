Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGQVA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:21:00 -0400
Subject: [PATCH 1/5] PCI: aardvark: Name private struct pointer "advk"
 consistently
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Oct 2016 11:20:53 -0500
Message-ID: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "advk", for struct advk_pcie pointers to hint
that this is device-specific information.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |  370 +++++++++++++++++++--------------------
 1 file changed, 183 insertions(+), 187 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index e4a5b7e..fd0e6af 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -209,40 +209,40 @@ struct advk_pcie {
 	int root_bus_nr;
 };
 
-static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
+static inline void advk_writel(struct advk_pcie *advk, u32 val, u64 reg)
 {
-	writel(val, pcie->base + reg);
+	writel(val, advk->base + reg);
 }
 
-static inline u32 advk_readl(struct advk_pcie *pcie, u64 reg)
+static inline u32 advk_readl(struct advk_pcie *advk, u64 reg)
 {
-	return readl(pcie->base + reg);
+	return readl(advk->base + reg);
 }
 
-static int advk_pcie_link_up(struct advk_pcie *pcie)
+static int advk_pcie_link_up(struct advk_pcie *advk)
 {
 	u32 val, ltssm_state;
 
-	val = advk_readl(pcie, CFG_REG);
+	val = advk_readl(advk, CFG_REG);
 	ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
 	return ltssm_state >= LTSSM_L0;
 }
 
-static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
+static int advk_pcie_wait_for_link(struct advk_pcie *advk)
 {
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (advk_pcie_link_up(pcie)) {
-			dev_info(&pcie->pdev->dev, "link up\n");
+		if (advk_pcie_link_up(advk)) {
+			dev_info(&advk->pdev->dev, "link up\n");
 			return 0;
 		}
 
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(&pcie->pdev->dev, "link never came up\n");
+	dev_err(&advk->pdev->dev, "link never came up\n");
 
 	return -ETIMEDOUT;
 }
@@ -251,136 +251,136 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
  * Set PCIe address window register which could be used for memory
  * mapping.
  */
-static void advk_pcie_set_ob_win(struct advk_pcie *pcie,
+static void advk_pcie_set_ob_win(struct advk_pcie *advk,
 				 u32 win_num, u32 match_ms,
 				 u32 match_ls, u32 mask_ms,
 				 u32 mask_ls, u32 remap_ms,
 				 u32 remap_ls, u32 action)
 {
-	advk_writel(pcie, match_ls, OB_WIN_MATCH_LS(win_num));
-	advk_writel(pcie, match_ms, OB_WIN_MATCH_MS(win_num));
-	advk_writel(pcie, mask_ms, OB_WIN_MASK_MS(win_num));
-	advk_writel(pcie, mask_ls, OB_WIN_MASK_LS(win_num));
-	advk_writel(pcie, remap_ms, OB_WIN_REMAP_MS(win_num));
-	advk_writel(pcie, remap_ls, OB_WIN_REMAP_LS(win_num));
-	advk_writel(pcie, action, OB_WIN_ACTIONS(win_num));
-	advk_writel(pcie, match_ls | BIT(0), OB_WIN_MATCH_LS(win_num));
+	advk_writel(advk, match_ls, OB_WIN_MATCH_LS(win_num));
+	advk_writel(advk, match_ms, OB_WIN_MATCH_MS(win_num));
+	advk_writel(advk, mask_ms, OB_WIN_MASK_MS(win_num));
+	advk_writel(advk, mask_ls, OB_WIN_MASK_LS(win_num));
+	advk_writel(advk, remap_ms, OB_WIN_REMAP_MS(win_num));
+	advk_writel(advk, remap_ls, OB_WIN_REMAP_LS(win_num));
+	advk_writel(advk, action, OB_WIN_ACTIONS(win_num));
+	advk_writel(advk, match_ls | BIT(0), OB_WIN_MATCH_LS(win_num));
 }
 
-static void advk_pcie_setup_hw(struct advk_pcie *pcie)
+static void advk_pcie_setup_hw(struct advk_pcie *advk)
 {
 	u32 reg;
 	int i;
 
 	/* Point PCIe unit MBUS decode windows to DRAM space */
 	for (i = 0; i < 8; i++)
-		advk_pcie_set_ob_win(pcie, i, 0, 0, 0, 0, 0, 0, 0);
+		advk_pcie_set_ob_win(advk, i, 0, 0, 0, 0, 0, 0, 0);
 
 	/* Set to Direct mode */
-	reg = advk_readl(pcie, CTRL_CONFIG_REG);
+	reg = advk_readl(advk, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
 	reg |= ((PCIE_CORE_MODE_DIRECT & CTRL_MODE_MASK) << CTRL_MODE_SHIFT);
-	advk_writel(pcie, reg, CTRL_CONFIG_REG);
+	advk_writel(advk, reg, CTRL_CONFIG_REG);
 
 	/* Set PCI global control register to RC mode */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg |= (IS_RC_MSK << IS_RC_SHIFT);
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
 
 	/* Set Advanced Error Capabilities and Control PF0 register */
 	reg = PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV;
-	advk_writel(pcie, reg, PCIE_CORE_ERR_CAPCTL_REG);
+	advk_writel(advk, reg, PCIE_CORE_ERR_CAPCTL_REG);
 
 	/* Set PCIe Device Control and Status 1 PF0 register */
 	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
 		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
 		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
-	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
+	advk_writel(advk, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
 
 	/* Program PCIe Control 2 to disable strict ordering */
 	reg = PCIE_CORE_CTRL2_RESERVED |
 		PCIE_CORE_CTRL2_TD_ENABLE;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Set GEN2 */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg &= ~PCIE_GEN_SEL_MSK;
 	reg |= SPEED_GEN_2;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
 
 	/* Set lane X1 */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg &= ~LANE_CNT_MSK;
 	reg |= LANE_COUNT_1;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
 
 	/* Enable link training */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg = advk_readl(advk, PCIE_CORE_CTRL0_REG);
 	reg |= LINK_TRAINING_EN;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL0_REG);
 
 	/* Enable MSI */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
+	reg = advk_readl(advk, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_MSI_ENABLE;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Clear all interrupts */
-	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
-	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
-	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
+	advk_writel(advk, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
+	advk_writel(advk, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
+	advk_writel(advk, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
 	/* Disable All ISR0/1 Sources */
 	reg = PCIE_ISR0_ALL_MASK;
 	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
-	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
+	advk_writel(advk, reg, PCIE_ISR0_MASK_REG);
 
-	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
+	advk_writel(advk, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
 
 	/* Unmask all MSI's */
-	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
+	advk_writel(advk, 0, PCIE_MSI_MASK_REG);
 
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
-	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
+	advk_writel(advk, reg, HOST_CTRL_INT_MASK_REG);
 
-	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
+	reg = advk_readl(advk, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_OB_WIN_ENABLE;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
+	advk_writel(advk, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Bypass the address window mapping for PIO */
-	reg = advk_readl(pcie, PIO_CTRL);
+	reg = advk_readl(advk, PIO_CTRL);
 	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
-	advk_writel(pcie, reg, PIO_CTRL);
+	advk_writel(advk, reg, PIO_CTRL);
 
 	/* Start link training */
-	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
+	reg = advk_readl(advk, PCIE_CORE_LINK_CTRL_STAT_REG);
 	reg |= PCIE_CORE_LINK_TRAINING;
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+	advk_writel(advk, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
 
-	advk_pcie_wait_for_link(pcie);
+	advk_pcie_wait_for_link(advk);
 
 	reg = PCIE_CORE_LINK_L0S_ENTRY |
 		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+	advk_writel(advk, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
 
-	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
+	reg = advk_readl(advk, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
 		PCIE_CORE_CMD_MEM_IO_REQ_EN;
-	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
+	advk_writel(advk, reg, PCIE_CORE_CMD_STATUS_REG);
 }
 
-static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
+static void advk_pcie_check_pio_status(struct advk_pcie *advk)
 {
 	u32 reg;
 	unsigned int status;
 	char *strcomp_status, *str_posted;
 
-	reg = advk_readl(pcie, PIO_STAT);
+	reg = advk_readl(advk, PIO_STAT);
 	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
 		PIO_COMPLETION_STATUS_SHIFT;
 
@@ -407,11 +407,11 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 	else
 		str_posted = "Posted";
 
-	dev_err(&pcie->pdev->dev, "%s PIO Response Status: %s, %#x @ %#x\n",
-		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
+	dev_err(&advk->pdev->dev, "%s PIO Response Status: %s, %#x @ %#x\n",
+		str_posted, strcomp_status, reg, advk_readl(advk, PIO_ADDR_LS));
 }
 
-static int advk_pcie_wait_pio(struct advk_pcie *pcie)
+static int advk_pcie_wait_pio(struct advk_pcie *advk)
 {
 	unsigned long timeout;
 
@@ -420,20 +420,20 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	while (time_before(jiffies, timeout)) {
 		u32 start, isr;
 
-		start = advk_readl(pcie, PIO_START);
-		isr = advk_readl(pcie, PIO_ISR);
+		start = advk_readl(advk, PIO_START);
+		isr = advk_readl(advk, PIO_ISR);
 		if (!start && isr)
 			return 0;
 	}
 
-	dev_err(&pcie->pdev->dev, "config read/write timed out\n");
+	dev_err(&advk->pdev->dev, "config read/write timed out\n");
 	return -ETIMEDOUT;
 }
 
 static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
-	struct advk_pcie *pcie = bus->sysdata;
+	struct advk_pcie *advk = bus->sysdata;
 	u32 reg;
 	int ret;
 
@@ -443,37 +443,37 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	}
 
 	/* Start PIO */
-	advk_writel(pcie, 0, PIO_START);
-	advk_writel(pcie, 1, PIO_ISR);
+	advk_writel(advk, 0, PIO_START);
+	advk_writel(advk, 1, PIO_ISR);
 
 	/* Program the control register */
-	reg = advk_readl(pcie, PIO_CTRL);
+	reg = advk_readl(advk, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->number ==  pcie->root_bus_nr)
+	if (bus->number ==  advk->root_bus_nr)
 		reg |= PCIE_CONFIG_RD_TYPE0;
 	else
 		reg |= PCIE_CONFIG_RD_TYPE1;
-	advk_writel(pcie, reg, PIO_CTRL);
+	advk_writel(advk, reg, PIO_CTRL);
 
 	/* Program the address registers */
 	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
-	advk_writel(pcie, reg, PIO_ADDR_LS);
-	advk_writel(pcie, 0, PIO_ADDR_MS);
+	advk_writel(advk, reg, PIO_ADDR_LS);
+	advk_writel(advk, 0, PIO_ADDR_MS);
 
 	/* Program the data strobe */
-	advk_writel(pcie, 0xf, PIO_WR_DATA_STRB);
+	advk_writel(advk, 0xf, PIO_WR_DATA_STRB);
 
 	/* Start the transfer */
-	advk_writel(pcie, 1, PIO_START);
+	advk_writel(advk, 1, PIO_START);
 
-	ret = advk_pcie_wait_pio(pcie);
+	ret = advk_pcie_wait_pio(advk);
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
-	advk_pcie_check_pio_status(pcie);
+	advk_pcie_check_pio_status(advk);
 
 	/* Get the read result */
-	*val = advk_readl(pcie, PIO_RD_DATA);
+	*val = advk_readl(advk, PIO_RD_DATA);
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
 	else if (size == 2)
@@ -485,7 +485,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 				int where, int size, u32 val)
 {
-	struct advk_pcie *pcie = bus->sysdata;
+	struct advk_pcie *advk = bus->sysdata;
 	u32 reg;
 	u32 data_strobe = 0x0;
 	int offset;
@@ -498,22 +498,22 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_SET_FAILED;
 
 	/* Start PIO */
-	advk_writel(pcie, 0, PIO_START);
-	advk_writel(pcie, 1, PIO_ISR);
+	advk_writel(advk, 0, PIO_START);
+	advk_writel(advk, 1, PIO_ISR);
 
 	/* Program the control register */
-	reg = advk_readl(pcie, PIO_CTRL);
+	reg = advk_readl(advk, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->number == pcie->root_bus_nr)
+	if (bus->number == advk->root_bus_nr)
 		reg |= PCIE_CONFIG_WR_TYPE0;
 	else
 		reg |= PCIE_CONFIG_WR_TYPE1;
-	advk_writel(pcie, reg, PIO_CTRL);
+	advk_writel(advk, reg, PIO_CTRL);
 
 	/* Program the address registers */
 	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
-	advk_writel(pcie, reg, PIO_ADDR_LS);
-	advk_writel(pcie, 0, PIO_ADDR_MS);
+	advk_writel(advk, reg, PIO_ADDR_LS);
+	advk_writel(advk, 0, PIO_ADDR_MS);
 
 	/* Calculate the write strobe */
 	offset      = where & 0x3;
@@ -521,19 +521,19 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	data_strobe = GENMASK(size - 1, 0) << offset;
 
 	/* Program the data register */
-	advk_writel(pcie, reg, PIO_WR_DATA);
+	advk_writel(advk, reg, PIO_WR_DATA);
 
 	/* Program the data strobe */
-	advk_writel(pcie, data_strobe, PIO_WR_DATA_STRB);
+	advk_writel(advk, data_strobe, PIO_WR_DATA_STRB);
 
 	/* Start the transfer */
-	advk_writel(pcie, 1, PIO_START);
+	advk_writel(advk, 1, PIO_START);
 
-	ret = advk_pcie_wait_pio(pcie);
+	ret = advk_pcie_wait_pio(advk);
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
-	advk_pcie_check_pio_status(pcie);
+	advk_pcie_check_pio_status(advk);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -543,37 +543,37 @@ static struct pci_ops advk_pcie_ops = {
 	.write = advk_pcie_wr_conf,
 };
 
-static int advk_pcie_alloc_msi(struct advk_pcie *pcie)
+static int advk_pcie_alloc_msi(struct advk_pcie *advk)
 {
 	int hwirq;
 
-	mutex_lock(&pcie->msi_used_lock);
-	hwirq = find_first_zero_bit(pcie->msi_irq_in_use, MSI_IRQ_NUM);
+	mutex_lock(&advk->msi_used_lock);
+	hwirq = find_first_zero_bit(advk->msi_irq_in_use, MSI_IRQ_NUM);
 	if (hwirq >= MSI_IRQ_NUM)
 		hwirq = -ENOSPC;
 	else
-		set_bit(hwirq, pcie->msi_irq_in_use);
-	mutex_unlock(&pcie->msi_used_lock);
+		set_bit(hwirq, advk->msi_irq_in_use);
+	mutex_unlock(&advk->msi_used_lock);
 
 	return hwirq;
 }
 
-static void advk_pcie_free_msi(struct advk_pcie *pcie, int hwirq)
+static void advk_pcie_free_msi(struct advk_pcie *advk, int hwirq)
 {
-	mutex_lock(&pcie->msi_used_lock);
-	if (!test_bit(hwirq, pcie->msi_irq_in_use))
-		dev_err(&pcie->pdev->dev, "trying to free unused MSI#%d\n",
+	mutex_lock(&advk->msi_used_lock);
+	if (!test_bit(hwirq, advk->msi_irq_in_use))
+		dev_err(&advk->pdev->dev, "trying to free unused MSI#%d\n",
 			hwirq);
 	else
-		clear_bit(hwirq, pcie->msi_irq_in_use);
-	mutex_unlock(&pcie->msi_used_lock);
+		clear_bit(hwirq, advk->msi_irq_in_use);
+	mutex_unlock(&advk->msi_used_lock);
 }
 
 static int advk_pcie_setup_msi_irq(struct msi_controller *chip,
 				   struct pci_dev *pdev,
 				   struct msi_desc *desc)
 {
-	struct advk_pcie *pcie = pdev->bus->sysdata;
+	struct advk_pcie *advk = pdev->bus->sysdata;
 	struct msi_msg msg;
 	int virq, hwirq;
 	phys_addr_t msi_msg_phys;
@@ -582,19 +582,19 @@ static int advk_pcie_setup_msi_irq(struct msi_controller *chip,
 	if (desc->msi_attrib.is_msix)
 		return -EINVAL;
 
-	hwirq = advk_pcie_alloc_msi(pcie);
+	hwirq = advk_pcie_alloc_msi(advk);
 	if (hwirq < 0)
 		return hwirq;
 
-	virq = irq_create_mapping(pcie->msi_domain, hwirq);
+	virq = irq_create_mapping(advk->msi_domain, hwirq);
 	if (!virq) {
-		advk_pcie_free_msi(pcie, hwirq);
+		advk_pcie_free_msi(advk, hwirq);
 		return -EINVAL;
 	}
 
 	irq_set_msi_desc(virq, desc);
 
-	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
+	msi_msg_phys = virt_to_phys(&advk->msi_msg);
 
 	msg.address_lo = lower_32_bits(msi_msg_phys);
 	msg.address_hi = upper_32_bits(msi_msg_phys);
@@ -610,19 +610,19 @@ static void advk_pcie_teardown_msi_irq(struct msi_controller *chip,
 {
 	struct irq_data *d = irq_get_irq_data(irq);
 	struct msi_desc *msi = irq_data_get_msi_desc(d);
-	struct advk_pcie *pcie = msi_desc_to_pci_sysdata(msi);
+	struct advk_pcie *advk = msi_desc_to_pci_sysdata(msi);
 	unsigned long hwirq = d->hwirq;
 
 	irq_dispose_mapping(irq);
-	advk_pcie_free_msi(pcie, hwirq);
+	advk_pcie_free_msi(advk, hwirq);
 }
 
 static int advk_pcie_msi_map(struct irq_domain *domain,
 			     unsigned int virq, irq_hw_number_t hw)
 {
-	struct advk_pcie *pcie = domain->host_data;
+	struct advk_pcie *advk = domain->host_data;
 
-	irq_set_chip_and_handler(virq, &pcie->msi_irq_chip,
+	irq_set_chip_and_handler(virq, &advk->msi_irq_chip,
 				 handle_simple_irq);
 
 	return 0;
@@ -634,36 +634,35 @@ static const struct irq_domain_ops advk_pcie_msi_irq_ops = {
 
 static void advk_pcie_irq_mask(struct irq_data *d)
 {
-	struct advk_pcie *pcie = d->domain->host_data;
+	struct advk_pcie *advk = d->domain->host_data;
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 mask;
 
-	mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	mask = advk_readl(advk, PCIE_ISR0_MASK_REG);
 	mask |= PCIE_ISR0_INTX_ASSERT(hwirq);
-	advk_writel(pcie, mask, PCIE_ISR0_MASK_REG);
+	advk_writel(advk, mask, PCIE_ISR0_MASK_REG);
 }
 
 static void advk_pcie_irq_unmask(struct irq_data *d)
 {
-	struct advk_pcie *pcie = d->domain->host_data;
+	struct advk_pcie *advk = d->domain->host_data;
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 mask;
 
-	mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	mask = advk_readl(advk, PCIE_ISR0_MASK_REG);
 	mask &= ~PCIE_ISR0_INTX_ASSERT(hwirq);
-	advk_writel(pcie, mask, PCIE_ISR0_MASK_REG);
+	advk_writel(advk, mask, PCIE_ISR0_MASK_REG);
 }
 
 static int advk_pcie_irq_map(struct irq_domain *h,
 			     unsigned int virq, irq_hw_number_t hwirq)
 {
-	struct advk_pcie *pcie = h->host_data;
+	struct advk_pcie *advk = h->host_data;
 
 	advk_pcie_irq_mask(irq_get_irq_data(virq));
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	irq_set_chip_and_handler(virq, &pcie->irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(virq, pcie);
+	irq_set_chip_and_handler(virq, &advk->irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, advk);
 
 	return 0;
 }
@@ -673,16 +672,16 @@ static const struct irq_domain_ops advk_pcie_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
+static int advk_pcie_init_msi_irq_domain(struct advk_pcie *advk)
 {
-	struct device *dev = &pcie->pdev->dev;
+	struct device *dev = &advk->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct irq_chip *msi_irq_chip;
 	struct msi_controller *msi;
 	phys_addr_t msi_msg_phys;
 	int ret;
 
-	msi_irq_chip = &pcie->msi_irq_chip;
+	msi_irq_chip = &advk->msi_irq_chip;
 
 	msi_irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-msi",
 					    dev_name(dev));
@@ -694,45 +693,43 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	msi_irq_chip->irq_mask = pci_msi_mask_irq;
 	msi_irq_chip->irq_unmask = pci_msi_unmask_irq;
 
-	msi = &pcie->msi;
+	msi = &advk->msi;
 
 	msi->setup_irq = advk_pcie_setup_msi_irq;
 	msi->teardown_irq = advk_pcie_teardown_msi_irq;
 	msi->of_node = node;
 
-	mutex_init(&pcie->msi_used_lock);
+	mutex_init(&advk->msi_used_lock);
 
-	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
+	msi_msg_phys = virt_to_phys(&advk->msi_msg);
 
-	advk_writel(pcie, lower_32_bits(msi_msg_phys),
-		    PCIE_MSI_ADDR_LOW_REG);
-	advk_writel(pcie, upper_32_bits(msi_msg_phys),
-		    PCIE_MSI_ADDR_HIGH_REG);
+	advk_writel(advk, lower_32_bits(msi_msg_phys), PCIE_MSI_ADDR_LOW_REG);
+	advk_writel(advk, upper_32_bits(msi_msg_phys), PCIE_MSI_ADDR_HIGH_REG);
 
-	pcie->msi_domain =
+	advk->msi_domain =
 		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
-				      &advk_pcie_msi_irq_ops, pcie);
-	if (!pcie->msi_domain)
+				      &advk_pcie_msi_irq_ops, advk);
+	if (!advk->msi_domain)
 		return -ENOMEM;
 
 	ret = of_pci_msi_chip_add(msi);
 	if (ret < 0) {
-		irq_domain_remove(pcie->msi_domain);
+		irq_domain_remove(advk->msi_domain);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void advk_pcie_remove_msi_irq_domain(struct advk_pcie *pcie)
+static void advk_pcie_remove_msi_irq_domain(struct advk_pcie *advk)
 {
-	of_pci_msi_chip_remove(&pcie->msi);
-	irq_domain_remove(pcie->msi_domain);
+	of_pci_msi_chip_remove(&advk->msi);
+	irq_domain_remove(advk->msi_domain);
 }
 
-static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
+static int advk_pcie_init_irq_domain(struct advk_pcie *advk)
 {
-	struct device *dev = &pcie->pdev->dev;
+	struct device *dev = &advk->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 	struct irq_chip *irq_chip;
@@ -743,7 +740,7 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 		return -ENODEV;
 	}
 
-	irq_chip = &pcie->irq_chip;
+	irq_chip = &advk->irq_chip;
 
 	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
 					dev_name(dev));
@@ -756,10 +753,10 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	irq_chip->irq_mask_ack = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
-	pcie->irq_domain =
+	advk->irq_domain =
 		irq_domain_add_linear(pcie_intc_node, LEGACY_IRQ_NUM,
-				      &advk_pcie_irq_domain_ops, pcie);
-	if (!pcie->irq_domain) {
+				      &advk_pcie_irq_domain_ops, advk);
+	if (!advk->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		of_node_put(pcie_intc_node);
 		return -ENOMEM;
@@ -768,106 +765,105 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	return 0;
 }
 
-static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
+static void advk_pcie_remove_irq_domain(struct advk_pcie *advk)
 {
-	irq_domain_remove(pcie->irq_domain);
+	irq_domain_remove(advk->irq_domain);
 }
 
-static void advk_pcie_handle_msi(struct advk_pcie *pcie)
+static void advk_pcie_handle_msi(struct advk_pcie *advk)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
 	u16 msi_data;
 
-	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
-	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
+	msi_mask = advk_readl(advk, PCIE_MSI_MASK_REG);
+	msi_val = advk_readl(advk, PCIE_MSI_STATUS_REG);
 	msi_status = msi_val & ~msi_mask;
 
 	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & 0xFF;
+		advk_writel(advk, BIT(msi_idx), PCIE_MSI_STATUS_REG);
+		msi_data = advk_readl(advk, PCIE_MSI_PAYLOAD_REG) & 0xFF;
 		generic_handle_irq(msi_data);
 	}
 
-	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-		    PCIE_ISR0_REG);
+	advk_writel(advk, PCIE_ISR0_MSI_INT_PENDING, PCIE_ISR0_REG);
 }
 
-static void advk_pcie_handle_int(struct advk_pcie *pcie)
+static void advk_pcie_handle_int(struct advk_pcie *advk)
 {
 	u32 val, mask, status;
 	int i, virq;
 
-	val = advk_readl(pcie, PCIE_ISR0_REG);
-	mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+	val = advk_readl(advk, PCIE_ISR0_REG);
+	mask = advk_readl(advk, PCIE_ISR0_MASK_REG);
 	status = val & ((~mask) & PCIE_ISR0_ALL_MASK);
 
 	if (!status) {
-		advk_writel(pcie, val, PCIE_ISR0_REG);
+		advk_writel(advk, val, PCIE_ISR0_REG);
 		return;
 	}
 
 	/* Process MSI interrupts */
 	if (status & PCIE_ISR0_MSI_INT_PENDING)
-		advk_pcie_handle_msi(pcie);
+		advk_pcie_handle_msi(advk);
 
 	/* Process legacy interrupts */
 	for (i = 0; i < LEGACY_IRQ_NUM; i++) {
 		if (!(status & PCIE_ISR0_INTX_ASSERT(i)))
 			continue;
 
-		advk_writel(pcie, PCIE_ISR0_INTX_ASSERT(i),
+		advk_writel(advk, PCIE_ISR0_INTX_ASSERT(i),
 			    PCIE_ISR0_REG);
 
-		virq = irq_find_mapping(pcie->irq_domain, i);
+		virq = irq_find_mapping(advk->irq_domain, i);
 		generic_handle_irq(virq);
 	}
 }
 
 static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 {
-	struct advk_pcie *pcie = arg;
+	struct advk_pcie *advk = arg;
 	u32 status;
 
-	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
+	status = advk_readl(advk, HOST_CTRL_INT_STATUS_REG);
 	if (!(status & PCIE_IRQ_CORE_INT))
 		return IRQ_NONE;
 
-	advk_pcie_handle_int(pcie);
+	advk_pcie_handle_int(advk);
 
 	/* Clear interrupt */
-	advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
+	advk_writel(advk, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
 
 	return IRQ_HANDLED;
 }
 
-static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
+static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *advk)
 {
 	int err, res_valid = 0;
-	struct device *dev = &pcie->pdev->dev;
+	struct device *dev = &advk->pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct resource_entry *win, *tmp;
 	resource_size_t iobase;
 
-	INIT_LIST_HEAD(&pcie->resources);
+	INIT_LIST_HEAD(&advk->resources);
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &advk->resources,
 					       &iobase);
 	if (err)
 		return err;
 
-	err = devm_request_pci_bus_resources(dev, &pcie->resources);
+	err = devm_request_pci_bus_resources(dev, &advk->resources);
 	if (err)
 		goto out_release_res;
 
-	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
+	resource_list_for_each_entry_safe(win, tmp, &advk->resources) {
 		struct resource *res = win->res;
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
-			advk_pcie_set_ob_win(pcie, 1,
+			advk_pcie_set_ob_win(advk, 1,
 					     upper_32_bits(res->start),
 					     lower_32_bits(res->start),
 					     0,	0xF8000000, 0,
@@ -881,7 +877,7 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 			}
 			break;
 		case IORESOURCE_MEM:
-			advk_pcie_set_ob_win(pcie, 0,
+			advk_pcie_set_ob_win(advk, 0,
 					     upper_32_bits(res->start),
 					     lower_32_bits(res->start),
 					     0x0, 0xF8000000, 0,
@@ -890,7 +886,7 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 			break;
 		case IORESOURCE_BUS:
-			pcie->root_bus_nr = res->start;
+			advk->root_bus_nr = res->start;
 			break;
 		}
 	}
@@ -904,59 +900,59 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	return 0;
 
 out_release_res:
-	pci_free_resource_list(&pcie->resources);
+	pci_free_resource_list(&advk->resources);
 	return err;
 }
 
 static int advk_pcie_probe(struct platform_device *pdev)
 {
-	struct advk_pcie *pcie;
+	struct advk_pcie *advk;
 	struct resource *res;
 	struct pci_bus *bus, *child;
 	struct msi_controller *msi;
 	struct device_node *msi_node;
 	int ret, irq;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(struct advk_pcie),
+	advk = devm_kzalloc(&pdev->dev, sizeof(struct advk_pcie),
 			    GFP_KERNEL);
-	if (!pcie)
+	if (!advk)
 		return -ENOMEM;
 
-	pcie->pdev = pdev;
-	platform_set_drvdata(pdev, pcie);
+	advk->pdev = pdev;
+	platform_set_drvdata(pdev, advk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
+	advk->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(advk->base))
+		return PTR_ERR(advk->base);
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq, advk_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
-			       pcie);
+			       advk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register interrupt\n");
 		return ret;
 	}
 
-	ret = advk_pcie_parse_request_of_pci_ranges(pcie);
+	ret = advk_pcie_parse_request_of_pci_ranges(advk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to parse resources\n");
 		return ret;
 	}
 
-	advk_pcie_setup_hw(pcie);
+	advk_pcie_setup_hw(advk);
 
-	ret = advk_pcie_init_irq_domain(pcie);
+	ret = advk_pcie_init_irq_domain(advk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize irq\n");
 		return ret;
 	}
 
-	ret = advk_pcie_init_msi_irq_domain(pcie);
+	ret = advk_pcie_init_msi_irq_domain(advk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize irq\n");
-		advk_pcie_remove_irq_domain(pcie);
+		advk_pcie_remove_irq_domain(advk);
 		return ret;
 	}
 
@@ -967,10 +963,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		msi = NULL;
 
 	bus = pci_scan_root_bus_msi(&pdev->dev, 0, &advk_pcie_ops,
-				    pcie, &pcie->resources, &pcie->msi);
+				    advk, &advk->resources, &advk->msi);
 	if (!bus) {
-		advk_pcie_remove_msi_irq_domain(pcie);
-		advk_pcie_remove_irq_domain(pcie);
+		advk_pcie_remove_msi_irq_domain(advk);
+		advk_pcie_remove_irq_domain(advk);
 		return -ENOMEM;
 	}
 

