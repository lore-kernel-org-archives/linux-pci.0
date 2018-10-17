Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B35ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E240C21526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dTJ1aJIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E240C21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJQPgo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:36:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56410 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:36:43 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7g0ad022831;
        Wed, 17 Oct 2018 02:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762120;
        bh=3AdF0VMpgtkV9yWrrnXvabWcf4Spt+07w4PmTvQYyH8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dTJ1aJIpyTli+QbK/3XU+bgaqeqvI7/5NdCJMUsUMcHJ7NhBI6/qLXfB18kBWg5Jr
         CjQP+kiX1LHP0u7deGcY+nVNF8wRdgX4HhmEz+Cpv/phBvKVVqp9XDmQkYTMK+M91z
         BmdABzLeG9sh5F3lHsZF2esYnRRL8b6B19ESguDQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fx5O023348;
        Wed, 17 Oct 2018 02:41:59 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:41:59 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:41:59 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSP009413;
        Wed, 17 Oct 2018 02:41:56 -0500
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
Subject: [PATCH v2 04/21] PCI: keystone: Do not initiate link training multiple times
Date:   Wed, 17 Oct 2018 13:10:57 +0530
Message-ID: <20181017074114.28239-5-kishon@ti.com>
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

