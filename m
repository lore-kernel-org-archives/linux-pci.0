Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755113AbcJLNH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:07:56 -0400
Subject: [PATCH v2 0/4] PCI: xgene: Cleanups
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:07:35 -0500
Message-ID: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Pass the struct xgene_pcie_port pointer, not addresses, to setup
    functions to enable simplifications.

  - Add register accessors to encapsulate usage of port->csr_base a bit.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patch because it was a lot of churn for
  questionable benefit:
    PCI: xgene: Name private struct pointer "xgene" consistently

---

Bjorn Helgaas (4):
      PCI: xgene: Add local struct device pointers
      PCI: xgene: Remove unused platform data
      PCI: xgene: Pass struct xgene_pcie_port to setup functions
      PCI: xgene: Add register accessors


 drivers/pci/host/pci-xgene.c |  151 +++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 70 deletions(-)
