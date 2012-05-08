Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:37637 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab2EHXqM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 19:46:12 -0400
Received: by qcsp5 with SMTP id p5so297510qcs.1
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2012 16:46:11 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 84BAF10004D
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 16:46:11 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 3AFF4180170
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 16:46:11 -0700 (PDT)
Subject: [PATCH 2/3] PCI: remove pci_max_busnr() (was already commented out)
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 08 May 2012 17:46:11 -0600
Message-ID: <20120508234611.2085.95132.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120508234605.2085.32267.stgit@bhelgaas.mtv.corp.google.com>
References: <20120508234605.2085.32267.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_max_busnr() has been commented out for years (since 54c762fe62), and
this patch removes it completely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 69c21f0..09cd709 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -135,30 +135,6 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
 #endif
 
-#if 0
-/**
- * pci_max_busnr - returns maximum PCI bus number
- *
- * Returns the highest PCI bus number present in the system global list of
- * PCI buses.
- */
-unsigned char __devinit
-pci_max_busnr(void)
-{
-	struct pci_bus *bus = NULL;
-	unsigned char max, n;
-
-	max = 0;
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		n = pci_bus_max_busnr(bus);
-		if(n > max)
-			max = n;
-	}
-	return max;
-}
-
-#endif  /*  0  */
-
 #define PCI_FIND_CAP_TTL	48
 
 static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,

