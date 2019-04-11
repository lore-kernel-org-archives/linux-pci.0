Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6006DC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CA220818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I1plJej5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDKRE0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:04:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11607 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKRE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:04:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf739e0000>; Thu, 11 Apr 2019 10:04:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:04:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:04:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:25 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:24 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:04:21 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 00/30] Enable Tegra PCIe root port features
Date:   Thu, 11 Apr 2019 22:33:25 +0530
Message-ID: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002270; bh=hexCZTaTUTtvS9oIb69307gafhgrxvyTiowA5xxMF/s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=I1plJej5Ksy09GTvueJvZ6Wf0phDIMcAt2uubTS9DwuzTimYAhHI47FKkQVHAzujm
         YeufuDpJQysqPJ+k4Z9cBaKksxOxa3WCtc0BGFxqzoKUmjHj7Qeo0ozoCEemMf+Q1R
         iJwpskmKzBNg/Lh0eur14ASAHmtsXyPusPpqu/vB5JZPxSkAwH5jBCujz0AXBRDtC9
         gMN7lQjF/dzg03upPyvMZTkoisMrW03aNdAhhwXxLyXQs1kFSIUPyXcFuM3BXBGbgy
         eZekCl3wZh3ON6DrlWEmaS+lBCnR4ZnyZMjHu3jM1WKbyf/Z5YenLElrk8kzjGBZbG
         /8mdoGstEL0YQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds,
- Tegra root port features like Gen2, AER, etc
- Power and perf optimizations
- Fixes like "power up sequence", "dev_err prints", etc

These series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
based Jetson-TX1 and T124 based Jetson-TK1 platforms.

Manikanta Maddireddy (30):
  soc/tegra: pmc: Export tegra_powergate_power_on()
  PCI: tegra: Fix PCIe host power up sequence
  PCI: tegra: Move REFCLK pad settings out of phy_power_on()
  PCI: tegra: Add PCIe Gen2 link speed support
  PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
  PCI: tegra: Program UPHY electrical settings for Tegra210
  PCI: tegra: Enable opportunistic update FC and ACK
  PCI: tegra: Disable AFI dynamic clock gating
  PCI: tegra: Process pending DLL transactions before entering L1 or L2
  PCI: tegra: Enable PCIe xclk clock clamping
  PCI: tegra: Increase the deskew retry time
  PCI: tegra: Add SW fixup for RAW violations
  PCI: tegra: Update flow control threshold in Tegra210
  PCI: tegra: Set target speed as Gen1 before link up
  PCI: tegra: Fix PLLE powerdown issue due to CLKREQ# signal
  PCI: tegra: Program AFI_CACHE* registers only for Tegra20
  PCI: tegra: Use switch statements in tegra_pcie_isr()
  PCI: tegra: Change PRSNT_SENSE irq log to debug
  PCI: tegra: Use legacy irq for port service drivers
  PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
  PCI: tegra: Add "pci" type check before parsing child device tree node
  PCI: tegra: Access endpoint config only if PCIe link is up
  dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
  arm64: tegra: Add PEX DPD states as pinctrl properties
  PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
  dt-bindings: pci: tegra: Document nvidia,plat-gpios optional prop
  PCI: tegra: Add support to configure platform GPIOs
  dt-bindings: pci: tegra: Document nvidia,rst-gpio optional prop
  PCI: tegra: Add support for GPIO based PCIe reset
  PCI: tegra: Change link retry log level to INFO

 .../bindings/pci/nvidia,tegra20-pcie.txt      |  15 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
 drivers/pci/controller/pci-tegra.c            | 696 ++++++++++++++++--
 drivers/soc/tegra/pmc.c                       |   1 +
 4 files changed, 656 insertions(+), 75 deletions(-)

-- 
2.17.1

