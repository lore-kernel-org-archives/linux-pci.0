Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40501 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945979Ab2JaVTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 17:19:30 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 6/8] ixgbe: refactor SRIOV enable and disable for sysfs interface
Date: Wed, 31 Oct 2012 17:19:11 -0400
Message-Id: <1351718353-6124-7-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In preparation for enable/disable of SR-IOV via the pci sysfs interface
move some core SR-IOV enablement code that would be common to module
parameter usage or callback from the pci bus driver to a separate
function so that it can be used by either method.

Authored-by: Greg Rose <gregory.v.rose@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 98 +++++++++++++++-----------
 1 file changed, 58 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 9aeb929..7c068b4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -44,49 +44,11 @@
 #include "ixgbe_sriov.h"
 
 #ifdef CONFIG_PCI_IOV
-void ixgbe_enable_sriov(struct ixgbe_adapter *adapter);
+static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	int num_vf_macvlans, i;
 	struct vf_macvlans *mv_list;
-	int pre_existing_vfs = 0;
-
-	pre_existing_vfs = pci_num_vf(adapter->pdev);
-	if (!pre_existing_vfs && !adapter->num_vfs)
-		return;
-
-	/* If there are pre-existing VFs then we have to force
-	 * use of that many because they were not deleted the last
-	 * time someone removed the PF driver.  That would have
-	 * been because they were allocated to guest VMs and can't
-	 * be removed.  Go ahead and just re-enable the old amount.
-	 * If the user wants to change the number of VFs they can
-	 * use ethtool while making sure no VFs are allocated to
-	 * guest VMs... i.e. the right way.
-	 */
-	if (pre_existing_vfs) {
-		adapter->num_vfs = pre_existing_vfs;
-		dev_warn(&adapter->pdev->dev, "Virtual Functions already "
-			 "enabled for this device - Please reload all "
-			 "VF drivers to avoid spoofed packet errors\n");
-	} else {
-		int err;
-		/*
-		 * The 82599 supports up to 64 VFs per physical function
-		 * but this implementation limits allocation to 63 so that
-		 * basic networking resources are still available to the
-		 * physical function.  If the user requests greater thn
-		 * 63 VFs then it is an error - reset to default of zero.
-		 */
-		adapter->num_vfs = min_t(unsigned int, adapter->num_vfs, 63);
-
-		err = pci_enable_sriov(adapter->pdev, adapter->num_vfs);
-		if (err) {
-			e_err(probe, "Failed to enable PCI sriov: %d\n", err);
-			adapter->num_vfs = 0;
-			return;
-		}
-	}
 
 	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED;
 	e_info(probe, "SR-IOV enabled with %d VFs\n", adapter->num_vfs);
@@ -156,10 +118,66 @@ void ixgbe_enable_sriov(struct ixgbe_adapter *adapter);
 		/* enable spoof checking for all VFs */
 		for (i = 0; i < adapter->num_vfs; i++)
 			adapter->vfinfo[i].spoofchk_enabled = true;
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+/*
+ * Note this function is called when the user wants to enable SR-IOV
+ * VFs using the now deprecated module parameter
+ */
+void ixgbe_enable_sriov(struct ixgbe_adapter *adapter)
+{
+	int pre_existing_vfs = 0;
+
+	pre_existing_vfs = pci_num_vf(adapter->pdev);
+	if (!pre_existing_vfs && !adapter->num_vfs)
 		return;
+
+	if (!pre_existing_vfs)
+		dev_warn(&adapter->pdev->dev,
+		 	 "Enabling SR-IOV VFs using the module parameter is deprecated - please use the pci sysfs interface.\n");
+
+	/*
+	 * If there are pre-existing VFs then we have to force
+	 * use of that many - over ride any module parameter value.
+	 * This may result from the user unloading the PF driver
+	 * while VFs were assigned to guest VMs or because the VFs
+	 * have been created via the new PCI SR-IOV sysfs interface.
+	 */
+	if (pre_existing_vfs) {
+		adapter->num_vfs = pre_existing_vfs;
+		dev_warn(&adapter->pdev->dev, "Virtual Functions already "
+			 "enabled for this device - Please reload all "
+			 "VF drivers to avoid spoofed packet errors\n");
+	} else {
+		int err;
+		/*
+		 * The 82599 supports up to 64 VFs per physical function
+		 * but this implementation limits allocation to 63 so that
+		 * basic networking resources are still available to the
+		 * physical function.  If the user requests greater thn
+		 * 63 VFs then it is an error - reset to default of zero.
+		 */
+		adapter->num_vfs = min_t(unsigned int, adapter->num_vfs, 63);
+
+		err = pci_enable_sriov(adapter->pdev, adapter->num_vfs);
+		if (err) {
+			e_err(probe, "Failed to enable PCI sriov: %d\n", err);
+			adapter->num_vfs = 0;
+			return;
+		}
 	}
 
-	/* Oh oh */
+	if (!__ixgbe_enable_sriov(adapter))
+		return;
+
+	/*
+	 * If we have gotten to this point then there is no memory available
+	 * to manage the VF devices - print message and bail.
+	 */
 	e_err(probe, "Unable to allocate memory for VF Data Storage - "
 	      "SRIOV disabled\n");
 	ixgbe_disable_sriov(adapter);
-- 
1.7.10.2.552.gaa3bb87

