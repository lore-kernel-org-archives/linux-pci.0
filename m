Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40959 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKAU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:20:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id f189-v6so1844009pfa.7
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:20:58 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 1/9] PCI: exynos: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:11 +0800
Message-Id: <1525998019-28634-2-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

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
