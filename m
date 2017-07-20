Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v3 3/8] phy: qcom-qmp: Fix phy pipe clock name
Date: Thu, 20 Jul 2017 11:04:35 +0530
Message-Id: <1500528880-25804-4-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
References: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Presently, the phy pipe clock's name is assumed to be either
usb3_phy_pipe_clk_src or pcie_XX_pipe_clk_src (where XX is the
phy lane's number). However, this will not work if an SoC has
more than one instance of the phy. Hence, instead of assuming
the name of the clock, fetch it from the DT.

Acked-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 78ca628..97020ec 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -925,20 +925,13 @@ static int qcom_qmp_phy_clk_init(struct device *dev)
  *    clk  |   +-------+   |                   +-----+
  *         +---------------+
  */
-static int phy_pipe_clk_register(struct qcom_qmp *qmp, int id)
+static int phy_pipe_clk_register(struct qcom_qmp *qmp, const char *clk_name)
 {
-	char name[24];
 	struct clk_fixed_rate *fixed;
 	struct clk_init_data init = { };
 
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
@@ -947,7 +940,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, int id)
 	if (!fixed)
 		return -ENOMEM;
 
-	init.name = name;
+	init.name = clk_name;
 	init.ops = &clk_fixed_rate_ops;
 
 	/* controllers using QMP phys use 125MHz pipe clock interface */
@@ -1110,6 +1103,8 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
+		const char *clk_name;
+
 		/* Create per-lane phy */
 		ret = qcom_qmp_phy_create(dev, child, id);
 		if (ret) {
@@ -1118,11 +1113,20 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 			return ret;
 		}
 
+		ret = of_property_read_string(child, "clock-output-names",
+							&clk_name);
+		if (ret) {
+			dev_err(dev,
+				"failed to get clock-output-names for lane%d phy, %d\n",
+				id, ret);
+			return ret;
+		}
+
 		/*
 		 * Register the pipe clock provided by phy.
 		 * See function description to see details of this pipe clock.
 		 */
-		ret = phy_pipe_clk_register(qmp, id);
+		ret = phy_pipe_clk_register(qmp, clk_name);
 		if (ret) {
 			dev_err(qmp->dev,
 				"failed to register pipe clock source\n");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
