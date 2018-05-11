Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44896 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKAVN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2018 20:21:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id q22-v6so1840265pff.11
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 17:21:12 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH v2 5/9] PCI: artpec6: Drop unnecessary root_bus_nr setting
Date: Fri, 11 May 2018 08:20:15 +0800
Message-Id: <1525998019-28634-6-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/dwc/pcie-artpec6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index e66cede2b5b7..af78b5c23bce 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -399,7 +399,6 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 		}
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &artpec6_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
1.9.1
