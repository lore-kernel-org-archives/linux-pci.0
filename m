Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37319 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeGADzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jun 2018 23:55:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id n15-v6so2415145pgv.4
        for <linux-pci@vger.kernel.org>; Sat, 30 Jun 2018 20:55:52 -0700 (PDT)
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
Subject: [PATCH v3 8/9] PCI: qcom: Drop unnecessary root_bus_nr setting
Date: Sun,  1 Jul 2018 11:54:50 +0800
Message-Id: <1530417291-30495-9-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dw_pcie_host_init() already initializes the root_bus_nr field
of 'struct pcie_port', so the -1 assignment prior to calling
dw_pcie_host_init() in platform specific driver is not really needed.
Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a1d0198081a6..4352c1cb926d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1251,7 +1251,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pp->root_bus_nr = -1;
 	pp->ops = &qcom_pcie_dw_ops;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-- 
1.9.1
