Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61470 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbbA3V7b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 16:59:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] ARM: integrator: remove unused variable
Date: Fri, 30 Jan 2015 22:59:21 +0100
Message-ID: <1666566.z9ZP4KJ7VA@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch to add the new generic config space accessors removed
a useless spinlock, but left the flags variable in place, which
now causes a build warning:

arch/arm/mach-integrator/pci_v3.c: In function 'pci_v3_preinit':
arch/arm/mach-integrator/pci_v3.c:614:16: warning: unused variable 'flags' [-Wunused-variable]

This removes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1ba525109219 ("ARM: integrator: Convert PCI to use generic config accessors")

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index dc7782f26cbb..2565f0e7b5cf 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -611,7 +611,6 @@ static int __init pci_v3_setup(int nr, struct pci_sys_data *sys)
  */
 static void __init pci_v3_preinit(void)
 {
-	unsigned long flags;
 	unsigned int temp;
 	phys_addr_t io_address = pci_pio_to_address(io_mem.start);
 

