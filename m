Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35424 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKAV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:21:26 -0400
Received: by mail-pg0-f68.google.com with SMTP id n1-v6so1662490pgs.2
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:21:25 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH v2 9/9] PCI: spear13xx: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:19 +0800
Message-Id: <1525998019-28634-10-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/dwc/pcie-spear13xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index ecb58f7b7566..7d0cdfd8138b 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -210,7 +210,6 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 		return ret;
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &spear13xx_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
1.9.1
