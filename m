Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbdK2W5L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 17:57:11 -0500
Subject: [PATCH] PCI: Tone down resource mmap warning
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Date: Wed, 29 Nov 2017 16:57:08 -0600
Message-ID: <20171129225708.32271.35467.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

When a process tries to mmap more space than is available in a PCI BAR, we
emit a warning and a backtrace.  The mmap fails anyway, so the backtrace is
mainly for debugging.  It seems like overkill now, so reduce this to a
dev_info() and remove the backtrace.

This was added by b5ff7df3df9e ("Check mapped ranges on sysfs resource
files").

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 06c7f0b85cd2..97f071674605 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1217,11 +1217,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 		return -EINVAL;
 
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS)) {
-		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
+		dev_info(&pdev->dev, "process \"%s\" tried to map 0x%lx bytes at page 0x%lx of BAR %d %pR\n",
 			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
-			pci_name(pdev), bar,
-			(u64)pci_resource_start(pdev, bar),
-			(u64)pci_resource_len(pdev, bar));
+			bar, res);
 		return -EINVAL;
 	}
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
