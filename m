Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:47187 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756866AbcJTHsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2016 03:48:15 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: rockchip: remove the pointer to L1 substate cap
Date: Thu, 20 Oct 2016 15:53:20 +0800
Message-Id: <1476950000-16910-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per the errata of TRM, the RC can't support L1 substate, so we
need to remove the L1 substate cap as well as operation for
PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
- Add Brian's tag and remove operation for PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2.

 drivers/pci/host/pcie-rockchip.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e0b22da..a23c7f1 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -142,6 +142,8 @@
 #define   PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
 #define   PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
+#define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
+#define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
@@ -481,15 +483,6 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	/*
-	 * We need to read/write PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 before
-	 * enabling ASPM.  Otherwise L1PwrOnSc and L1PwrOnVal isn't
-	 * reliable and enabling ASPM doesn't work.  This is a controller
-	 * bug we need to work around.
-	 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
-
 	/* Fix the transmitted FTS count desired to exit from L0s. */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_PLC1);
 	status = (status & PCIE_CORE_CTRL_PLC1_FTS_MASK) |
@@ -558,6 +551,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip,
 			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
 			    PCIE_RC_CONFIG_RID_CCR);
+
+	/* Clear THP cap's next cap pointer to remove L1 substate cap */
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_THP_CAP);
+	status &= ~PCIE_RC_CONFIG_THP_CAP_NEXT_MASK;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_THP_CAP);
+
 	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
 
 	rockchip_pcie_write(rockchip,
-- 
2.3.7


