Return-Path: <SRS0=bzeM=UR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F80C31E5B
	for <linux-pci@archiver.kernel.org>; Tue, 18 Jun 2019 18:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F129206B7
	for <linux-pci@archiver.kernel.org>; Tue, 18 Jun 2019 18:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N4tsu3GZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfFRSCR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:02:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12465 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSCQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:02:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927280000>; Tue, 18 Jun 2019 11:02:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:02:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:02:15 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:15 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:02:12 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 00/27] Enable Tegra PCIe root port features
Date:   Tue, 18 Jun 2019 23:31:39 +0530
Message-ID: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880936; bh=BcALiKmLvUfe+LlZIDQ4JqaZ+0Ps22RbUxVRHExJOuY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=N4tsu3GZyYs3hTHmn8m90v0CWBIpQ15zqWTW/7yRcSMbrO88xU1OciQGwC725sBUZ
         JNfRXy5JzVdIffOA08Ef5KP6LgivVudGVDLrwvIYSIpKikqmHHE+cU01WA1MSJzsMe
         1fkfcSUTDGvxwP53T2lPiD8/r4D43UFGhEefDBUAhOddu9TTKzF2Th5Lhu5U5LNqw9
         N8h6b0sNiMIWZm5PrYBZBkE6ajNDpX3neCBDmEXpu2w64DgtTTUHq7ecZw5qLRrmw9
         noB69GA4wwLMgdX7sEw2fZ3gOTveJuQBPgXTgxNDxE2spXlXNwC00KqxC5iWTNfrMQ
         8lmGbahPRMdxA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds,
- Tegra root port features like Gen2, AER, etc
- Power and perf optimizations
- Fixes like "power up sequence", "dev_err prints", etc

This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
based Jetson-TX1, T124 based Jetson-TK1, Tegra20 and Tegra30 platforms.

Changes from V5 to V6:
  - Patch [V4, 20/27]: Replaced pcie_pme_disable_msi() with no_msi quirk

Changes from V4 to V5:
 - Patch [V4, 4/28]: Added blank line before block style comment
 - Patch [V4, 22/28]: "Access endpoint config only if PCIe link is up"
patch is dropped
 - Patch [V4, 27/28]:
* Updated reset gpio toggle logic to reflect active low usage
* Replaced kasprintf() with devm_kasprintf()
* Updated commit message with more information.

Changes from V3 to V4:
 - Patch [V3,27/29] is dropped
 - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
   pci-tegra driver instead of of_get_pci* wrapper function defined in
   Patch [V3,27/29].

Manikanta Maddireddy (27):
  soc/tegra: pmc: Export tegra_powergate_power_on()
  PCI: tegra: Handle failure cases in tegra_pcie_power_on()
  PCI: tegra: Rearrange Tegra PCIe driver functions
  PCI: tegra: Mask AFI_INTR in runtime suspend
  PCI: tegra: Fix PCIe host power up sequence
  PCI: tegra: Add PCIe Gen2 link speed support
  PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
  PCI: tegra: Program UPHY electrical settings for Tegra210
  PCI: tegra: Enable opportunistic UpdateFC and ACK
  PCI: tegra: Disable AFI dynamic clock gating
  PCI: tegra: Process pending DLL transactions before entering L1 or L2
  PCI: tegra: Enable PCIe xclk clock clamping
  PCI: tegra: Increase the deskew retry time
  PCI: tegra: Add SW fixup for RAW violations
  PCI: tegra: Update flow control timer frequency in Tegra210
  PCI: tegra: Set target speed as Gen1 before starting LTSSM
  PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
  PCI: tegra: Program AFI_CACHE* registers only for Tegra20
  PCI: tegra: Change PRSNT_SENSE IRQ log to debug
  PCI: tegra: Disable MSI for Tegra PCIe root port
  PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
  dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
  arm64: tegra: Add PEX DPD states as pinctrl properties
  PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
  PCI: Add DT binding for "reset-gpios" property
  PCI: tegra: Add support for GPIO based PERST#
  PCI: tegra: Change link retry log level to debug

 .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
 Documentation/devicetree/bindings/pci/pci.txt |   3 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
 drivers/pci/controller/pci-tegra.c            | 578 +++++++++++++++---
 drivers/pci/quirks.c                          |  39 ++
 drivers/soc/tegra/pmc.c                       |   1 +
 6 files changed, 568 insertions(+), 80 deletions(-)

-- 
2.17.1

