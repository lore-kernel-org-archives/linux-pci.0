Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755711AbcJLNKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:10:35 -0400
Subject: [PATCH v2 0/5] PCI: xilinx: Cleanups
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:10:30 -0500
Message-ID: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Remove unused xilinx_pcie_assign_msi() argument.

Nothing here should change the behavior of the driver.

Changes from v1:
  Added "PCI: xilinx: Removed unused xilinx_pcie_assign_msi() argument"
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: xilinx: Name private struct pointer "xilinx" consistently
    PCI: xilinx: Rename accessors
    PCI: xilinx: Swap order of xilinx_writel() reg/val arguments
    PCI: xilinx-nwl: Name private struct pointer "nwl" consistently
    PCI: xilinx-nwl: Swap order of nwl_bridge_writel() reg/val arguments

---

Bjorn Helgaas (5):
      PCI: xilinx: Add local struct device pointers
      PCI: xilinx: Remove unused platform data
      PCI: xilinx: Removed unused xilinx_pcie_assign_msi() argument
      PCI: xilinx-nwl: Add local struct device pointers
      PCI: xilinx-nwl: Remove unused platform data


 drivers/pci/host/pcie-xilinx-nwl.c |  109 ++++++++++++++++++------------------
 drivers/pci/host/pcie-xilinx.c     |   62 ++++++++++----------
 2 files changed, 87 insertions(+), 84 deletions(-)
