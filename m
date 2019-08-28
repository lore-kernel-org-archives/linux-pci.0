Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834C8C3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E3622CED
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bNPPEbcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfH1NPQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:15:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16239 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1NPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:15:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d667e650000>; Wed, 28 Aug 2019 06:15:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 06:15:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 06:15:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:14 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 13:15:14 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d667e5e0000>; Wed, 28 Aug 2019 06:15:14 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 0/6] PCI: tegra: Enable PCIe C5 controller of Tegra194 in p2972-0000 platform
Date:   Wed, 28 Aug 2019 18:44:59 +0530
Message-ID: <20190828131505.28475-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566998117; bh=6gE8JO5jHpwhTw643om2gL+eYxt+1gqjrcc+vk+Bz10=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=bNPPEbcr+r+cMKTDSkKzK3gEmx4poL2ucpuWpuvcSkyCpliAvdeHrpF7CZCU93/Gk
         uNNAyIh++t4R+FhG6gtUGfEdQebatulERdWJgs/gXLzVas5YZ+WKyPB7ic0qalJf0r
         Ajk1uHov8kWYYmTZTXO1eKBtuXqRu7bGT6GxLF6v4125OboMyt8wbRCsaF8MhDdN8A
         yYEABiCfN+R7vPXJCJ4tHtKDo/sxtfeXyMR5xuutDSM7cnd5ber/qpl0OermQfS14V
         JA7wX9USzmLh2pcWZZC3zTLHPjd6rx4SF3kLV0Vd1LSWJzLHwRDCBjhvaTte6km5V7
         gbe/mLMYwCnLw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series enables Tegra194's C5 controller which owns x16 slot in
p2972-0000 platform. C5 controller's PERST# and CLKREQ# are not configured as
output and bi-directional signals by default and hence they need to be
configured explicitly. Also, x16 slot's 3.3V and 12V supplies are controlled
through GPIOs and hence they need to be enabled through regulator framework.
This patch series adds required infrastructural support to address both the
aforementioned requirements.
Testing done on p2972-0000 platform
- Able to enumerate devices connected to x16 slot (owned by C5 controller)
- Enumerated device's functionality verified
- Suspend-Resume sequence is verified with device connected to x16 slot

V2:
* Changed the order of patches in the series for easy merging
* Addressed review comments from Thierry Reding and Andrew Murray

Vidya Sagar (6):
  dt-bindings: PCI: tegra: Add sideband pins configuration entries
  dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
  PCI: tegra: Add support to configure sideband pins
  PCI: tegra: Add support to enable slot regulators
  arm64: tegra: Add configuration for PCIe C5 sideband signals
  arm64: tegra: Add PCIe slot supply information in p2972-0000 platform

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 16 ++++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 24 +++++
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 38 +++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 91 ++++++++++++++++++-
 5 files changed, 169 insertions(+), 4 deletions(-)

-- 
2.17.1

