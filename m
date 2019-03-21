Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52806C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B0F218B0
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="in7E87R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfCUKBR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:01:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38192 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUKAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 06:00:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LA0XiD124592;
        Thu, 21 Mar 2019 05:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553162433;
        bh=mwURSJuX1rQNIU9D/+jfzZA3qB5wwzwULYs8IWL7tW4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=in7E87R7fNjqm1SisNg0v6THhR7CHrTX7XwSHbYtXFhI/I/cas50zGc5mFABinXLX
         iiUCIdnPns+JdkGMitOCGByB+d26g2uiu80GvqVKgObb7vUv0dJV+j6Lbm4rFSPRlg
         unSTapSjJ04ev7PWraJzSVPFoLc+Gnw34FqEnHo0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LA0Xgt069276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 05:00:33 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 05:00:32 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 05:00:32 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LA0KO9014903;
        Thu, 21 Mar 2019 05:00:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/8] PCI: keystone: Use hwirq to get the MSI IRQ number offset
Date:   Thu, 21 Mar 2019 15:29:22 +0530
Message-ID: <20190321095927.7058-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321095927.7058-1-kishon@ti.com>
References: <20190321095927.7058-1-kishon@ti.com>
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
index 47f0dcf638f2..fce25a0dcd08 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -74,7 +74,6 @@
 #define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
 					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
-#define MAX_MSI_HOST_IRQS		8
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK			0xb008
 #define PCIE_RC_K2E			0xb009
@@ -90,7 +89,7 @@ struct keystone_pcie {
 	int			legacy_host_irqs[PCI_NUM_INTX];
 	struct			device_node *legacy_intc_np;
 
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			msi_host_irq;
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
@@ -553,9 +552,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 
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
@@ -606,6 +605,7 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
+	struct irq_data *irq_data;
 	int irq_count, irq, ret, i;
 
 	if (!IS_ENABLED(CONFIG_PCI_MSI))
@@ -624,19 +624,21 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
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

