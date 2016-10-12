Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:43457 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbcJLCKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 22:10:49 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/3] PCI: rockchip: Provide captured slot power limit and scale
Date: Wed, 12 Oct 2016 10:05:01 +0800
Message-Id: <1476237903-15076-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If vpcie3v3 is available, we could provide these information
via RC's configure register to make EP able to know the power
limit.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- rebase the code since it isn't cleanly applied again.

Changes in v2:
- rebase the code since it isn't cleanly applied after Bjorn's cleanup

 drivers/pci/host/pcie-rockchip.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index db917c7..a67ff9e 100644
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
@@ -398,6 +402,40 @@ static struct pci_ops rockchip_pcie_ops = {
 	.write = rockchip_pcie_wr_conf,
 };
 
+static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip_pcie)
+{
+	u32 status, curr, scale, power;
+
+	if (IS_ERR(rockchip_pcie->vpcie3v3))
+		return;
+
+	/*
+	 * Set RC's captured slot power limit and scale if
+	 * vpcie3v3 available. The default values are both zero
+	 * which means the software should set these two according
+	 * to the actual power supply.
+	 */
+	curr = regulator_get_current_limit(rockchip_pcie->vpcie3v3);
+	if (curr > 0) {
+		scale = 3; /* 0.001x */
+		curr = curr / 1000; /* convert to mA */
+		power = (curr * 3300) / 1000; /* milliwatt */
+		while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+			if (!scale) {
+				dev_warn(rockchip_pcie->dev, "invalid power supply\n");
+				return;
+			}
+			scale--;
+			power = power / 10;
+		}
+
+		status = rockchip_pcie_readl(rockchip_pcie, PCIE_RC_CONFIG_DCR);
+		status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
+			  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
+		rockchip_pcie_writel(rockchip_pcie, PCIE_RC_CONFIG_DCR, status);
+	}
+}
+
 /**
  * rockchip_pcie_init_port - Initialize hardware
  * @rockchip_pcie: PCIe port information
@@ -500,6 +538,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip_pcie)
 		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
 	rockchip_pcie_writel(rockchip_pcie, PCIE_CORE_CTRL_PLC1, status);
 
+	rockchip_pcie_set_power_limit(rockchip_pcie);
+
 	/* Enable Gen1 training */
 	rockchip_pcie_writel(rockchip_pcie, PCIE_CLIENT_CONFIG,
 			PCIE_CLIENT_LINK_TRAIN_ENABLE);
-- 
2.3.7


