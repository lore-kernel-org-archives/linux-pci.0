Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36165 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEIFmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id w129so19650607pfd.3
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:39 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH 8/9] PCI: qcom: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:45 +0800
Message-Id: <1525844386-5433-8-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 drivers/pci/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 5897af7d3355..a32aa024e907 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -1247,7 +1247,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pp->root_bus_nr = -1;
 	pp->ops = &qcom_pcie_dw_ops;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-- 
1.9.1
