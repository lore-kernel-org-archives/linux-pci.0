Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35085 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIFm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id i5-v6so3625738plt.2
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:29 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH 5/9] PCI: artpec6: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:42 +0800
Message-Id: <1525844386-5433-5-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

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
