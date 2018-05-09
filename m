Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39979 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbeEIFmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id t22-v6so3627903plo.7
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:43 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 9/9] PCI: spear13xx: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:46 +0800
Message-Id: <1525844386-5433-9-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

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
