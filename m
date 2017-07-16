Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34909 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdGPGmH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2017 02:42:07 -0400
Received: by mail-pg0-f53.google.com with SMTP id v190so6245588pgv.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2017 23:42:07 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: qcom: Allow post_init to fail
Date: Sat, 15 Jul 2017 23:42:03 -0700
Message-Id: <20170716064203.3406-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

host_init should detect and propagate errors from post_init.

In addition, by acknowleding that post_init can fail we must disable the
post_init resources in a step separate from the deinit, so that we don't
try to disable the post_init resources a second time.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/dwc/pcie-qcom.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 7b703741a3fd..26e84a957c35 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -124,6 +124,7 @@ struct qcom_pcie_ops {
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
+	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 };
 
@@ -517,13 +518,19 @@ static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
 
-	clk_disable_unprepare(res->pipe_clk);
 	clk_disable_unprepare(res->slave_clk);
 	clk_disable_unprepare(res->master_clk);
 	clk_disable_unprepare(res->cfg_clk);
 	clk_disable_unprepare(res->aux_clk);
 }
 
+static void qcom_pcie_post_deinit_v2(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
+
+	clk_disable_unprepare(res->pipe_clk);
+}
+
 static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
@@ -907,8 +914,11 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err_deinit;
 
-	if (pcie->ops->post_init)
-		pcie->ops->post_init(pcie);
+	if (pcie->ops->post_init) {
+		ret = pcie->ops->post_init(pcie);
+		if (ret)
+			goto err_disable_phy;
+	}
 
 	dw_pcie_setup_rc(pp);
 
@@ -924,6 +934,9 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	return 0;
 err:
 	qcom_ep_reset_assert(pcie);
+	if (pcie->ops->post_deinit)
+		pcie->ops->post_deinit(pcie);
+err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
@@ -971,6 +984,7 @@ static const struct qcom_pcie_ops ops_v2 = {
 	.init = qcom_pcie_init_v2,
 	.post_init = qcom_pcie_post_init_v2,
 	.deinit = qcom_pcie_deinit_v2,
+	.post_deinit = qcom_pcie_post_deinit_v2,
 	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
 };
 
-- 
2.12.0
