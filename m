Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f202.google.com ([209.85.160.202]:50979 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760900Ab1LPWbf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:31:35 -0500
Received: by mail-gy0-f202.google.com with SMTP id r15so169231ghr.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:31:35 -0800 (PST)
Subject: [PATCH 1/6] frv/PCI: use list_for_each_entry() for bus->devices
	traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>, linux-pci@vger.kernel.org
Date: Fri, 16 Dec 2011 15:31:34 -0700
Message-ID: <20111216223134.5963.37040.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/frv/mb93090-mb00/pci-vdk.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index 6b0b82f..37b5285 100644
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

