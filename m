Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D48C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5521473
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DiU7+pdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfCYIhu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:37:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52388 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbfCYIht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:37:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8bSiI106731;
        Mon, 25 Mar 2019 03:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553503048;
        bh=mRZ/N3tIORcVcdf8U0MRLHXGRFmU8jONue5muhGax30=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DiU7+pdX8DwYX/IK1tcEm694NGt19dsDWnA7hYwR/wFML+l2gmI6hw6hiZnBxBqwr
         4RYeLHxzdOQST4Sdw4a6GXHXRclqT79ZdStJPYFZfwOuLvt/OcZA8InP/r6giJrRSw
         PcOZLVSC3p6n576wOEmMnaE7wRHjWvGD/Us/DzBE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8bSMV017860
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:37:28 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:37:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:37:28 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsG3006534;
        Mon, 25 Mar 2019 03:37:24 -0500
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
Subject: [PATCH v2 21/26] PCI: dwc: Add callbacks for accessing dbi2 address space
Date:   Mon, 25 Mar 2019 14:04:56 +0530
Message-ID: <20190325083501.8088-22-kishon@ti.com>
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

Certain platforms like TI's AM654 doesn't have separate address space for
dbi2 instead they are accessed using the same address space as dbi
with some configuration bit set. In order to support such platforms,
add callbacks for accessing dbi2 address space.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 31 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 12 ++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4e2f7946da89..d7cc1a0c1de6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -89,6 +89,37 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
 
+u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			size_t size)
+{
+	int ret;
+	u32 val;
+
+	if (pci->ops->read_dbi2)
+		return pci->ops->read_dbi2(pci, base, reg, size);
+
+	ret = dw_pcie_read(base + reg, size, &val);
+	if (ret)
+		dev_err(pci->dev, "read DBI address failed\n");
+
+	return val;
+}
+
+void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			  size_t size, u32 val)
+{
+	int ret;
+
+	if (pci->ops->write_dbi2) {
+		pci->ops->write_dbi2(pci, base, reg, size, val);
+		return;
+	}
+
+	ret = dw_pcie_write(base + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "write DBI address failed\n");
+}
+
 static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e36941ff7cf6..7abca9eb00bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -218,6 +218,10 @@ struct dw_pcie_ops {
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			     size_t size, u32 val);
+	u32     (*read_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			     size_t size);
+	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
@@ -249,6 +253,10 @@ u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		       size_t size);
 void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 			 size_t size, u32 val);
+u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			size_t size);
+void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			  size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
@@ -292,12 +300,12 @@ static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
 
 static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, val);
+	__dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
+	return __dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
 }
 
 static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
-- 
2.17.1

