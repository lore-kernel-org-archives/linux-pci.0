Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:60782 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1LPWia (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:38:30 -0500
Received: by eaad1 with SMTP id d1so103051eaa.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:38:29 -0800 (PST)
Subject: [PATCH 3/6] sh/PCI: use list_for_each_entry() for bus->devices
	traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org
Date: Fri, 16 Dec 2011 15:31:44 -0700
Message-ID: <20111216223144.5963.48685.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/drivers/pci/pci.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index af9246d..e425b08 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -171,11 +171,8 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	struct list_head *ln;
-
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		dev = pci_dev_b(ln);
 
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}

