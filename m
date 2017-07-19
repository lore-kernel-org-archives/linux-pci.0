Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 054/102] PCI: rockchip: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:58 +0200
Message-Id: <20170719152646.25903-55-p.zabel@pengutronix.de>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/pci/host/pcie-rockchip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 7bb9870f6d8ce..e50d6f5a81f4b 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -903,49 +903,50 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
 		rockchip->link_gen = 2;
 
-	rockchip->core_rst = devm_reset_control_get(dev, "core");
+	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
 	if (IS_ERR(rockchip->core_rst)) {
 		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing core reset property in node\n");
 		return PTR_ERR(rockchip->core_rst);
 	}
 
-	rockchip->mgmt_rst = devm_reset_control_get(dev, "mgmt");
+	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
 	if (IS_ERR(rockchip->mgmt_rst)) {
 		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing mgmt reset property in node\n");
 		return PTR_ERR(rockchip->mgmt_rst);
 	}
 
-	rockchip->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
+	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
+								     "mgmt-sticky");
 	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
 		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing mgmt-sticky reset property in node\n");
 		return PTR_ERR(rockchip->mgmt_sticky_rst);
 	}
 
-	rockchip->pipe_rst = devm_reset_control_get(dev, "pipe");
+	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
 	if (IS_ERR(rockchip->pipe_rst)) {
 		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing pipe reset property in node\n");
 		return PTR_ERR(rockchip->pipe_rst);
 	}
 
-	rockchip->pm_rst = devm_reset_control_get(dev, "pm");
+	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
 	if (IS_ERR(rockchip->pm_rst)) {
 		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing pm reset property in node\n");
 		return PTR_ERR(rockchip->pm_rst);
 	}
 
-	rockchip->pclk_rst = devm_reset_control_get(dev, "pclk");
+	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
 	if (IS_ERR(rockchip->pclk_rst)) {
 		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing pclk reset property in node\n");
 		return PTR_ERR(rockchip->pclk_rst);
 	}
 
-	rockchip->aclk_rst = devm_reset_control_get(dev, "aclk");
+	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
 	if (IS_ERR(rockchip->aclk_rst)) {
 		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing aclk reset property in node\n");
-- 
2.11.0
