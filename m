Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:48341 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858AbaKLCmv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 21:42:51 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 12 Nov 2014 08:12:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 30390E003F
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:12:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAC2h15K56229948
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:13:02 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAC2gjcS032662
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:12:45 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Fix device node for virtual bus
Date: Wed, 12 Nov 2014 13:42:43 +1100
Message-Id: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_set_bus_of_node() sets virtual PCI bus's device node to PHB's
device node wrongly. The patch fixes the issue.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index f092993..7b2256b 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -31,9 +31,9 @@ void pci_release_of_node(struct pci_dev *dev)
 
 void pci_set_bus_of_node(struct pci_bus *bus)
 {
-	if (bus->self == NULL)
+	if (pci_is_root_bus(bus))
 		bus->dev.of_node = pcibios_get_phb_of_node(bus);
-	else
+	else if (bus->self)
 		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
 }
 
-- 
1.8.3.2

