Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35741 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdDJMCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 08:02:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id a188so669426pfa.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2017 05:02:40 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
        aik@ozlabs.ru, benh@kernel.crashing.org, mpe@ellerman.id.au,
        paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: [PATCH v10 4/4] PCI: Don't extend device's size when using default alignment for all devices
Date: Mon, 10 Apr 2017 19:58:14 +0800
Message-Id: <1491825494-19331-5-git-send-email-elohimes@gmail.com>
In-Reply-To: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently we reassign the alignment by extending resources' size in
pci_reassigndev_resource_alignment(). This could potentially break
some drivers when the driver uses the size to locate register
whose length is related to the size. Some examples as below:

- misc/Hpilo.c:
off = pci_resource_len(pdev, bar) - 0x2000;

- net/ethernet/chelsio/cxgb4/cxgb4_uld.h:
(pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))

- infiniband/hw/nes/Nes_hw.c:
num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;

This risk could be easily prevented before because we only had one way
(kernel parameter resource_alignment) to touch those codes. And even
some users may be happy to see the extended size.

But now we introduce pcibios_default_alignment() to set default alignment
for all PCI devices which would also touch those codes. It would be hard
to prevent the risk in this case. So this patch tries to use
START_ALIGNMENT to identify the resource's alignment without extending
the size when the alignment reassigning is caused by the default alignment.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
---
 drivers/pci/pci.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 02f1255..358366e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4959,11 +4959,13 @@ resource_size_t __weak pcibios_default_alignment(struct pci_dev *dev)
 /**
  * pci_specified_resource_alignment - get resource alignment specified by user.
  * @dev: the PCI device to get
+ * @resize: whether or not to change resources' size when reassigning alignment
  *
  * RETURNS: Resource alignment if it is specified.
  *          Zero if it is not specified.
  */
-static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
+static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+							bool *resize)
 {
 	int seg, bus, slot, func, align_order, count;
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
@@ -5005,6 +5007,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 				(!device || (device == dev->device)) &&
 				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
 				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
+				*resize = true;
 				if (align_order == -1)
 					align = PAGE_SIZE;
 				else
@@ -5030,6 +5033,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 				bus == dev->bus->number &&
 				slot == PCI_SLOT(dev->devfn) &&
 				func == PCI_FUNC(dev->devfn)) {
+				*resize = true;
 				if (align_order == -1)
 					align = PAGE_SIZE;
 				else
@@ -5062,6 +5066,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	struct resource *r;
 	resource_size_t align, size;
 	u16 command;
+	bool resize = false;
 
 	/*
 	 * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
@@ -5073,7 +5078,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 
 	/* check if specified PCI is target device to reassign */
-	align = pci_specified_resource_alignment(dev);
+	align = pci_specified_resource_alignment(dev, &resize);
 	if (!align)
 		return;
 
@@ -5101,15 +5106,24 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		}
 
 		size = resource_size(r);
-		if (size < align) {
-			size = align;
-			dev_info(&dev->dev,
-				"Rounding up size of resource #%d to %#llx.\n",
-				i, (unsigned long long)size);
+		if (resize) {
+			if (size < align) {
+				size = align;
+				dev_info(&dev->dev,
+					"Rounding up size of resource #%d to %#llx.\n",
+					i, (unsigned long long)size);
+			}
+			r->flags |= IORESOURCE_UNSET;
+			r->start = 0;
+		} else {
+			if (size < align) {
+				r->flags &= ~IORESOURCE_SIZEALIGN;
+				r->flags |= IORESOURCE_STARTALIGN |
+							IORESOURCE_UNSET;
+				r->start = align;
+			}
 		}
-		r->flags |= IORESOURCE_UNSET;
-		r->end = size - 1;
-		r->start = 0;
+		r->end = r->start + size - 1;
 	}
 	/* Need to disable bridge's resource window,
 	 * to enable the kernel to reassign new resource
-- 
1.7.9.5
