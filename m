Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33708 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbdCJCrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2017 21:47:17 -0500
Received: by mail-pf0-f169.google.com with SMTP id w189so36076655pfb.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2017 18:46:31 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 4/5] PCI: export pci_remap_iospace() and pci_unmap_iospace()
Date: Thu,  9 Mar 2017 18:46:16 -0800
Message-Id: <20170310024617.67303-4-briannorris@chromium.org>
In-Reply-To: <20170310024617.67303-1-briannorris@chromium.org>
References: <20170310024617.67303-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are useful for PCIe host drivers, and those drivers can be
modules.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
new in v2
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02ffdb9..3ec248774911 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3363,7 +3363,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  *	Only architectures that have memory mapped IO functions defined
  *	(and the PCI_IOBASE value defined) should call this function.
  */
-int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
@@ -3383,6 +3383,7 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	return -ENODEV;
 #endif
 }
+EXPORT_SYMBOL(pci_remap_iospace);
 
 /**
  *	pci_unmap_iospace - Unmap the memory mapped I/O space
@@ -3400,6 +3401,7 @@ void pci_unmap_iospace(struct resource *res)
 	unmap_kernel_range(vaddr, resource_size(res));
 #endif
 }
+EXPORT_SYMBOL(pci_unmap_iospace);
 
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
-- 
2.12.0.246.ga2ecc84866-goog
