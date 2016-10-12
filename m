Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753578AbcJLNga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:36:30 -0400
Subject: [PATCH v2 0/7] PCI: artpec: Cleanups
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Wed, 12 Oct 2016 08:28:55 -0500
Message-ID: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Use generic DesignWare accessors when possible.

  - Add register accessors to encapsulate regmap usage.

  - Pass device-specific struct to internal functions for consistency.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patch because it was a lot of churn for
  questionable benefit:
    PCI: artpec6: Name private struct pointer "artpec6" consistently

---

Bjorn Helgaas (7):
      PCI: artpec6: Add local struct device pointers
      PCI: artpec6: Remove unused platform data
      PCI: artpec6: Add register accessors
      PCI: artpec6: Use generic DesignWare accessors
      PCI: artpec6: Remove unnecessary artpec6_pcie_link_up()
      PCI: artpec6: Pass device-specific struct to internal functions
      PCI: artpec6: Add resource name comments


 drivers/pci/host/pcie-artpec6.c |  115 ++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 56 deletions(-)
