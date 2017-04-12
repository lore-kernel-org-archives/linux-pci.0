Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/27] pci: Fix pci_mmap_fits() for HAVE_PCI_RESOURCE_TO_USER platforms
Date: Wed, 12 Apr 2017 13:25:50 +0100
Message-Id: <0d7c284a997414d7e9a264e21f316ca1ac673277.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

In the PCI_MMAP_PROCFS case when the address being passed by the user
is a 'user visible' resource address based on the bus window, and not
the actual contents of the resource, that's what we need to be checking
it against.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25d010d..7ac258f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -985,15 +985,19 @@ void pci_remove_legacy_files(struct pci_bus *b)
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 		  enum pci_mmap_api mmap_api)
 {
-	unsigned long nr, start, size, pci_start;
+	unsigned long nr, start, size;
+	resource_size_t pci_start = 0, pci_end;
 
 	if (pci_resource_len(pdev, resno) == 0)
 		return 0;
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
 	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
-	pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
-			pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
+	if (mmap_api == PCI_MMAP_PROCFS) {
+		pci_resource_to_user(pdev, resno, &pdev->resource[resno],
+				     &pci_start, &pci_end);
+		pci_start >>= PAGE_SHIFT;
+	}
 	if (start >= pci_start && start < pci_start + size &&
 			start + nr <= pci_start + size)
 		return 1;
-- 
2.9.3
