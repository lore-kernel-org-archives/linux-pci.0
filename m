Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BCECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092B2152B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M0T8xvuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3092B2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJQPhS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42316 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJQPhS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:18 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gXme017791;
        Wed, 17 Oct 2018 02:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762153;
        bh=aItukt+zC3Oklbc7KmFNHQG4jcnzszJmv7YP4k1EJxc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=M0T8xvuAFp8pdkSTvZ8i/TegdB2p6M0j1MWliQ261M1SoSudUfdjHvc1e8rZp++1P
         JBpicWvPk1YAdPraejp+rSr9WiTqKIjUHZai2G2gIdA934YnYqGpllDbmrzGugSeK/
         NZlXoeSK7/Nt+3fwni6h/ckhujxbtIgL8B+TYEEw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gXo4009568;
        Wed, 17 Oct 2018 02:42:33 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:33 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:32 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSZ009413;
        Wed, 17 Oct 2018 02:42:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 14/21] PCI: keystone: Get number of outbound windows from DT
Date:   Wed, 17 Oct 2018 13:11:07 +0530
Message-ID: <20181017074114.28239-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of having a fixed outbound window count, get the number of
outbound windows from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 1f14de0ef27f..608e40c4b991 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -54,7 +54,6 @@
 
 #define OB_SIZE				0x030
 #define CFG_PCIM_WIN_SZ_IDX		3
-#define CFG_PCIM_WIN_CNT		32
 #define SPACE0_REMOTE_CFG_OFFSET	0x1000
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
@@ -111,6 +110,7 @@ struct keystone_pcie {
 	int			num_msi_host_irqs;
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
 	int			num_lanes;
+	u32			num_viewport;
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
@@ -341,6 +341,7 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
+	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	u32 start = pp->mem->start, end = pp->mem->end;
@@ -359,7 +360,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
+	for (i = 0; (i < num_viewport) && (start < end); i++) {
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
 		start += tr_size;
@@ -898,6 +899,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
 	char name[10];
@@ -915,6 +917,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
+	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
+	if (ret < 0) {
+		dev_err(dev, "unable to read *num-viewport* property\n");
+		return ret;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
@@ -949,6 +957,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	ks_pcie->pci = pci;
 	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
+	ks_pcie->num_viewport = num_viewport;
 	ks_pcie->phy = phy;
 
 	ret = ks_pcie_enable_phy(ks_pcie);
-- 
2.17.1

