Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHDMO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2018 08:14:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/3] PCI/xilinx: Work-around for hardware DMA limit (32 bits)
Date: Sat,  4 Aug 2018 12:14:01 +0200
Message-Id: <20180804101402.10022-3-hch@lst.de>
In-Reply-To: <20180804101402.10022-1-hch@lst.de>
References: <20180804101402.10022-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This PCIe bridge only has a 32 bit bus master interface, thus truncating
the DMA capability of all PCIe devices attached beneath it. This caps
the child device capability so that these devices work on systems with
physical memory beyond the 4GiB threshold.

Based on an earlier patch from Wesley W. Terpstra <wesley@sifive.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/pcie-xilinx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 7b1389d8e2a5..ccfd91e0515f 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -197,6 +197,16 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 	return port->reg_base + relbus + where;
 }
 
+/*
+ * This PCIe bridge only has a 32 bit bus master interface, thus truncating
+ * the DMA capability of all PCIe devices attached beneath it.
+ */
+static int xilinx_pcie_add_device(struct pci_dev *pdev)
+{
+	pdev->dev.bus_dma_mask = DMA_BIT_MASK(32);
+	return 0;
+}
+
 /* PCIe operations */
 static struct pci_ops xilinx_pcie_ops = {
 	.map_bus = xilinx_pcie_map_bus,
@@ -665,6 +675,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	bridge->ops = &xilinx_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->add_device = xilinx_pcie_add_device;
 
 #ifdef CONFIG_PCI_MSI
 	xilinx_pcie_msi_chip.dev = dev;
-- 
2.18.0
