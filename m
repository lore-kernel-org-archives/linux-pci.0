Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46264 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab2KUUfB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:01 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <monstr@monstr.eu>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 1/9] microblaze/PCI: Remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 15:34:52 -0500
Message-Id: <1353530100-728-2-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: microblaze-uclinux@itee.uq.edu.au
Cc: devicetree-discuss@lists.ozlabs.org
---
 arch/microblaze/pci/pci-common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 4dbb505..a1c5b99 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1346,8 +1346,6 @@ void __init pcibios_resource_survey(void)
 	pci_assign_unassigned_resources();
 }
 
-#ifdef CONFIG_HOTPLUG
-
 /* This is used by the PCI hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
  * rest of the code later, for now, keep it as-is as our main
@@ -1407,8 +1405,6 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
-#endif /* CONFIG_HOTPLUG */
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	return pci_enable_resources(dev, mask);
-- 
1.8.0

