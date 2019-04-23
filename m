Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC650C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CABE21738
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZRMgqf6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfDWJ3m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7602 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDWJ3l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedb010001>; Tue, 23 Apr 2019 02:29:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 02:29:41 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:40 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:29:37 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 16/28] PCI: tegra: Set target speed as Gen1 before starting LTSSM
Date:   Tue, 23 Apr 2019 14:58:13 +0530
Message-ID: <20190423092825.759-17-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011778; bh=1kGwMkxpSLgFAK8z98H56LqvLRtl0az27vSt0CM3O2E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZRMgqf6bLPjIOMwptz9MBFfPgIWJ/4Nn1qMD1Fi3eVNYKc1o+qwH7/i5fDKHCFO+r
         E6u7AmD4GXLevPoGhn53QfvHELRHvdwBuImZPX7e932t0zQynF4a5xUrH8jPd8hAA2
         j97lOsxLFzuWlAZw4J/OgZvgR1mweEzUIski2Ug5MwCsVMvx8W55xPqzRpCe6kiBLz
         VkKR2P350ugj8UXfnbhKGQtSukmu3WoVL4UENFeGFmnOa2tSVCwpKg/34HhRd8t5up
         iQ6Ir7+Vx1AbNYqB8suxuFHPoOG2hrB1ickHTsgXGm910x7CA89uEzZU/AJSBrKBR4
         52jHn500KbKgg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe link up fails with few legacy endpoints if root port advertises both
Gen-1 and Gen-2 speeds in Tegra. This is because link number negotiation
fails if both Gen1 & Gen2 are advertised. Tegra doesn't retry link up by
advertising only Gen1. Hence, the strategy followed here is to initially
advertise only Gen-1 and after link is up, retrain link to Gen-2 speed.

Tegra doesn't support HW autonomous speed change. Link comes up in Gen1
even if Gen2 is advertised, so there is no downside of this change.

This behavior is observed with following two PCIe devices on Tegra,
 - Fusion HDTV 5 Express card
 - IOGear SIL - PCIE - SATA card

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Updated commit log to reflect why this issue is observed on Tegra with
these particular cards

 drivers/pci/controller/pci-tegra.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 7ab7d1387357..0de24cb66a71 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -676,6 +676,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= soc->update_fc_threshold;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	/*
+	 * PCIe link doesn't come up with few legacy PCIe endpoints if
+	 * root port advertises both Gen-1 and Gen-2 speeds in Tegra.
+	 * Hence, the strategy followed here is to initially advertise
+	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
+	 */
+	value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
+	value &= ~PCI_EXP_LNKSTA_CLS;
+	value |= PCI_EXP_LNKSTA_CLS_2_5GB;
+	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
-- 
2.17.1

