Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeFHUMC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:02 -0400
Subject: [RFC PATCH v1 0/9] PCI/portdrv: Squash into one file
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:00 -0500
Message-ID: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The portdrv code is scattered across several files, which makes it a bit of
a hassle to browse.  Consolidate it all in a single file.

This is all pure code moves; no functional changes intended.  Well, there
is a function rename, but it shouldn't change any behavior.

---

Bjorn Helgaas (9):
      PCI/portdrv: Rename resume_iter() to prevent name collision
      PCI/portdrv: Squash pieces of portdrv_core.c into portdrv_pci.c
      PCI/portdrv: Squash PM-related code into portdrv_pci.c
      PCI/portdrv: Squash device removal code into portdrv_pci.c
      PCI/portdrv: Squash lookup interfaces into portdrv_pci.c
      PCI/portdrv: Squash service driver registration into portdrv_pci.c
      PCI/portdrv: Move private definitions to portdrv_pci.c
      PCI/portdrv: Clean up whitespace
      PCI/portdrv: Rename portdrv_pci.c to portdrv.c


 drivers/pci/pcie/Makefile       |    6 
 drivers/pci/pcie/portdrv.c      |  822 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h      |   15 -
 drivers/pci/pcie/portdrv_core.c |  578 ---------------------------
 drivers/pci/pcie/portdrv_pci.c  |  261 ------------
 5 files changed, 824 insertions(+), 858 deletions(-)
 create mode 100644 drivers/pci/pcie/portdrv.c
 delete mode 100644 drivers/pci/pcie/portdrv_core.c
 delete mode 100644 drivers/pci/pcie/portdrv_pci.c
