Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FEC282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6720811
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ik3MmPK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfBMN1k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:27:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38026 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390772AbfBMN1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 08:27:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRTJL061092;
        Wed, 13 Feb 2019 07:27:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550064449;
        bh=qODhwOqNUlFw+Di6kaOzDrSeGIt7jacQAzXc8qJBXlg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ik3MmPK5rOTcamOtJkk78PCcFJIkvqzmDc+pojXt/erArKLnQAPdkD8jrc7vCzX/g
         HBQw3B7pjRhd97UgwGXQOWhRGz5EomgUsTVRxGOajyykRQiwqod3jXAJqBL9UWWXAv
         eRnjnxKnyXlhqCIB1KL3BXqRqoaa/aaC+KgtSnro=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRTBg025478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 07:27:29 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:28 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:28 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZd016688;
        Wed, 13 Feb 2019 07:27:26 -0600
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
Subject: [PATCH v3 3/9] PCI: keystone: Use hwirq to get the legacy IRQ number offset
Date:   Wed, 13 Feb 2019 18:56:23 +0530
Message-ID: <20190213132629.24790-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ks_pcie_legacy_irq_handler() uses 'virq' to get the IRQ number offset.
This offset is used to get the correct IRQ_STATUS register
corresponding to the IRQ line that raised the interrupt.
There is no guarantee that 'virq' assigned for consecutive hardware
IRQ will be contiguous. And this might get us an incorrect IRQ number
offset.

Fix it here by using 'hwirq' to get the IRQ number offset.

Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e8b1d8eca78e..d35ac712a9f8 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -87,7 +87,7 @@ struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
 	u32			device_id;
-	int			legacy_host_irqs[PCI_NUM_INTX];
+	int			legacy_host_irq;
 	struct			device_node *legacy_intc_np;
 
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
@@ -582,11 +582,11 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
  */
 static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int irq = desc->irq_data.hwirq;
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
+	u32 irq_offset = irq - ks_pcie->legacy_host_irq;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
@@ -657,6 +657,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
 	int irq_count, irq, ret, i;
+	struct irq_data *irq_data;
 
 	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!intc_np) {
@@ -677,7 +678,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 			ret = -EINVAL;
 			goto err;
 		}
-		ks_pcie->legacy_host_irqs[i] = irq;
+
+		if (!ks_pcie->legacy_host_irq) {
+			irq_data = irq_get_irq_data(irq);
+			if (!irq_data) {
+				ret = -EINVAL;
+				goto err;
+			}
+			ks_pcie->legacy_host_irq = irq_data->hwirq;
+		}
 
 		irq_set_chained_handler_and_data(irq,
 						 ks_pcie_legacy_irq_handler,
-- 
2.17.1

