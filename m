Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D337AA81
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931453; cv=none; b=bBLqpzLr9ShGFFC/k+4lWlmH7/bBxYmTaO7+4eeQCYDUZC4Y5js6/rHAebQJd6T9ampbV4swOrdoYRpqAIQEesAqtHVj/tJeNCX0FYFGXDHJqDIJdVDusiZScPFj+jRbb6yL4nr2rUl3Uz3CNEZdOTRzkxWjruPJG6ZmaXKbvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931453; c=relaxed/simple;
	bh=4GiY9KnO3IGfcB9TBZYZbeVvvhjJF6YhNoqrn+ZUS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf5UZwEgDvRMkHiOyyfpODP5DTtGHlofSm1lWqJW7v/pkxDaGUe3jSELGZQKJtlDDfEkb14KHAq7pCbWVPpsWznYT+UUW2D8qU56cqfFK2Mz0Mc14CnVgW9Rstbx7i4jbBhI2X6CO1rSwc8RsYGTNoX+H0m8tLuCcL06xYVJVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyGQ3I75; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyGQ3I75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771931452; x=1803467452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4GiY9KnO3IGfcB9TBZYZbeVvvhjJF6YhNoqrn+ZUS4o=;
  b=SyGQ3I75T8o+UjkTNrSUSJsu3vmC4iKajzuQcebkxn38mf9wrp5ASjKB
   gO2hu2gjlqku3KOylv4YLPHqWBSDgLfkhep0ne7Mcuo7ValYcNdLdNxI4
   3XcjUjevzHZ7iVzXpXpvkf/IqkEJ5Lo4NET2R24CUP+NfEgbZXrueq4ym
   LIOlvc+/SdD2OciekWmFQCGZs6KpqhXz+7607ruyWSyalzsZ7zO/E/KTz
   ETj67NEbG2n3rFeYoUQ4I9/9LsvZahX90v6PVGYizjup8v1ekjIjPhlHr
   +TZTkxPKuz8nGAd04iwhANCuWbbx8fi4GwQLQhoW7kTF9KKrtdadv1bUR
   Q==;
X-CSE-ConnectionGUID: PS8bSRGyQOafNWCIq6FyEQ==
X-CSE-MsgGUID: iKH3JS0cQsi7t9KPykD+eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="98404990"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="98404990"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:10:50 -0800
X-CSE-ConnectionGUID: YNqqA14XSzebFs1i1wvxyQ==
X-CSE-MsgGUID: lHEG7HAeTqm3HSQtwgxBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215892053"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 24 Feb 2026 03:10:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1A74795; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
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
Subject: [PATCH 1/5] igc: Call netif_queue_set_napi() with rntl locked
Date: Tue, 24 Feb 2026 12:10:40 +0100
Message-ID: <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
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

When runtime resuming igc we get:

  [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)

Happens because commit 310ae9eb2617 ("net: designate queue -> napi
linking as "ops protected"") added check for this. For this reason drop
the special case for runtime PM from __igc_resume(). This makes it take
rtnl lock unconditionally.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27e5c2109138..7ffd34bfa14e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7518,7 +7518,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
 	netif_rx(skb);
 }
 
-static int __igc_resume(struct device *dev, bool rpm)
+static int __igc_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7563,11 +7563,9 @@ static int __igc_resume(struct device *dev, bool rpm)
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
@@ -7577,12 +7575,12 @@ static int __igc_resume(struct device *dev, bool rpm)
 
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
2.50.1

