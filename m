Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FDBC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A362E2086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SE0tiVNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfANLR2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:17:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45784 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfANLR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:17:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGblh003669;
        Mon, 14 Jan 2019 05:16:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464597;
        bh=f30RSmXMqhsV1n1NfMeTlD3ATOBh5scl1ryG7fV6mJI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SE0tiVNds2+gqS/c938UfuIh4RziUQlz0qIL3A7BOUs4UPPVZsTUrInYOZLGKCRPA
         AhXMi31NfnwdASFvt8lRbTqLHuaXkMHtz76Sm1Tvsif4QBxMde/Rwz4dL5w0zX7/t/
         8QLsTIPUM4k4wtzNWwAtCXOv0zfW582SCAxJnS6c=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGbdY068044
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:37 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:37 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:37 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1g011560;
        Mon, 14 Jan 2019 05:16:33 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 14/15] PCI: designware-plat: Remove setting epc->features in Designware plat EP driver
Date:   Mon, 14 Jan 2019 16:45:12 +0530
Message-ID: <20190114111513.21618-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that pci-epf-test uses get_features callback and
dw_plat_pcie_epc_features in Designware plat EP driver already indicates
it doesn't support linkup notification and is MSIX capable, remove setting
epc->features which is not used anymore by the endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index bd0516afc86f..3be87126aef3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -70,14 +70,10 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct pci_epc *epc = ep->epc;
 	enum pci_barno bar;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
-
-	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
-	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;
 }
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-- 
2.17.1

