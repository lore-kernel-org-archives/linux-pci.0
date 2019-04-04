Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F4C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F7B20882
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FhD3UKXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfDDTz2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:55:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13268 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDTz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:55:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca661240000>; Thu, 04 Apr 2019 12:55:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:55:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:55:27 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:55:27 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:55:26 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:55:26 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca661290000>; Thu, 04 Apr 2019 12:55:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 04/16] PCI: dwc: Perform dbi regs write lock towards the end
Date:   Fri, 5 Apr 2019 01:24:31 +0530
Message-ID: <1554407683-31580-5-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407716; bh=AYjR5Sxw9yO5wnMNWcJ13dfYsBX1HI6qoWUQmwALJDo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FhD3UKXWFiUYxnItKsUBqIJg35iVI9+iZzYx2LF1cUZja9YNoa2DBu5W6yhqtcd3S
         qU213gPPbKbR9J6AzxhrUzFwCh3OoDnxUOHG6CJo8ac9DTVFyuQiQSxT4eedWDjvVm
         cvW8JN3gv08p4sIlw3FTm68XjVfeIq8Ujwjywr/tsov/ZHnjnRCCNFXosl47NusbEP
         aGCOsdqjgT/iT+kuujMRwUGrFOF21z0iBKGT2KwSogGQnC4U0cLAN1lQ95AkQapR/X
         Xz68fjQsEvQQhUH22F6ivJyCIqxHWkkURojNTf16ZUQaI9m7upxYbaFLZRF4Jctkhq
         3TQ9GAzI/rJfA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove multiple write enable and disable sequences of dbi registers as
Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
DBI write-lock enable bit thereby not allowing any further writes to BAR-0
register in config space to take place. Hence disabling write permission
only towards the end.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v1]:
* None

 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2a5332e5ccfa..c0334c92c1a6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -683,7 +683,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val &= 0xffff00ff;
 	val |= 0x00000100;
 	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
-	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
@@ -723,8 +722,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
-	/* Enable write permission for the DBI read-only register */
-	dw_pcie_dbi_ro_wr_en(pci);
 	/* Program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
 	/* Better disable write permission right after the update */
-- 
2.7.4

