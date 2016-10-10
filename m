Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:40866 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbcJJKU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2016 06:20:29 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/3] PCI: rockchip: Provide captured slot power limit and scale
Date: Mon, 10 Oct 2016 18:26:18 +0800
Message-Id: <1476095180-15984-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If vpcie3v3 is available, we could provide these information
via RC's configure register to make EP able to know the power
limit.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rebase the code since it isn't cleanly applied after Bjorn's cleanup

 drivers/pci/host/pcie-rockchip.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index b3548d0..75b6bbf 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -135,6 +135,10 @@
 #define PCIE_RC_CONFIG_VENDOR		(PCIE_RC_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
+#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
+#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
+#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
+#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define   PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
 #define   PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
@@ -394,6 +398,40 @@ static struct pci_ops rockchip_pcie_ops = {
 	.write = rockchip_pcie_wr_conf,
 };
 
+static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
+{
+	u32 status, curr, scale, power;
+
+	if (IS_ERR(rockchip->vpcie3v3))
+		return;
+
+	/*
+	 * Set RC's captured slot power limit and scale if
+	 * vpcie3v3 available. The default values are both zero
+	 * which means the software should set these two according
+	 * to the actual power supply.
+	 */
+	curr = regulator_get_current_limit(rockchip->vpcie3v3);
+	if (curr > 0) {
+		scale = 3; /* 0.001x */
+		curr = curr / 1000; /* convert to mA */
+		power = (curr * 3300) / 1000; /* milliwatt */
+		while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+			if (!scale) {
+				dev_warn(rockchip->dev, "invalid power supply\n");
+				return;
+			}
+			scale--;
+			power = power / 10;
+		}
+
+		status = rockchip_readl(rockchip, PCIE_RC_CONFIG_DCR);
+		status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
+			  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
+		rockchip_writel(rockchip, PCIE_RC_CONFIG_DCR, status);
+	}
+}
+
 /**
  * rockchip_pcie_init_port - Initialize hardware
  * @rockchip: PCIe port information
@@ -494,6 +532,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
 	rockchip_writel(rockchip, PCIE_CORE_CTRL_PLC1, status);
 
+	rockchip_pcie_set_power_limit(rockchip);
+
 	/* Enable Gen1 training */
 	rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
 			PCIE_CLIENT_LINK_TRAIN_ENABLE);
-- 
2.3.7


