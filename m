Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD3C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CB220836
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ulCxE0QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfBUKSu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:18:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42110 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfBUKSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 05:18:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIdV2053151;
        Thu, 21 Feb 2019 04:18:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550744319;
        bh=jj6FmrtAATey3jXJiSTKNFfft8ZueXEih9SzlA0HGn0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ulCxE0QS++KfNd9ZaYoPlqNLYknNU4OzUSY4WPh+dB/PjGvg+c4PYTm1qB2ScdlvS
         Gvqj0gCIEc4qyAiysadySuT4lt2gmLdgEhxfHJJEsU0EGBDdwdYFBLnyzuECqVBEnL
         akcnr/oPSQbjuunEbtql9nYWKUTzWDMnaFJtPXtk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIdf8070437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 04:18:39 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:38 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:38 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORJ022198;
        Thu, 21 Feb 2019 04:18:36 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/9] PCI: keystone: Use hwirq to get the MSI IRQ number offset
Date:   Thu, 21 Feb 2019 15:45:13 +0530
Message-ID: <20190221101518.22604-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221101518.22604-1-kishon@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ks_pcie_msi_irq_handler() uses 'virq' to get the IRQ number offset.
This offset is used to get the correct MSI_IRQ_STATUS register
corresponding to the IRQ line that raised the interrupt.
There is no guarantee that 'virq' assigned for consecutive hardware
IRQ will be contiguous. And this might get us an incorrect IRQ number
offset.

Fix it here by using 'hwirq' to get the IRQ number offset. Since we
don't store the 'virq' numbers of all the IRQ numbers, stop checking
if irq count is greater than MAX_MSI_HOST_IRQS and remove
MAX_MSI_HOST_IRQS.

Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 24 ++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7f1648453f54..0ebb8622fddb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -75,7 +75,6 @@
 #define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
 					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
-#define MAX_MSI_HOST_IRQS		8
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK			0xb008
 #define PCIE_RC_K2E			0xb009
@@ -90,7 +89,7 @@ struct keystone_pcie {
 	u32			device_id;
 	struct			device_node *legacy_intc_np;
 
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			msi_host_irq;
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
@@ -610,9 +609,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int irq = desc->irq_data.hwirq;
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	u32 offset = irq - ks_pcie->msi_host_irqs[0];
+	u32 offset = irq - ks_pcie->msi_host_irq;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -634,6 +633,7 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
+	struct irq_data *irq_data;
 	int irq_count, irq, ret, i;
 
 	if (!IS_ENABLED(CONFIG_PCI_MSI))
@@ -652,19 +652,21 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 		goto err;
 	}
 
-	if (irq_count > MAX_MSI_HOST_IRQS) {
-		dev_warn(dev, "Too many MSI interrupt lines defined %u\n",
-			 irq_count);
-		irq_count = MAX_MSI_HOST_IRQS;
-	}
-
 	for (i = 0; i < irq_count; i++) {
 		irq = irq_of_parse_and_map(intc_np, i);
 		if (!irq) {
 			ret = -EINVAL;
 			goto err;
 		}
-		ks_pcie->msi_host_irqs[i] = irq;
+
+		if (!ks_pcie->msi_host_irq) {
+			irq_data = irq_get_irq_data(irq);
+			if (!irq_data) {
+				ret = -EINVAL;
+				goto err;
+			}
+			ks_pcie->msi_host_irq = irq_data->hwirq;
+		}
 
 		irq_set_chained_handler_and_data(irq, ks_pcie_msi_irq_handler,
 						 ks_pcie);
-- 
2.17.1

