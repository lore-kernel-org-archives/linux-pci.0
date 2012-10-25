Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965239Ab2JYSiq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 14:38:46 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 5/8] ixgbe: refactor mailbox ops init
Date: Thu, 25 Oct 2012 14:38:27 -0400
Message-Id: <1351190310-5043-6-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
References: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no actual dependency on initialization of the mailbox ops on
whether SR-IOV is enabled or not and it doesn't hurt to go ahead and
initialize ops unconditionally.  Move the initialization into the device
probe so that the mailbox ops are initialized at the time we have the
board info necessary to do it.

Authored-by: Greg Rose <gregory.v.rose@intel.com>
Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 5 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 9 +--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h | 3 +--
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 868af69..8d2a507 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7249,7 +7249,10 @@ static int __devinit ixgbe_probe(struct pci_dev *pdev,
 	}
 
 #ifdef CONFIG_PCI_IOV
-	ixgbe_enable_sriov(adapter, ii);
+	/* Mailbox */
+	ixgbe_init_mbx_params_pf(hw);
+	memcpy(&hw->mbx.ops, ii->mbx_ops, sizeof(hw->mbx.ops));
+	ixgbe_enable_sriov(adapter);
 
 #endif
 	netdev->features = NETIF_F_SG |
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index dce48bf..9aeb929 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -44,8 +44,7 @@
 #include "ixgbe_sriov.h"
 
 #ifdef CONFIG_PCI_IOV
-void ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
-			 const struct ixgbe_info *ii)
+void ixgbe_enable_sriov(struct ixgbe_adapter *adapter);
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	int num_vf_macvlans, i;
@@ -124,12 +123,6 @@ void ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 		kcalloc(adapter->num_vfs,
 			sizeof(struct vf_data_storage), GFP_KERNEL);
 	if (adapter->vfinfo) {
-		/* Now that we're sure SR-IOV is enabled
-		 * and memory allocated set up the mailbox parameters
-		 */
-		ixgbe_init_mbx_params_pf(hw);
-		memcpy(&hw->mbx.ops, ii->mbx_ops, sizeof(hw->mbx.ops));
-
 		/* limit trafffic classes based on VFs enabled */
 		if ((adapter->hw.mac.type == ixgbe_mac_82599EB) &&
 		    (adapter->num_vfs < 16)) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index 1be1d30..d96ead2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -43,8 +43,7 @@ int ixgbe_ndo_get_vf_config(struct net_device *netdev,
 void ixgbe_check_vf_rate_limit(struct ixgbe_adapter *adapter);
 void ixgbe_disable_sriov(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
-void ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
-			const struct ixgbe_info *ii);
+void ixgbe_enable_sriov(struct ixgbe_adapter *adapter);
 #endif
 
 
-- 
1.7.10.2.552.gaa3bb87

