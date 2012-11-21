Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46278 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab2KUUfC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:02 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 3/9] powerpc/PCI: Remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 15:34:54 -0500
Message-Id: <1353530100-728-4-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 arch/powerpc/kernel/pci-common.c | 4 ----
 arch/powerpc/kernel/pci_64.c     | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f94f76..abc0d08 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1428,8 +1428,6 @@ void __init pcibios_resource_survey(void)
 		ppc_md.pcibios_fixup();
 }
 
-#ifdef CONFIG_HOTPLUG
-
 /* This is used by the PCI hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
  * rest of the code later, for now, keep it as-is as our main
@@ -1488,8 +1486,6 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
-#endif /* CONFIG_HOTPLUG */
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	if (ppc_md.pcibios_enable_device_hook)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4ff190f..2cbe676 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -74,8 +74,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-#ifdef CONFIG_HOTPLUG
-
 int pcibios_unmap_io_space(struct pci_bus *bus)
 {
 	struct pci_controller *hose;
@@ -124,8 +122,6 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_unmap_io_space);
 
-#endif /* CONFIG_HOTPLUG */
-
 static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 {
 	struct vm_struct *area;
-- 
1.8.0

