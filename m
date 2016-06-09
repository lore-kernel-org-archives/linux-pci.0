Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/3] PCI: Ignore write combining when mapping I/O port
 space
To: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michal Simek <monstr@monstr.eu>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Date: Thu, 09 Jun 2016 13:20:16 -0500
Message-ID: <20160609182016.13455.78148.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160609181102.13455.33593.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160609181102.13455.33593.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI exposes files like /proc/bus/pci/00/00.0 in procfs.  These files
support operations like this:

  ioctl(fd, PCIIOC_MMAP_IS_IO);           # request I/O port space
  ioctl(fd, PCIIOC_WRITE_COMBINE, 1);     # request write-combining
  mmap(fd, ...)

Write combining is useful on PCI memory space, but I don't think it makes
sense on PCI I/O port space.

We *could* change proc_bus_pci_ioctl() to make it impossible to set
mmap_state == pci_mmap_io and write_combine at the same time, but that
would break the following sequence, which is currently legal:

  mmap(fd, ...)                           # default is I/O, non-combining
  ioctl(fd, PCIIOC_WRITE_COMBINE, 1);     # request write-combining
  ioctl(fd, PCIIOC_MMAP_IS_MEM);          # request memory space
  mmap(fd, ...)

Ignore the write-combining flag when mapping I/O port space.

This patch should have no functional effect, based on this analysis of all
implementations of pci_mmap_page_range():

  - ia64 mips parisc sh unicore32 x86 do not support mapping of I/O port
    space at all.

  - arm cris microblaze mn10300 sparc xtensa support mapping of I/O port
    space, but ignore the write_combine argument to pci_mmap_page_range().

  - powerpc supports mapping of I/O port space and uses write_combine, and
    it disables write combining for I/O port space in
    __pci_mmap_set_pgprot().

This patch makes it possible to remove __pci_mmap_set_pgprot() from
powerpc, which simplifies that path.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/proc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 3f155e7..2408abe 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -231,7 +231,7 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
-	int i, ret;
+	int i, ret, write_combine;
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
@@ -245,9 +245,12 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
+	if (fpriv->mmap_state == pci_mmap_mem)
+		write_combine = fpriv->write_combine;
+	else
+		write_combine = 0;
 	ret = pci_mmap_page_range(dev, vma,
-				  fpriv->mmap_state,
-				  fpriv->write_combine);
+				  fpriv->mmap_state, write_combine);
 	if (ret < 0)
 		return ret;
 
