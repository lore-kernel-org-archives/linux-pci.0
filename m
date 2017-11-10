Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:56025 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKJV7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:59:01 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 2/5] PCI: rcar: Clean up the macros
Date: Fri, 10 Nov 2017 22:58:40 +0100
Message-Id: <20171110215843.432-3-marek.vasut+renesas@gmail.com>
In-Reply-To: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just clean up the macros in the RCar PCI driver, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: New patch
---
 drivers/pci/host/pcie-rcar.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 351e1276b90a..811e8194ef74 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -33,9 +33,9 @@
 
 #define PCIECAR			0x000010
 #define PCIECCTLR		0x000018
-#define  CONFIG_SEND_ENABLE	(1 << 31)
+#define  CONFIG_SEND_ENABLE	BIT(31)
 #define  TYPE0			(0 << 8)
-#define  TYPE1			(1 << 8)
+#define  TYPE1			BIT(8)
 #define PCIECDR			0x000020
 #define PCIEMSR			0x000028
 #define PCIEINTXR		0x000400
@@ -47,7 +47,7 @@
 #define PCIETSTR		0x02004
 #define  DATA_LINK_ACTIVE	1
 #define PCIEERRFR		0x02020
-#define  UNSUPPORTED_REQUEST	(1 << 4)
+#define  UNSUPPORTED_REQUEST	BIT(4)
 #define PCIEMSIFR		0x02044
 #define PCIEMSIALR		0x02048
 #define  MSIFE			1
@@ -60,17 +60,17 @@
 /* local address reg & mask */
 #define PCIELAR(x)		(0x02200 + ((x) * 0x20))
 #define PCIELAMR(x)		(0x02208 + ((x) * 0x20))
-#define  LAM_PREFETCH		(1 << 3)
-#define  LAM_64BIT		(1 << 2)
-#define  LAR_ENABLE		(1 << 1)
+#define  LAM_PREFETCH		BIT(3)
+#define  LAM_64BIT		BIT(2)
+#define  LAR_ENABLE		BIT(1)
 
 /* PCIe address reg & mask */
 #define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
 #define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
 #define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
 #define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
-#define  PAR_ENABLE		(1 << 31)
-#define  IO_SPACE		(1 << 8)
+#define  PAR_ENABLE		BIT(31)
+#define  IO_SPACE		BIT(8)
 
 /* Configuration */
 #define PCICONF(x)		(0x010000 + ((x) * 0x4))
@@ -82,23 +82,23 @@
 #define IDSETR1			0x011004
 #define TLCTLR			0x011048
 #define MACSR			0x011054
-#define  SPCHGFIN		(1 << 4)
-#define  SPCHGFAIL		(1 << 6)
-#define  SPCHGSUC		(1 << 7)
+#define  SPCHGFIN		BIT(4)
+#define  SPCHGFAIL		BIT(6)
+#define  SPCHGSUC		BIT(7)
 #define  LINK_SPEED		(0xf << 16)
 #define  LINK_SPEED_2_5GTS	(1 << 16)
 #define  LINK_SPEED_5_0GTS	(2 << 16)
 #define MACCTLR			0x011058
-#define  SPEED_CHANGE		(1 << 24)
-#define  SCRAMBLE_DISABLE	(1 << 27)
+#define  SPEED_CHANGE		BIT(24)
+#define  SCRAMBLE_DISABLE	BIT(27)
 #define MACS2R			0x011078
 #define MACCGSPSETR		0x011084
-#define  SPCNGRSN		(1 << 31)
+#define  SPCNGRSN		BIT(31)
 
 /* R-Car H1 PHY */
 #define H1_PCIEPHYADRR		0x04000c
-#define  WRITE_CMD		(1 << 16)
-#define  PHY_ACK		(1 << 24)
+#define  WRITE_CMD		BIT(16)
+#define  PHY_ACK		BIT(24)
 #define  RATE_POS		12
 #define  LANE_POS		8
 #define  ADR_POS		0
@@ -110,19 +110,19 @@
 #define GEN2_PCIEPHYDATA	0x784
 #define GEN2_PCIEPHYCTRL	0x78c
 
-#define INT_PCI_MSI_NR	32
+#define INT_PCI_MSI_NR		32
 
-#define RCONF(x)	(PCICONF(0)+(x))
-#define RPMCAP(x)	(PMCAP(0)+(x))
-#define REXPCAP(x)	(EXPCAP(0)+(x))
-#define RVCCAP(x)	(VCCAP(0)+(x))
+#define RCONF(x)		(PCICONF(0) + (x))
+#define RPMCAP(x)		(PMCAP(0) + (x))
+#define REXPCAP(x)		(EXPCAP(0) + (x))
+#define RVCCAP(x)		(VCCAP(0) + (x))
 
-#define  PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
-#define  PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
-#define  PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
+#define PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
+#define PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
+#define PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
 
-#define RCAR_PCI_MAX_RESOURCES 4
-#define MAX_NR_INBOUND_MAPS 6
+#define RCAR_PCI_MAX_RESOURCES	4
+#define MAX_NR_INBOUND_MAPS	6
 
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
-- 
2.11.0
