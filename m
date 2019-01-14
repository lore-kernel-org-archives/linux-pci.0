Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85317C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5214520659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZoJMJ1UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfANNZY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:25:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40920 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfANNZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 08:25:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDP6Tn019195;
        Mon, 14 Jan 2019 07:25:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547472306;
        bh=NtKe2jericu7SZi4WCZJdZomxBVNvIwuxybIlJmjYW0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZoJMJ1UDlKF49D1BkkOd3yN5yxSOPLnDFdTCZvitzuZ3lbqbVPhY8qraal+Ibh0FB
         YKnssgPPzJ7jk1v07k28HhwQ+x20X5X/kGi57IjFmM2HFOGGYGyZmL/OY/XUAYHTe+
         KRtGGo488jF/peCKVIAtRre590cFDMVj0GsQLAyw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDP5j9088411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:25:06 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:05 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:05 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWO028516;
        Mon, 14 Jan 2019 07:25:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH 02/24] PCI: keystone: Cleanup error_irq configuration
Date:   Mon, 14 Jan 2019 18:54:02 +0530
Message-ID: <20190114132424.6445-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-keystone driver uses irq_of_parse_and_map to get irq number of
error_irq. Use platform_get_irq instead and move platform_get_irq()
and request_irq() of error_irq from ks_pcie_add_pcie_port to ks_pcie_probe
since error_irq is common to both RC mode and EP mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 24c38ae570b5..f63268aee2de 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -97,8 +97,6 @@ struct keystone_pcie {
 	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
 
-	int error_irq;
-
 	/* Application register space */
 	void __iomem		*va_app_base;	/* DT 1st resource */
 	struct resource		app;
@@ -726,12 +724,6 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
-static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
-{
-	if (ks_pcie->error_irq > 0)
-		ks_pcie_enable_error_irq(ks_pcie);
-}
-
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -793,7 +785,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	ks_pcie_stop_link(pci);
 	ks_pcie_setup_rc_app_regs(ks_pcie);
-	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
@@ -837,23 +828,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	/*
-	 * Index 0 is the platform interrupt for error interrupt
-	 * from RC.  This is optional.
-	 */
-	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
-	if (ks_pcie->error_irq <= 0)
-		dev_info(dev, "no error IRQ defined\n");
-	else {
-		ret = request_irq(ks_pcie->error_irq, ks_pcie_err_irq_handler,
-				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
-		if (ret < 0) {
-			dev_err(dev, "failed to request error IRQ %d\n",
-				ks_pcie->error_irq);
-			return ret;
-		}
-	}
-
 	pp->ops = &ks_pcie_host_ops;
 	ret = ks_pcie_dw_host_init(ks_pcie);
 	if (ret) {
@@ -929,6 +903,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	u32 num_lanes;
 	char name[10];
 	int ret;
+	int irq;
 	int i;
 
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
@@ -948,6 +923,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "missing IRQ resource: %d\n", irq);
+		return irq;
+	}
+
+	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
+			  "ks-pcie-error-irq", ks_pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to request error IRQ %d\n",
+			irq);
+		return ret;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
@@ -1003,6 +992,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_get_sync;
 
+	ks_pcie_enable_error_irq(ks_pcie);
+
 	return 0;
 
 err_get_sync:
-- 
2.17.1

