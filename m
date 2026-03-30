Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DF30E0D5;
	Mon, 30 Mar 2026 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911776; cv=none; b=serFsYzkJp4H2L8VlfCcErdURvuv0ihL0vOWEFg/E7WYg2unUShoXHEQKBNtUl+TvGowmIqerOsVXln9zZ8QttNrdlpliMAo/bICPSImM1/9FGsbCKS7z0yQqQCHwBb6YF1ZqLV0YAHFlEOMRVrIGSO/IyQRjtt4ZNhAyEQkMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911776; c=relaxed/simple;
	bh=5CWyWKFk5jTQoN5toNXnqvNG/6yKBVyWb01H9h4pABY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfQZ0c+LshVMhUCm6V0kBVAIybCaOZLftVwLd+y3wTrKwLDcLUE1t7dYOkzK9XQWD+TcILGT4GCjP4aHkIChZVwYOhEK2MBQEcN5dUAhONGewgMmnjaLu5YsTxIvi/GebSsXJ41KFJKBHgXvsUHLf5CA/441ciEZBDyX221j+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN3ipinF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN3ipinF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911775; x=1806447775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5CWyWKFk5jTQoN5toNXnqvNG/6yKBVyWb01H9h4pABY=;
  b=MN3ipinFCr3oamFPxqtkv1pEyyppmXtVQAJGiDtviBldYhQSRdi135ox
   Kqdo1PSJk4GiOmw0fv1j7P+SA+veIWZ8wDP5L9b16k0Lcniae0DEiclT1
   9WV3IrFqfMEcV5Q7jdnwVF0CELs3sHyzsSBddTS6UgcqGqComBwvkih9y
   voRLndMDOTmJn7YenUR/YY+xVRR+ThjjNofmCluUMXoMaJ7hfAjjpS2o2
   s9ntsZ/Itr8uMJsH8id3cITLHIALaLb8vEmi2w+QRC+0dcY6mtBCt0aJ2
   zudX5cxTxbMQntr97Pb1ZdJPTDsc0rWwMUCH8e65nK9zW7JIorV63dLVO
   Q==;
X-CSE-ConnectionGUID: dWvXIMRGTDObkChX78oEfA==
X-CSE-MsgGUID: cDSNCRs7QwWGDt6e3kQgDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297540"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:52 -0700
X-CSE-ConnectionGUID: T0eqtQNIS7+6uQCqQZ6Yrg==
X-CSE-MsgGUID: /23C1A/BR5e9O/4t3vTCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687703"
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
Subject: [PATCH net-next 01/15] igc: Call netif_queue_set_napi() with rtnl locked
Date: Mon, 30 Mar 2026 16:02:30 -0700
Message-ID: <20260330230248.646900-2-anthony.l.nguyen@intel.com>
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

When runtime resuming igc we get:

  [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)

Happens because commit 310ae9eb2617 ("net: designate queue -> napi
linking as "ops protected"") added check for this. For this reason drop
the special case for runtime PM from __igc_resume(). This makes it take
rtnl lock unconditionally.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 72bc5128d8b8..98024b46789f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7536,7 +7536,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
 	netif_rx(skb);
 }
 
-static int __igc_resume(struct device *dev, bool rpm)
+static int __igc_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7581,11 +7581,9 @@ static int __igc_resume(struct device *dev, bool rpm)
 	wr32(IGC_WUS, ~0);
 
 	if (netif_running(netdev)) {
-		if (!rpm)
-			rtnl_lock();
+		rtnl_lock();
 		err = __igc_open(netdev, true);
-		if (!rpm)
-			rtnl_unlock();
+		rtnl_unlock();
 		if (!err)
 			netif_device_attach(netdev);
 	}
@@ -7595,12 +7593,12 @@ static int __igc_resume(struct device *dev, bool rpm)
 
 static int igc_resume(struct device *dev)
 {
-	return __igc_resume(dev, false);
+	return __igc_resume(dev);
 }
 
 static int igc_runtime_resume(struct device *dev)
 {
-	return __igc_resume(dev, true);
+	return __igc_resume(dev);
 }
 
 static int igc_suspend(struct device *dev)
-- 
2.47.1

