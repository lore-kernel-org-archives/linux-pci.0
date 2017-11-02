Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38986 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbdKBWOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 18:14:08 -0400
To: linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] pci: move PCI_QUIRKS to the PCI bus menu
Message-ID: <95976b5f-e1df-358e-f457-38efd359de17@infradead.org>
Date: Thu, 2 Nov 2017 15:14:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Localize PCI_QUIRKS in the PCI bus menu.

Move PCI_QUIRKS to the PCI bus menu instead of the (often broken)
General Setup EXPERT menu.  The prompt still depends on EXPERT.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/pci/Kconfig |    9 +++++++++
 init/Kconfig        |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- lnx-414-rc7.orig/drivers/pci/Kconfig
+++ lnx-414-rc7/drivers/pci/Kconfig
@@ -29,6 +29,15 @@ config PCI_MSI_IRQ_DOMAIN
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
+config PCI_QUIRKS
+	default y
+	bool "Enable PCI quirk workarounds" if EXPERT
+	depends on PCI
+	help
+	  This enables workarounds for various PCI chipset
+	  bugs/quirks. Disable this only if your target machine is
+	  unaffected by PCI quirks.
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
--- lnx-414-rc7.orig/init/Kconfig
+++ lnx-414-rc7/init/Kconfig
@@ -1379,15 +1379,6 @@ config USERFAULTFD
 	  Enable the userfaultfd() system call that allows to intercept and
 	  handle page faults in userland.
 
-config PCI_QUIRKS
-	default y
-	bool "Enable PCI quirk workarounds" if EXPERT
-	depends on PCI
-	help
-	  This enables workarounds for various PCI chipset
-	  bugs/quirks. Disable this only if your target machine is
-	  unaffected by PCI quirks.
-
 config MEMBARRIER
 	bool "Enable membarrier() system call" if EXPERT
 	default y
