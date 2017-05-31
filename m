Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44554 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdEaFeQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2017 01:34:16 -0400
From: Colin King <colin.king@canonical.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][V2] PCI: qcom: fix spelling mistake: "asser" -> "assert"
Date: Wed, 31 May 2017 06:34:14 +0100
Message-Id: <20170531053414.17673-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 289cda1b4897..fbc79a5274c6 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -695,7 +695,7 @@ static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
 
 	ret = reset_control_assert(res->axi_s_reset);
 	if (ret) {
-		dev_err(dev, "cannot asser axi slave reset\n");
+		dev_err(dev, "cannot assert axi slave reset\n");
 		return ret;
 	}
 
-- 
2.11.0
