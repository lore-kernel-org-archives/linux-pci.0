Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82FDC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF5B20645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mvGl3OdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDWI2I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:28:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2633 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfDWI2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 04:28:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbecc930001>; Tue, 23 Apr 2019 01:28:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 01:28:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 01:28:06 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 08:28:06 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 08:28:06 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 08:28:06 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbecc910001>; Tue, 23 Apr 2019 01:28:05 -0700
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
Subject: [PATCH V4 04/16] PCI: dwc: Perform dbi regs write lock towards the end
Date:   Tue, 23 Apr 2019 13:57:18 +0530
Message-ID: <20190423082730.370-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423082730.370-1-vidyas@nvidia.com>
References: <20190423082730.370-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556008083; bh=KVElxKnY+pn1TE5FHBtkN0ZmcjQmHEyPBQbhjnXGwKw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mvGl3OdQiLLGXUs9+TLbNxpD2ftykBn3uU8KXiEhOBJ6XPjcz8FiQv/4CCuKo6F0W
         NprJzNj8yxJcMphHtnua+WY6zjJjeEpuiTSN7FRhd7s7TTPrWcGzM+xQPOYtOeetBc
         V8nyhnaF+o8HKphUiJ1jUN42EPyZzkGzQ2SLMsCQKlD3myFjSg9ZCguAmcc3Xk20tc
         VykbRdWxI8nf0oyGeRF2xVVnGb3AhAzK/XzJg9Rv38pQP3sXPj4/ctlr602Y23fRJ4
         sXvn+gfhBrULTZlvRroNyB/7xtekhQBFgaCpHH5m86Mge+I0TQO2PYpYfIk3Shwub1
         2fOYItc3daXVA==
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
Changes since [v3]:
* None

Changes since [v2]:
* None

Changes since [v1]:
* None

 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 36fd3f5b48f6..e5e3571dd2fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -654,7 +654,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val &= 0xffff00ff;
 	val |= 0x00000100;
 	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
-	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
@@ -686,8 +685,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
-	/* Enable write permission for the DBI read-only register */
-	dw_pcie_dbi_ro_wr_en(pci);
 	/* Program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
 	/* Better disable write permission right after the update */
-- 
2.17.1

