Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: Richard.Zhu@freescale.com, l.stach@penguintronix.com,
	thomas.petazzoni@free-electrons.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci:host Fix missing line after declarations
Date: Sat, 12 Dec 2015 03:41:48 -0800
Message-Id: <1449920508-105873-1-git-send-email-brutallesale@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes few warnings about missing line after declarations and one
no whitespace is necesarry before that "("

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/host/pci-imx6.c  | 2 +-
 drivers/pci/host/pci-mvebu.c | 3 +++
 drivers/pci/host/pcie-rcar.c | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 22e8224..2dd018c 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -122,7 +122,7 @@ static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(void __iomem *dbi_base, int addr , int *data)
+static int pcie_phy_read(void __iomem *dbi_base, int addr, int *data)
 {
 	u32 val, phy_ctl;
 	int ret;
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 53b79c5..d826bef 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1011,6 +1011,7 @@ static int mvebu_pcie_suspend(struct device *dev)
 	pcie = dev_get_drvdata(dev);
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = pcie->ports + i;
+
 		port->saved_pcie_stat = mvebu_readl(port, PCIE_STAT_OFF);
 	}
 
@@ -1025,6 +1026,7 @@ static int mvebu_pcie_resume(struct device *dev)
 	pcie = dev_get_drvdata(dev);
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = pcie->ports + i;
+
 		mvebu_writel(port, port->saved_pcie_stat, PCIE_STAT_OFF);
 		mvebu_pcie_setup_hw(port);
 	}
@@ -1296,6 +1298,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,kirkwood-pcie", },
 	{},
 };
+
 MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
 
 static struct dev_pm_ops mvebu_pcie_pm_ops = {
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index f4fa6c5..58b7ac6 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -377,6 +377,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pcie)
 
 		if (res->flags & IORESOURCE_IO) {
 			phys_addr_t io_start = pci_pio_to_address(res->start);
+
 			pci_ioremap_io(global_io_offset, io_start);
 			global_io_offset += SZ_64K;
 		}
@@ -904,6 +905,7 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 	/* Get the dma-ranges from DT */
 	for_each_of_pci_range(&parser, &range) {
 		u64 end = range.cpu_addr + range.size - 1;
+
 		dev_dbg(pcie->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
 			range.flags, range.cpu_addr, end, range.pci_addr);
 
-- 
2.5.0

