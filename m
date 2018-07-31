Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731637AbeHAAcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jul 2018 20:32:45 -0400
Subject: [PATCH] PCI/AER: Remove duplicate PCI_EXP_AER_FLAGS definition
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Oza Pawandeep <poza@codeaurora.org>,
        Rajat Jain <rajatja@google.com>
Date: Tue, 31 Jul 2018 17:50:10 -0500
Message-ID: <153307741056.12895.16173953885240310937.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

PCI_EXP_AER_FLAGS was defined twice (with identical definitions), once
under #ifdef CONFIG_ACPI_APEI, and again at the top level.  This looks like
my merge error from these commits:

  fd3362cb73de ("PCI/AER: Squash aerdrv_core.c into aerdrv.c")
  41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")

Remove the duplicate PCI_EXP_AER_FLAGS definition.

Fixes: 41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2b344c9e2d46..c6cc855bfa22 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -329,8 +329,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
-#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
 static bool aer_firmware_first;
 
