Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38143 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbdBMI0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2017 03:26:21 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        niyas.ahmed@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        vivek.gautam@codeaurora.org, robh+dt@kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V3 0/4] PCI: exynos: use the PHY generic framework
Date: Mon, 13 Feb 2017 17:26:09 +0900
Message-id: <20170213082613.19628-1-jh80.chung@samsung.com>
References: <CGME20170213082615epcas5p2f5ecabbd5853a8e27da5f88fcae85158@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patcheset is for using PHY generic framework.
Current pci-exyns doesn't use the phy framework since there haven't been on
PHY subsystem when Exynos5440 had bean upstreamed.
It's making a difficult to upstream the other Exynos variants because of different
PHY registers.

This patcheset has the below modifications:
1) Introduces the phy-exynos-pcie
2) Handles PHY register from PHY framework for pci-exynos
3) Modifies the dt-binding of pci-exynos
4) Maintains the backward compatibility

Changelog on V3:
- Drops "ARM: dts: exynos5440: support the phy-pcie node of pcie"
  : Will send this patch after applying this patchset.
- Fixes typo
- Based on latest PCI git repository (host-exynos branch)
- Changes commit message
- Removes the dependency

Changelog on V2:
- Keep current codes for backward compatibility
- Fixes some typos
- Split the patches for removing the dependency
- Removes the unnecessary codes
- Change the patch's sequence
- Based on latest PCI git repository.(next branch)

Jaehoon Chung (4):
  Documetation: samsung-phy: add the exynos-pcie-phy binding
  phy: phy-exynos-pcie: Add support for Exynos PCIe phy
  Documetation: binding: modify the exynos5440 pcie binding
  PCI: exynos: support the using PHY generic framework

 .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 +++
 .../devicetree/bindings/phy/samsung-phy.txt        |  17 ++
 drivers/pci/host/pci-exynos.c                      |  54 +++-
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-exynos-pcie.c                      | 285 +++++++++++++++++++++
 6 files changed, 390 insertions(+), 4 deletions(-)
 create mode 100644 drivers/phy/phy-exynos-pcie.c

-- 
2.10.2
