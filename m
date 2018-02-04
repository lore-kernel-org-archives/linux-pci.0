Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40069 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeBDAxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Feb 2018 19:53:18 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Mares <mj@ucw.cz>, Michal Vaner <vorner@vorner.cz>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] PCI: update location of pci.ids file
Message-ID: <1703ad43-3bf3-b777-7e1c-0beb55b064e8@infradead.org>
Date: Sat, 3 Feb 2018 16:53:09 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Update the URL for the pci.ids file and add locations for its mirrors.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Martin Mares <mj@ucw.cz>
Cc: Michal Vaner <vorner@vorner.cz>
---
 Documentation/PCI/pci.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20180202.orig/Documentation/PCI/pci.txt
+++ linux-next-20180202/Documentation/PCI/pci.txt
@@ -570,7 +570,9 @@ your driver if they're helpful, or just
 The device IDs are arbitrary hex numbers (vendor controlled) and normally used
 only in a single location, the pci_device_id table.
 
-Please DO submit new vendor/device IDs to http://pciids.sourceforge.net/.
+Please DO submit new vendor/device IDs to http://pci-ids.ucw.cz/.
+There are mirrors of the pci.ids file at http://pciids.sourceforge.net/
+and https://github.com/pciutils/pciids.
 
 
 
