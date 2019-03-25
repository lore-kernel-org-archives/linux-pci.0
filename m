Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7DC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5B62080F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g1F8xUgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfCYIgj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:36:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52224 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfCYIgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:36:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8aKsl106108;
        Mon, 25 Mar 2019 03:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553502980;
        bh=8ftV+tyeP19Er0Uqruzv3Zjv2HvQTzbCletDFZ3afkE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g1F8xUgElVpNW9N2HFrxlKj+YXeJOYXNCm3GfUArEQMngr/Bc1z0YSVfwQeNPdMmg
         o8brTMdPFxDDhgB+ZIcZF8x8flfiERBoLzxSJZlGPasdaebG4T2tNwbSrNl+zmu9Jq
         eQEtM9KAgYIql0uLA+JxLuZAwVLz7X5pObUo7ChU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8aKtj016379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:36:20 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:36:19 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:36:19 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsFl006534;
        Mon, 25 Mar 2019 03:36:16 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH v2 05/26] PCI: keystone: Use platform_get_resource_byname to get memory resources
Date:   Mon, 25 Mar 2019 14:04:40 +0530
Message-ID: <20190325083501.8088-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use platform_get_resource_byname() instead of platform_get_resource() which
uses index to get memory resources. While at that get the memory resource
defined specifically for configuration space instead of deriving the
configuration space address from dbics address space. Since pci-keystone
driver has never worked out of the box in mainline kernel, dt backward
compatibility is ignored.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 566718ea7ebf..5eebef9b9ada 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -44,7 +44,6 @@
 #define CFG_TYPE1			BIT(24)
 
 #define OB_SIZE				0x030
-#define SPACE0_REMOTE_CFG_OFFSET	0x1000
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 #define OB_ENABLEN			BIT(0)
@@ -807,21 +806,19 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct resource *res;
 	int ret;
 
-	/* Index 0 is the config reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	/*
-	 * We set these same and is used in pcie rd/wr_other_conf
-	 * functions
-	 */
-	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pp->va_cfg0_base))
+		return PTR_ERR(pp->va_cfg0_base);
+
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	/* Index 1 is the application reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
 	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ks_pcie->va_app_base))
 		return PTR_ERR(ks_pcie->va_app_base);
-- 
2.17.1

