Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945982Ab2JaVTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 17:19:30 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 7/8] ixgbe: sysfs sriov configuration callback support
Date: Wed, 31 Oct 2012 17:19:12 -0400
Message-Id: <1351718353-6124-8-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement callbacks in the driver for the new PCI bus driver
interface that allows the user to enable/disable SR-IOV VFs
in a device via the sysfs interface.

Authored-by: Greg Rose <gregory.v.rose@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 28 +++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 89 +++++++++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  6 +-
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5bd2676..89fa3f8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -753,5 +753,8 @@ extern int ixgbe_ptp_hwtstamp_ioctl(struct ixgbe_adapter *adapter,
 extern void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter);
 extern void ixgbe_ptp_check_pps_event(struct ixgbe_adapter *adapter, u32 eicr);
 #endif /* CONFIG_IXGBE_PTP */
+#ifdef CONFIG_PCI_IOV
+void ixgbe_sriov_reinit(struct ixgbe_adapter *adapter);
+#endif
 
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8d2a507..5d868e4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6784,6 +6784,26 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 }
 
 #endif /* CONFIG_IXGBE_DCB */
+#ifdef CONFIG_PCI_IOV
+void ixgbe_sriov_reinit(struct ixgbe_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	rtnl_lock();
+#ifdef CONFIG_IXGBE_DCB
+	ixgbe_setup_tc(netdev, netdev_get_num_tc(netdev));
+#else
+	if (netif_running(netdev))
+		ixgbe_close(netdev);
+	ixgbe_clear_interrupt_scheme(adapter);
+	ixgbe_init_interrupt_scheme(adapter);
+	if (netif_running(netdev))
+		ixgbe_open(netdev);
+#endif
+	rtnl_unlock();
+}
+
+#endif
 void ixgbe_do_reset(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
@@ -7519,7 +7539,12 @@ static void __devexit ixgbe_remove(struct pci_dev *pdev)
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
-	ixgbe_disable_sriov(adapter);
+	/*
+	 * Only disable SR-IOV on unload if the user specified the now
+	 * deprecated max_vfs module parameter.
+	 */
+	if (max_vfs)
+		ixgbe_disable_sriov(adapter);
 
 	ixgbe_clear_interrupt_scheme(adapter);
 
@@ -7734,6 +7759,7 @@ static struct pci_driver ixgbe_driver = {
 	.resume   = ixgbe_resume,
 #endif
 	.shutdown = ixgbe_shutdown,
+	.sriov_configure = ixgbe_pci_sriov_configure,
 	.err_handler = &ixgbe_err_handler
 };
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 7c068b4..60a2f4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -217,11 +217,12 @@ static bool ixgbe_vfs_are_assigned(struct ixgbe_adapter *adapter)
 }
 
 #endif /* #ifdef CONFIG_PCI_IOV */
-void ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
+int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 gpie;
 	u32 vmdctl;
+	int rss;
 
 	/* set num VFs to 0 to prevent access to vfinfo */
 	adapter->num_vfs = 0;
@@ -236,7 +237,7 @@ void ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 
 	/* if SR-IOV is already disabled then there is nothing to do */
 	if (!(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED))
-		return;
+		return 0;
 
 #ifdef CONFIG_PCI_IOV
 	/*
@@ -246,7 +247,7 @@ void ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 	 */
 	if (ixgbe_vfs_are_assigned(adapter)) {
 		e_dev_warn("Unloading driver while VFs are assigned - VFs will not be deallocated\n");
-		return;
+		return -EPERM;
 	}
 	/* disable iov and allow time for transactions to clear */
 	pci_disable_sriov(adapter->pdev);
@@ -269,10 +270,92 @@ void ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 		adapter->flags &= ~IXGBE_FLAG_VMDQ_ENABLED;
 	adapter->ring_feature[RING_F_VMDQ].offset = 0;
 
+	rss = min_t(int, IXGBE_MAX_RSS_INDICES, num_online_cpus());
+	adapter->ring_feature[RING_F_RSS].limit = rss;
+
 	/* take a breather then clean up driver data */
 	msleep(100);
 
 	adapter->flags &= ~IXGBE_FLAG_SRIOV_ENABLED;
+	return 0;
+}
+
+int ixgbe_pci_sriov_enable(struct pci_dev *dev, int num_vfs)
+{
+#ifdef CONFIG_PCI_IOV
+	struct ixgbe_adapter *adapter = pci_get_drvdata(dev);
+	int err = 0;
+	int i;
+	int pre_existing_vfs = pci_num_vf(dev);
+
+	if (pre_existing_vfs && pre_existing_vfs != num_vfs)
+		err = ixgbe_disable_sriov(adapter);
+	else if (pre_existing_vfs && pre_existing_vfs == num_vfs)
+		goto out;
+
+	if (err)
+		goto err_out; 
+
+	/*
+	 * While the SR-IOV capability structure reports total VFs to be
+	 * 64 we limit the actual number that can be allocated to 63 so
+	 * that some transmit/receive resources can be reserved to the
+	 * PF.  The PCI bus driver already checks for other values out of
+	 * range.
+	 */
+	if (num_vfs > 63) {
+		err = -EPERM;
+		goto err_out;
+	}
+
+	adapter->num_vfs = num_vfs;
+
+	if ((err = __ixgbe_enable_sriov(adapter)))
+		goto err_out;
+
+	for (i = 0; i < adapter->num_vfs; i++)
+		ixgbe_vf_configuration(dev, (i | 0x10000000));
+
+	err = pci_enable_sriov(dev, num_vfs);
+	if (err) {
+		e_dev_warn("Failed to enable PCI sriov: %d\n", err);
+		goto err_out;
+	}
+	ixgbe_sriov_reinit(adapter);
+
+out:
+	return num_vfs;
+
+err_out:
+	return err;
+#endif
+	return 0;
+}
+
+int ixgbe_pci_sriov_disable(struct pci_dev *dev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(dev);
+	int err;
+	u32 current_flags = adapter->flags;
+
+	err = ixgbe_disable_sriov(adapter);
+
+	/* Only reinit if no error and state changed */
+	if (!err && current_flags != adapter->flags) {
+		/* ixgbe_disable_sriov() doesn't clear VMDQ flag */
+		adapter->flags &= ~IXGBE_FLAG_VMDQ_ENABLED;
+		ixgbe_sriov_reinit(adapter);
+	}
+
+	return err;
+}
+
+int ixgbe_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+{
+	if (num_vfs == 0)
+		return ixgbe_pci_sriov_disable(dev);
+	else
+		return ixgbe_pci_sriov_enable(dev, num_vfs);
 }
 
 static int ixgbe_set_vf_multicasts(struct ixgbe_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index d96ead2..3d0fb07 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -41,11 +41,13 @@ int ixgbe_ndo_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
 int ixgbe_ndo_get_vf_config(struct net_device *netdev,
 			    int vf, struct ifla_vf_info *ivi);
 void ixgbe_check_vf_rate_limit(struct ixgbe_adapter *adapter);
-void ixgbe_disable_sriov(struct ixgbe_adapter *adapter);
+int ixgbe_disable_sriov(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
 void ixgbe_enable_sriov(struct ixgbe_adapter *adapter);
 #endif
-
+int ixgbe_pci_sriov_enable(struct pci_dev *dev, int num_vfs);
+int ixgbe_pci_sriov_disable(struct pci_dev *dev);
+int ixgbe_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
 
 #endif /* _IXGBE_SRIOV_H_ */
 
-- 
1.7.10.2.552.gaa3bb87

