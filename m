Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36722 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbcDHAWs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:48 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: [PATCH v11 02/60] alpha/PCI: Only check iomem_is_exclusive() for IORESOURCE_MEM, not IORESOURCE_IO
Date: Thu,  7 Apr 2016 17:15:15 -0700
Message-Id: <1460074573-7481-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The alpha pci_mmap_resource() is used for both IORESOURCE_MEM and
IORESOURCE_IO resources, but iomem_is_exclusive() is only applicable for
IORESOURCE_MEM.

Call iomem_is_exclusive() only for IORESOURCE_MEM resources, and do it
earlier to match the generic version of pci_mmap_resource().

Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
---
 arch/alpha/kernel/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 99e8d47..92c0d46 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -77,10 +77,10 @@ static int pci_mmap_resource(struct kobject *kobj,
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
-	if (!__pci_mmap_fits(pdev, i, vma, sparse))
+	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (iomem_is_exclusive(res->start))
+	if (!__pci_mmap_fits(pdev, i, vma, sparse))
 		return -EINVAL;
 
 	pcibios_resource_to_bus(pdev->bus, &bar, res);
-- 
1.8.4.5

