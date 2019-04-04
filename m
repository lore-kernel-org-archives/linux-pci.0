Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A2C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEF220855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rmodcwim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfDDTyz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:54:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13215 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDTyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:54:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca661020001>; Thu, 04 Apr 2019 12:54:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:54:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:54:53 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:54:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:54:53 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca66107000c>; Thu, 04 Apr 2019 12:54:53 -0700
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
Subject: [PATCH V2 00/16] Add Tegra194 PCIe support
Date:   Fri, 5 Apr 2019 01:24:27 +0530
Message-ID: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407682; bh=W5eokYj10gfqFS8ZSwmG197RGajSR706MqOJmcH8sbw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=rmodcwimjl7tSOsPHf/sAyK7h2jJSQ+C+rGcMVcoSBhq0Kg3r5TN5mTuC6soYuZlW
         ShhQQ+3WL5zib546Fk9e1MwBZ2uk3XaFgtCp2MWNTUubGLpsb6/MLSNogC8xpy+MVA
         PJBQUV/wUz8Qh6c82CSgY1my9XbIOFzS3Bb64wviAKt1CsEkWjcJmIcxg+vIvt0qXH
         BoWt34Lpzf92QvmjW9LIAaqrdxux/qNwMebb4zb0zV9Djw8nklaYT+7yt/ySuH0tEG
         UxBiN0pDCH57/j4gd7cJDaHh4K7mCBlpCxSY63w8v/zhZvAmqR8o/s6rQPkP3x9pCp
         1jF77IkOkKUYA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra194 has six PCIe controllers based on Synopsys DesignWare core.
There are two Universal PHY (UPHY) blocks with each supporting 12(HSIO:
Hisg Speed IO) and 8(NVHS: NVIDIA High Speed) lanes respectively.
Controllers:0~4 use UPHY lanes from HSIO brick whereas Controller:5 uses
UPHY lanes from NVHS brick. Lane mapping in HSIO UPHY brick to each PCIe
controller (0~4) is controlled in XBAR module by BPMP-FW. Since PCIe
core has PIPE interface, a glue module called PIPE-to-UPHY (P2U) is used
to connect each UPHY lane (applicable to both HSIO and NVHS UPHY bricks)
to PCIe controller
This patch series
- Adds support for P2U PHY driver
- Adds support for PCIe host controller
- Adds device tree nodes each PCIe controllers
- Enables nodes applicable to p2972-0000 platform
- Adds helper APIs in Designware core driver to get capability regs offset
- Adds defines for new feature registers of PCIe spec revision 4
- Makes changes in DesignWare core driver to get Tegra194 PCIe working

Testing done on P2972-0000 platform
- Able to get PCIe link up with on-board Marvel eSATA controller
- Able to get PCIe link up with NVMe cards connected to M.2 Key-M slot
- Able to do data transfers with both SATA drives and NVMe cards

Note
- Enabling x8 slot on P2972-0000 platform requires pinmux driver for Tegra194.
  It is being worked on currently and hence Controller:5 (i.e. x8 slot) is
  disabled in this patch series. A future patch series would enable this.
- This series is based on top of the following series
  Jisheng's patches to add support to .remove() in Designware sub-system
  https://patchwork.kernel.org/project/linux-pci/list/?series=98559
  My patches made on top of Jisheng's patches to export various symbols
  https://patchwork.kernel.org/project/linux-pci/list/?series=101259

Changes since [v1]:
* Addressed review comments from Bjorn, Thierry, Jonathan, Rob & Kishon
* Added more patches in v2 series

Vidya Sagar (16):
  PCI: Add #defines for PCIe spec r4.0 features
  PCI/PME: Export pcie_pme_disable_msi() API
  PCI: Export pcie_bus_config symbol
  PCI: dwc: Perform dbi regs write lock towards the end
  PCI: dwc: Move config space capability search API
  PCI: dwc: Add ext config space capability search API
  dt-bindings: PCI: designware: Add binding for CDM register check
  PCI: dwc: Add support to enable CDM register check
  Documentation/devicetree: Add PCIe supports-clkreq property
  dt-bindings: PCI: tegra: Add device tree support for T194
  dt-bindings: PHY: P2U: Add Tegra 194 P2U block
  arm64: tegra: Add P2U and PCIe controller nodes to Tegra194 DT
  arm64: tegra: Enable PCIe slots in P2972-0000 board
  phy: tegra: Add PCIe PIPE2UPHY support
  PCI: tegra: Add Tegra194 PCIe support
  arm64: Add Tegra194 PCIe driver to defconfig

 .../devicetree/bindings/pci/designware-pcie.txt    |    4 +
 .../bindings/pci/nvidia,tegra194-pcie.txt          |  181 ++
 Documentation/devicetree/bindings/pci/pci.txt      |    5 +
 .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |   28 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |   50 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  449 +++++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/pci/controller/dwc/Kconfig                 |   11 +
 drivers/pci/controller/dwc/Makefile                |    1 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   37 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |    3 -
 drivers/pci/controller/dwc/pcie-designware.c       |   81 +
 drivers/pci/controller/dwc/pcie-designware.h       |   12 +
 drivers/pci/controller/dwc/pcie-tegra194.c         | 1760 ++++++++++++++++++++
 drivers/pci/pci.c                                  |    1 +
 drivers/pci/pcie/pme.c                             |    6 +
 drivers/pci/pcie/portdrv.h                         |    5 +-
 drivers/phy/tegra/Kconfig                          |    7 +
 drivers/phy/tegra/Makefile                         |    1 +
 drivers/phy/tegra/pcie-p2u-tegra194.c              |  120 ++
 include/uapi/linux/pci_regs.h                      |   22 +-
 22 files changed, 2743 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
 create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c

-- 
2.7.4

