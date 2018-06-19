Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937442AbeFSORV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2018 10:17:21 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] PCI/xilinx: Depend on OF instead of the ARCH
Date: Tue, 19 Jun 2018 16:17:00 +0200
Message-Id: <20180619141700.7842-4-hch@lst.de>
In-Reply-To: <20180619141700.7842-1-hch@lst.de>
References: <20180619141700.7842-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Palmer Dabbelt <palmer@dabbelt.com>

There isn't a hard dependency of the Xilinx AXI-PCIe host bridge on any
architecture.  For example: at SiFive we map RISC-V cores to Xilinx FPGAs
and connect the Xilinx IP via a TileLink adapter, so the RISC-V Linux
port will need to be able to enable PCIE_XILINX in order to have PCIe
support.

This patch decouples the PCIE_XILINX support from ARCH.  Instead it just
depends on OF, which I believe is the only true dependency.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: replaced the now removed OF_PCI dependency with just OF]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 18fa09b3ac8f..1fc3d4eb373d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -103,7 +103,7 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC) || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.17.1
