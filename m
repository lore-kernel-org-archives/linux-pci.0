Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42786 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIFmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 01:42:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so19262531pgc.9
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2018 22:42:32 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 6/9] PCI: designware-plat: Drop unnecessary root_bus_nr setting
Date: Wed,  9 May 2018 13:39:43 +0800
Message-Id: <1525844386-5433-6-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The root_bus_nr initialization has already been done in function
dw_pcie_host_init().  The -1 assignment in platform driver before
calling into dw_pcie_host_init() is not really needed.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 5416aa8a07a5..6e39afefd6db 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -58,7 +58,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
 			return pp->msi_irq;
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &dw_plat_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
1.9.1
