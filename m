Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86620C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580722086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f3sD6HNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfANLQR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:16:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45328 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfANLQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:16:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBFtlh112673;
        Mon, 14 Jan 2019 05:15:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464555;
        bh=UxFV2AA/OxJ+RGbF6mGrC+ScIM/GAuGJn+bhMgD6qEM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f3sD6HNCShsAqDvvThjSjSh6ZV9XuUzizQl/De5staAp3gWhblDVfYwrVM1Y0IDdA
         o1SAZutWn5iPD4M8o4mwKYlYdj6cde9/5AYd6VpmoZfxB5RqDKrOHQEJnHzXuIe8vC
         7SygVG2L7ogoCeO1wWEVIMvv5ADDygDOrOcF8Mvw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBFtSu107903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:15:55 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:15:55 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:15:54 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1V011560;
        Mon, 14 Jan 2019 05:15:51 -0600
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
Subject: [PATCH v2 03/15] PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
Date:   Mon, 14 Jan 2019 16:45:01 +0530
Message-ID: <20190114111513.21618-4-kishon@ti.com>
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

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by Designware PCIe endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index c12bf794d69c..bd0516afc86f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -100,9 +100,22 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features dw_plat_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+};
+
+static const struct pci_epc_features*
+dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &dw_plat_pcie_epc_features;
+}
+
 static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dw_plat_pcie_ep_init,
 	.raise_irq = dw_plat_pcie_ep_raise_irq,
+	.get_features = dw_plat_pcie_get_features,
 };
 
 static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
-- 
2.17.1

