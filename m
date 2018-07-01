Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43587 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeGADzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jun 2018 23:55:19 -0400
Received: by mail-pg0-f65.google.com with SMTP id v13-v6so19386pgr.10
        for <linux-pci@vger.kernel.org>; Sat, 30 Jun 2018 20:55:18 -0700 (PDT)
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
        Shawn Guo <shawn.guo@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/9] PCI: imx6: Drop unnecessary root_bus_nr setting
Date: Sun,  1 Jul 2018 11:54:44 +0800
Message-Id: <1530417291-30495-3-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80f604602783..4a9a673b4777 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -667,7 +667,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 		}
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
1.9.1
