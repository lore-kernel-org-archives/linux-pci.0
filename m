Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36325 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeGADzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jun 2018 23:55:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so5960970pfh.3
        for <linux-pci@vger.kernel.org>; Sat, 30 Jun 2018 20:55:47 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 7/9] PCI: histb: Drop unnecessary root_bus_nr setting
Date: Sun,  1 Jul 2018 11:54:49 +0800
Message-Id: <1530417291-30495-8-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 3611d6ce9a92..7b32e619b959 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -420,7 +420,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		phy_init(hipcie->phy);
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &histb_pcie_host_ops;
 
 	platform_set_drvdata(pdev, hipcie);
-- 
1.9.1
