Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58240 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3GBS2w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2013 14:28:52 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so13386902iej.15
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2013 11:28:52 -0700 (PDT)
Subject: [PATCH] frv/PCI: Mark pcibios_fixup_bus() as non-init
To: David Howells <dhowells@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 02 Jul 2013 12:28:50 -0600
Message-ID: <20130702182850.28548.17168.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcibios_fixup_bus() is called by pci_scan_child_bus(), which is not marked
__init.  Therefore, pcibios_fixup_bus() cannot be marked __init either.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/frv/mb93090-mb00/pci-vdk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index 0aa35f0..deb6784 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -320,7 +320,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
  *  are examined.
  */
 
-void __init pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 #if 0
 	printk("### PCIBIOS_FIXUP_BUS(%d)\n",bus->number);

