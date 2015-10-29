Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 2/7] PCI: Remove redundant validation of SR-IOV
 offset/stride registers
To: Alexander Duyck <aduyck@mirantis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2015 17:23:01 -0500
Message-ID: <20151029222301.11908.97709.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <aduyck@mirantis.com>

Previously, we read, validated, and cached PCI_SRIOV_VF_OFFSET and
PCI_SRIOV_VF_STRIDE in sriov_enable().  But sriov_init() now does
that via compute_max_vf_buses(), so we don't need to do it again.

Remove the PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE config reads from
sriov_enable().  The pci_sriov structure already contains the offset and
stride corresponding to the current NumVFs.

[bhelgaas: split to separate patch for reviewability]
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 1b1acc2..ca400a9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -235,7 +235,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	int rc;
 	int i, j;
 	int nres;
-	u16 offset, stride, initial;
+	u16 initial;
 	struct resource *res;
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
@@ -258,11 +258,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial)))
 		return -EINVAL;
 
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &offset);
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &stride);
-	if (!offset || (nr_virtfn > 1 && !stride))
-		return -EIO;
-
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		bars |= (1 << (i + PCI_IOV_RESOURCES));
@@ -275,9 +270,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		return -ENOMEM;
 	}
 
-	iov->offset = offset;
-	iov->stride = stride;
-
 	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
 	if (bus > dev->bus->busn_res.end) {
 		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",

