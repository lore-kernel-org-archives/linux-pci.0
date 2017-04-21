Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425138AbdDUTcu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Apr 2017 15:32:50 -0400
Subject: [PATCH 9/9] lspci: Fix "Auxiliary" spelling error
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org,
        Jayachandran C <jnair@caviumnetworks.com>
Date: Fri, 21 Apr 2017 14:32:41 -0500
Message-ID: <20170421193241.6562.57167.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pci.h b/lib/pci.h
index 9781acc..052f43b 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -147,7 +147,7 @@ struct pci_dev {
   u8 *cache;				/* Cached config registers */
   int cache_len;
   int hdrtype;				/* Cached low 7 bits of header type, -1 if unknown */
-  void *aux;				/* Auxillary data */
+  void *aux;				/* Auxiliary data */
 };
 
 #define PCI_ADDR_IO_MASK (~(pciaddr_t) 0x3)
