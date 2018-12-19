Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF9C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3242080D
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fgDBsGKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeLSMnJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:43:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54850 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeLSMnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 07:43:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgg3d098497;
        Wed, 19 Dec 2018 06:42:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545223362;
        bh=aGKggKrre68tpewZr9QnXh/i5cUBcmHQ2TJDpEiqdgk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fgDBsGKLiEWFeZ0Qd2X6bXgfIdVvHuUuf3tBXtKMxJ54ywWCtLvg6CIk0LtFTq6TM
         UbVFhXlfPVIrF/JhzrKhOF4N7uN2rwnKyLPED9I61jc5xNNd2aPkb0PoCVKMRAmWNg
         lAo8q8vkKyzEcTOLF4PXUwLhxkP0KoCd1UusXbA4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCggpA040985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 06:42:42 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:42 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:42 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgNZo003940;
        Wed, 19 Dec 2018 06:42:39 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kishon@ti.com>
Subject: [PATCH 05/10] PCI: keystone: Use hwirq to get the IRQ number offset
Date:   Wed, 19 Dec 2018 18:12:02 +0530
Message-ID: <20181219124207.13479-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219124207.13479-1-kishon@ti.com>
References: <20181219124207.13479-1-kishon@ti.com>
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
index a8712804c891..8a78307dac99 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -74,7 +74,6 @@
 #define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
 					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
-#define MAX_MSI_HOST_IRQS		8
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK			0xb008
 #define PCIE_RC_K2E			0xb009
@@ -89,7 +88,7 @@ struct keystone_pcie {
 	u32			device_id;
 	struct			device_node *legacy_intc_np;
 
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			msi_host_irq;
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
@@ -527,9 +526,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 
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
@@ -587,6 +586,7 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
+	struct irq_data *irq_data;
 	int irq_count;
 	int irq;
 	int ret;
@@ -608,19 +608,21 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
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

