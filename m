Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755322AbcJLMrD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:03 -0400
Subject: [PATCH v2 0/6] PCI: altera: Cleanups
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:46:59 -0500
Message-ID: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Removed an unnecessary platform_get_resource() return value check.

  - Rework TLB_CFG_DW0 and TLP_CFG_DW1 to make the code prettier.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: altera: Name private struct pointer "altera" consistently
    PCI: altera: Rename _altera_pcie_cfg_read() to altera_raw_cfg_read()
    PCI: altera: Rename CRA accessors
    PCI: altera: Swap order of altera_cra_writel() reg/val arguments

---

Bjorn Helgaas (6):
      PCI: altera: Add local struct device pointers
      PCI: altera: Remove unused platform data
      PCI: altera: Remove redundant platform_get_resource() return value check
      PCI: altera: Rename altera_pcie_valid_config() to altera_pcie_valid_device()
      PCI: altera: Simplify TLB_CFG_DW0 usage
      PCI: altera: Simplify TLP_CFG_DW1 usage


 drivers/pci/host/pcie-altera.c |   77 +++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 44 deletions(-)
