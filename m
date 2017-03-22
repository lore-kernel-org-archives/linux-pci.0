Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759807AbdCVNZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2017 09:25:33 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] pci: Only allow WC mmap on prefetchable resources
Date: Wed, 22 Mar 2017 13:25:17 +0000
Message-Id: <a1b17c98858efd323fcd91a1e0898e8f0e45f442.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

The /proc/bus/pci mmap interface allows the user to specify whether they
want WC or not. Don't let them do so on non-prefetchable BARs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 drivers/pci/proc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 62a0c3e..dc8912e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -231,7 +231,7 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
-	int i, ret, write_combine, res_bit;
+	int i, ret, write_combine = 0, res_bit;
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
@@ -251,10 +251,13 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
-	if (fpriv->mmap_state == pci_mmap_mem)
-		write_combine = fpriv->write_combine;
-	else
-		write_combine = 0;
+	if (fpriv->mmap_state == pci_mmap_mem &&
+	    fpriv->write_combine) {
+		if (dev->resource[i].flags & IORESOURCE_PREFETCH)
+			write_combine = 1;
+		else
+			return -EINVAL;
+	}
 	ret = pci_mmap_page_range(dev, vma,
 				  fpriv->mmap_state, write_combine);
 	if (ret < 0)
-- 
2.9.3
