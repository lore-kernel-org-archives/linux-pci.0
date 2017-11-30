Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdK3QgC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Nov 2017 11:36:02 -0500
Subject: [PATCH v2] PCI: Remove sysfs resource mmap warning
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Date: Thu, 30 Nov 2017 10:35:57 -0600
Message-ID: <20171130163557.19488.80756.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

When a process uses sysfs and tries to mmap more space than is available in
a PCI BAR, we emit a warning and a backtrace.  The mmap fails anyway, so
the backtrace is mainly for debugging.  But in general we don't emit kernel
messages when syscalls return failure.

The similar procfs mmap path simply fails the mmap with no warning.  Remove
the sysfs warning.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 06c7f0b85cd2..ccc0e28c6678 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1216,14 +1216,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS)) {
-		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
-			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
-			pci_name(pdev), bar,
-			(u64)pci_resource_start(pdev, bar),
-			(u64)pci_resource_len(pdev, bar));
+	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
-	}
+
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
