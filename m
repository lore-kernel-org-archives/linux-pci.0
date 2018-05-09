Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33547 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIFmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id i194-v6so22170260pgd.0
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:16 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 1/9] PCI: exynos: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:38 +0800
Message-Id: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/dwc/pci-exynos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 4cc1e5df8c79..cee5f2f590e2 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -421,7 +421,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 		}
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &exynos_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
1.9.1
