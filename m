Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v6 3/7] phy: qcom-qmp: Fix phy pipe clock name
Date: Mon, 31 Jul 2017 12:04:13 +0530
Message-Id: <1501482857-14100-4-git-send-email-varada@codeaurora.org>
In-Reply-To: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Presently, the phy pipe clock's name is assumed to be either
usb3_phy_pipe_clk_src or pcie_XX_pipe_clk_src (where XX is the
phy lane's number). However, this will not work if an SoC has
more than one instance of the phy. Hence, instead of assuming
the name of the clock, fetch it from the DT.

Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 78ca628..3dd7891 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -925,29 +925,28 @@ static int qcom_qmp_phy_clk_init(struct device *dev)
  *    clk  |   +-------+   |                   +-----+
  *         +---------------+
  */
-static int phy_pipe_clk_register(struct qcom_qmp *qmp, int id)
+static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 {
-	char name[24];
 	struct clk_fixed_rate *fixed;
 	struct clk_init_data init = { };
+	int ret;
 
-	switch (qmp->cfg->type) {
-	case PHY_TYPE_USB3:
-		snprintf(name, sizeof(name), "usb3_phy_pipe_clk_src");
-		break;
-	case PHY_TYPE_PCIE:
-		snprintf(name, sizeof(name), "pcie_%d_pipe_clk_src", id);
-		break;
-	default:
+	if ((qmp->cfg->type != PHY_TYPE_USB3) &&
+	    (qmp->cfg->type != PHY_TYPE_PCIE)) {
 		/* not all phys register pipe clocks, so return success */
 		return 0;
 	}
 
+	ret = of_property_read_string(np, "clock-output-names", &init.name);
+	if (ret) {
+		dev_err(qmp->dev, "%s: No clock-output-names\n", np->name);
+		return ret;
+	}
+
 	fixed = devm_kzalloc(qmp->dev, sizeof(*fixed), GFP_KERNEL);
 	if (!fixed)
 		return -ENOMEM;
 
-	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
 
 	/* controllers using QMP phys use 125MHz pipe clock interface */
@@ -1122,7 +1121,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		 * Register the pipe clock provided by phy.
 		 * See function description to see details of this pipe clock.
 		 */
-		ret = phy_pipe_clk_register(qmp, id);
+		ret = phy_pipe_clk_register(qmp, child);
 		if (ret) {
 			dev_err(qmp->dev,
 				"failed to register pipe clock source\n");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
