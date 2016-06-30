Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36072 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcF3NOi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 09:14:38 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: tegra: Make register definitions consistent
Date: Thu, 30 Jun 2016 15:14:28 +0200
Message-Id: <20160630131430.32096-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Most of the register definitions use lowercase hexadecimal values, with
a few exceptions using uppercase. Convert the latter to be more in line
with the former.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index c388468c202a..9595518f541d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -183,26 +183,26 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
-#define RP_VEND_XP	0x00000F00
+#define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
-#define RP_PRIV_MISC	0x00000FE0
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xE << 0)
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xF << 0)
+#define RP_PRIV_MISC	0x00000fe0
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
 
 #define RP_LINK_CONTROL_STATUS			0x00000090
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
 #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
 
-#define PADS_CTL_SEL		0x0000009C
+#define PADS_CTL_SEL		0x0000009c
 
-#define PADS_CTL		0x000000A0
+#define PADS_CTL		0x000000a0
 #define  PADS_CTL_IDDQ_1L	(1 << 0)
 #define  PADS_CTL_TX_DATA_EN_1L	(1 << 6)
 #define  PADS_CTL_RX_DATA_EN_1L	(1 << 10)
 
-#define PADS_PLL_CTL_TEGRA20			0x000000B8
-#define PADS_PLL_CTL_TEGRA30			0x000000B4
+#define PADS_PLL_CTL_TEGRA20			0x000000b8
+#define PADS_PLL_CTL_TEGRA30			0x000000b4
 #define  PADS_PLL_CTL_RST_B4SM			(1 << 1)
 #define  PADS_PLL_CTL_LOCKDET			(1 << 8)
 #define  PADS_PLL_CTL_REFCLK_MASK		(0x3 << 16)
@@ -214,9 +214,9 @@
 #define  PADS_PLL_CTL_TXCLKREF_DIV5		(1 << 20)
 #define  PADS_PLL_CTL_TXCLKREF_BUF_EN		(1 << 22)
 
-#define PADS_REFCLK_CFG0			0x000000C8
-#define PADS_REFCLK_CFG1			0x000000CC
-#define PADS_REFCLK_BIAS			0x000000D0
+#define PADS_REFCLK_CFG0			0x000000c8
+#define PADS_REFCLK_CFG1			0x000000cc
+#define PADS_REFCLK_BIAS			0x000000d0
 
 /*
  * Fields in PADS_REFCLK_CFG*. Those registers form an array of 16-bit
-- 
2.8.3

