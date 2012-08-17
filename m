Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757777Ab2HQXgr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:47 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:47 -0700 (PDT)
Subject: [PATCH v2 12/16] frv/PCI: Use list_for_each_entry() for bus->devices
	traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:46 -0600
Message-ID: <20120817233646.10973.40175.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
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

