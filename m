Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933924AbdGTFfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 01:35:21 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v3 4/8] phy: qcom-qmp: Handle unavailable registers
Date: Thu, 20 Jul 2017 11:04:36 +0530
Message-Id: <1500528880-25804-5-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
References: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In some implementations of the QMP phy, some registers might not
be present. Provide a way identify such registers and not access
those registers.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 97020ec..000ad1c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -187,6 +187,8 @@ struct qmp_phy_init_tbl {
 		.in_layout = 1,		\
 	}
 
+#define QPHY_REG_INVAL		0xffffffffu
+
 /* set of registers with offsets different per-PHY */
 enum qphy_reg_layout {
 	/* Common block control registers */
@@ -676,15 +678,18 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
 			     SERDES_START | PCS_START);
 
-		status = serdes + cfg->regs[QPHY_COM_PCS_READY_STATUS];
-		mask = cfg->mask_com_pcs_ready;
-
-		ret = readl_poll_timeout(status, val, (val & mask), 10,
-					 PHY_INIT_COMPLETE_TIMEOUT);
-		if (ret) {
-			dev_err(qmp->dev,
-				"phy common block init timed-out\n");
-			goto err_com_init;
+		if (cfg->regs[QPHY_COM_PCS_READY_STATUS] != QPHY_REG_INVAL) {
+			status = serdes + cfg->regs[QPHY_COM_PCS_READY_STATUS];
+			mask = cfg->mask_com_pcs_ready;
+
+			ret = readl_poll_timeout(status, val, (val & mask), 10,
+						 PHY_INIT_COMPLETE_TIMEOUT);
+			if (ret) {
+				dev_err(qmp->dev,
+					"%s: phy common block init timed-out\n",
+					__func__);
+				goto err_com_init;
+			}
 		}
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
