Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:52329 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaHLA1n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 20:27:43 -0400
Received: by mail-oi0-f53.google.com with SMTP id e131so6128911oig.40
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 17:27:42 -0700 (PDT)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] pci: bugfix, pci_get_domain_bus_and_slot() needs to inc reference count
Date: Tue, 12 Aug 2014 08:31:21 +0800
Message-Id: <1407803481-7910-1-git-send-email-pingfank@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As the notes of this function, pci_get_domain_bus_and_slot() should
increase the reference count.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 drivers/pci/search.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 827ad83..41a5738 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -258,8 +258,10 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 
 	for_each_pci_dev(dev) {
 		if (pci_domain_nr(dev->bus) == domain &&
-		    (dev->bus->number == bus && dev->devfn == devfn))
+		    (dev->bus->number == bus && dev->devfn == devfn)) {
+			pci_dev_get(dev);
 			return dev;
+		}
 	}
 	return NULL;
 }
-- 
1.8.1.4

