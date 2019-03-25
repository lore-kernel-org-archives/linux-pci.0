Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF680C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D402085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kPQIPx/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfCYIhL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:37:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54906 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbfCYIhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:37:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8afY8106641;
        Mon, 25 Mar 2019 03:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553503001;
        bh=opMCiGPkYZm6/8E3Wl0dThxDMvrUVywCg5P4fMf+/IA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kPQIPx/UDDci6RiYgjXPaKVdYpLX5WScnkwFrs4fuBVhsCYgSkWKT4RqnIUqBFZCn
         Rf2KUjQ8BgWH1VI9v1VetbYcwWjOjYlVl8LW8IllCLIqDWTpBmwbgfh/2HfF1rZom7
         9/klJkdyMB+3DEPh4mRmjHp571yjUA6OiMBjkaMY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8afOL092022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:36:41 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:36:41 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:36:41 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsFq006534;
        Mon, 25 Mar 2019 03:36:37 -0500
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
Subject: [PATCH v2 10/26] PCI: dwc: Enable iATU unroll for endpoint too
Date:   Mon, 25 Mar 2019 14:04:45 +0530
Message-ID: <20190325083501.8088-11-kishon@ti.com>
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

iatu_unroll_enabled flag is set only for Designware in host mode.
However iATU unroll can be applicable for endpoint mode too. Set
iatu_unroll_enabled flag in dw_pcie_setup which is common for
both host mode and endpoint mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 ----
 .../pci/controller/dwc/pcie-designware-host.c | 19 -------------------
 drivers/pci/controller/dwc/pcie-designware.c  | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 24f5a775ad34..dc6a4bbd3ace 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -517,10 +517,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
 		return -EINVAL;
 	}
-	if (pci->iatu_unroll_enabled && !pci->atu_base) {
-		dev_err(dev, "atu_base is not populated\n");
-		return -EINVAL;
-	}
 
 	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
 	if (ret < 0) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7e0ff7d428a9..7bf6558341b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -608,17 +608,6 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
-	if (val == 0xffffffff)
-		return 1;
-
-	return 0;
-}
-
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
@@ -672,14 +661,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		/* Get iATU unroll support */
-		pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-		dev_dbg(pci->dev, "iATU unroll: %s\n",
-			pci->iatu_unroll_enabled ? "enabled" : "disabled");
-
-		if (pci->iatu_unroll_enabled && !pci->atu_base)
-			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
-
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 31f6331ca46f..a14ca00f72aa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -339,6 +339,17 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
 
+static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+	if (val == 0xffffffff)
+		return 1;
+
+	return 0;
+}
+
 void dw_pcie_setup(struct dw_pcie *pci)
 {
 	int ret;
@@ -347,6 +358,14 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
+	/* Get iATU unroll support */
+	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
+	dev_dbg(pci->dev, "iATU unroll: %s\n",
+		pci->iatu_unroll_enabled ? "enabled" : "disabled");
+
+	if (pci->iatu_unroll_enabled && !pci->atu_base)
+		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+
 	ret = of_property_read_u32(np, "num-lanes", &lanes);
 	if (ret)
 		lanes = 0;
-- 
2.17.1

