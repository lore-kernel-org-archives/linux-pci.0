Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34475 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbbCLRf3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 13:35:29 -0400
Received: by oiba3 with SMTP id a3so6203716oib.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2015 10:35:28 -0700 (PDT)
Subject: [PATCH v1 1/4] PNP: Don't check for overlaps with unassigned PCI
 BARs
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org
Date: Thu, 12 Mar 2015 12:35:26 -0500
Message-ID: <20150312173526.1052.59512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After 0509ad5e1a7d ("PNP: disable PNP motherboard resources that overlap
PCI BARs"), we disable and warn about PNP resources that overlap PCI BARs.
But we assume that all PCI BARs are valid, which is incorrect, because a
BAR may not have any space assigned to it.  In that case, we will not
enable the BAR, so no other resource can conflict with it.

Ignore PCI BARs that are unassigned, as indicated by IORESOURCE_UNSET.

Firmware often leaves PCI BARs unassigned, containing zero.  Zero is a
valid BAR value, so we can't just check for that, but the PCI core can set
IORESOURCE_UNSET when it detects an unassigned BAR by other means.  This
should get rid of many of the annoying messages like this:

  pnp 00:00: disabling [io  0x0061] because it overlaps 0001:05:00.0 BAR 0 [io  0x0000-0x00ff]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pnp/quirks.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index ebf0d6710b5a..943c1cb9566c 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -246,13 +246,16 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
 	 */
 	for_each_pci_dev(pdev) {
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			unsigned long type;
+			unsigned long flags, type;
 
-			type = pci_resource_flags(pdev, i) &
-					(IORESOURCE_IO | IORESOURCE_MEM);
+			flags = pci_resource_flags(pdev, i);
+			type = flags & (IORESOURCE_IO | IORESOURCE_MEM);
 			if (!type || pci_resource_len(pdev, i) == 0)
 				continue;
 
+			if (flags & IORESOURCE_UNSET)
+				continue;
+
 			pci_start = pci_resource_start(pdev, i);
 			pci_end = pci_resource_end(pdev, i);
 			for (j = 0;

