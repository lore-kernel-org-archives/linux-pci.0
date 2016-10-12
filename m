Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbcJLNRr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:17:47 -0400
Subject: [PATCH v2 00/10] PCI: designware: Cleanups
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:17:41 -0500
Message-ID: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc exynos folks, since pcie_host_ops.readl_rc affects them]

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

Nothing here should change the behavior of the drivers.

Changes from v1:
  Split uninline of register accessors into a separate patch.
  Add Kishon's *unroll() fix (v1 broke exynos).

---

Bjorn Helgaas (9):
      PCI: designware: Rename dw_pcie_valid_config() to dw_pcie_valid_device()
      PCI: designware: Simplify pcie_host_ops.readl_rc() and .writel_rc() interfaces
      PCI: designware: Swap order of dw_pcie_writel_rc() reg/val arguments
      PCI: designware: Export dw_pcie_readl_rc(), dw_pcie_writel_rc()
      PCI: designware: Uninline register accessors
      PCI: designware: Swap order of dw_pcie_writel_unroll() reg/val arguments
      PCI: designware-plat: Remove redundant dw_plat_pcie.mem_base
      PCI: designware-plat: Add local struct device pointers
      PCI: designware-plat: Remove unused platform data

Kishon Vijay Abraham I (1):
      PCI: designware: Simplify dw_pcie_readl_unroll(), dw_pcie_writel_unroll()


 drivers/pci/host/pci-exynos.c           |   10 +--
 drivers/pci/host/pcie-designware-plat.c |   25 +++-----
 drivers/pci/host/pcie-designware.c      |  102 +++++++++++++++----------------
 drivers/pci/host/pcie-designware.h      |    7 +-
 4 files changed, 67 insertions(+), 77 deletions(-)
