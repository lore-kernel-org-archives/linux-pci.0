Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFCCC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABD12080D
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 12:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PaBeUMaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeLSMmy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:42:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36206 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbeLSMmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 07:42:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgXcU126318;
        Wed, 19 Dec 2018 06:42:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545223353;
        bh=tUqtMhWdpAvQJvFjUSGA83BB/8fhxvBVfFQdnpC737Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PaBeUMaXd8/XPHx12/5eYnkTBusopQc1o98+U5Y/P9Q2LfqCS4uuWOKDNYdzb0k+3
         rYzLKq6Ras0uVMORaFtQqEQbyOJM05v9N3Zcy7hUo9A7nIWcOth70H7RAojgGCU3wr
         h+mJ2q8cei7MY1c2LtPmsiCbaJaqzPeyb5G0KDR0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgXxt051563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 06:42:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:33 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgNZl003940;
        Wed, 19 Dec 2018 06:42:30 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kishon@ti.com>
Subject: [PATCH 02/10] PCI: keystone: Use "dummy_irq_chip" instead of new irqchip for legacy interrupt handling
Date:   Wed, 19 Dec 2018 18:11:59 +0530
Message-ID: <20181219124207.13479-3-kishon@ti.com>
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

Instead of creating a new irqchip with empty callback functions, use
dummy_irq_chip. Since there is nothing to do in the irqchip callback
functions, use handle_simple_irq instead of handle_level_irq.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 24 ++---------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5286a480f76b..1ef443009da5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -266,31 +266,12 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
-static void ks_pcie_ack_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_pcie_mask_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
-{
-}
-
-static struct irq_chip ks_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_pcie_ack_legacy_irq,
-	.irq_mask = ks_pcie_mask_legacy_irq,
-	.irq_unmask = ks_pcie_unmask_legacy_irq,
-};
-
 static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
 				       unsigned int irq,
 				       irq_hw_number_t hw_irq)
 {
-	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
-				 handle_level_irq);
+	irq_set_chip_and_handler(irq, &dummy_irq_chip,
+				 handle_simple_irq);
 	irq_set_chip_data(irq, d->host_data);
 
 	return 0;
@@ -298,7 +279,6 @@ static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
 
 static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
 	.map = ks_pcie_init_legacy_irq_map,
-	.xlate = irq_domain_xlate_onetwocell,
 };
 
 /**
-- 
2.17.1

