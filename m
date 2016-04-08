Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42143 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbcDHAQx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:16:53 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH v11 01/60] PCI: Fix iomem_is_exclusive() checking in pci_mmap_resource()
Date: Thu,  7 Apr 2016 17:15:14 -0700
Message-Id: <1460074573-7481-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

iomem_is_exclusive() requires a CPU physical address, but on some arches we
supplied a PCI bus address instead.

On most arches, pci_resource_to_user(res) returns "res->start", which is a
CPU physical address.  But on microblaze, mips, powerpc, and sparc, it
returns the PCI bus address corresponding to "res->start".

The result is that pci_mmap_resource() may fail when it shouldn't (if the
bus address happens to match an existing resource), or it may succeed when
it should fail (if the resource is exclusive but the bus address doesn't
match it).

Call iomem_is_exclusive() with "res->start", which is always a CPU physical
address, not the result of pci_resource_to_user().

Fixes: e8de1481fd71 ("resource: allow MMIO exclusivity for device drivers")
Suggested-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e982010..cbb13be 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1008,6 +1008,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
+	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+		return -EINVAL;
+
 	if (!pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)) {
 		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
 			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
@@ -1024,10 +1027,6 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	pci_resource_to_user(pdev, i, res, &start, &end);
 	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
-
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(start))
-		return -EINVAL;
-
 	return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
 }
 
-- 
1.8.4.5

