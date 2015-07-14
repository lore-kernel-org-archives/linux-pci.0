Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34907 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbGNWBW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:01:22 -0400
Received: by oihq81 with SMTP id q81so16135073oih.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 15:01:21 -0700 (PDT)
Subject: [PATCH] PCI: Remove useless redundant code
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 14 Jul 2015 17:01:18 -0500
Message-ID: <20150714220118.21427.99172.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove redundant code from __pci_bus_find_cap_start().  No functional
change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29b5605..359b954 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -195,8 +195,6 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
 		return PCI_CAPABILITY_LIST;
 	case PCI_HEADER_TYPE_CARDBUS:
 		return PCI_CB_CAPABILITY_LIST;
-	default:
-		return 0;
 	}
 
 	return 0;

