Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56478 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbdLDPJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:44 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 5/8] arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
Date: Mon,  4 Dec 2017 16:09:04 +0100
Message-Id: <20171204150907.24345-6-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Depending on the physical memory layout, some PCI MEM areas are not
usable. According to the SH7786 datasheet, the PCI MEM area from
1000_0000 to 13FF_FFFF is only usable if the physical memory layout
(in MMSELR) is 1, 2, 5 or 6. In all other configurations, this PCI MEM
area is not usable (because it overlaps with DRAM).

Therefore, this commit adjusts the PCI SH7786 initialization to mark
the relevant PCI resource as IORESOURCE_DISABLED if we can't use it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index c2f877b4ef7e..8d7c328b1899 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/sh_clk.h>
 #include <linux/sh_intc.h>
+#include <cpu/sh7786.h>
 #include "pcie-sh7786.h"
 #include <asm/sizes.h>
 
@@ -511,6 +512,7 @@ static struct sh7786_pcie_hwops sh7786_65nm_pcie_hwops __initdata = {
 static int __init sh7786_pcie_init(void)
 {
 	struct clk *platclk;
+	u32 mm_sel;
 	int i;
 
 	printk(KERN_NOTICE "PCI: Starting initialization.\n");
@@ -544,6 +546,16 @@ static int __init sh7786_pcie_init(void)
 
 	clk_enable(platclk);
 
+	mm_sel = sh7786_mm_sel();
+
+	/*
+	 * Depending on the MMSELR register value, the PCIe0 MEM 1
+	 * area may not be available. See Table 13.11 of the SH7786
+	 * datasheet.
+	 */
+	if (mm_sel != 1 && mm_sel != 2 && mm_sel != 5 && mm_sel != 6)
+		sh7786_pci0_resources[2].flags |= IORESOURCE_DISABLED;
+
 	printk(KERN_NOTICE "PCI: probing %d ports.\n", nr_ports);
 
 	for (i = 0; i < nr_ports; i++) {
-- 
2.13.6
