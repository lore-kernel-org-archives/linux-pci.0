Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43EC71130
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D5420842
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mSEePOxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D5420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJOUy2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:54:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38748 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeJOUxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 16:53:44 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FD8C1l119730;
        Mon, 15 Oct 2018 08:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539608892;
        bh=3AdF0VMpgtkV9yWrrnXvabWcf4Spt+07w4PmTvQYyH8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mSEePOxLDDPeC5VLFMwIzaewWuZBK7ZbIPNBbCQvFj1hWXTySTLxWaZJTHptRro3B
         DAKROCH86labCFOGWPTztonauFU9LsAWGrI6rg+A6TkanNsIOqgDEjsDpmCtZP16rQ
         pp3jSDa3TdXi/5Av/nkwUXAI7/2t4GP928ez1WbI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD8C3N032668;
        Mon, 15 Oct 2018 08:08:12 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 08:08:12 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 08:08:12 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD7tL7009433;
        Mon, 15 Oct 2018 08:08:09 -0500
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
Subject: [PATCH 04/19] PCI: keystone: Do not initiate link training multiple times
Date:   Mon, 15 Oct 2018 18:37:06 +0530
Message-ID: <20181015130721.5535-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 886bc5ceb5cc3ad4b219502d72 ("PCI: designware: Add generic
dw_pcie_wait_for_link()") while adding a generic dw_pcie_wait_for_link()
performed a special handling (initiate link training multiple times) for
keystone which is not required. This also resulted in unncessarily waiting
for more time to establish the link even when no PCI device is connected.

Remove it and make it look similar to other dwc based PCIe drivers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index afb948372077..aa7e706fc37d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -87,19 +87,17 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	unsigned int retries;
 
 	if (dw_pcie_link_up(pci)) {
 		dev_info(dev, "Link already up\n");
 		return 0;
 	}
 
+	ks_dw_pcie_initiate_link_train(ks_pcie);
+
 	/* check if the link is up or not */
-	for (retries = 0; retries < 5; retries++) {
-		ks_dw_pcie_initiate_link_train(ks_pcie);
-		if (!dw_pcie_wait_for_link(pci))
-			return 0;
-	}
+	if (!dw_pcie_wait_for_link(pci))
+		return 0;
 
 	dev_err(dev, "phy link never came up\n");
 	return -ETIMEDOUT;
-- 
2.17.1

