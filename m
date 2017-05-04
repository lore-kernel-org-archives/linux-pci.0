Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:60860 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdEDC0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2017 22:26:23 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] PCI: rockchip: spilt out rockchip_pcie_cfg_configuration_accesses
Date: Thu,  4 May 2017 10:24:50 +0800
Message-Id: <1493864691-102523-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
References: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to reconfigure the header type later, so spilt out
a new function.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 4228629..76bb508 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -175,6 +175,8 @@
 #define IB_ROOT_PORT_REG_SIZE_SHIFT		3
 #define AXI_WRAPPER_IO_WRITE			0x6
 #define AXI_WRAPPER_MEM_WRITE			0x2
+#define AXI_WRAPPER_TYPE0_CFG			0xa
+#define AXI_WRAPPER_TYPE1_CFG			0xb
 #define AXI_WRAPPER_NOR_MSG			0xc
 
 #define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
@@ -198,6 +200,7 @@
 #define RC_REGION_0_ADDR_TRANS_H		0x00000000
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
 #define RC_REGION_0_PASS_BITS			(25 - 1)
+#define RC_REGION_0_TYPE_MASK			GENMASK(3, 0)
 #define MAX_AXI_WRAPPER_REGION_NUM		33
 
 struct rockchip_pcie {
@@ -341,6 +344,28 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static void rockchip_pcie_cfg_configuration_accesses(
+		struct rockchip_pcie *rockchip, u32 type)
+{
+	u32 ob_desc_0;
+
+	/* Configuration Accesses for region 0 */
+	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
+
+	rockchip_pcie_write(rockchip,
+			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
+			    PCIE_CORE_OB_REGION_ADDR0);
+	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
+			    PCIE_CORE_OB_REGION_ADDR1);
+	ob_desc_0 = rockchip_pcie_read(rockchip, PCIE_CORE_OB_REGION_DESC0);
+	ob_desc_0 &= ~(RC_REGION_0_TYPE_MASK);
+	ob_desc_0 |= (type | (0x1 << 23));
+	rockchip_pcie_write(rockchip, ob_desc_0, PCIE_CORE_OB_REGION_DESC0);
+	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
+
+
+}
+
 static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 *val)
@@ -1153,16 +1178,8 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 	int err;
 	int reg_no;
 
-	/* Configuration Accesses for region 0 */
-	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
-
-	rockchip_pcie_write(rockchip,
-			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
-			    PCIE_CORE_OB_REGION_ADDR0);
-	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
-			    PCIE_CORE_OB_REGION_ADDR1);
-	rockchip_pcie_write(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
-	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
+	rockchip_pcie_cfg_configuration_accesses(rockchip,
+						 AXI_WRAPPER_TYPE0_CFG);
 
 	for (reg_no = 0; reg_no < (rockchip->mem_size >> 20); reg_no++) {
 		err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
-- 
1.9.1
