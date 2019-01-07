Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C70C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9010B2146F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GpSd2ahK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfAGGoE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:44:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36794 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfAGGoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 01:44:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hDVM021658;
        Mon, 7 Jan 2019 00:43:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546843393;
        bh=7BZqM5lihQv/21d7TmC8rclZDArMN5iGSCdWQmZG2ac=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GpSd2ahKxWrTJHYfGwg4GDpLvKh0L4Hw63vMjt0GgWfYhz3t0Tlms+AU4zWrLNmv+
         suQe5kIkYsPpL4cwBCt8SHYsORNsaRcSB9X1+jEy1C0Zo4P0QB3MJMopHSQbN6gR11
         6dpkF2HyhJtqdvqNg+kowP9Zbcv+bUzeL6mc8r5g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hDEN038427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 00:43:13 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:13 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:13 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfo3002672;
        Mon, 7 Jan 2019 00:43:09 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH 06/15] PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
Date:   Mon, 7 Jan 2019 12:11:39 +0530
Message-ID: <20190107064148.10152-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by Cadence PCIe endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index c3a088910f48..14c2545bb17e 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -411,6 +411,18 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static const struct pci_epc_features cdns_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	return &cdns_pcie_epc_features;
+}
+
 static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.write_header	= cdns_pcie_ep_write_header,
 	.set_bar	= cdns_pcie_ep_set_bar,
@@ -421,6 +433,7 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_msi	= cdns_pcie_ep_get_msi,
 	.raise_irq	= cdns_pcie_ep_raise_irq,
 	.start		= cdns_pcie_ep_start,
+	.get_features	= cdns_pcie_ep_get_features,
 };
 
 static const struct of_device_id cdns_pcie_ep_of_match[] = {
-- 
2.17.1

