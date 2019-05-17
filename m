Return-Path: <SRS0=S6xX=TR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8337C04AB4
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71B92089E
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 12:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qj/2P0IY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfEQMjb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 May 2019 08:39:31 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9653 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfEQMjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 08:39:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdeab580000>; Fri, 17 May 2019 05:38:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 05:39:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 05:39:30 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:39:30 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:39:29 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 May 2019 12:39:29 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdeab7b0001>; Fri, 17 May 2019 05:39:29 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V7 02/15] PCI: Disable MSI for Tegra194 root port
Date:   Fri, 17 May 2019 18:08:33 +0530
Message-ID: <20190517123846.3708-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517123846.3708-1-vidyas@nvidia.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558096728; bh=HSVuj7isNNLisx5nM09rg6tTu0ozPxsXBWfH15LevhU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qj/2P0IY9G8DF5KjvSznVd9FT16mrDjVXV0xfi1/7AqJWk4srJu8APDjKeHT3v2kr
         ISuTzQD8xVe+2gPcABPsZw2y3OE9xe+XQ+JVn57E81k4homBCm7TsIN3ZPljRT454F
         /J/0VyvZ6Mo/k7SW4vMrTjH5ZRq64JdK7ai6ebnX6Ugr3tqovLUe+i2uM9+diVjjCF
         0utAnriSb0poPoBtGIH5lS76uXhFCG2zb8Tci5H30r6gmHSGM4gxGnZSLdZwxKFzY3
         5vwgh35nwqUGbHfDJ2RboEi+QBponQxGTDbZ72POiqPzC52K4EwJMxatpH1hcCySu9
         cNY71x5qipEOQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra194 rootports don't generate MSI interrupts for PME events and hence
MSI needs to be disabled for them to avoid root ports service drivers
registering their respective ISRs with MSI interrupt.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v6]:
* This is a new patch

 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f16acc323c6..28f9a0380df5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2592,6 +2592,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			PCI_DEVICE_ID_NVIDIA_NVENET_15,
 			nvenet_msi_disable);
 
+/*
+ * Tegra194's PCIe root ports don't generate MSI interrupts for PME events
+ * instead legacy interrupts are generated. Hence, to avoid service drivers
+ * registering their respective ISRs for MSIs, need to disable MSI interrupts
+ * for root ports.
+ */
+static void disable_tegra194_rp_msi(struct pci_dev *dev)
+{
+	dev->no_msi = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0, disable_tegra194_rp_msi);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1, disable_tegra194_rp_msi);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2, disable_tegra194_rp_msi);
+
 /*
  * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
  * config register.  This register controls the routing of legacy
-- 
2.17.1

