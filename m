Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ben Shelton <benjamin.h.shelton@intel.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Shelton <benjamin.h.shelton@intel.com>
Subject: [PATCH v2] PCI: IOV: read SRIOV_NUM_VF after enabling ARI
Date: Thu,  8 Oct 2015 10:20:17 -0500
Message-Id: <1444317617-13399-1-git-send-email-benjamin.h.shelton@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For some SR-IOV devices, the number of available virtual functions increases
after enabling ARI.  Currently, SRIOV_NUM_VF is read and saved off before the
ARI control bit is enabled in SRIOV_CTRL.  This causes an issue when VFs are
enabled.

At device init, SRIOV_INITIAL_VF and SRIOV_NUM_VF are specified to contain the
number of available VFs for the device.  sriov_enable() does a sanity check
that SRIOV_INITIAL_VF is not greater than iov->total_VFs, the saved-off value
of SRIOV_NUM_VF.  Since the value of both SRIOV_INITIAL_VF and SRIOV_NUM_VF has
increased after enabling the ARI bit, the check fails, and the VFs cannot be
enabled.

To fix the issue, write SRIOV_CTRL first, and then read SRIOV_NUM_VF.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
---

Changes since v1:
 * Moved read of SRIOV_NUM_VF rather than re-reading it if ARI was enabled.

 drivers/pci/iov.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..0174044 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -399,10 +399,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		ssleep(1);
 	}
 
-	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
-	if (!total)
-		return 0;
-
 	ctrl = 0;
 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
 		if (pdev->is_physfn)
@@ -414,6 +410,11 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 found:
 	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
+
+	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
+	if (!total)
+		return 0;
+
 	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
-- 
1.9.5

