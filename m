Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755041AbcJLOEh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 10:04:37 -0400
Subject: [PATCH v2 0/4] PCI: spear: Cleanups
To: Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 09:04:20 -0500
Message-ID: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Remove unused constants.  There's some documentation value in these,
    but they're only marginally useful to people without the spec, and
    I think it's preferable to rely on the spec directly to avoid
    transcription errors.

  - Pass device-specific struct to internal functions for consistency.

  - Tidy up usage of local struct device pointers.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patch because it was lot of churn for
  questionable benefit:
    PCI: spear: Name private struct pointer "spear13xx" consistently

---

Bjorn Helgaas (4):
      PCI: spear: Remove unused constants
      PCI: spear: Pass device-specific struct to internal functions
      PCI: spear: Reorder struct spear13xx_pcie
      PCI: spear: Clean up struct device usage


 drivers/pci/host/pcie-spear13xx.c |  108 +++++++------------------------------
 1 file changed, 20 insertions(+), 88 deletions(-)
