Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v14 01/17] PCI: Fix proc mmap on sparc
Date: Fri, 16 Sep 2016 13:01:51 -0700
Message-Id: <20160916200207.21439-2-yinghai@kernel.org>
In-Reply-To: <20160916200207.21439-1-yinghai@kernel.org>
References: <20160916200207.21439-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
to check exposed value with resource start/end in proc mmap path.

|        start = vma->vm_pgoff;
|        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
|        pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
|                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
|        if (start >= pci_start && start < pci_start + size &&
|                        start + nr <= pci_start + size)

vma->vm_pgoff is above code segment is user/BAR value >> PAGE_SHIFT.
pci_start is resource->start >> PAGE_SHIFT.

For sparc, resource start is different from BAR start aka pci bus address.
pci bus address need to add offset to be the resource start.

So that commit breaks all arch that exposed value is BAR/user value,
and need to be offseted to resource address.

test code using: ./test_mmap_proc /proc/bus/pci/0000:00/04.0 0x2000000
test code segment:
  fd = open(argv[1], O_RDONLY);
  ...
  sscanf(argv[2], "0x%lx", &offset);
  left = offset & (PAGE_SIZE - 1);
  offset &= PAGE_MASK;
  ioctl(fd, PCIIOC_MMAP_IS_MEM);
  addr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, offset);
  for (i = 0; i < 8; i++)
    printf("%x ", addr[i + left]);
  munmap(addr, PAGE_SIZE);
  close(fd);

Fixes: 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index bcd10c7..e907154 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -974,15 +974,20 @@ void pci_remove_legacy_files(struct pci_bus *b)
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 		  enum pci_mmap_api mmap_api)
 {
-	unsigned long nr, start, size, pci_start;
+	unsigned long nr, start, size, pci_start = 0;
 
 	if (pci_resource_len(pdev, resno) == 0)
 		return 0;
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
 	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
-	pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
-			pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
+	if (mmap_api == PCI_MMAP_PROCFS) {
+		resource_size_t user_start, user_end;
+
+		pci_resource_to_user(pdev, resno, &pdev->resource[resno],
+					&user_start, &user_end);
+		pci_start = user_start >> PAGE_SHIFT;
+	}
 	if (start >= pci_start && start < pci_start + size &&
 			start + nr <= pci_start + size)
 		return 1;
-- 
2.8.3
