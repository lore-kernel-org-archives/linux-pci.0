Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdGaFkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2017 01:40:20 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v5 3/7] phy: qcom-qmp: Fix phy pipe clock name
Date: Mon, 31 Jul 2017 11:09:50 +0530
Message-Id: <1501479594-18285-4-git-send-email-varada@codeaurora.org>
In-Reply-To: <1501479594-18285-1-git-send-email-varada@codeaurora.org>
References: <1501479594-18285-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Presently, the phy pipe clock's name is assumed to be either
usb3_phy_pipe_clk_src or pcie_XX_pipe_clk_src (where XX is the
phy lane's number). However, this will not work if an SoC has
more than one instance of the phy. Hence, instead of assuming
the name of the clock, fetch it from the DT.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 78ca628..464049c 100644
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
@@ -1110,6 +1109,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
+
 		/* Create per-lane phy */
 		ret = qcom_qmp_phy_create(dev, child, id);
 		if (ret) {
@@ -1119,10 +1119,10 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		}
 
 		/*
-		 * Register the pipe clock provided by phy.
-		 * See function description to see details of this pipe clock.
+		 * Register the pipe clock provided by phy. See function
+		 * description to see details of this pipe clock.
 		 */
-		ret = phy_pipe_clk_register(qmp, id);
+		ret = phy_pipe_clk_register(qmp, child);
 		if (ret) {
 			dev_err(qmp->dev,
 				"failed to register pipe clock source\n");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
