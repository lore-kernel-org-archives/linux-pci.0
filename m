Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33673 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3C0SFL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:05:11 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFC PATCHv1 3/5] arm: mach-kirkwood: seperate PCIe window init from other windows
Date: Wed, 27 Mar 2013 19:05:02 +0100
Message-Id: <1364407504-13524-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since we are going to enable the usage of the mvebu PCIe driver on
Kirkwood, we need a way to disable the static addition of address
decoding windows currently done by the Kirkwood code. In order to do
this, we split the initialization of windows in two functions: one
function for the PCIe windows, and a second function for the other
windows.

Then, we have three cases:

 * non-DT platforms: PCIe windows are always initialized statically,
   by a call to kirkwood_setup_pcie_wins() in
   mach-kirkwood/commonc:kirkwood_init().

 * DT platforms that don't yet use the mvebu PCIe driver (example:
   board-iconnect.c). The kirkwood_setup_pcie_wins() function is
   called from mach-kirkwood/board-dt.c:kirkwood_dt_init(), because
   needs_pcie_wins is true.

 * DT platforms that use the mvebu PCIe driver (none as of this
   patch). They will set needs_pcie_wins to false in
   mach-kirkwood/board-dt.c:kirkwood_dt_init().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/board-dt.c |    5 +++++
 arch/arm/mach-kirkwood/common.c   |    7 ++++++-
 arch/arm/mach-kirkwood/common.h   |    1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ea49476..1b4675f 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -72,6 +72,8 @@ static void __init kirkwood_of_clk_init(void)
 
 static void __init kirkwood_dt_init(void)
 {
+	int needs_pcie_wins = 1;
+
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
 
 	/*
@@ -144,6 +146,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("usi,topkick"))
 		usi_topkick_init();
 
+	if (needs_pcie_wins)
+		kirkwood_setup_pcie_wins();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index c2cae69..9a5d65a 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -652,7 +652,7 @@ char * __init kirkwood_id(void)
 	}
 }
 
-void __init kirkwood_setup_wins(void)
+void __init kirkwood_setup_pcie_wins(void)
 {
 	/*
 	 * The PCIe windows will no longer be statically allocated
@@ -678,6 +678,10 @@ void __init kirkwood_setup_wins(void)
 					  KIRKWOOD_PCIE1_MEM_SIZE,
 					  MVEBU_MBUS_NO_REMAP,
 					  MVEBU_MBUS_PCI_MEM);
+}
+
+void __init kirkwood_setup_wins(void)
+{
 	mvebu_mbus_add_window("nand", KIRKWOOD_NAND_MEM_PHYS_BASE,
 			      KIRKWOOD_NAND_MEM_SIZE);
 	mvebu_mbus_add_window("sram", KIRKWOOD_SRAM_PHYS_BASE,
@@ -710,6 +714,7 @@ void __init kirkwood_init(void)
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
 	kirkwood_setup_wins();
+	kirkwood_setup_pcie_wins();
 
 	kirkwood_l2_init();
 
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index e24f743..de280f5 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -31,6 +31,7 @@ void kirkwood_init_early(void);
 void kirkwood_init_irq(void);
 
 void kirkwood_setup_wins(void);
+void kirkwood_setup_pcie_wins(void);
 
 void kirkwood_enable_pcie(void);
 void kirkwood_pcie_id(u32 *dev, u32 *rev);
-- 
1.7.9.5

