Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:34047 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760606Ab3DDV6T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 17:58:19 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 15:58:18 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1CB8619D8042
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 15:58:13 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34LwHPL368230
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 15:58:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34LwGAi010682
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 15:58:16 -0600
Message-Id: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
Subject: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics adapters on Power
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org, lucaskt@linux.vnet.ibm.com,
	klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 04 Apr 2013 16:58:15 -0500
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Initialize dev->dev.type such that the PCI group attributes for boot_vga
and SR-IOV can be displayed if appropriate. This fixes an issue seen on
Power preventing X from auto initializing a graphics adapter when using KMS.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/pci_of_scan.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type arch/powerpc/kernel/pci_of_scan.c
--- linux/arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type	2013-04-03 09:43:19.000000000 -0500
+++ linux-bjking1/arch/powerpc/kernel/pci_of_scan.c	2013-04-03 09:43:19.000000000 -0500
@@ -141,6 +141,7 @@ struct pci_dev *of_create_pci_dev(struct
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev->dev.type = &pci_dev_type;
 	dev->devfn = devfn;
 	dev->multifunction = 0;		/* maybe a lie? */
 	dev->needs_freset = 0;		/* pcie fundamental reset required */
_

