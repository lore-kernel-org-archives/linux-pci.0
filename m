Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27ADC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A742087E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G9yVLeaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfCYIhf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:37:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34048 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbfCYIhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:37:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8bKZd031107;
        Mon, 25 Mar 2019 03:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553503040;
        bh=FFBI81IHUSwFB45pqKhYDbRxN16ADNIUFkLN5k6S3dE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G9yVLeaJ1feWrZZP/o/42jlczvAF/UnU6BxyruGqEWTKaQkkIVxdd39I8YTS7qAdJ
         +UN8xUUj2qVi4JMzTYVcyhyFUuCOHsrb9wgbaOmqFxuK5P9yVgCZoQQh1lv9zUlIVo
         iTmPRmTOUMygakwOPKg+LRGspOzSRuDSjiw5heOg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8bKlA089711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:37:20 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:37:19 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:37:19 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsG1006534;
        Mon, 25 Mar 2019 03:37:15 -0500
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
Subject: [PATCH v2 19/26] PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
Date:   Mon, 25 Mar 2019 14:04:54 +0530
Message-ID: <20190325083501.8088-20-kishon@ti.com>
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

Add const qualifier to struct dw_pcie_ep_ops member of
struct dw_pcie_ep.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index ae84a69ae63a..b287dbf6914c 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -406,7 +406,7 @@ dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
 	return &dra7xx_pcie_epc_features;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dra7xx_pcie_ep_init,
 	.raise_irq = dra7xx_pcie_raise_irq,
 	.get_features = dra7xx_pcie_get_features,
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index dba83abfe764..d00252bd8fae 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -444,7 +444,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = artpec6_pcie_ep_init,
 	.raise_irq = artpec6_pcie_raise_irq,
 };
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 932dbd0b34b6..b58fdcbc664b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -106,7 +106,7 @@ dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
 	return &dw_plat_pcie_epc_features;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dw_plat_pcie_ep_init,
 	.raise_irq = dw_plat_pcie_ep_raise_irq,
 	.get_features = dw_plat_pcie_get_features,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 90a5b1215344..e36941ff7cf6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -196,7 +196,7 @@ struct dw_pcie_ep_ops {
 
 struct dw_pcie_ep {
 	struct pci_epc		*epc;
-	struct dw_pcie_ep_ops	*ops;
+	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-- 
2.17.1

