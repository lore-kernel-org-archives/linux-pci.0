Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754980AbcJLNsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:14 -0400
Subject: [PATCH v2 0/8] PCI: imx6: Cleanups
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:47:32 -0500
Message-ID: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Clean up redundant dev->of_node usage.

  - Remove redundant struct members.

  - Pass struct imx6_pcie pointer rather than register address to PHY
    accessors.  This enables use of the generic DesignWare accessors.

  - Use generic DesignWare accessors when possible.

  - Pass device-specific struct to internal functions for consistency.

  - Remove unused return values.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: imx6: Name private struct pointer "imx6" consistently
    PCI: imx6: Name PHY accessors consistently with other i.MX6 accessors
    PCI: imx6: Add register accessors

---

Bjorn Helgaas (8):
      PCI: imx6: Add local struct device pointers
      PCI: imx6: Remove redundant of_node pointer
      PCI: imx6: Removed unused struct imx6_pcie.mem_base
      PCI: imx6: Pass struct imx6_pcie to PHY accessors
      PCI: imx6: Pass device-specific struct to internal functions
      PCI: imx6: Use generic DesignWare accessors
      PCI: imx6: Reorder struct imx6_pcie
      PCI: imx6: Remove unused return values


 drivers/pci/host/pci-imx6.c |  250 ++++++++++++++++++++++---------------------
 1 file changed, 126 insertions(+), 124 deletions(-)
