Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35586 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbeGADzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jun 2018 23:55:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so6341323plt.2
        for <linux-pci@vger.kernel.org>; Sat, 30 Jun 2018 20:55:24 -0700 (PDT)
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
Subject: [PATCH v3 3/9] PCI: keystone: Drop unnecessary root_bus_nr setting
Date: Sun,  1 Jul 2018 11:54:45 +0800
Message-Id: <1530417291-30495-4-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3722a5f31e5e..e88bd221fffe 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -347,7 +347,6 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 		}
 	}
 
-	pp->root_bus_nr = -1;
 	pp->ops = &keystone_pcie_host_ops;
 	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
 	if (ret) {
-- 
1.9.1
