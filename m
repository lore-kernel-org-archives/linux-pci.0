Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ben Shelton <benjamin.h.shelton@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ben Shelton <benjamin.h.shelton@intel.com>
Subject: [PATCH] PCI: IOV: reread SRIOV_NUM_VF after enabling ARI
Date: Fri, 11 Sep 2015 16:55:00 -0500
Message-Id: <1442008500-3570-1-git-send-email-benjamin.h.shelton@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For some SR-IOV devices, the number of available virtual functions
increases after enabling ARI.  Currently, SRIOV_NUM_VF is read and saved
off before the ARI control bit is enabled.  This causes an issue when VFs
are enabled.

At device init, SRIOV_INITIAL_VF and SRIOV_NUM_VF are specified to contain
the number of available VFs for the device.  sriov_enable() does a sanity
check that PCI_SRIOV_INITIAL_VF is not greater than iov->total_VFs, the
saved-off value of SRIOV_NUM_VF.  Since the value of both SRIOV_INITIAL_VF
and SRIOV_NUM_VF has increased after enabling the ARI bit, the check fails,
and the VFs cannot be enabled.

To fix the issue, after ARI is enabled for a device, reread SRIOV_NUM_VF.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
---
 drivers/pci/iov.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..88b1959 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -388,6 +388,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	struct pci_sriov *iov;
 	struct resource *res;
 	struct pci_dev *pdev;
+	bool total_needs_reread = false;
 
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
 	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
@@ -409,12 +410,18 @@ static int sriov_init(struct pci_dev *dev, int pos)
 			goto found;
 
 	pdev = NULL;
-	if (pci_ari_enabled(dev->bus))
+	if (pci_ari_enabled(dev->bus)) {
 		ctrl |= PCI_SRIOV_CTRL_ARI;
+		total_needs_reread = true;
+	}
 
 found:
 	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
 	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0);
+
+	if (total_needs_reread)
+		pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
+
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
 	if (!offset || (total > 1 && !stride))
-- 
1.9.5

