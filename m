Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56490 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754087AbdLDPJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:44 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 7/8] arch/sh: pcie-sh7786: adjust the memory mapping
Date: Mon,  4 Dec 2017 16:09:06 +0100
Message-Id: <20171204150907.24345-8-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The code setting up the PCI -> SuperHighway mapping doesn't take into
account the fact that the address stored in PCIELARx must be aligned
with the size stored in PCIELAMRx.

For example, when your physical memory starts at 0x0800_0000 (128 MB),
a size of 64 MB or 128 MB is fine. However, if you have 256 MB of
memory, it doesn't work because the base address is not aligned on the
size.

In such situation, we have to round down the base address to make sure
it is aligned on the size of the area. For for a 0x0800_0000 base
address with 256 MB of memory, we will round down to 0x0, and extend
the size of the mapping to 512 MB.

This allows the mapping to work on platforms that have 256 MB of
RAM. The current setup would only work with 128 MB of RAM or less.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 69da026682ba..224bcad24dca 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -284,7 +284,7 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 {
 	struct pci_channel *chan = port->hose;
 	unsigned int data;
-	phys_addr_t memphys;
+	phys_addr_t memstart, memend;
 	size_t memsize;
 	int ret, i, win;
 
@@ -339,15 +339,24 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	data |= (0xff << 16);
 	pci_write_reg(chan, data, SH4A_PCIEMACCTLR);
 
-	memphys = __pa(memory_start);
-	memsize = roundup_pow_of_two(memory_end - memory_start);
+	memstart = __pa(memory_start);
+	memend   = __pa(memory_end);
+	memsize = roundup_pow_of_two(memend - memstart);
+
+	/*
+	 * The start address must be aligned on its size. So we round
+	 * it down, and then recalculate the size so that it covers
+	 * the entire memory.
+	 */
+	memstart = ALIGN_DOWN(memstart, memsize);
+	memsize = roundup_pow_of_two(memend - memstart);
 
 	/*
 	 * If there's more than 512MB of memory, we need to roll over to
 	 * LAR1/LAMR1.
 	 */
 	if (memsize > SZ_512M) {
-		pci_write_reg(chan, memphys + SZ_512M, SH4A_PCIELAR1);
+		pci_write_reg(chan, memstart + SZ_512M, SH4A_PCIELAR1);
 		pci_write_reg(chan, ((memsize - SZ_512M) - SZ_256) | 1,
 			      SH4A_PCIELAMR1);
 		memsize = SZ_512M;
@@ -363,7 +372,7 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	 * LAR0/LAMR0 covers up to the first 512MB, which is enough to
 	 * cover all of lowmem on most platforms.
 	 */
-	pci_write_reg(chan, memphys, SH4A_PCIELAR0);
+	pci_write_reg(chan, memstart, SH4A_PCIELAR0);
 	pci_write_reg(chan, (memsize - SZ_256) | 1, SH4A_PCIELAMR0);
 
 	/* Finish initialization */
-- 
2.13.6
