Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:52221 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752432Ab2J2HCW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:22 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 07/15] SPEAr1340: Add PCIe auxdata for miphy clock initialization
Date: Mon, 29 Oct 2012 12:31:21 +0530
Message-ID: <d35d2da48beb1ca1e476ec861e4f58fe541f4e3c.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Miphy Clock initialization is very specific to controller and its
instances. Pass this custom function using auxdata.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/mach-spear13xx/spear1340.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
index 223d9ef..194c3ac 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -29,6 +29,7 @@
 #include <asm/mach/arch.h>
 #include <mach/dma.h>
 #include <mach/generic.h>
+#include <mach/pcie.h>
 #include <mach/spdif.h>
 #include <mach/spear.h>
 #include <sound/designware_i2s.h>
@@ -42,6 +43,7 @@
 #define SPEAR1340_CAM2_BASE			UL(0xD0400000)
 #define SPEAR1340_CAM3_BASE			UL(0xD0500000)
 #define SPEAR1340_SATA_BASE			UL(0xB1000000)
+#define SPEAR1340_PCIE_BASE			UL(0xB1000000)
 #define SPEAR1340_UART1_BASE			UL(0xB4100000)
 #define SPEAR1340_I2S_PLAY_BASE			UL(0xB2400000)
 #define SPEAR1340_I2S_REC_BASE			UL(0xB2000000)
@@ -358,6 +360,28 @@ static struct ahci_platform_data sata_pdata = {
 	.resume = sata_resume,
 };
 
+static int spear1340_pcie_clk_init(struct pcie_port *pp)
+{
+	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE,
+			SPEAR1340_PCIE_MIPHY_CFG);
+	writel(SPEAR1340_PCIE_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
+
+	return 0;
+}
+
+static int spear1340_pcie_clk_exit(struct pcie_port *pp)
+{
+	writel(0, SPEAR1340_PCIE_SATA_CFG);
+	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
+
+	return 0;
+}
+
+static struct pcie_port_info pcie_pdata = {
+	.clk_init = spear1340_pcie_clk_init,
+	.clk_exit = spear1340_pcie_clk_exit,
+};
+
 /* camera sensor registeration */
 static struct i2c_board_info vs6725_camera_sensor_info = {
 	I2C_BOARD_INFO("vs6725", 0x10),
@@ -609,6 +633,8 @@ static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
 
 	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
 			&sata_pdata),
+	OF_DEV_AUXDATA("st,pcie-host", SPEAR1340_PCIE_BASE, NULL,
+			&pcie_pdata),
 	OF_DEV_AUXDATA("arm,pl011", SPEAR1340_UART1_BASE, NULL, &uart1_data),
 	OF_DEV_AUXDATA("st,spear600-gmac", SPEAR13XX_GETH_BASE, NULL,
 			&eth_data),
-- 
1.7.5.4

