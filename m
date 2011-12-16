Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:49850 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760900Ab1LPWbm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:31:42 -0500
Received: by eaad1 with SMTP id d1so102916eaa.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:31:41 -0800 (PST)
Subject: [PATCH 2/6] MIPS: PCI: use list_for_each_entry() for bus->devices
	traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Date: Fri, 16 Dec 2011 15:31:39 -0700
Message-ID: <20111216223139.5963.51460.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c                    |    5 +----
 arch/mips/pmc-sierra/yosemite/ht-irq.c |   10 ----------
 2 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 934862c..ae5e423 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -273,7 +273,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* Propagate hose info into the subordinate devices.  */
 
-	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
 	if (pci_probe_only && dev &&
@@ -282,9 +281,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 		pcibios_fixup_device_resources(dev, bus);
 	}
 
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		dev = pci_dev_b(ln);
-
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}
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

