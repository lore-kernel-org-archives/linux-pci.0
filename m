Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F1B0BCB.4090901@xenotime.net>
Date: Sat, 21 Jan 2012 11:02:35 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 3/14] kernel-doc: fix new warnings in pci
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix new kernel-doc warnings:

Warning(drivers/pci/pci.c:2811): No description found for parameter 'dev'
Warning(drivers/pci/pci.c:2811): Excess function parameter 'pdev' description in 'pci_intx_mask_supported'
Warning(drivers/pci/pci.c:2894): No description found for parameter 'dev'
Warning(drivers/pci/pci.c:2894): Excess function parameter 'pdev' description in 'pci_check_and_mask_intx'
Warning(drivers/pci/pci.c:2908): No description found for parameter 'dev'
Warning(drivers/pci/pci.c:2908): Excess function parameter 'pdev' description in 'pci_check_and_unmask_intx'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/pci/pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-33-rc1.orig/drivers/pci/pci.c
+++ lnx-33-rc1/drivers/pci/pci.c
@@ -2802,7 +2802,7 @@ pci_intx(struct pci_dev *pdev, int enabl
 
 /**
  * pci_intx_mask_supported - probe for INTx masking support
- * @pdev: the PCI device to operate on
+ * @dev: the PCI device to operate on
  *
  * Check if the device dev support INTx masking via the config space
  * command word.
@@ -2884,7 +2884,7 @@ done:
 
 /**
  * pci_check_and_mask_intx - mask INTx on pending interrupt
- * @pdev: the PCI device to operate on
+ * @dev: the PCI device to operate on
  *
  * Check if the device dev has its INTx line asserted, mask it and
  * return true in that case. False is returned if not interrupt was
@@ -2898,7 +2898,7 @@ EXPORT_SYMBOL_GPL(pci_check_and_mask_int
 
 /**
  * pci_check_and_mask_intx - unmask INTx of no interrupt is pending
- * @pdev: the PCI device to operate on
+ * @dev: the PCI device to operate on
  *
  * Check if the device dev has its INTx line asserted, unmask it if not
  * and return true. False is returned and the mask remains active if
