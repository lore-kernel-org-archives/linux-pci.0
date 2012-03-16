Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:44312 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946331Ab2CPXsL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:48:11 -0400
Received: by yenq2 with SMTP id q2so763302yen.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:48:09 -0700 (PDT)
Subject: [PATCH v2 3/7] powerpc/PCI: compute I/O space bus-to-resource offset
	consistently
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 16 Mar 2012 17:48:09 -0600
Message-ID: <20120316234809.6649.97788.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make sure we compute CPU addresses (resource start/end) the same way both
when we set up the I/O aperture (hose->io_resource) and when we use
pcibios_bus_to_resource() to convert BAR values into resources.

This fixes a build failure ("cast from pointer to integer of different
size" in configs where resource_size_t is 64 bits but pointers are 32 bits)
I introduced in 6c5705fec63d.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/pci.h   |    1 +
 arch/powerpc/kernel/pci-common.c |    8 ++++++--
 arch/powerpc/kernel/pci_32.c     |    6 +++---
 arch/powerpc/kernel/pci_64.c     |    2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 201e352..6653f27 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -182,6 +182,7 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
+extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 910b9de..2efd52d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1492,6 +1492,11 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
+resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
+{
+	return (unsigned long) hose->io_base_virt - _IO_BASE;
+}
+
 static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
 {
 	struct resource *res;
@@ -1516,8 +1521,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 		 (unsigned long long)res->start,
 		 (unsigned long long)res->end,
 		 (unsigned long)res->flags);
-	pci_add_resource_offset(resources, res,
-			(resource_size_t) hose->io_base_virt - _IO_BASE);
+	pci_add_resource_offset(resources, res, pcibios_io_space_offset(hose));
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index fdd1a3d..4b06ec5 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -219,9 +219,9 @@ void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
 	struct resource *res = &hose->io_resource;
 
 	/* Fixup IO space offset */
-	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	res->start = (res->start + io_offset) & 0xffffffffu;
-	res->end = (res->end + io_offset) & 0xffffffffu;
+	io_offset = pcibios_io_space_offset(hose);
+	res->start += io_offset;
+	res->end += io_offset;
 }
 
 static int __init pcibios_init(void)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 75417fd..94a54f6 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -168,7 +168,7 @@ static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
-	io_virt_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+	io_virt_offset = pcibios_io_space_offset(hose);
 	hose->io_resource.start += io_virt_offset;
 	hose->io_resource.end += io_virt_offset;
 

