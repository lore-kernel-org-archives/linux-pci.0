Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56462 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754057AbdLDPJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:44 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 4/8] arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
Date: Mon,  4 Dec 2017 16:09:03 +0100
Message-Id: <20171204150907.24345-5-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCI MEM resources are marked as IORESOURCE_MEM_32BIT, which means
they are only usable when the SH core runs in 32-bit mode. In 29-bit
mode, such memory regions are not usable.

The existing code for SH7786 properly skips such regions when
configuring the PCIe controller registers. However, because such
regions are still described in the resource array, the
pcibios_scanbus() function in the SuperH pci.c will register them to
the PCI core. Due to this, the PCI core will allocate MEM areas from
this resource, and assign BARs pointing to this area, even though it's
unusable.

In order to prevent this from happening, we mark such regions as
IORESOURCE_DISABLED, which tells the SuperH pci.c pcibios_scanbus()
function to skip them.

Note that we separate marking the region as disabled from skipping it,
because other regions will be marked as disabled in follow-up patches.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 45bbe6927251..c2f877b4ef7e 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -419,6 +419,9 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 		 * mode, so just skip them entirely.
 		 */
 		if ((res->flags & IORESOURCE_MEM_32BIT) && __in_29bit_mode())
+			res->flags |= IORESOURCE_DISABLED;
+
+		if (res->flags & IORESOURCE_DISABLED)
 			continue;
 
 		pci_write_reg(chan, 0x00000000, SH4A_PCIEPTCTLR(win));
-- 
2.13.6
