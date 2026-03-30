Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90673398905;
	Mon, 30 Mar 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911777; cv=none; b=J5DIo3DQnOmmC19EJ5nAdHjCRGr0zkLdvA3tY4e3ycZ5TF/br/wmmGK+CiNZxe0UdRTMyDTAsZyGH1rtQ6gLc8DoS/K4SUqrGsKUhWarFyKwMk27R3b6P4UES05RHa+PbSjMFNYL6Fmduijj5zmcbBgvCCxDJqXO/MPI9zMm/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911777; c=relaxed/simple;
	bh=Ed5V2hmcxxu7yQL6n80HzX/Bg/5WgEmq3+NmnnOazks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwQLmm8RgcBbJ7CgH0y4bJpxCJPAsTCB6u0PuCSZ+j9scwIgOiWXVcJkjMHoXTxjeKmQEH/qTKrlJ1leDGxVesr7uzzzeGtBIXF5EQCBw7hoPF8gcfu15AMCZfCIqfYLnpDmzL3l6XZcpk5nynHuQbkenQfUYXczcaqi4B0WQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi0T2mqA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi0T2mqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911776; x=1806447776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ed5V2hmcxxu7yQL6n80HzX/Bg/5WgEmq3+NmnnOazks=;
  b=Bi0T2mqAF0+5mMlGEmy6J2r2xUklOvqWjpkFDPLe1jJREem8RcpB1JaH
   uiUNViznWDmlr0+RLX4V9XvvkFaEj5GqIEt2Tjz+TjHpKgeI6kF78O0aV
   VTxC7KQArs/tLxcjEhVFg5Q3sXOqH1VFjfWY9d8mzpeA7sYYf/fq7Yi5X
   TgmKztolAvUF/KJgYpoPKDenrZfYlGLLutl9wIOTfbPdPugt/RcGX8WWR
   LhlVfkoBUFNBkKsT5VnvysdrXvF3rvnejD0kdwCab4hsrprzqdc4GoA/O
   PEOerraLvW4EwP6umD9D+/2SWIv8tYjWg1XE+VG7GFhWXlN4vPp+p6o5a
   g==;
X-CSE-ConnectionGUID: 8xiTWigFRpChFNi9UO3rkQ==
X-CSE-MsgGUID: N4Jh+B0fSYuejPoLaj+hmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297560"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297560"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:53 -0700
X-CSE-ConnectionGUID: doNwZa4JS+q8VdjEq/EX9w==
X-CSE-MsgGUID: wD2Qj1D1SLWiWt5BCiD3qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687711"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	andriy.shevchenko@intel.com,
	ilpo.jarvinen@linux.intel.com,
	dima.ruinskiy@intel.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	linux-pci@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	lukas@wunner.de,
	bhelgaas@google.com,
	richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 03/15] igc: Don't reset the hardware on suspend path
Date: Mon, 30 Mar 2026 16:02:32 -0700
Message-ID: <20260330230248.646900-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Commit c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices during
suspend") made the PCI core to suspend (disable) PTM before driver
suspend hooks are called. In case of igc what happens is that on suspend
path PCI core calls pci_suspend_ptm() then igc suspend hook that calls
igc_down() that ends up calling igc_ptp_reset() (which according to the
comment is actually needed for re-enabling the device). Anyways that
function also poll IGC_PTM_STAT that will end up timing out because PTM
is already disabled:

  [  160.716119] igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register

There should be no reason resetting the hardware on suspend path so fix
this by avoiding the reset.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  6 +++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 17236813965d..caa5b89b2b24 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -349,7 +349,7 @@ struct igc_adapter {
 };
 
 void igc_up(struct igc_adapter *adapter);
-void igc_down(struct igc_adapter *adapter);
+void igc_down(struct igc_adapter *adapter, bool reset);
 int igc_open(struct net_device *netdev);
 int igc_close(struct net_device *netdev);
 int igc_setup_tx_resources(struct igc_ring *ring);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0122009bedd0..4d1bcc19255f 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -638,7 +638,7 @@ igc_ethtool_set_ringparam(struct net_device *netdev,
 		goto clear_reset;
 	}
 
-	igc_down(adapter);
+	igc_down(adapter, true);
 
 	/* We can't just free everything and then setup again,
 	 * because the ISRs in MSI-X mode get passed pointers
@@ -737,7 +737,7 @@ static int igc_ethtool_set_pauseparam(struct net_device *netdev,
 	if (adapter->fc_autoneg == AUTONEG_ENABLE) {
 		hw->fc.requested_mode = igc_fc_default;
 		if (netif_running(adapter->netdev)) {
-			igc_down(adapter);
+			igc_down(adapter, true);
 			igc_up(adapter);
 		} else {
 			igc_reset(adapter);
@@ -2077,7 +2077,7 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 
 	/* reset the link */
 	if (netif_running(adapter->netdev)) {
-		igc_down(adapter);
+		igc_down(adapter, true);
 		igc_up(adapter);
 	} else {
 		igc_reset(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 0e785af0a3a3..80a90ce0ad0e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5312,8 +5312,9 @@ void igc_update_stats(struct igc_adapter *adapter)
 /**
  * igc_down - Close the interface
  * @adapter: board private structure
+ * @reset: issue reset
  */
-void igc_down(struct igc_adapter *adapter)
+void igc_down(struct igc_adapter *adapter, bool reset)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
@@ -5369,7 +5370,7 @@ void igc_down(struct igc_adapter *adapter)
 	adapter->link_speed = 0;
 	adapter->link_duplex = 0;
 
-	if (!pci_channel_offline(adapter->pdev))
+	if (reset && !pci_channel_offline(adapter->pdev))
 		igc_reset(adapter);
 
 	/* clear VLAN promisc flag so VFTA will be updated if necessary */
@@ -5387,7 +5388,7 @@ void igc_reinit_locked(struct igc_adapter *adapter)
 {
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
-	igc_down(adapter);
+	igc_down(adapter, true);
 	igc_up(adapter);
 	clear_bit(__IGC_RESETTING, &adapter->state);
 }
@@ -5441,7 +5442,7 @@ static int igc_change_mtu(struct net_device *netdev, int new_mtu)
 	adapter->max_frame_size = max_frame;
 
 	if (netif_running(netdev))
-		igc_down(adapter);
+		igc_down(adapter, true);
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n", netdev->mtu, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
@@ -6305,7 +6306,7 @@ static int __igc_close(struct net_device *netdev, bool suspending)
 	if (!suspending)
 		pm_runtime_get_sync(&pdev->dev);
 
-	igc_down(adapter);
+	igc_down(adapter, !suspending);
 
 	igc_release_hw_control(adapter);
 
@@ -7646,7 +7647,7 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
 	}
 
 	if (netif_running(netdev))
-		igc_down(adapter);
+		igc_down(adapter, true);
 	pci_disable_device(pdev);
 	rtnl_unlock();
 
-- 
2.47.1

