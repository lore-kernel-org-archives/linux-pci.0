Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35816 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKAVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:21:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id i5-v6so2235316plt.2
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:21:04 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH v2 3/9] PCI: keystone: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:13 +0800
Message-Id: <1525998019-28634-4-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/dwc/pci-keystone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index d55ae0716adf..6ca80a21969e 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -347,7 +347,6 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 		}
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &keystone_pcie_host_ops;
 	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
 	if (ret) {
-- 
1.9.1
