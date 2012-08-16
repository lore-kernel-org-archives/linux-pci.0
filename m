Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:65276 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab2HPX02 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 19:26:28 -0400
Received: by weyr1 with SMTP id r1so155204wey.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:26 -0700 (PDT)
Subject: [PATCH 2/6] frv/PCI: Use list_for_each_entry() for bus->devices
	traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>
Date: Thu, 16 Aug 2012 17:26:25 -0600
Message-ID: <20120816232625.3662.28141.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
References: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: David Howells <dhowells@redhat.com>
---
 arch/frv/mb93090-mb00/pci-vdk.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index d04ed14..71e9bcf 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -330,10 +330,8 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 	pci_read_bridge_bases(bus);
 
 	if (bus->number == 0) {
-		struct list_head *ln;
 		struct pci_dev *dev;
-		for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-			dev = pci_dev_b(ln);
+		list_for_each_entry(dev, &bus->devices, bus_list) {
 			if (dev->devfn == 0) {
 				dev->resource[0].start = 0;
 				dev->resource[0].end = 0;

