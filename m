Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/5] iov: Reset resources to 0 if totalVFs increases after
 enabling ARI
From: Alexander Duyck <aduyck@mirantis.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2015 13:52:21 -0700
Message-ID: <20151027205221.14626.8940.stgit@localhost.localdomain>
In-Reply-To: <20151027204607.14626.59671.stgit@localhost.localdomain>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch forces us to reallocate VF BARs if the totalVFs value has
increased after enabling ARI.  This normally shouldn't occur, however I
have seen some non-spec devices that shift between 7 and some value greater
than 7 based on the ARI value and we want to avoid triggering any issues
with such devices.

Fixes: 3aa71da412fe ("PCI: Enable SR-IOV ARI Capable Hierarchy before reading TotalVFs")
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/pci/iov.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 099050d78a39..238950412de0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -393,7 +393,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	int rc;
 	int nres;
 	u32 pgsz;
-	u16 ctrl, total;
+	u16 ctrl, total, orig_total;
 	struct pci_sriov *iov;
 	struct resource *res;
 	struct pci_dev *pdev;
@@ -402,6 +402,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
 		return -ENODEV;
 
+	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &orig_total);
 	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
 	if (ctrl & PCI_SRIOV_CTRL_VFE) {
 		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, 0);
@@ -450,6 +451,14 @@ found:
 		}
 		iov->barsz[i] = resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
+
+		/* force reallocation of BARs if total VFs increased */
+		if (orig_total < total) {
+			res->flags |= IORESOURCE_UNSET;
+			res->end -= res->start;
+			res->start = 0;
+		}
+
 		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
 			 i, res, i, total);
 		i += bar64;

