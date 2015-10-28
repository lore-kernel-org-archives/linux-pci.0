Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54326 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbbJ1QcW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Oct 2015 12:32:22 -0400
Date: Wed, 28 Oct 2015 11:32:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <aduyck@mirantis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iov: Update virtfn_max_buses to validate offset and
 stride
Message-ID: <20151028163216.GA2927@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205215.14626.93504.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027205215.14626.93504.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

Thanks a lot for cleaning this up.  I think this is a great
improvement over what I did.

On Tue, Oct 27, 2015 at 01:52:15PM -0700, Alexander Duyck wrote:
> This patch pulls the validation of offset and stride into virtfn_max_buses.
> The general idea is to validate offset and stride for each possible value
> of numvfs in addition to still determining the maximum bus value for the
> VFs.
> 
> I also reversed the loop as the most likely maximum will be when numvfs is
> set to total_VFs.  In addition this makes it so that we loop down to a
> value of 0 for numvfs which should be the resting state for the register.
> 
> Fixes: 8e20e89658f2 ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

I'd like to squash this together with my patch instead of having fixes
on top of fixes.  What do you think of the following?  (This applies
on top of 70675e0b6a1a ("PCI: Don't try to restore VF BARs")).


commit c20e11b572c5d4e4f01c86580a133122fbd13cfa
Author: Alexander Duyck <aduyck@mirantis.com>
Date:   Wed Oct 28 10:54:32 2015 -0500

    PCI: Set SR-IOV NumVFs to zero after enumeration
    
    The enumeration path should leave NumVFs set to zero.  But after
    4449f079722c ("PCI: Calculate maximum number of buses required for VFs"),
    we call virtfn_max_buses() in the enumeration path, which changes NumVFs.
    This NumVFs change is visible via lspci and sysfs until a driver enables
    SR-IOV.
    
    Iterate from TotalVFs down to zero so NumVFs is zero when we're finished
    computing the maximum number of buses.  Validate offset and stride in
    the loop, so we can test it at every possible NumVFs setting.  Rename
    virtfn_max_buses() to compute_max_vf_buses() to hint that it does have a
    side effect of updating iov->max_VF_buses.
    
    [bhelgaas: changelog, rename, reverse sense of error path]
    Fixes: 4449f079722c ("PCI: Calculate maximum number of buses required for VFs")
    Based-on-patch-by: Ethan Zhao <ethan.zhao@oracle.com>
    Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..120cfb3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -54,24 +54,33 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
  * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
  * determine how many additional bus numbers will be consumed by VFs.
  *
- * Iterate over all valid NumVFs and calculate the maximum number of bus
- * numbers that could ever be required.
+ * Iterate over all valid NumVFs, validate offset and stride, and calculate
+ * the maximum number of bus numbers that could ever be required.
  */
-static inline u8 virtfn_max_buses(struct pci_dev *dev)
+static int compute_max_vf_buses(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
-	int nr_virtfn;
-	u8 max = 0;
+	int nr_virtfn = iov->total_VFs;
 	int busnr;
 
-	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
-		pci_iov_set_numvfs(dev, nr_virtfn);
+	pci_iov_set_numvfs(dev, nr_virtfn);
+
+	while (nr_virtfn--) {
+		if (!iov->offset || !iov->stride)
+			goto err;
+
 		busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
-		if (busnr > max)
-			max = busnr;
+		if (busnr > iov->max_VF_buses)
+			iov->max_VF_buses = busnr;
+
+		pci_iov_set_numvfs(dev, nr_virtfn);
 	}
 
-	return max;
+	return 0;
+
+err:
+	pci_iov_set_numvfs(dev, 0);
+	return -EIO;
 }
 
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
@@ -384,7 +393,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	int rc;
 	int nres;
 	u32 pgsz;
-	u16 ctrl, total, offset, stride;
+	u16 ctrl, total;
 	struct pci_sriov *iov;
 	struct resource *res;
 	struct pci_dev *pdev;
@@ -414,11 +423,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 found:
 	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
-	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0);
-	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
-	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
-	if (!offset || (total > 1 && !stride))
-		return -EIO;
 
 	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
 	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0;
@@ -456,8 +460,6 @@ found:
 	iov->nres = nres;
 	iov->ctrl = ctrl;
 	iov->total_VFs = total;
-	iov->offset = offset;
-	iov->stride = stride;
 	iov->pgsz = pgsz;
 	iov->self = dev;
 	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
@@ -474,10 +476,15 @@ found:
 
 	dev->sriov = iov;
 	dev->is_physfn = 1;
-	iov->max_VF_buses = virtfn_max_buses(dev);
+	rc = compute_max_vf_buses(dev);
+	if (rc)
+		goto fail_max_buses;
 
 	return 0;
 
+fail_max_buses:
+	dev->sriov = NULL;
+	dev->is_physfn = 0;
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
