Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:45887 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbLBFlr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 00:41:47 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 2 Dec 2015 11:11:44 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id EC1B1E0061
	for <linux-pci@vger.kernel.org>; Wed,  2 Dec 2015 11:12:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tB25feIG6095138
	for <linux-pci@vger.kernel.org>; Wed, 2 Dec 2015 11:11:41 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tB25fdba008966
	for <linux-pci@vger.kernel.org>; Wed, 2 Dec 2015 11:11:39 +0530
Date: Wed, 2 Dec 2015 16:41:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/eeh: Fix PE location code
Message-ID: <20151202054136.GA29523@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1449033440-26213-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449033440-26213-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 02, 2015 at 04:17:20PM +1100, Gavin Shan wrote:

Please ignore the noise as it should have been sent to linux-ppc
(not linux-pci) maillist.

Thanks,
Gavin

>In eeh_pe_loc_get(), the PE location code is retrieved from the
>"ibm,loc-code" property of the device node for the bridge of the
>PE's primary bus. It's not correct because the property indicates
>the parent PE's location code.
>
>This reads the correct PE location code from "ibm,io-base-loc-code"
>or "ibm,slot-location-code" property of PE parent bus's device node.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/eeh_pe.c | 33 +++++++++++++++------------------
> 1 file changed, 15 insertions(+), 18 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index 8654cb1..ca9e537 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -883,32 +883,29 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
> const char *eeh_pe_loc_get(struct eeh_pe *pe)
> {
> 	struct pci_bus *bus = eeh_pe_bus_get(pe);
>-	struct device_node *dn = pci_bus_to_OF_node(bus);
>+	struct device_node *dn;
> 	const char *loc = NULL;
>
>-	if (!dn)
>-		goto out;
>+	while (bus) {
>+		dn = pci_bus_to_OF_node(bus);
>+		if (!dn) {
>+			bus = bus->parent;
>+			continue;
>+		}
>
>-	/* PHB PE or root PE ? */
>-	if (pci_is_root_bus(bus)) {
>-		loc = of_get_property(dn, "ibm,loc-code", NULL);
>-		if (!loc)
>+		if (pci_is_root_bus(bus))
> 			loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
>+		else
>+			loc = of_get_property(dn, "ibm,slot-location-code",
>+					      NULL);
>+
> 		if (loc)
>-			goto out;
>+			return loc;
>
>-		/* Check the root port */
>-		dn = dn->child;
>-		if (!dn)
>-			goto out;
>+		bus = bus->parent;
> 	}
>
>-	loc = of_get_property(dn, "ibm,loc-code", NULL);
>-	if (!loc)
>-		loc = of_get_property(dn, "ibm,slot-location-code", NULL);
>-
>-out:
>-	return loc ? loc : "N/A";
>+	return "N/A";
> }
>
> /**
>-- 
>2.1.0
>

