Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755446AbcJLMxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:53:11 -0400
Subject: [PATCH v2 0/5] PCI: iproc: Cleanups
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Wed, 12 Oct 2016 07:53:03 -0500
Message-ID: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Tidy up drvdata usage.

  - Remove some null pointer checking after adding corresponding checking
    elsewhere.

  - Hard-code the PCIe capability offset instead of searching for it.  This
    removes a little bit of dependency on struct pci_bus, with an eye
    toward moving the link maintenance before enumeration.

Changes from v1:
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: iproc: Rename accessors
    PCI: iproc: Name private struct pointer "iproc" consistently

---

Bjorn Helgaas (5):
      PCI: iproc: Add local struct device pointers
      PCI: iproc: Set drvdata at end of probe function
      PCI: iproc: Validate CSR base in BCMA setup code
      PCI: iproc: Remove redundant null pointer checking
      PCI: iproc: Hard-code PCIe capability offset instead of searching


 drivers/pci/host/pcie-iproc-bcma.c     |   14 ++++++---
 drivers/pci/host/pcie-iproc-platform.c |   27 +++++++++--------
 drivers/pci/host/pcie-iproc.c          |   52 ++++++++++++++++----------------
 3 files changed, 50 insertions(+), 43 deletions(-)
