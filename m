Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:42567 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbcJJKcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2016 06:32:10 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] PCI: rockchip: Mark RC as common clock architecture
Date: Mon, 10 Oct 2016 18:26:19 +0800
Message-Id: <1476095180-15984-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1476095180-15984-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476095180-15984-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The default value of common clock configuration is
zero indicating Rockchip's RC is using asynchronous
clock architecture but actually we are using common
clock. This will confuses some EP drivers if they
need some different settings referring to this value.
So let's fix it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rebase the code since it isn't cleanly applied after Bjorn's cleanup

 drivers/pci/host/pcie-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 75b6bbf..35f1ce2 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -141,6 +141,7 @@
 #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define   PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
+#define   PCIE_RC_CONFIG_LCS_CCC		BIT(6)
 #define   PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
 #define   PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
 #define   PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
@@ -534,6 +535,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	rockchip_pcie_set_power_limit(rockchip);
 
+	/* Set RC's clock architecture as common clock */
+	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
+	status |= PCIE_RC_CONFIG_LCS_CCC;
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_LCS, status);
+
 	/* Enable Gen1 training */
 	rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
 			PCIE_CLIENT_LINK_TRAIN_ENABLE);
-- 
2.3.7


