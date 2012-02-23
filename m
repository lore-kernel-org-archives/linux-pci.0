Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:56726 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2BWTow (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 14:44:52 -0500
Received: by yenm1 with SMTP id m1so199636yen.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 11:44:52 -0800 (PST)
Subject: [PATCH] mips/PCI: remove titan_ht_pcibios_fixup_bus() code that does
	nothing
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 23 Feb 2012 12:44:52 -0700
Message-ID: <20120223194452.21202.13905.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This list traversal seems pointless.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pmc-sierra/yosemite/ht-irq.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/ht-irq.c b/arch/mips/pmc-sierra/yosemite/ht-irq.c
index 86b98e9..62ead66 100644
--- a/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ b/arch/mips/pmc-sierra/yosemite/ht-irq.c
@@ -35,16 +35,6 @@
  */
 void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_bus *current_bus = bus;
-	struct pci_dev *devices;
-	struct list_head *devices_link;
-
-	list_for_each(devices_link, &(current_bus->devices)) {
-		devices = pci_dev_b(devices_link);
-		if (devices == NULL)
-			continue;
-	}
-
 	/*
 	 * PLX and SPKT related changes go here
 	 */

