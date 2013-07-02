Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:63048 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3GBS3p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2013 14:29:45 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so13377039ied.28
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2013 11:29:45 -0700 (PDT)
Subject: [PATCH] xtensa/PCI: Mark pcibios_fixup_bus() as non-init
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-xtensa@linux-xtensa.org, linux-pci@vger.kernel.org
Date: Tue, 02 Jul 2013 12:29:42 -0600
Message-ID: <20130702182942.28572.82708.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcibios_fixup_bus() is called by pci_scan_child_bus(), which is not marked
__init.  Therefore, pcibios_fixup_bus() cannot be marked __init either.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/kernel/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 126c188..56693dd 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -197,7 +197,7 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-void __init pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	if (bus->parent) {
 		/* This is a subordinate bridge */

