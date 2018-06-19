Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937635AbeFSORQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2018 10:17:16 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 2/3] PCI/xilinx: Work-around for hardware DMA limit (32 bits)
Date: Tue, 19 Jun 2018 16:16:59 +0200
Message-Id: <20180619141700.7842-3-hch@lst.de>
In-Reply-To: <20180619141700.7842-1-hch@lst.de>
References: <20180619141700.7842-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Wesley W. Terpstra" <wesley@sifive.com>

This PCIe bridge only has a 32 bit bus master interface, thus truncating
the DMA capability of all PCIe devices attached beneath it. This caps
the child device capability so that these devices work on systems with
physical memory beyond the 4GiB threshold.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[hch: switched to setting the dma_32bit_limit flag instead of overriding
 the dma_map_ops]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/pcie-xilinx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index b110a3a814e3..f6b41df59886 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -197,11 +197,21 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 	return port->reg_base + relbus + where;
 }
 
+/*
+ * This PCIe bridge only has a 32 bit bus master interface, thus truncating
+ * the DMA capability of all PCIe devices attached beneath it.
+ */
+static void xilinx_pcie_add_dev(struct pci_dev *pdev, struct pci_bus *bus)
+{
+	pdev->dev.dma_32bit_limit = true;
+}
+
 /* PCIe operations */
 static struct pci_ops xilinx_pcie_ops = {
 	.map_bus = xilinx_pcie_map_bus,
 	.read	= pci_generic_config_read,
 	.write	= pci_generic_config_write,
+	.add_dev = xilinx_pcie_add_dev,
 };
 
 /* MSI functions */
-- 
2.17.1
