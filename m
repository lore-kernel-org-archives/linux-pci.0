Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36227 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbdDJMBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 08:01:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so25490604pgh.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2017 05:01:32 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
        aik@ozlabs.ru, benh@kernel.crashing.org, mpe@ellerman.id.au,
        paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: [PATCH v10 2/4] PCI: Add pcibios_default_alignment() for arch-specific alignment control
Date: Mon, 10 Apr 2017 19:58:12 +0800
Message-Id: <1491825494-19331-3-git-send-email-elohimes@gmail.com>
In-Reply-To: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When VFIO passes through a PCI device to a guest, it does not allow
the guest to mmap BARs that are smaller than PAGE_SIZE unless it
can reserve the rest of the page (see vfio_pci_probe_mmaps()). This
is because a page might contain several small BARs for unrelated
devices and a guest should not be able to access all of them.

VFIO emulates guest accesses to non-mappable BARs, which is functional
but slow. On systems with large page sizes, e.g., PowerNV with 64K pages,
BARs are more likely to share a page and performance is more likely to
be a problem.

Add a weak function to set default alignment for all PCI devices.
An arch can override it to force the PCI core to place memory BARs on
their own pages.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
---
 drivers/pci/pci.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..02f1255 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4947,6 +4947,11 @@ void pci_ignore_hotplug(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 
+resource_size_t __weak pcibios_default_alignment(struct pci_dev *dev)
+{
+	return 0;
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
@@ -4962,14 +4967,15 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 {
 	int seg, bus, slot, func, align_order, count;
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
-	resource_size_t align = 0;
+	resource_size_t align = pcibios_default_alignment(dev);
 	char *p;
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
-	if (!*p)
+	if (!*p && !align)
 		goto out;
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		align = 0;
 		pr_info_once("PCI: Ignoring requested alignments (PCI_PROBE_ONLY)\n");
 		goto out;
 	}
-- 
1.7.9.5
