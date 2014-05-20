Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:48433 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaETDqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 23:46:08 -0400
Received: by mail-ig0-f176.google.com with SMTP id hl10so4345117igb.9
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 20:46:07 -0700 (PDT)
Subject: [PATCH v10 3/4] PCI: Simplify __pci_assign_resource() coding style
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: talal@mellanox.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Date: Mon, 19 May 2014 21:46:05 -0600
Message-ID: <20140520034605.11972.20671.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If an allocation succeeds, we can return success immediately.  Then we
don't have to test for success in the subsequent code.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 2473f091a9cc..3bdac9dc4a88 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -213,9 +213,10 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
+	if (ret == 0)
+		return 0;
 
-	if (ret < 0 &&
-	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
+	if ((res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		/*
 		 * That failed.
@@ -225,10 +226,11 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
+		if (ret == 0)
+			return 0;
 	}
 
-	if (ret < 0 &&
-	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))) {
+	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		/*
 		 * That failed.
 		 *

