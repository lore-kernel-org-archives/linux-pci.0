Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55473 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaJOMDN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 08:03:13 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH RFC 2/2] arm: kernel: fix pci_mmap_page_range() offset calculation
Date: Wed, 15 Oct 2014 13:03:41 +0100
Message-Id: <1413374624-30066-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1413374624-30066-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1413374624-30066-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_mmap_page_range() API should be written to expect offset
values representing PCI memory resource addresses as seen by user space,
through the pci_resource_to_user() API.

ARM relies on the standard implementation of pci_resource_to_user()
which actually is an identity map and exports to user space
PCI memory resources as they are stored in PCI devices resources (ie BARs)
which represent CPU physical addresses (fixed-up using BUS to CPU
address conversions) not PCI bus addresses.

On platforms where the mapping between CPU and BUS address is not a 1:1
mapping this is erroneous, in that an additional shift is applied to
an already fixed-up offset passed from userspace.

Hence, this patch removes the mem_offset from the pgoff calculation
since the offset as passed from user space already represents
the CPU physical address corresponding to the resource to be mapped,
ie no additional offset should be applied.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/bios32.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..b56fa2d 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -626,21 +626,15 @@ int pcibios_enable_device(struct pci_dev *dev, int ma=
sk)
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 =09=09=09enum pci_mmap_state mmap_state, int write_combine)
 {
-=09struct pci_sys_data *root =3D dev->sysdata;
-=09unsigned long phys;
-
-=09if (mmap_state =3D=3D pci_mmap_io) {
+=09if (mmap_state =3D=3D pci_mmap_io)
 =09=09return -EINVAL;
-=09} else {
-=09=09phys =3D vma->vm_pgoff + (root->mem_offset >> PAGE_SHIFT);
-=09}
=20
 =09/*
 =09 * Mark this as IO
 =09 */
 =09vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
=20
-=09if (remap_pfn_range(vma, vma->vm_start, phys,
+=09if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 =09=09=09     vma->vm_end - vma->vm_start,
 =09=09=09     vma->vm_page_prot))
 =09=09return -EAGAIN;
--=20
2.1.2


