Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/27] pci: Fix another sanity check bug in /proc/pci mmap
Date: Wed, 12 Apr 2017 13:25:51 +0100
Message-Id: <08d0400c6bf711e3b26824eaa2870c1502f79834.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Don't match MMIO maps with I/O BARs and vice versa.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 drivers/pci/proc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f82710a..62a0c3e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -231,14 +231,20 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
-	int i, ret, write_combine;
+	int i, ret, write_combine, res_bit;
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
+	if (fpriv->mmap_state == pci_mmap_io)
+		res_bit = IORESOURCE_IO;
+	else
+		res_bit = IORESOURCE_MEM;
+
 	/* Make sure the caller is mapping a real resource for this device */
 	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
-		if (pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
+		if (dev->resource[i].flags & res_bit &&
+		    pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
 			break;
 	}
 
-- 
2.9.3
