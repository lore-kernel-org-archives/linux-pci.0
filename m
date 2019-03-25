Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D3C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240992087E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gJQ+yQEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfCYIhW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:37:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33998 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbfCYIhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:37:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8ajCH030863;
        Mon, 25 Mar 2019 03:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553503005;
        bh=Z5FsYHz2+eCaWuP/Fr5+/R+9oCvd7mzmcItqNVxbMQU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gJQ+yQEXu9b9udaGcXG/OL3a15kiZaOfNPDu/VsuhsuN6DIQKF95A4ZvkeBHbwcj4
         CMMO1rzAXxQv3TpHNKOyoNXCjEWuAyJRgfqKl8B4YuHmXjwt9PixjFrFCgT1pWnXZl
         0QUHwk+cx+rnM/yv9NWELUBCtGYJ7jt6dY1W/6mU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8ajHU088947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:36:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:36:45 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:36:45 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsFr006534;
        Mon, 25 Mar 2019 03:36:41 -0500
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
Subject: [PATCH v2 11/26] PCI: dwc: Fix ATU identification for designware version >= 4.80
Date:   Mon, 25 Mar 2019 14:04:46 +0530
Message-ID: <20190325083501.8088-12-kishon@ti.com>
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

Synopsys designware version >= 4.80 uses a separate register space
for programming ATU. The current code identifies if there exists a
separate register space by accessing the register address of ATUs
in designware version < 4.80. Accessing this address results in
abort in the case of K2G.

Fix it here by adding "version" member to struct dw_pcie. This should
be set by platform specific drivers and designware core will use it
to identify if the platform has a separate ATU space. For platforms
which hasn't populated the version member, the old method of
identification will still be used.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 14 ++++++++------
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a14ca00f72aa..4e2f7946da89 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -358,13 +358,15 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
-	/* Get iATU unroll support */
-	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-	dev_dbg(pci->dev, "iATU unroll: %s\n",
-		pci->iatu_unroll_enabled ? "enabled" : "disabled");
+	if (pci->version >= 0x480A || (!pci->version &&
+				       dw_pcie_iatu_unroll_enabled(pci))) {
+		pci->iatu_unroll_enabled = true;
+		if (!pci->atu_base)
+			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+	}
+	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
+		"enabled" : "disabled");
 
-	if (pci->iatu_unroll_enabled && !pci->atu_base)
-		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 
 	ret = of_property_read_u32(np, "num-lanes", &lanes);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ca3a3190a6f5..90a5b1215344 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -234,6 +234,7 @@ struct dw_pcie {
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
+	unsigned int		version;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.17.1

