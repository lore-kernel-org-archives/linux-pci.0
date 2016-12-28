Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59040 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbcL1KfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2016 05:35:01 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/4] PCI: exynos: use the PHY generic framework
Date: Wed, 28 Dec 2016 19:34:50 +0900
Message-id: <20161228103454.26467-1-jh80.chung@samsung.com>
References: <CGME20161228103455epcas1p1c762bc59add0011beff1d4ff697b5c8d@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is for using PHY generic framework.
When Exynos5440 had upstreamed, there was no PHY subsytem.
Now the using PHY framework is mandantory.
In future, Exynos variant should be supported in pci-exynos.c

Theses pathces based on the below patches

- Jaehoon's patches
http://patchwork.ozlabs.org/patch/706998/
http://patchwork.ozlabs.org/patch/706997/
http://patchwork.ozlabs.org/patch/706995/
http://patchwork.ozlabs.org/patch/706994/

- Srinivas's patch
http://patchwork.ozlabs.org/patch/703530/

- Pankaj's patch
http://patchwork.ozlabs.org/patch/708414/

Jaehoon Chung (4):
  phy: exynos-pcie: Add support for Exynos PCIe phy
  Documetation: samsung-phy: add the exynos-pcie-phy binding
  Documetation: binding: modify the exynos5440 pcie binding
  ARM: dts: exynos5440: support the phy-pcie node for pcie

 .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 ++-
 .../devicetree/bindings/phy/samsung-phy.txt        |  23 ++
 arch/arm/boot/dts/exynos5440.dtsi                  |  44 +++-
 drivers/pci/host/pci-exynos.c                      | 198 ++------------
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-exynos-pcie.c                      | 289 +++++++++++++++++++++
 7 files changed, 395 insertions(+), 198 deletions(-)
 create mode 100644 drivers/phy/phy-exynos-pcie.c

-- 
2.10.2

