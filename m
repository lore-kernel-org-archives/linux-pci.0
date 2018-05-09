Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33195 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIFmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id n10-v6so532596plp.0
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:19 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 2/9] PCI: imx6: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:39 +0800
Message-Id: <1525844386-5433-2-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 4818ef875f8a..f330e322c1e7 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -667,7 +667,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 		}
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
1.9.1
