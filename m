Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932518AbcIBPzG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:55:06 -0400
Subject: [PATCH v2 08/15] Remove duplicate CSR definition.
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:55:01 -0500
Message-ID: <20160902155501.8650.92863.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIE_RC_CONFIG_LCSR was the same as PCIE_RC_CONFIG_LCS.  Kept
PCIE_RC_CONFIG_LCS.

PCIE_CORE_LCSR_RETRAIN_LINK was inexplicably named differently and defined
separately.
---
 drivers/pci/host/pcie-rockchip.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index b204567..a2dd196 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -40,11 +40,12 @@
 #define PCIE_CLIENT_BASE			0x0
 #define PCIE_RC_CONFIG_BASE			0xa00000
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	0x90c
-#define PCIE_RC_CONFIG_LCSR			0xd0
-#define  PCIE_RC_CONFIG_LCSR_LBMIE		BIT(10)
-#define  PCIE_RC_CONFIG_LCSR_LABIE		BIT(11)
-#define  PCIE_RC_CONFIG_LCSR_LBMS		BIT(30)
-#define  PCIE_RC_CONFIG_LCSR_LAMS		BIT(31)
+#define PCIE_RC_CONFIG_LCS			0xd0
+#define  PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
+#define  PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
+#define  PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
+#define  PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
+#define  PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
 #define PCIE_CORE_CTRL_MGMT_BASE		0x900000
 #define PCIE_CORE_AXI_CONF_BASE			0xc00000
 #define PCIE_CORE_AXI_INBOUND_BASE		0xc00800
@@ -68,7 +69,6 @@
 #define  PCIE_CLIENT_INT_HOT_PLUG		BIT(1)
 #define  PCIE_CLIENT_INT_PWR_STCG		BIT(0)
 #define PCIE_RC_CONFIG_RID_CCR			0x8
-#define PCIE_RC_CONFIG_LCS			0xd0
 #define PCIE_RC_BAR_CONF			0x300
 #define PCIE_CORE_OB_REGION_ADDR1		0x4
 #define PCIE_CORE_OB_REGION_DESC0		0x8
@@ -119,7 +119,6 @@
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
 #define RC_REGION_0_PASS_BITS			(25 - 1)
 #define MAX_AXI_WRAPPER_REGION_NUM		33
-#define PCIE_CORE_LCSR_RETRAIN_LINK		BIT(5)
 
 /*
  * The upper 16 bits of the PCIE_CLIENT registers are a write mask for the
@@ -204,18 +203,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
-	status |= (PCIE_RC_CONFIG_LCSR_LBMIE | PCIE_RC_CONFIG_LCSR_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
+	status |= (PCIE_RC_CONFIG_LCS_LBMIE | PCIE_RC_CONFIG_LCS_LABIE);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
-	status |= (PCIE_RC_CONFIG_LCSR_LBMS | PCIE_RC_CONFIG_LCSR_LAMS);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
+	status |= (PCIE_RC_CONFIG_LCS_LBMS | PCIE_RC_CONFIG_LCS_LAMS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
 }
 
 static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
@@ -506,7 +505,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 */
 	status = rockchip_pcie_read(rockchip,
 			   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
-	status |= PCIE_CORE_LCSR_RETRAIN_LINK;
+	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
 	rockchip_pcie_write(rockchip, status,
 		   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
 

