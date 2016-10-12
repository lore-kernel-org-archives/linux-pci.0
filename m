Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933326AbcJLNZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:25:15 -0400
Subject: [PATCH v2 0/6] PCI: armada: Cleanups
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:25:11 -0500
Message-ID: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Remove redundant struct members.

  - Use generic DesignWare accessors when possible.

  - Pass device-specific struct to internal functions for consistency.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: armada: Name private struct pointer "armada8k" consistently
    PCI: armada: Add register accessors

---

Bjorn Helgaas (6):
      PCI: armada: Remove unused platform data
      PCI: armada: Add local base pointer
      PCI: armada: Remove redundant struct armada8k_pcie.base
      PCI: armada: Use generic DesignWare accessors
      PCI: armada: Pass device-specific struct to internal functions
      PCI: armada: Reorder struct armada8k_pcie


 drivers/pci/host/pcie-armada8k.c |   78 ++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 41 deletions(-)
