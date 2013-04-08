Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:33747 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935544Ab3DHNFP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 09:05:15 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Mon, 8 Apr 2013 07:05:14 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C1FC56E8041
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2013 09:05:08 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r38D5B3C313674
	for <linux-pci@vger.kernel.org>; Mon, 8 Apr 2013 09:05:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r38D5A7c000703
	for <linux-pci@vger.kernel.org>; Mon, 8 Apr 2013 09:05:11 -0400
Message-Id: <201304081305.r38D58DO000500@d01av04.pok.ibm.com>
Subject: [PATCH 2/2] powerpc: Set default VGA device
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org, lucaskt@linux.vnet.ibm.com,
	klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 08 Apr 2013 08:05:10 -0500
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
--- linux/arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device	2013-04-08 06:16:37.000000000 -0500
+++ linux-bjking1/arch/powerpc/kernel/pci-common.c	2013-04-08 06:16:37.000000000 -0500
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

