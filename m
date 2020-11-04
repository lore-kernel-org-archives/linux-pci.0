Return-Path: <SRS0=vddI=EK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2C7C2D0A3
	for <linux-pci@archiver.kernel.org>; Wed,  4 Nov 2020 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F81216C4
	for <linux-pci@archiver.kernel.org>; Wed,  4 Nov 2020 08:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pRAaalLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgKDIwd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 4 Nov 2020 03:52:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6017 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgKDIwd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 03:52:33 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa26bd00000>; Wed, 04 Nov 2020 00:52:32 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 08:52:29 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Nov 2020 08:52:25 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 3/5] PCI: tegra: Set DesignWare IP version
Date:   Wed, 4 Nov 2020 14:20:16 +0530
Message-ID: <20201104085018.13021-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104085018.13021-1-vidyas@nvidia.com>
References: <20201104085018.13021-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604479952; bh=vQOp09k8Olf7pGN54LhCH3GMJTN3ReO8f6pSXafBmVc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=pRAaalLvdnzxFZ7tmAVZRSxBZ7S5qIQHUxwJ8/U/K8iw73G5yTilDuIXTSyp4rG/4
         v5E9WyW11VzQCEyPY7RY6r224imkxk3wNQamF/AMsr5CM8ZyDxxsTBs+1SNo0y3W+J
         8j4qYUuoYl2D2E7XwoDPvIB0JTKHF7piN/oodXmIZMWYhZCgv4grDeHYj5tgBbMq0I
         dnB5uH+grqrAeFMSFGAfC5pWv20BxUfgkZn3qVR6Zd7aNBIDy3Kb0C1AomkAnwBsaL
         5Je+0vxT+QvecKIeXY4SdkuoU24jHeN59S9esnP395wObN9Wn6JQTxjXWBFljpWxNp
         +cjb1t9B/QdsQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the DesignWare IP version for Tegra194 to 0x490A. This would be used
by the DesigWare sub-system to do any version specific configuration
(Ex:- TD bit programming for ECRC).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7a0c64436861..253d91033bc3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2011,6 +2011,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci->ops = &tegra_dw_pcie_ops;
 	pci->n_fts[0] = N_FTS_VAL;
 	pci->n_fts[1] = FTS_VAL;
+	pci->version = 0x490A;
 
 	pp = &pci->pp;
 	pcie->dev = &pdev->dev;
-- 
2.17.1

