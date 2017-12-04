Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56494 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbdLDPJp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:45 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 8/8] arch/sh: pcie-sh7786: handle non-zero DMA offset
Date: Mon,  4 Dec 2017 16:09:07 +0100
Message-Id: <20171204150907.24345-9-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On SuperH, the base of the physical memory might be different from
zero. In this case, PCI address zero will map to a non-zero physical
address. In order to make sure that the DMA mapping API takes care of
this DMA offset, we must fill in the dev->dma_pfn_offset field for PCI
devices. This gets done in the pcibios_bus_add_device() hook, called
for each new PCI device detected.

The dma_pfn_offset global variable is re-calculated for every PCI
controller available on the platform, but that's not an issue because
its value will each time be exactly the same, as it only depends on
the memory start address and memory size.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 224bcad24dca..95f9a3536a93 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -33,6 +33,7 @@ struct sh7786_pcie_port {
 
 static struct sh7786_pcie_port *sh7786_pcie_ports;
 static unsigned int nr_ports;
+static unsigned long dma_pfn_offset;
 
 static struct sh7786_pcie_hwops {
 	int (*core_init)(void);
@@ -351,6 +352,8 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	memstart = ALIGN_DOWN(memstart, memsize);
 	memsize = roundup_pow_of_two(memend - memstart);
 
+	dma_pfn_offset = memstart >> PAGE_SHIFT;
+
 	/*
 	 * If there's more than 512MB of memory, we need to roll over to
 	 * LAR1/LAMR1.
@@ -466,6 +469,11 @@ int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
         return evt2irq(0xae0);
 }
 
+void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	pdev->dev.dma_pfn_offset = dma_pfn_offset;
+}
+
 static int __init sh7786_pcie_core_init(void)
 {
 	/* Return the number of ports */
-- 
2.13.6
