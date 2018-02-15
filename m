Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033088AbeBOPSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Feb 2018 10:18:14 -0500
Subject: [PATCH v1 2/2] sparc/PCI: Reserve System ROM and Video ROM outside
 of PCI space
From: Bjorn Helgaas <helgaas@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Date: Thu, 15 Feb 2018 09:18:11 -0600
Message-ID: <20180215151811.196756.2750.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, pci_register_legacy_regions() reserved PCI address space under
every PCI host bridge for the System ROM and the Video ROM, but these
regions are not part of PCI address space.

PCI address space usage is discoverable via PCI device BARs, PCI bridge
window registers, or legacy IDE or VGA devices that use the hardwired
legacy resources, e.g., memory 0xa0000-0xbffff, io 0x3c0-0x3df, etc.

The System ROM and Video ROM areas are none of these, so they should be
reserved as part of the system address space, not the PCI address space.

Reserve the System ROM and Video ROM areas once per system.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci_common.c |   20 --------------------
 arch/sparc/mm/init_64.c        |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 14fa74f90fdb..38d46bcc8634 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -344,26 +344,6 @@ static void pci_register_legacy_regions(struct resource *io_res,
 	p->end = p->start + 0x1ffffUL;
 	p->flags = IORESOURCE_BUSY;
 	request_resource(mem_res, p);
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "System ROM";
-	p->start = mem_res->start + 0xf0000UL;
-	p->end = p->start + 0xffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "Video ROM";
-	p->start = mem_res->start + 0xc0000UL;
-	p->end = p->start + 0x7fffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
 }
 
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 995f9490334d..a9f94e911e0a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3089,6 +3089,20 @@ static struct resource bss_resource = {
 	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
 };
 
+static struct resource system_rom_resource = {
+	.name	= "System ROM",
+	.start  = 0xf0000,
+	.end    = 0xfffff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM,
+};
+
+static struct resource video_rom_resource = {
+	.name	= "Video ROM",
+	.start  = 0xc0000,
+	.end    = 0xc7fff,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM,
+};
+
 static inline resource_size_t compute_kern_paddr(void *addr)
 {
 	return (resource_size_t) (addr - KERNBASE + kern_base);
@@ -3134,6 +3148,9 @@ static int __init report_memory(void)
 		insert_resource(res, &bss_resource);
 	}
 
+	request_resource(&iomem_resource, &system_rom_resource);
+	request_resource(&iomem_resource, &video_rom_resource);
+
 	return 0;
 }
 arch_initcall(report_memory);
