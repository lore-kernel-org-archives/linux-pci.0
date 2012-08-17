Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757777Ab2HQXgw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:52 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:52 -0700 (PDT)
Subject: [PATCH v2 13/16] parisc/PCI: Enable PERR/SERR on all devices
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	linux-parisc@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:51 -0600
Message-ID: <20120817233651.10973.83188.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, we enabled PERR & SERR for the first device on the bus, but
left other devices alone.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-parisc@vger.kernel.org
---
 drivers/parisc/lba_pci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 4f9cf24..4ce57c9 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -630,6 +630,7 @@ static void
 lba_fixup_bus(struct pci_bus *bus)
 {
 	struct list_head *ln;
+	struct pci_dev *dev;
 #ifdef FBB_SUPPORT
 	u16 status;
 #endif
@@ -712,8 +713,8 @@ lba_fixup_bus(struct pci_bus *bus)
 
 	list_for_each(ln, &bus->devices) {
 		int i;
-		struct pci_dev *dev = pci_dev_b(ln);
 
+		dev = pci_dev_b(ln);
 		DBG("lba_fixup_bus() %s\n", pci_name(dev));
 
 		/* Virtualize Device/Bridge Resources. */
@@ -771,6 +772,7 @@ lba_fixup_bus(struct pci_bus *bus)
 
 	/* Lastly enable FBB/PERR/SERR on all devices too */
 	list_for_each(ln, &bus->devices) {
+		dev = pci_dev_b(ln);
 		(void) pci_read_config_word(dev, PCI_COMMAND, &status);
 		status |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR | fbb_enable;
 		(void) pci_write_config_word(dev, PCI_COMMAND, status);

