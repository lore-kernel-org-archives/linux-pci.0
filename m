Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38374 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760699Ab3DDV6Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 17:58:25 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 15:58:24 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 97FFE19D8043
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 15:58:17 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34LwLjO097474
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 15:58:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34LwHja010756
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 15:58:20 -0600
Message-Id: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
Subject: [PATCH 3/3] powerpc: Set default VGA device
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org, lucaskt@linux.vnet.ibm.com,
	klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 04 Apr 2013 16:58:17 -0500
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Add a PCI quirk for VGA devices on Power to set the default VGA device.
Ensures a default VGA is always set if a graphics adapter is present,
even if firmware did not initialize it. If more than one graphics
adapter is present, ensure the one initialized by firmware is set
as the default VGA device. This ensures that X autoconfiguration
will work.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/pci-common.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff -puN arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device arch/powerpc/kernel/pci-common.c
--- linux/arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device	2013-04-03 09:50:33.000000000 -0500
+++ linux-bjking1/arch/powerpc/kernel/pci-common.c	2013-04-03 09:50:33.000000000 -0500
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/vgaarb.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -1725,3 +1726,15 @@ static void fixup_hide_host_resource_fsl
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
+
+static void fixup_vga(struct pci_dev *pdev)
+{
+	u16 cmd;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
+		vga_set_default_device(pdev);
+
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
+			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
_

