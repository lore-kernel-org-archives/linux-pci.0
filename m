Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58920 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933071AbcFISUf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jun 2016 14:20:35 -0400
Subject: [PATCH v1 3/3] microblaze/PCI: Remove useless
 __pci_mmap_set_pgprot()
To: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michal Simek <monstr@monstr.eu>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Date: Thu, 09 Jun 2016 13:20:31 -0500
Message-ID: <20160609182031.13455.52037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160609181102.13455.33593.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160609181102.13455.33593.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The microblaze __pci_mmap_set_pgprot() was apparently copied from powerpc,
where it computes either an uncacheable pgprot_t or a write-combining one.
But on microblaze, we always use the regular uncacheable pgprot_t.

Remove the useless code in __pci_mmap_set_pgprot() and inline the
pgprot_noncached() at the only caller.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/microblaze/pci/pci-common.c |   31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 14cba60..1974567 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -219,33 +219,6 @@ static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
 }
 
 /*
- * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
- * device mapping.
- */
-static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
-				      pgprot_t protection,
-				      enum pci_mmap_state mmap_state,
-				      int write_combine)
-{
-	pgprot_t prot = protection;
-
-	/* Write combine is always 0 on non-memory space mappings. On
-	 * memory space, if the user didn't pass 1, we check for a
-	 * "prefetchable" resource. This is a bit hackish, but we use
-	 * this to workaround the inability of /sysfs to provide a write
-	 * combine bit
-	 */
-	if (mmap_state != pci_mmap_mem)
-		write_combine = 0;
-	else if (write_combine == 0) {
-		if (rp->flags & IORESOURCE_PREFETCH)
-			write_combine = 1;
-	}
-
-	return pgprot_noncached(prot);
-}
-
-/*
  * This one is used by /dev/mem and fbdev who have no clue about the
  * PCI device, it tries to find the PCI device first and calls the
  * above routine
@@ -317,9 +290,7 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 		return -EINVAL;
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
-						  vma->vm_page_prot,
-						  mmap_state, write_combine);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);

