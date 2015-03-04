Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:56503 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbbCDFYr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 00:24:47 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 4 Mar 2015 15:24:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 67CB43578047
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2015 16:24:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t245OZ4Q18809054
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2015 16:24:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t245O9iq031419
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2015 16:24:09 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V13 11/21] powerpc/pci: Don't unset PCI resources for VFs
Date: Wed,  4 Mar 2015 13:19:03 +0800
Message-Id: <1425446353-30513-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Flag PCI_REASSIGN_ALL_RSRC is used to ignore resources information setup by
firmware, so that kernel would re-assign all resources of pci devices.

On powerpc arch, this happens in a header fixup function
pcibios_fixup_resources(), which will clean up the resources if this flag
is set. This works fine for PFs, since after clean up, kernel will
re-assign the resources in pcibios_resource_survey().

Below is a simple call flow on how it works:

    pcibios_init
      pcibios_scan_phb
        pci_scan_child_bus
          ...
            pci_device_add
              pci_fixup_device(pci_fixup_header)
                pcibios_fixup_resources                     # header fixup
                  for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
                    dev->resource[i].start = 0
      pcibios_resource_survey                               # re-assign
        pcibios_allocate_resources

However, the VF resources won't be re-assigned, since the VF resources are
completely determined by the PF resources, and the PF resources have
already been reassigned. This means we need to leave VF's resources
un-cleared in pcibios_fixup_resources().

In this patch, we skip the resource unset process in
pcibios_fixup_resources(), if the pci_dev is a VF.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c9..8203101 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		       pci_name(dev));
 		return;
 	}
+
+	if (dev->is_virtfn)
+		return;
+
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		struct resource *res = dev->resource + i;
 		struct pci_bus_region reg;
-- 
1.7.9.5

