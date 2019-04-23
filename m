Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976A5C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E3A20843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aKCTOOAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDWJ2i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:28:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7498 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDWJ2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:28:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedac20000>; Tue, 23 Apr 2019 02:28:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:28:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:28:37 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:28:37 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:28:34 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 00/28] Enable Tegra PCIe root port features
Date:   Tue, 23 Apr 2019 14:57:57 +0530
Message-ID: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011714; bh=//HyqROb7SQO5iuaGGrg6DOyTnAwi9meRg4SSL6bs94=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=aKCTOOAM94l5JpvY5ksASs6f5foR0wEdbcnEWYodW7yanvW5dIPXxAhBLlUuSUn21
         9ehaqR9A1yx37tqpwyHkK1qjSSKzhW60bNyK3sW3Tro5X8MtPXnieyjkL/Wz9gb3+D
         QaKTmk0UC1FPXFgNeFXzdNxKjpR5JGgsz6BW/w+0HFYw0lNIkxPz1h0YpLqR4ED46+
         2OnsDhErQl/f0c+wvopS4JJASZkk1gitX6XYF5zCJz4e9QvuxY3gIffkYtzoicex5C
         IfEcbPufZuabbzePargqo4AAojMq11Cuyw3q9a2ho96eXnXpWKqK3JzPbiFtDWe1uk
         ekXvFvuwTKF9w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds,
- Tegra root port features like Gen2, AER, etc
- Power and perf optimizations
- Fixes like "power up sequence", "dev_err prints", etc

This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
based Jetson-TX1 and T124 based Jetson-TK1 platforms.

TODO: I don't have T20 and T30 platforms to verify this series.
Thierry has kindly agreed to verify this series on T20 and T30.

V2 takes care of comments from Bjorn and Thierry.

Manikanta Maddireddy (28):
  soc/tegra: pmc: Export tegra_powergate_power_on()
  PCI: tegra: Handle failure cases in tegra_pcie_power_on()
  PCI: tegra: Rearrange Tegra PCIe driver functions
  PCI: tegra: Disable PCIe interrupts in runtime suspend
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
  PCI: tegra: Change PRSNT_SENSE irq log to debug
  PCI: tegra: Use legacy irq for port service drivers
  PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
  PCI: tegra: Access endpoint config only if PCIe link is up
  dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
  arm64: tegra: Add PEX DPD states as pinctrl properties
  PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
  dt-bindings: pci: tegra: Document reset-gpio optional prop
  PCI: tegra: Add support for GPIO based PCIe reset
  PCI: tegra: Change link retry log level to info

 .../bindings/pci/nvidia,tegra20-pcie.txt      |  13 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
 drivers/pci/controller/pci-tegra.c            | 605 +++++++++++++++---
 drivers/soc/tegra/pmc.c                       |   1 +
 4 files changed, 558 insertions(+), 80 deletions(-)

-- 
2.17.1

