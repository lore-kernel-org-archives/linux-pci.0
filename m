Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58298 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3A1S5H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:07 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 16/27] arm: mvebu: add functions to alloc/free PCIe decoding windows
Date: Mon, 28 Jan 2013 19:56:25 +0100
Message-Id: <1359399397-29729-17-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds two functions armada_370_xp_alloc_pcie_window() and
armada_370_xp_free_pcie_window() that respectively allocate and free
an address decoding window pointing to either a memory or I/O region
of a PCIe device.

Those functions will be used by the PCIe driver to create and remove
those regions depending on the PCIe devices that are detected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/addr-map.c              |   87 +++++++++++++++++++++++++--
 arch/arm/mach-mvebu/common.h                |    1 +
 arch/arm/mach-mvebu/include/mach/addr-map.h |    8 +++
 3 files changed, 92 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/include/mach/addr-map.h

diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
index ab9b3bd..7ec8fc6 100644
--- a/arch/arm/mach-mvebu/addr-map.c
+++ b/arch/arm/mach-mvebu/addr-map.c
@@ -24,14 +24,10 @@
 #define ARMADA_XP_TARGET_DEV_BUS	1
 #define   ARMADA_XP_ATTR_DEV_BOOTROM    0x1D
 #define ARMADA_XP_TARGET_ETH1		3
-#define ARMADA_XP_TARGET_PCIE_0_2	4
 #define ARMADA_XP_TARGET_ETH0		7
-#define ARMADA_XP_TARGET_PCIE_1_3	8
 
 #define ARMADA_370_TARGET_DEV_BUS       1
 #define   ARMADA_370_ATTR_DEV_BOOTROM   0x1D
-#define ARMADA_370_TARGET_PCIE_0        4
-#define ARMADA_370_TARGET_PCIE_1        8
 
 #define ARMADA_WINDOW_8_PLUS_OFFSET       0x90
 #define ARMADA_SDRAM_ADDR_DECODING_OFFSET 0x180
@@ -89,6 +85,89 @@ static struct __initdata orion_addr_map_cfg addr_map_cfg = {
 	.win_cfg_base = armada_cfg_base,
 };
 
+#ifdef CONFIG_PCI
+/*
+ * This structure and the following arrays allow to map a PCIe (port,
+ * lane) tuple to the corresponding (target, attribute) tuple needed
+ * to configure an address decoding window for the given PCIe (port,
+ * lane).
+ */
+struct pcie_mapping {
+	int port;
+	int lane;
+	u8  target;
+	u8  attr;
+};
+
+struct pcie_mapping armada_xp_pcie_mappings[] = {
+	{ .port = 0, .lane = 0, .target = 4, .attr = 0xE0 },
+	{ .port = 0, .lane = 1, .target = 4, .attr = 0xD0 },
+	{ .port = 0, .lane = 2, .target = 4, .attr = 0xB0 },
+	{ .port = 0, .lane = 3, .target = 4, .attr = 0x70 },
+	{ .port = 1, .lane = 0, .target = 8, .attr = 0xE0 },
+	{ .port = 1, .lane = 1, .target = 8, .attr = 0xD0 },
+	{ .port = 1, .lane = 2, .target = 8, .attr = 0xB0 },
+	{ .port = 1, .lane = 3, .target = 8, .attr = 0x70 },
+	{ .port = 2, .lane = 0, .target = 4, .attr = 0xF0 },
+	{ .port = 3, .lane = 0, .target = 8, .attr = 0xF0 },
+	{ .port = -1 },
+};
+
+struct pcie_mapping armada_370_pcie_mappings[] = {
+	{ .port = 0, .lane = 0, .target = 4, .attr = 0xE0 },
+	{ .port = 1, .lane = 0, .target = 8, .attr = 0xE0 },
+	{ .port = -1 },
+};
+
+/*
+ * This function sets up a new address decoding window at the given
+ * base address, pointing to the given PCIe interface (through
+ * pcie_port and pcie_lane).
+ */
+int __init armada_370_xp_alloc_pcie_window(int pcie_port, int pcie_lane,
+					   unsigned long base, u32 size,
+					   int type)
+{
+	struct pcie_mapping *mapping, *mappings;
+	u8 target, attr;
+
+	if (of_machine_is_compatible("marvell,armadaxp"))
+		mappings = armada_xp_pcie_mappings;
+	else if (of_machine_is_compatible("marvell,armada370"))
+		mappings = armada_370_pcie_mappings;
+	else
+		return -ENODEV;
+
+	for (mapping = mappings; mapping->port != -1; mapping++)
+		if (mapping->port == pcie_port && mapping->lane == pcie_lane)
+			break;
+
+	if (mapping->port == -1)
+		return -ENODEV;
+
+	target = mapping->target;
+	attr = mapping->attr;
+
+	/*
+	 * Bit 3 of the attributes indicates that it is a
+	 * memory region, as opposed to an I/O region
+	 */
+	if (type == IORESOURCE_MEM)
+		attr |= (1 << 3);
+
+	return orion_alloc_cpu_win(&addr_map_cfg, base, size, target, attr, -1);
+}
+
+/*
+ * Frees an address decoding window previously set up by
+ * armada_370_xp_setup_pcie_window().
+ */
+int __init armada_370_xp_free_pcie_window(unsigned long base)
+{
+	return orion_free_cpu_win(&addr_map_cfg, base);
+}
+#endif
+
 static int __init armada_setup_cpu_mbus(void)
 {
 	struct device_node *np;
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index aa27bc2..77c078c 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,4 +25,5 @@ int armada_370_xp_coherency_init(void);
 int armada_370_xp_pmsu_init(void);
 void armada_xp_secondary_startup(void);
 extern struct smp_operations armada_xp_smp_ops;
+
 #endif
diff --git a/arch/arm/mach-mvebu/include/mach/addr-map.h b/arch/arm/mach-mvebu/include/mach/addr-map.h
new file mode 100644
index 0000000..0845b27
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/addr-map.h
@@ -0,0 +1,8 @@
+#ifndef MVEBU_ADDR_MAP_H
+#define MVEBU_ADDR_MAP_H
+
+int armada_370_xp_alloc_pcie_window(int pcie_port, int pcie_lane,
+				    unsigned long base, u32 size, int type);
+int armada_370_xp_free_pcie_window(unsigned long base);
+
+#endif /* MVEBU_ADDR_MAP_H */
-- 
1.7.9.5

