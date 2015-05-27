Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0102.northgrum.com ([134.223.120.77]:28090 "EHLO
	xspv0102.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbE0VKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:10:21 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 02/13] PCI: Use child bus's number instead of max
Date: Wed, 27 May 2015 20:58:49 +0000
Message-ID: <39d69e4d36174906a62d08c9dfcc3d4a@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pci_scan_bridge(), a newly allocated child bus's resource are added
using the bus number "max+1". The current enumeration algorithm numbers
each child sequentially, thus the new child's number happens to always
be max+1; see the call to pci_add_new_bus() a few lines earlier.

An upcoming patch will allow static enumeration, such that the new child
bus's number might no longer be max+1. Thus when inserting the child's
resources, use the number actually assigned to child instead of assuming
that it is always max+1.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 873030b..18bee64 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -866,7 +866,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			child = pci_add_new_bus(bus, dev, max+1);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1, 0xff);
+			pci_bus_insert_busn_res(child, child->number, 0xff);
 		}
 		max++;
 		buses = (buses & 0xff000000)
-- 
1.7.9.5

