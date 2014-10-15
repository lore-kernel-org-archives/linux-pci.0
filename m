Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55452 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbaJOMDN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 08:03:13 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Russell King <linux@arm.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Michal Simek <monstr@monstr.eu>,
	Martin Wilck <martin.wilck@ts.fujitsu.com>,
	"Derrick J. Wong" <djwong@us.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH RFC 1/2] drivers: pci: fix pci_mmap_fits() implementation for procfs mmap
Date: Wed, 15 Oct 2014 13:03:40 +0100
Message-Id: <1413374624-30066-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The addresses stored in PCI device resources for memory spaces
correspond to CPU physical addresses, which do not necessarily
map 1:1 to PCI bus addresses as programmed in PCI devices configuration
spaces.

Therefore, the changes applied by commits:

8c05cd08a7504b855c26526
3b519e4ea618b6943a82931

imply that the sanity checks carried out in pci_mmap_fits() to
ensure that the user executes an mmap of a "real" pci resource are
erroneous when executed through procfs. Some platforms (ie SPARC)
expect the offset value to be passed in (procfs mapping) to be the
PCI BAR configuration value as read from the PCI device configuration
space, not the fixed-up CPU physical address that is present in PCI
device resources.

The required pgoff (offset in mmap syscall) value passed from userspace
is supposed to represent the resource value exported through
/proc/bus/pci/devices when the resource is mmapped though procfs (and 0
when the mapping is carried out through sysfs resource files), which
corresponds to the PCI resource filtered through the pci_resource_to_user()
API.

This patch converts the PCI resource to the expected "user visible"
value through pci_resource_to_user() before carrying out sanity checks
in pci_mmap_fits() so that the check is carried out on the resource
values as expected from the userspace mmap API.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: David S. Miller <davem@davemloft.net>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: Derrick J. Wong <djwong@us.ibm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/pci-sysfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 92b6d9a..777d8bc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -963,17 +963,20 @@ void pci_remove_legacy_files(struct pci_bus *b)
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *=
vma,
 =09=09  enum pci_mmap_api mmap_api)
 {
-=09unsigned long nr, start, size, pci_start;
+=09unsigned long nr, start, size, pci_offset;
+=09resource_size_t pci_start, pci_end;
=20
 =09if (pci_resource_len(pdev, resno) =3D=3D 0)
 =09=09return 0;
 =09nr =3D vma_pages(vma);
 =09start =3D vma->vm_pgoff;
+=09pci_resource_to_user(pdev, resno, &pdev->resource[resno],
+=09=09=09     &pci_start, &pci_end);
 =09size =3D ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
-=09pci_start =3D (mmap_api =3D=3D PCI_MMAP_PROCFS) ?
-=09=09=09pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
-=09if (start >=3D pci_start && start < pci_start + size &&
-=09=09=09start + nr <=3D pci_start + size)
+=09pci_offset =3D (mmap_api =3D=3D PCI_MMAP_PROCFS) ?
+=09=09=09pci_start >> PAGE_SHIFT : 0;
+=09if (start >=3D pci_offset && start < pci_offset + size &&
+=09=09=09start + nr <=3D pci_offset + size)
 =09=09return 1;
 =09return 0;
 }
--=20
2.1.2


