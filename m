Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/27] pci: Use BAR index in sysfs attr->private instead of resource pointer
Date: Wed, 12 Apr 2017 13:25:57 +0100
Message-Id: <2325fe926807a7d4cde95c3cfd5d9b88ac4949b1.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

We store the pointer, and then on *every* use of it we loop over the
device's resources to find out the index. That's kind of silly.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/pci/pci-sysfs.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index cb04bc2..534844d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1017,26 +1017,20 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 			     struct vm_area_struct *vma, int write_combine)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	struct resource *res = attr->private;
+	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
 	resource_size_t start, end;
-	int i;
-
-	for (i = 0; i < PCI_ROM_RESOURCE; i++)
-		if (res == &pdev->resource[i])
-			break;
-	if (i >= PCI_ROM_RESOURCE)
-		return -ENODEV;
+	struct resource *res = &pdev->resource[bar];
 
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (!pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)) {
+	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS)) {
 		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
 			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
-			pci_name(pdev), i,
-			(u64)pci_resource_start(pdev, i),
-			(u64)pci_resource_len(pdev, i));
+			pci_name(pdev), bar,
+			(u64)pci_resource_start(pdev, bar),
+			(u64)pci_resource_len(pdev, bar));
 		return -EINVAL;
 	}
 
@@ -1044,7 +1038,7 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	 * from /proc/bus/pci/ which is a "user visible" value. If this is
 	 * different from the resource itself, arch will do necessary fixup.
 	 */
-	pci_resource_to_user(pdev, i, res, &start, &end);
+	pci_resource_to_user(pdev, bar, res, &start, &end);
 	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 	return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
@@ -1069,22 +1063,18 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			       loff_t off, size_t count, bool write)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	struct resource *res = attr->private;
+	int bar = (unsigned long)attr->private;
+	struct resource *res;
 	unsigned long port = off;
-	int i;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++)
-		if (res == &pdev->resource[i])
-			break;
-	if (i >= PCI_ROM_RESOURCE)
-		return -ENODEV;
+	res = &pdev->resource[bar];
 
-	port += pci_resource_start(pdev, i);
+	port += pci_resource_start(pdev, bar);
 
-	if (port > pci_resource_end(pdev, i))
+	if (port > pci_resource_end(pdev, bar))
 		return 0;
 
-	if (port + count - 1 > pci_resource_end(pdev, i))
+	if (port + count - 1 > pci_resource_end(pdev, bar))
 		return -EINVAL;
 
 	switch (count) {
@@ -1186,7 +1176,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = S_IRUSR | S_IWUSR;
 	res_attr->size = pci_resource_len(pdev, num);
-	res_attr->private = &pdev->resource[num];
+	res_attr->private = (void *)(unsigned long)num;
 	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
 	if (retval)
 		kfree(res_attr);
-- 
2.9.3
