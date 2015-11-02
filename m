Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:55174 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbKBHon (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 02:44:43 -0500
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 2 Nov 2015 13:14:39 +0530
Date: Mon, 2 Nov 2015 15:28:16 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Duyck <aduyck@mirantis.com>,
	linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] PCI: Set SR-IOV NumVFs to zero after enumeration
Message-ID: <20151102072816.GA1120@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222254.11908.78884.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151030034821.GB3551@richards-mbp.cn.ibm.com>
 <56338F84.8070300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56338F84.8070300@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 08:40:52AM -0700, Alexander Duyck wrote:
>On 10/29/2015 08:48 PM, Wei Yang wrote:
>>On Thu, Oct 29, 2015 at 05:22:54PM -0500, Bjorn Helgaas wrote:
>>>ines: 115
>>>
>>>From: Alexander Duyck <aduyck@mirantis.com>
>>>
>>>The enumeration path should leave NumVFs set to zero.  But after
>>>4449f079722c ("PCI: Calculate maximum number of buses required for VFs"),
>>>we call virtfn_max_buses() in the enumeration path, which changes NumVFs.
>>>This NumVFs change is visible via lspci and sysfs until a driver enables
>>>SR-IOV.
>>>
>>>Iterate from TotalVFs down to zero so NumVFs is zero when we're finished
>>>computing the maximum number of buses.  Validate offset and stride in
>>>the loop, so we can test it at every possible NumVFs setting.  Rename
>>>virtfn_max_buses() to compute_max_vf_buses() to hint that it does have a
>>>side effect of updating iov->max_VF_buses.
>>>
>>>[bhelgaas: changelog, rename, allow numVF==1 && stride==0, rework loop,
>>>reverse sense of error path]
>>>Fixes: 4449f079722c ("PCI: Calculate maximum number of buses required for VFs")
>>>Based-on-patch-by: Ethan Zhao <ethan.zhao@oracle.com>
>>>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>>>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>---
>>>drivers/pci/iov.c |   41 ++++++++++++++++++++++-------------------
>>>1 file changed, 22 insertions(+), 19 deletions(-)
>>>
>>>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>index 0cdb2d1..1b1acc2 100644
>>>--- a/drivers/pci/iov.c
>>>+++ b/drivers/pci/iov.c
>>>@@ -54,24 +54,29 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
>>>  * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
>>>  * determine how many additional bus numbers will be consumed by VFs.
>>>  *
>>>- * Iterate over all valid NumVFs and calculate the maximum number of bus
>>>- * numbers that could ever be required.
>>>+ * Iterate over all valid NumVFs, validate offset and stride, and calculate
>>>+ * the maximum number of bus numbers that could ever be required.
>>>  */
>>>-static inline u8 virtfn_max_buses(struct pci_dev *dev)
>>>+static int compute_max_vf_buses(struct pci_dev *dev)
>>>{
>>>	struct pci_sriov *iov = dev->sriov;
>>>-	int nr_virtfn;
>>>-	u8 max = 0;
>>>-	int busnr;
>>>+	int nr_virtfn, busnr, rc = 0;
>>>
>>>-	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
>>>+	for (nr_virtfn = iov->total_VFs; nr_virtfn; nr_virtfn--) {
>>Hmm... I agree to iterate the nr_virtfn from total_VFs to 0, which keep the
>>original logic, before my patch.
>>
>>
>>>		pci_iov_set_numvfs(dev, nr_virtfn);
>>>+		if (!iov->offset || (nr_virtfn > 1 && !iov->stride)) {
>>                                      ^^^
>>
>>Should be this?
>>                 if (!iov->offset || (iov->total_VFs > 1 && !iov->stride))
>
>The problem is the spec says stride and offset can change depending on the
>value of NumVFs.  We end up testing all values from TotalVFs to 1.  The spec
>states that stride is unused if NumVFs is 1, not TotalVFs.
>

Yes, I checked the SPEC again, and found this change is correct.

>>
>>>+			rc = -EIO;
>>>+			goto out;
>>>+		}
>>>+
>>>		busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
>>>-		if (busnr > max)
>>>-			max = busnr;
>>>+		if (busnr > iov->max_VF_buses)
>>>+			iov->max_VF_buses = busnr;
>>>	}
>>>
>>>-	return max;
>>>+out:
>>>+	pci_iov_set_numvfs(dev, 0);
>>>+	return rc;
>>>}
>>>
>>>static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>>>@@ -384,7 +389,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>>	int rc;
>>>	int nres;
>>>	u32 pgsz;
>>>-	u16 ctrl, total, offset, stride;
>>>+	u16 ctrl, total;
>>>	struct pci_sriov *iov;
>>>	struct resource *res;
>>>	struct pci_dev *pdev;
>>>@@ -410,11 +415,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>>
>>>found:
>>>	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
>>>-	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0);
>>>-	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
>>>-	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
>>>-	if (!offset || (total > 1 && !stride))
>>>-		return -EIO;
>>>
>>Original code will return when it found this condition, so that we don't need
>>to bother to do those initialization and then fall back.
>>
>>So I suggest to keep it here.
>
>The problem is this code isn't valid as per the spec.  The offset and stride
>are considered unused when numvfs is 0.  That is why this has to be dropped.
>
>>>	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
>>>	if (!total)
>>>@@ -456,8 +456,6 @@ found:
>>>	iov->nres = nres;
>>>	iov->ctrl = ctrl;
>>>	iov->total_VFs = total;
>>>-	iov->offset = offset;
>>>-	iov->stride = stride;
>>>	iov->pgsz = pgsz;
>>>	iov->self = dev;
>>>	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
>>>@@ -474,10 +472,15 @@ found:
>>>
>>>	dev->sriov = iov;
>>>	dev->is_physfn = 1;
>>>-	iov->max_VF_buses = virtfn_max_buses(dev);
>>>+	rc = compute_max_vf_buses(dev);
>>>+	if (rc)
>>>+		goto fail_max_buses;
>>>
>>>	return 0;
>>>
>>>+fail_max_buses:
>>>+	dev->sriov = NULL;
>>The dev->sriov is allocated with kzalloc(), seems we forget to release it?
>
>No, if you check at the end of the function we release it via a kfree(iov).
>

Right.

>>>+	dev->is_physfn = 0;
>>>failed:
>>>	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>>		res = &dev->resource[i + PCI_IOV_R

-- 
Richard Yang
Help you, Help me

