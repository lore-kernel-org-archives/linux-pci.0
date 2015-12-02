Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:54218 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbLBFSR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 00:18:17 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 2 Dec 2015 15:18:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3A0913578054
	for <linux-pci@vger.kernel.org>; Wed,  2 Dec 2015 16:18:11 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tB25HjT110616914
	for <linux-pci@vger.kernel.org>; Wed, 2 Dec 2015 16:17:53 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tB25HceL015675
	for <linux-pci@vger.kernel.org>; Wed, 2 Dec 2015 16:17:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix PE location code
Date: Wed,  2 Dec 2015 16:17:20 +1100
Message-Id: <1449033440-26213-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In eeh_pe_loc_get(), the PE location code is retrieved from the
"ibm,loc-code" property of the device node for the bridge of the
PE's primary bus. It's not correct because the property indicates
the parent PE's location code.

This reads the correct PE location code from "ibm,io-base-loc-code"
or "ibm,slot-location-code" property of PE parent bus's device node.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8654cb1..ca9e537 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -883,32 +883,29 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
 const char *eeh_pe_loc_get(struct eeh_pe *pe)
 {
 	struct pci_bus *bus = eeh_pe_bus_get(pe);
-	struct device_node *dn = pci_bus_to_OF_node(bus);
+	struct device_node *dn;
 	const char *loc = NULL;
 
-	if (!dn)
-		goto out;
+	while (bus) {
+		dn = pci_bus_to_OF_node(bus);
+		if (!dn) {
+			bus = bus->parent;
+			continue;
+		}
 
-	/* PHB PE or root PE ? */
-	if (pci_is_root_bus(bus)) {
-		loc = of_get_property(dn, "ibm,loc-code", NULL);
-		if (!loc)
+		if (pci_is_root_bus(bus))
 			loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
+		else
+			loc = of_get_property(dn, "ibm,slot-location-code",
+					      NULL);
+
 		if (loc)
-			goto out;
+			return loc;
 
-		/* Check the root port */
-		dn = dn->child;
-		if (!dn)
-			goto out;
+		bus = bus->parent;
 	}
 
-	loc = of_get_property(dn, "ibm,loc-code", NULL);
-	if (!loc)
-		loc = of_get_property(dn, "ibm,slot-location-code", NULL);
-
-out:
-	return loc ? loc : "N/A";
+	return "N/A";
 }
 
 /**
-- 
2.1.0

