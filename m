Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A3C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 10:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8534C218A6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mFcoIGHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfAXKqP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:46:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55352 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfAXKqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 05:46:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OAkB25015903;
        Thu, 24 Jan 2019 04:46:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548326771;
        bh=LURlEazdlsViq/bSZlZwQimKeprMkOuAEx+h6N1PDkM=;
        h=From:To:CC:Subject:Date;
        b=mFcoIGHVFg6MclMIvWAmMGzkBNVhaN7gjna47o7PcBCUV/lfRirQYw6qc+3aldayq
         sSH1iw1b3D7JizremAcIM6yET6ainSdpE39NXDaZBqb2czza46+x1cHPxgs4nCx67N
         mxhhQxA8B3CSRLLYdmOcuTnpm3E7u5Cft0QClmFg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OAkBN6049658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 04:46:11 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 04:46:10 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 04:46:10 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OAk8TC003193;
        Thu, 24 Jan 2019 04:46:08 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: dra7xx: Invoke phy_set_mode API to set PHY mode to PHY_MODE_PCIE
Date:   Thu, 24 Jan 2019 16:15:37 +0530
Message-ID: <20190124104537.22271-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain PHYs used with PCIe controller can also be used with other
controllers such as USB or SATA. In order to configure the PHY
to work with PCIe controller, invoke phy_set_mode API with mode
set to PHY_MODE_PCIE.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index efb26096ccb5..b287dbf6914c 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -517,6 +517,10 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
 	int i;
 
 	for (i = 0; i < phy_count; i++) {
+		ret = phy_set_mode(dra7xx->phy[i], PHY_MODE_PCIE);
+		if (ret < 0)
+			goto err_phy;
+
 		ret = phy_init(dra7xx->phy[i]);
 		if (ret < 0)
 			goto err_phy;
-- 
2.17.1

