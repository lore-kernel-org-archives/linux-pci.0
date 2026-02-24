Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA3156F45
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931452; cv=none; b=jpPFa7SsPWsxfeJM/UWuv1V2p6bdbGe8TU6BIoQZYkekpU8lv7kem+XZ94TusKQs9K6av2mLhS1DrDpVAyXxEcwBLfBQUMGOwkMYMWKrdgSbs1Og9rwwGYRK01lPIAAxGP8b47DvOjv0/yl220DgIqe/W8N06VG9f1JkaEvbPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931452; c=relaxed/simple;
	bh=56yevZUMPDZILbEoozNRhpdvOE4yXm35dKj3iYbqF3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXcNDHcrssLk20rxgBU7ywRPMMZv0YcQDxZEBHa9E9rqpoEa1Vz2uFa70DYXeQZA/sPUYjUyKwQH0ymQ8kDbc3MBIM6FtW1QySpKBYU30jfjfTTxcaqx4EX0Ou7/SoVAg34aT2WiUg9mjx/SAAeV1CXBvTgAESidfxhly2Y4d6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uzq7IMpL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uzq7IMpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771931451; x=1803467451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56yevZUMPDZILbEoozNRhpdvOE4yXm35dKj3iYbqF3E=;
  b=Uzq7IMpL9lijYgwDHdcFPBK1qBuGWH5NBToL+FHU2Wdwu/DnfSn3fJpE
   JnZEemH81r4Lwdh4yJf/pNJB1aS0QOAzv3e4cyJv/hLnBEFzRL7spr5Nc
   h5OgcksNd0lbns6+2ozhThC/+ldnnfopZeT9l82zkwQqjKZ2WPOlMPbdQ
   cbWMoD1ahh9JRorkFBoLASm8sl+d6wh+b2/nGwM1joHJ+XgxkWVDyeGXy
   9Zw52krLYbAtv7RWlS1B8nh840oqHdTaF6+QI+wsITd4N9+mf+bg5g1G/
   BqJdeEPYS/wayWXAEcaxAVLK6G5lmI39Q1nKDUxh9o8IScWKMqAzA8Vk7
   Q==;
X-CSE-ConnectionGUID: ODKc9Of0SgCyKuxPi19AoA==
X-CSE-MsgGUID: 33b8vpWXRpeq31l9sFPPVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="98404999"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="98404999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:10:50 -0800
X-CSE-ConnectionGUID: vLSKuYS3SjSjDD4qLWSjqQ==
X-CSE-MsgGUID: WTJXnrQmSyu+OemXyCYZ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215892055"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 24 Feb 2026 03:10:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 220E69D; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/5] igc: Don't reset the hardware on suspend path
Date: Tue, 24 Feb 2026 12:10:42 +0100
Message-ID: <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  6 +++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index a427f05814c1..21d6eba1cc09 100644
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
index 99a4c99ddd57..84f5d92c81cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5308,8 +5308,9 @@ void igc_update_stats(struct igc_adapter *adapter)
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
@@ -5365,7 +5366,7 @@ void igc_down(struct igc_adapter *adapter)
 	adapter->link_speed = 0;
 	adapter->link_duplex = 0;
 
-	if (!pci_channel_offline(adapter->pdev))
+	if (reset && !pci_channel_offline(adapter->pdev))
 		igc_reset(adapter);
 
 	/* clear VLAN promisc flag so VFTA will be updated if necessary */
@@ -5383,7 +5384,7 @@ void igc_reinit_locked(struct igc_adapter *adapter)
 {
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
-	igc_down(adapter);
+	igc_down(adapter, true);
 	igc_up(adapter);
 	clear_bit(__IGC_RESETTING, &adapter->state);
 }
@@ -5437,7 +5438,7 @@ static int igc_change_mtu(struct net_device *netdev, int new_mtu)
 	adapter->max_frame_size = max_frame;
 
 	if (netif_running(netdev))
-		igc_down(adapter);
+		igc_down(adapter, true);
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n", netdev->mtu, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
@@ -6301,7 +6302,7 @@ static int __igc_close(struct net_device *netdev, bool suspending)
 	if (!suspending)
 		pm_runtime_get_sync(&pdev->dev);
 
-	igc_down(adapter);
+	igc_down(adapter, !suspending);
 
 	igc_release_hw_control(adapter);
 
@@ -7628,7 +7629,7 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
 	}
 
 	if (netif_running(netdev))
-		igc_down(adapter);
+		igc_down(adapter, true);
 	pci_disable_device(pdev);
 	rtnl_unlock();
 
-- 
2.50.1

