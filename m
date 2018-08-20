Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNCb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Aug 2018 09:02:31 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource() comment
Date: Mon, 20 Aug 2018 10:47:29 +0100
Message-Id: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
Bridge IP driver")

and

commit ecf677c8dcaa ("PCI: Add a generic weak pcibios_align_resource()")

first patched then removed pcibios_align_resource() from the microblaze
architecture code but failed to remove the comment that was added to
it.

Remove it since it has now become stale and it is quite confusing.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/pci/pci-common.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index f34346d56095..2ffd171af8b6 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -597,19 +597,6 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
 
-/*
- * We need to avoid collisions with `mirrored' VGA ports
- * and other strange ISA hardware, so we always want the
- * addresses to be allocated in the 0x000-0x0ff region
- * modulo 0x400.
- *
- * Why? Because some silly external IO cards only decode
- * the low 10 bits of the IO address. The 0x00-0xff region
- * is reserved for motherboard devices that decode all 16
- * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
- * but we want to try to avoid allocating at 0x2900-0x2bff
- * which might have be mirrored at 0x0100-0x03ff..
- */
 int pcibios_add_device(struct pci_dev *dev)
 {
 	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-- 
2.15.0
