Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <guohanjun@huawei.com>, <jcm@redhat.com>, <toshi.kani@hpe.com>,
        <tanxiaojun@huawei.com>, <wangzhou1@hisilicon.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v3 2/2] PCI: Check phys_addr for pci_remap_iospace
Date: Tue, 29 May 2018 20:18:19 +0800
Message-ID: <1527596299-57567-2-git-send-email-xieyisheng1@huawei.com>
In-Reply-To: <1527596299-57567-1-git-send-email-xieyisheng1@huawei.com>
References: <1527596299-57567-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If phys_addr is not page aligned, ioremap_page_range() will align down it
when get pfn by phys_addr >> PAGE_SHIFT. An example in arm64 system with
64KB page size:

 phys_addr:  0xefff8000
 res->start: 0x0
 res->end:   0x0ffff
 PCI_IOBASE: 0xffff7fdffee00000

This will remap virtual address 0xffff7fdffee00000 to phys_addr 0xefff0000,
but what we really want is 0xefff8000, which makes later IO access to a
mess. And users may even donot know this until find some odd phenemenon.

This patch checks whether phys_addr is PAGE_ALIGNED or not to find the
primary scene.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0eb0381..117ca6a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3547,6 +3547,9 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	if (!PAGE_ALIGNED(vaddr) || !PAGE_ALIGNED(resource_size(res)))
 		return -EINVAL;
 
+	if (!PAGE_ALIGNED(phys_addr))
+		return -EINVAL;
+
 	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
 				  pgprot_device(PAGE_KERNEL));
 #else
-- 
1.7.12.4

