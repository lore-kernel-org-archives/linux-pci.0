Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33705 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3C0SFO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:05:14 -0400
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
Subject: [RFC PATCHv1 5/5] arm: kirkwood: convert db-88f6281 to the Device Tree
Date: Wed, 27 Mar 2013 19:05:04 +0100
Message-Id: <1364407504-13524-6-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit converts the db-88f6281 board to the Device Tree.

Note: this commit is not entirely correct. The db-88f6281 code was in
fact handling both the case of a board having the 6281 (one PCIe
interface) and the 6282 (two PCIe interfaces). For now, we make the
assumption that we have two PCIe interfaces (because that's the board
I have in my hands). We'll probably have to create two separate Device
Trees to distinguish between those two boards.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                  |    1 +
 arch/arm/boot/dts/kirkwood-db-88f6281.dts   |   96 ++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig              |   12 +--
 arch/arm/mach-kirkwood/Makefile             |    2 +-
 arch/arm/mach-kirkwood/board-db88f6281-bp.c |   26 +++++++
 arch/arm/mach-kirkwood/board-dt.c           |    6 ++
 arch/arm/mach-kirkwood/common.h             |    6 ++
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c |  108 ---------------------------
 8 files changed, 142 insertions(+), 115 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6281.dts
 create mode 100644 arch/arm/mach-kirkwood/board-db88f6281-bp.c
 delete mode 100644 arch/arm/mach-kirkwood/db88f6281-bp-setup.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..07ae76d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-km_kirkwood.dtb \
 	kirkwood-lschlv2.dtb \
 	kirkwood-lsxhl.dtb \
+	kirkwood-db-88f6281.dtb \
 	kirkwood-mplcec4.dtb \
 	kirkwood-ns2.dtb \
 	kirkwood-ns2lite.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
new file mode 100644
index 0000000..8fceee9
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -0,0 +1,96 @@
+/*
+ * Marvell DB-88F6281-BP Development Board Setup
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "Marvell DB-88F6281-BP Development Board";
+	compatible = "marvell,db-88f6281-bp", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp@f1000000 {
+		pinctrl@10000 {
+			pmx_sdio_gpios: pmx-sdio-gpios {
+				marvell,pins = "mpp37", "mpp38";
+				marvell,function = "gpio";
+			};
+		};
+
+		serial@12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		nand@3000000 {
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
+			chip-delay = <25>;
+			status = "okay";
+
+			partition@0 {
+				label = "uboot";
+				reg = <0x0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "uImage";
+				reg = <0x100000 0x400000>;
+			};
+
+			partition@500000 {
+				label = "root";
+				reg = <0x500000 0x1fb00000>;
+			};
+		};
+
+		sata@80000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
+
+		ehci@50000 {
+			status = "okay";
+		};
+
+		mvsdio@90000 {
+			pinctrl-0 = <&pmx_sdio_gpios>;
+			pinctrl-names = "default";
+			wp-gpios = <&gpio1 5 0>;
+			cd-gpios = <&gpio1 6 0>;
+			status = "okay";
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie@1,0 {
+				status = "okay";
+			};
+
+			pcie@2,0 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7b6a64b..56bbeb0 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -2,12 +2,6 @@ if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
 
-config MACH_DB88F6281_BP
-	bool "Marvell DB-88F6281-BP Development Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell DB-88F6281-BP Development Board.
-
 config MACH_RD88F6192_NAS
 	bool "Marvell RD-88F6192-NAS Reference Board"
 	help
@@ -58,6 +52,12 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
+config MACH_DB88F6281_BP_DT
+	bool "Marvell DB-88F6281-BP Development Board (Flattened Device Tree)"
+	help
+	  Say 'Y' here if you want your kernel to support the Marvell
+	  DB-88F6281-BP Development Board (Flattened Device Tree).
+
 config MACH_GURUPLUG_DT
 	bool "Marvell GuruPlug Reference Board (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index d805f80..ea5a2f8 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,6 +1,5 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
 
-obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
@@ -20,6 +19,7 @@ obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_DB88F6281_BP_DT)	+= board-db88f6281-bp.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_GURUPLUG_DT)		+= board-guruplug.o
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
diff --git a/arch/arm/mach-kirkwood/board-db88f6281-bp.c b/arch/arm/mach-kirkwood/board-db88f6281-bp.c
new file mode 100644
index 0000000..bffd160
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-db88f6281-bp.c
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ *
+ * Marvell DB-88F6281-BP Development Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/mv643xx_eth.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data db88f6281_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+void __init db88f6281_init(void)
+{
+	kirkwood_ge00_init(&db88f6281_ge00_data);
+}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1b4675f..fbc0d8b 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -137,6 +137,11 @@ static void __init kirkwood_dt_init(void)
 	    of_machine_is_compatible("lacie,netspace_mini_v2"))
 		ns2_init();
 
+	if (of_machine_is_compatible("marvell,db-88f6281-bp")) {
+		needs_pcie_wins = 0;
+		db88f6281_init();
+	}
+
 	if (of_machine_is_compatible("mpl,cec4"))
 		mplcec4_init();
 
@@ -170,6 +175,7 @@ static const char * const kirkwood_dt_board_compat[] = {
 	"lacie,netspace_v2",
 	"lacie,netspace_lite_v2",
 	"lacie,netspace_mini_v2",
+	"marvell,db-88f6281-bp",
 	"mpl,cec4",
 	"plathome,openblocks-a6",
 	"usi,topkick",
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index de280f5..410b1ff 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -120,6 +120,12 @@ void km_kirkwood_init(void);
 static inline void km_kirkwood_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_DB88F6281_BP_DT
+void db88f6281_init(void);
+#else
+static inline void db88f6281_init(void) {};
+#endif
+
 #ifdef CONFIG_MACH_MPLCEC4_DT
 void mplcec4_init(void);
 #else
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
deleted file mode 100644
index 5a369fe..0000000
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/db88f6281-bp-setup.c
- *
- * Marvell DB-88F6281-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/sizes.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <linux/platform_data/mmc-mvsdio.h>
-#include "common.h"
-#include "mpp.h"
-
-static struct mtd_partition db88f6281_nand_parts[] = {
-	{
-		.name = "u-boot",
-		.offset = 0,
-		.size = SZ_1M
-	}, {
-		.name = "uImage",
-		.offset = MTDPART_OFS_NXTBLK,
-		.size = SZ_4M
-	}, {
-		.name = "root",
-		.offset = MTDPART_OFS_NXTBLK,
-		.size = MTDPART_SIZ_FULL
-	},
-};
-
-static struct mv643xx_eth_platform_data db88f6281_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-static struct mv_sata_platform_data db88f6281_sata_data = {
-	.n_ports	= 2,
-};
-
-static struct mvsdio_platform_data db88f6281_mvsdio_data = {
-	.gpio_write_protect	= 37,
-	.gpio_card_detect	= 38,
-};
-
-static unsigned int db88f6281_mpp_config[] __initdata = {
-	MPP0_NF_IO2,
-	MPP1_NF_IO3,
-	MPP2_NF_IO4,
-	MPP3_NF_IO5,
-	MPP4_NF_IO6,
-	MPP5_NF_IO7,
-	MPP18_NF_IO0,
-	MPP19_NF_IO1,
-	MPP37_GPIO,
-	MPP38_GPIO,
-	0
-};
-
-static void __init db88f6281_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(db88f6281_mpp_config);
-
-	kirkwood_nand_init(ARRAY_AND_SIZE(db88f6281_nand_parts), 25);
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&db88f6281_ge00_data);
-	kirkwood_sata_init(&db88f6281_sata_data);
-	kirkwood_uart0_init();
-	kirkwood_sdio_init(&db88f6281_mvsdio_data);
-}
-
-static int __init db88f6281_pci_init(void)
-{
-	if (machine_is_db88f6281_bp()) {
-		u32 dev, rev;
-
-		kirkwood_pcie_id(&dev, &rev);
-		if (dev == MV88F6282_DEV_ID)
-			kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);
-		else
-			kirkwood_pcie_init(KW_PCIE0);
-	}
-	return 0;
-}
-subsys_initcall(db88f6281_pci_init);
-
-MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
-	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.atag_offset	= 0x100,
-	.init_machine	= db88f6281_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-- 
1.7.9.5

