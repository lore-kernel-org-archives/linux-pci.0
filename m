Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 4/7] PCI: Reorder pcibios_sriov_disable()
To: Alexander Duyck <aduyck@mirantis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2015 17:23:15 -0500
Message-ID: <20151029222315.11908.6949.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <aduyck@mirantis.com>

Move pcibios_sriov_disable() up so it's defined before a future use.

[bhelgaas: split to separate patch for reviewability]
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c86d94c..fada98d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -227,7 +227,12 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 
 int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
-       return 0;
+	return 0;
+}
+
+int __weak pcibios_sriov_disable(struct pci_dev *pdev)
+{
+	return 0;
 }
 
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
@@ -344,11 +349,6 @@ failed:
 	return rc;
 }
 
-int __weak pcibios_sriov_disable(struct pci_dev *pdev)
-{
-       return 0;
-}
-
 static void sriov_disable(struct pci_dev *dev)
 {
 	int i;

