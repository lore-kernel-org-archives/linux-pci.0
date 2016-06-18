Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45125 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcFRCZg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 22:25:36 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v13 03/16] PCI: Check resource alignment for /sys pci_mmap_resource path
Date: Fri, 17 Jun 2016 19:24:48 -0700
Message-Id: <20160618022501.15648-4-yinghai@kernel.org>
In-Reply-To: <20160618022501.15648-1-yinghai@kernel.org>
References: <20160618022501.15648-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When user access /sys/.../resourceX  with pci_mmap_resource(),
pci_mmap_resource():
	...
        pci_resource_to_user(pdev, i, res, &start, &end);
        vma->vm_pgoff += start >> PAGE_SHIFT;
        mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
        return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
so it will return virtual address for round_down of start.

user code should pass offset with PAGE_SIZE offset.
  fd = open(argv[1], O_RDONLY);
  ...
  sscanf(argv[2], "0x%lx", &offset);
  left = offset & (PAGE_SIZE - 1);
  offset &= PAGE_MASK;
  addr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, offset);
  for (i = 0; i < 8; i++)
    printf("%x ", addr[i + left]);
  munmap(addr, PAGE_SIZE);
  close(fd);

When the resource start is not PAGE_SIZE aligned, it should
be io port, pci_mmap_resource could return round_down address of
resource start.
As the whole point for pci_mmap_resource is passing offset in
[0, resource_size), user may assume virtual add is corresponding
to unaligned resource_size. Later they could get wrong value
with offset to resource start.

Block the path for now, and need to use pci_read_resource_io
/pci_write_resource_io path instead.
user code should be like:
  fd = open(argv[1], O_RDONLY);
  ...
  sscanf(argv[2], "0x%lx", &offset);
  for (i = 0; i < 8; i++) {
    pread(fd, &buf, 1, i + offset);
  }
  close(fd);

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 82b98dd..138dfc2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1018,6 +1018,16 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
+	/*
+	 * resource start have to be PAGE_SIZE aligned, as we pass
+	 * back virt address include round down of resource_start,
+	 * that caller can not figure out directly.
+	 * when it is not aligned, that mean it is io port, should go
+	 * pci_read_resource_io()/pci_write_resource_io() path.
+	 */
+	if (res->start & ~PAGE_MASK)
+		return -EINVAL;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-- 
2.8.3

