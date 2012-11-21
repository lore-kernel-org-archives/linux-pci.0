Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46269 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2KUUfB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:01 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 2/9] mips/PCI: Remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 15:34:53 -0500
Message-Id: <1353530100-728-3-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 arch/mips/pci/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 04e35bc..4040416 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -313,10 +313,8 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-#endif
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
-- 
1.8.0

