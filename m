Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:44875 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdEDC0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2017 22:26:20 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/4] PCI: rockchip: move configuration accesses into rockchip_pcie_cfg_atu
Date: Thu,  4 May 2017 10:24:49 +0800
Message-Id: <1493864691-102523-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
References: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Configuration accesses is also part of ATU settings, so let's
keep all of them inside rockchip_pcie_cfg_atu.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index ac08b4c..4228629 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -664,16 +664,6 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
 	}
 
-	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
-
-	rockchip_pcie_write(rockchip,
-			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
-			    PCIE_CORE_OB_REGION_ADDR0);
-	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
-			    PCIE_CORE_OB_REGION_ADDR1);
-	rockchip_pcie_write(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
-	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
-
 	return 0;
 }
 
@@ -1163,6 +1153,17 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 	int err;
 	int reg_no;
 
+	/* Configuration Accesses for region 0 */
+	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
+
+	rockchip_pcie_write(rockchip,
+			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
+			    PCIE_CORE_OB_REGION_ADDR0);
+	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
+			    PCIE_CORE_OB_REGION_ADDR1);
+	rockchip_pcie_write(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
+	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
+
 	for (reg_no = 0; reg_no < (rockchip->mem_size >> 20); reg_no++) {
 		err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
 						AXI_WRAPPER_MEM_WRITE,
-- 
1.9.1
