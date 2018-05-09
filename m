Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41944 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIFm0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id v63so25063308pfk.8
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:26 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 4/9] PCI: armada8k: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:41 +0800
Message-Id: <1525844386-5433-4-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index b587352f8b9f..2d8eb88fd4f8 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -171,7 +171,6 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	pp->root_bus_nr = -1;
 	pp->ops = &armada8k_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 0);
-- 
1.9.1
