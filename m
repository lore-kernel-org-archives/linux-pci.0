Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:33596 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2IGWWR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 18:22:17 -0400
Received: by vbis24 with SMTP id s24so12827vbi.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 15:22:17 -0700 (PDT)
Subject: [PATCH] PCI: Remove bus number resource debug messages
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 07 Sep 2012 16:22:16 -0600
Message-ID: <20120907222216.22413.26865.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These messages don't seem to add much value.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6c143b4..e2dd4b7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1753,11 +1753,6 @@ int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 			   "busn_res: can not insert %pR under %s%pR (conflicts with %s %pR)\n",
 			    res, pci_is_root_bus(b) ? "domain " : "",
 			    parent_res, conflict->name, conflict);
-	else
-		dev_printk(KERN_DEBUG, &b->dev,
-			   "busn_res: %pR is inserted under %s%pR\n",
-			   res, pci_is_root_bus(b) ? "domain " : "",
-			   parent_res);
 
 	return conflict == NULL;
 }

