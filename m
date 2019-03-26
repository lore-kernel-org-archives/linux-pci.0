Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEEC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FC320857
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BJAuOBjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfCZPOV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:14:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4950 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZPOV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 11:14:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9a41c80000>; Tue, 26 Mar 2019 08:14:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 08:14:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 08:14:20 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 15:14:20 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 15:14:19 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 26 Mar 2019 15:14:19 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9a41c20000>; Tue, 26 Mar 2019 08:14:19 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <vidyas@nvidia.com>, <tiwai@suse.de>,
        <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
Subject: [PATCH 01/10] PCI: save pci_bus pointer in pcie_port structure
Date:   Tue, 26 Mar 2019 20:43:18 +0530
Message-ID: <1553613207-3988-2-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553613256; bh=ajoC/pclit004a1DH0iOXhHMxfdpECOLvK6JLTZhJKQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BJAuOBjyWFwg7r516BafCaDbsdk4nuDCtjbKFVYdWQNeiS8LJru9ZPI8ikHLj9juV
         TcQuoMNHDhQKSabahrxVHvJjiIEVep8dZEiKLUMHm7lcoa6vRSen5QUNl+Z5pcq34n
         bdLp896dGbpngZKf4qra/5FQiimAfzreB3NA6+bsuh1aTku15pQz4nqGi8wkuqolK+
         oHPIhnYNCyQptfGC021zgyhZcstzO+OpzL6uQJbzFR/0ntXVlBS+EN8YoAc8T5PwtU
         d17gtLE9aj7Hxos3j4xMYufCXwURFEsiytBExOh8PDJsJ6QRk9cca9V1PiK6HL9TVq
         AWnLvIjiC4qpg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

save pci_bus pointer created by PCIe sub-system's
pci_scan_root_bus_bridge() to be used by host controller drivers for post
processing. Tegra host controller driver needs it for the following
reasons
- to derive pci_host_bridge structure from pci_bus which is used to
configure iATU's outbound regions for different windows accesses
- to traverse and configure downstream hierarchy. One such case is,
configuring all immediate downstream devices to D0 state before transiting
link to L2 state. Saving pci_bus pointer seems the best method compared to
deriving it by other means.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 25087d3c9a82..15add3cf3945 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -494,6 +494,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		goto error;
 
 	bus = bridge->bus;
+	pp->bus = bus;
 
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 377f4c0b52da..70007276bc93 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -175,6 +175,7 @@ struct pcie_port {
 	struct resource		*busn;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
+	struct pci_bus		*bus;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
-- 
2.7.4

