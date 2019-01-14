Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B856C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5F20651
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ogUqVufQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfANN0m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:26:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37436 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfANN0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 08:26:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDPimd098134;
        Mon, 14 Jan 2019 07:25:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547472345;
        bh=D3SpjZ5R1aRjfVZ7VM2I5QEfz4WOvJBUIsbp05h8aqY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ogUqVufQPF4gH6zHydPgoxdYDw/n+mQCs5EYKOMAVsJV0lAmfpZtpIUkjhHPmFqcN
         Dsli75pOExCF7Gc5hFeGXpulA4twdXnrTKmiXS2C37scp/zqNcgn2+z50ptGDA/rhc
         c2ZW7+Rtpdr22l/bkYPZqGa/1pi6B3vRQeIj9iMo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDPi0Y056711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:25:44 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:44 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:44 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWW028516;
        Mon, 14 Jan 2019 07:25:40 -0600
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
Subject: [PATCH 10/24] PCI: dwc: Enable iATU unroll for endpoint too
Date:   Mon, 14 Jan 2019 18:54:10 +0530
Message-ID: <20190114132424.6445-11-kishon@ti.com>
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
index 7a2925a16ab8..d5144781005b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -515,10 +515,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
index d7184e1a7d92..1fb7eece78ab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -629,17 +629,6 @@ static struct pci_ops dw_pcie_ops = {
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
@@ -693,14 +682,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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
index 93ef8c31fb39..78539452c265 100644
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

