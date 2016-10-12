Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbcJLNhL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:37:11 -0400
Subject: [PATCH v2 0/5] PCI: exynos: Cleanups
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 12 Oct 2016 08:37:07 -0500
Message-ID: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Name private struct pointer consistently within driver.

  - Pass device-specific struct to internal functions for consistency.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: exynos: Name private struct pointer "exynos" consistently
      (Instead of renaming *all* the pointers, I only renamed enough to
      make them consistent within this file.)
    PCI: exynos: Swap order of exynos_elb_writel() reg/val arguments
    PCI: exynos: Swap order of exynos_phy_writel() reg/val arguments
    PCI: exynos: Swap order of exynos_blk_writel() reg/val arguments

---

Bjorn Helgaas (5):
      PCI: exynos: Add local struct device pointers
      PCI: exynos: Uninline register accessors
      PCI: exynos: Name private struct pointer "exynos_pcie" consistently
      PCI: exynos: Pass device-specific struct to internal functions
      PCI: exynos: Reorder struct exynos_pcie


 drivers/pci/host/pci-exynos.c |  214 +++++++++++++++++++----------------------
 1 file changed, 100 insertions(+), 114 deletions(-)
