Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36091 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbaBCDC0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Feb 2014 22:02:26 -0500
Message-ID: <52EF06C0.1050104@infradead.org>
Date: Sun, 02 Feb 2014 19:02:24 -0800
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] pci: fix kernel-doc notation warning
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix a "blank" kernel-doc line to have an asterisk instead of
being totally empty.  This fixes the kernel-doc warning:

Warning(drivers/pci/msi.c:962): bad line: 

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/pci/msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-314-rc1.orig/drivers/pci/msi.c
+++ lnx-314-rc1/drivers/pci/msi.c
@@ -959,7 +959,7 @@ EXPORT_SYMBOL(pci_disable_msi);
 /**
  * pci_msix_vec_count - return the number of device's MSI-X table entries
  * @dev: pointer to the pci_dev data structure of MSI-X device function
-
+ *
  * This function returns the number of device's MSI-X table entries and
  * therefore the number of MSI-X vectors device is capable of sending.
  * It returns a negative errno if the device is not capable of sending MSI-X
