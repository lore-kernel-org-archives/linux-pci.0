Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34625 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKAVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:21:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id a14-v6so1850607pfi.1
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:21:19 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Jianguo Sun <sunjianguo1@huawei.com>
Subject: [PATCH v2 7/9] PCI: histb: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:17 +0800
Message-Id: <1525998019-28634-8-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
---
 drivers/pci/dwc/pcie-histb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 3611d6ce9a92..7b32e619b959 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -420,7 +420,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		phy_init(hipcie->phy);
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &histb_pcie_host_ops;
 
 	platform_set_drvdata(pdev, hipcie);
-- 
1.9.1
