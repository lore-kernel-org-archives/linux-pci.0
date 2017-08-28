Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48513 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751232AbdH1Pas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 11:30:48 -0400
From: Jan Luebbe <jlu@pengutronix.de>
To: Gregory Clement <gregory.clement@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jan Luebbe <jlu@pengutronix.de>
Subject: [RFC] ARM: Orion: Check DRAM window size
Date: Mon, 28 Aug 2017 17:30:39 +0200
Message-Id: <20170828153039.27088-1-jlu@pengutronix.de>
In-Reply-To: <20170828152517.24506-1-jlu@pengutronix.de>
References: <20170828152517.24506-1-jlu@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a corresponding change as "PCI: mvebu: Check DRAM window size" applied
to the Orion PCIe driver. I don't have the relevant hardware myself, but the
patch may still be useful for someone who has. This is completely untested.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/mach-dove/pcie.c    |  3 ++-
 arch/arm/mach-mv78xx0/pcie.c |  3 ++-
 arch/arm/mach-orion5x/pci.c  |  3 ++-
 arch/arm/plat-orion/pcie.c   | 19 +++++++++++++++----
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 91fe97144570..27e4689ee58d 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -51,7 +51,8 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 
-	orion_pcie_setup(pp->base);
+	if (!orion_pcie_setup(pp->base))
+		return 0;
 
 	if (pp->index == 0)
 		pci_ioremap_io(sys->busnr * SZ_64K, DOVE_PCIE0_IO_PHYS_BASE);
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 81ff4327a962..3d17eeff44bf 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -113,7 +113,8 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 	 * Generic PCIe unit setup.
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
-	orion_pcie_setup(pp->base);
+	if (!orion_pcie_setup(pp->base))
+		return 0;
 
 	pci_ioremap_io(nr * SZ_64K, MV78XX0_PCIE_IO_PHYS_BASE(nr));
 
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index ecb998e7f8dc..f7f830872cc9 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -147,7 +147,8 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	/*
 	 * Generic PCIe unit setup.
 	 */
-	orion_pcie_setup(PCIE_BASE);
+	if (!orion_pcie_setup(PCIE_BASE))
+		return 0;
 
 	/*
 	 * Check whether to apply Orion-1/Orion-NAS PCIe config
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index 8b8c06d2e9c4..07ae382cf48a 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -120,10 +120,10 @@ void __init orion_pcie_reset(void __iomem *base)
  * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
  * WIN[0-3] -> DRAM bank[0-3]
  */
-static void __init orion_pcie_setup_wins(void __iomem *base)
+static int __init orion_pcie_setup_wins(void __iomem *base)
 {
 	const struct mbus_dram_target_info *dram;
-	u32 size;
+	u64 size;
 	int i;
 
 	dram = mv_mbus_dram_info();
@@ -170,15 +170,23 @@ static void __init orion_pcie_setup_wins(void __iomem *base)
 	if ((size & (size - 1)) != 0)
 		size = 1 << fls(size);
 
+	if (size > 0x100000000) {
+		pr_err("Could not configure DRAM window (too large): 0x%llx\n",
+		       size);
+		return 0;
+	}
+
 	/*
 	 * Setup BAR[1] to all DRAM banks.
 	 */
 	writel(dram->cs[0].base, base + PCIE_BAR_LO_OFF(1));
 	writel(0, base + PCIE_BAR_HI_OFF(1));
 	writel(((size - 1) & 0xffff0000) | 1, base + PCIE_BAR_CTRL_OFF(1));
+
+	return 1;
 }
 
-void __init orion_pcie_setup(void __iomem *base)
+int __init orion_pcie_setup(void __iomem *base)
 {
 	u16 cmd;
 	u32 mask;
@@ -186,7 +194,8 @@ void __init orion_pcie_setup(void __iomem *base)
 	/*
 	 * Point PCIe unit MBUS decode windows to DRAM space.
 	 */
-	orion_pcie_setup_wins(base);
+	if (!orion_pcie_setup_wins(base))
+		return 0;
 
 	/*
 	 * Master + slave enable.
@@ -203,6 +212,8 @@ void __init orion_pcie_setup(void __iomem *base)
 	mask = readl(base + PCIE_MASK_OFF);
 	mask |= 0x0f000000;
 	writel(mask, base + PCIE_MASK_OFF);
+
+	return 1;
 }
 
 int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
-- 
2.11.0
