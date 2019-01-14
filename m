Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2871DC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1DB20656
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="enDfy+2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfANLQc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:16:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46868 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfANLQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:16:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBG31j065515;
        Mon, 14 Jan 2019 05:16:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464563;
        bh=B87URmk8FxmkzbOiUN33pM2ksJFStfqzKpKRhu9JNSU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=enDfy+2CkwQlJL5pG2orA0+8L0UPvpQC1aO4S9pOm3q70K2elptWNMrgClYxz/sxs
         NyoXk01Vo8+2jA0CHMl8uYbD/XQsNaatfWfT9N4/UplnCxo3jhWfDGl61lynfv7kqB
         zj9HxLt0SWxx8Aammbv01fyrS46OvNuip7Tv+9+c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBG3NH067318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:03 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:02 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1X011560;
        Mon, 14 Jan 2019 05:15:59 -0600
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
Subject: [PATCH v2 05/15] PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
Date:   Mon, 14 Jan 2019 16:45:03 +0530
Message-ID: <20190114111513.21618-6-kishon@ti.com>
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
supported by Rockchip PCIe endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index b8163c56a142..9b60ad323ac7 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -505,6 +505,18 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static const struct pci_epc_features rockchip_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+rockchip_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	return &rockchip_pcie_epc_features;
+}
+
 static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.write_header	= rockchip_pcie_ep_write_header,
 	.set_bar	= rockchip_pcie_ep_set_bar,
@@ -515,6 +527,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.get_msi	= rockchip_pcie_ep_get_msi,
 	.raise_irq	= rockchip_pcie_ep_raise_irq,
 	.start		= rockchip_pcie_ep_start,
+	.get_features	= rockchip_pcie_ep_get_features,
 };
 
 static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
-- 
2.17.1

