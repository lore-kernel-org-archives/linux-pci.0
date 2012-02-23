Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:36003 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab2BWTnp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 14:43:45 -0500
Received: by eekb15 with SMTP id b15so51949eek.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 11:43:44 -0800 (PST)
Subject: [PATCH v2 08/12] mips/PCI: removed unused pci_probe configurability
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 23 Feb 2012 12:43:43 -0700
Message-ID: <20120223194343.20708.34965.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We never assign anything other than PCI_ASSIGN_ALL_BUSSES to pci_probe,
so just remove the indirection.  If configurability is required in the
future, please use the pci_flags/PCI_REASSIGN_ALL_BUS functionality
as is done for powerpc.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 2a11045..19f6d19 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -24,10 +24,6 @@
  * assignments.
  */
 
-#define PCI_ASSIGN_ALL_BUSSES	1
-
-unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
-
 /*
  * The PCI controller list.
  */
@@ -238,7 +234,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 
 unsigned int pcibios_assign_all_busses(void)
 {
-	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
+	return 1;
 }
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)

