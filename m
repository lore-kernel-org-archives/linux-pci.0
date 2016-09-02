Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 14/15] Simplify testing of link status and speed testing.
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
Date: Fri, 02 Sep 2016 10:55:53 -0500
Message-ID: <20160902155553.8650.83259.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |   36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index a2610dd..e33d2f7 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -52,9 +52,8 @@
 #define  PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
 #define  PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE(0x0040, 0x0040)
 #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
-#define  PCIE_CLIENT_LINK_STATUS_UP		0x3
-#define  PCIE_CLIENT_LINK_STATUS_SHIFT		20
-#define  PCIE_CLIENT_LINK_STATUS_MASK		0x3
+#define  PCIE_CLIENT_LINK_STATUS_UP		0x00300000
+#define  PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
 #define PCIE_CLIENT_INT_MASK		(PCIE_CLIENT_BASE + 0x4c)
 #define PCIE_CLIENT_INT_STATUS		(PCIE_CLIENT_BASE + 0x50)
 #define  PCIE_CLIENT_INTR_MASK			GENMASK(8, 5)
@@ -89,11 +88,10 @@
 
 #define PCIE_CORE_CTRL_MGMT_BASE	0x900000
 #define PCIE_CORE_CTRL			(PCIE_CORE_CTRL_MGMT_BASE + 0x000)
-#define  PCIE_CORE_PL_CONF_SPEED_5G		0x1
-#define  PCIE_CORE_PL_CONF_SPEED_SHIFT		3
-#define  PCIE_CORE_PL_CONF_SPEED_MASK		0x3
+#define  PCIE_CORE_PL_CONF_SPEED_5G		0x00000008
+#define  PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
+#define  PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
 #define  PCIE_CORE_PL_CONF_LANE_SHIFT		1
-#define  PCIE_CORE_PL_CONF_LANE_MASK		0x3
 #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define  PCIE_CORE_INT_PRFPE			BIT(0)
 #define  PCIE_CORE_INT_CRFPE			BIT(1)
@@ -477,9 +475,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	for (;;) {
 		status = rockchip_pcie_read(rockchip,
 					    PCIE_CLIENT_BASIC_STATUS1);
-		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
-		      PCIE_CLIENT_LINK_STATUS_MASK) ==
-		      PCIE_CLIENT_LINK_STATUS_UP) {
+		if ((status & PCIE_CLIENT_LINK_STATUS_MASK) ==
+		    PCIE_CLIENT_LINK_STATUS_UP) {
 			dev_dbg(dev, "PCIe link training gen1 pass!\n");
 			break;
 		}
@@ -496,9 +493,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	if (err) {
 		status = rockchip_pcie_read(rockchip,
 					    PCIE_CLIENT_BASIC_STATUS1);
-		err = (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
-			PCIE_CLIENT_LINK_STATUS_MASK) ==
-			PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
+		err = ((status & PCIE_CLIENT_LINK_STATUS_MASK) ==
+		       PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
 		if (err) {
 			dev_err(dev, "PCIe link training gen1 timeout!\n");
 			return err;
@@ -516,9 +512,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	timeout = jiffies + msecs_to_jiffies(500);
 	for (;;) {
 		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
-		     PCIE_CORE_PL_CONF_SPEED_MASK) ==
-		     PCIE_CORE_PL_CONF_SPEED_5G) {
+		if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
+		    PCIE_CORE_PL_CONF_SPEED_5G) {
 			dev_dbg(dev, "PCIe link training gen2 pass!\n");
 			break;
 		}
@@ -534,17 +529,16 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	/* Double check gen2 training */
 	if (err) {
 		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-		err = (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
-			PCIE_CORE_PL_CONF_SPEED_MASK) ==
-			PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
+		err = ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
+		       PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
 		if (err)
 			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
 	}
 
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
-			   PCIE_CORE_PL_CONF_LANE_MASK);
+	status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
+			  PCIE_CORE_PL_CONF_LANE_MASK);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
