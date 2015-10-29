Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 7/7] PCI: Set NumVFs before computing how many buses VFs
 require
To: Alexander Duyck <aduyck@mirantis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2015 17:23:36 -0500
Message-ID: <20151029222336.11908.66193.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <aduyck@mirantis.com>

VF bus numbers depend on the First VF Offset and VF Stride, and per
sections 3.3.9 and 3.3.10 of the SR-IOV spec r1.1, these depend on the
NumVF value.

Wait until after we set NumVFs to compute and validate the bus number of
the last VF.

[bhelgaas: changelog, add spec reference, split to separate patch for
reviewability]
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index bd1c4fa..9d29712 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -274,13 +274,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		return -ENOMEM;
 	}
 
-	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
-	if (bus > dev->bus->busn_res.end) {
-		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
-			nr_virtfn, bus, &dev->bus->busn_res);
-		return -ENOMEM;
-	}
-
 	if (pci_enable_resources(dev, bars)) {
 		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
 		return -ENOMEM;
@@ -304,6 +297,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	}
 
 	pci_iov_set_numvfs(dev, nr_virtfn);
+
+	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
+	if (bus > dev->bus->busn_res.end) {
+		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
+			nr_virtfn, bus, &dev->bus->busn_res);
+		rc = -ENOMEM;
+		goto err_bus;
+	}
+
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
@@ -342,7 +344,7 @@ err_pcibios:
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
-
+err_bus:
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 

