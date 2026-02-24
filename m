Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D0379999
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931452; cv=none; b=j61rQ6b2M77E7KlDfqQl/ZhV5A5pTELJ9afw4gC9kiqPUhOikO2ypIyDboHyJxn9FA++eCJAPMjBMKx18ovdfTEuELwXxmmWU+M7KrZiF//tT5gzVz4Ox6Ea9ep+YTnBbPlf76LTaA+2vilSYEEU45Odpit8FL9TSdme1gkv2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931452; c=relaxed/simple;
	bh=R+QtiOPuFfp3S5QbZO4NvSZNp52rBIcTtfnP5DXv4+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3zFkYmekab2Noo47IGfzX51QRnZ6QxUDrJw6sG2vZ4JvABtVPgaAU2OZWw/tErRL0Ocds5Tl117Uz1hNhhP1+QErDcRmdEl4rcLjWlD6D2/pORy7Y2/ckgNmPtfABtlchDI9yXXPva1QIhlCWbijrxHy9A+ASRvEU+xxaWXDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlnVn07P; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlnVn07P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771931451; x=1803467451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+QtiOPuFfp3S5QbZO4NvSZNp52rBIcTtfnP5DXv4+Q=;
  b=OlnVn07P1lScmkJq9DyX+aTSYfVQECRa7qC7ySuaSfjlis7qxGUy9+VI
   qUDUzg8RNpfC+qAbL35UbKYY5U3qXNCMn7Zn/V3frBviH0QlzYvRSPawf
   b1/zzranHuk3Hl6sUlidzA8Xju+NH/XPTYpGcccA0sDjYz0TM8RenzrZy
   IFmzn8zbNDaLRuDWS1rxzpPJsFtlYptXrXYONpiK5duIQ5F/kpH6PhAyf
   UnYdAN1mIw+xIg1t7dt/8g7JCdLQGhRLH+4PxtyNPW5r1AawsQgDargbP
   YLB5K+wMq4wtfK7U4jckBNOqk23vdktByqLd4rzapb0tQUnpIUYfv24IH
   Q==;
X-CSE-ConnectionGUID: 0LwS7lfGR6OYBSc21fi++A==
X-CSE-MsgGUID: VY5sINkYSyGOj+9cS99f3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71974259"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="71974259"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:10:51 -0800
X-CSE-ConnectionGUID: yNqYtachR4mFbLJVV8acEg==
X-CSE-MsgGUID: GbPWuUYeR2aUblceRzNGPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="216037798"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 24 Feb 2026 03:10:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1E6039B; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
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
Subject: [PATCH 2/5] igc: Let the PCI core deal with the PM resume flow
Date: Tue, 24 Feb 2026 12:10:41 +0100
Message-ID: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
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

Currently igc driver calls pci_set_power_state() and pci_restore_state()
and the like to bring the device back from low power states. However,
PCI core handles all this on behalf of the driver. Furthermore with PTM
enabled the PCI core re-enables it on resume but the driver calls
pci_restore_state() which ends up disabling it again.

For this reason let the PCI core handle the common PM resume flow.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7ffd34bfa14e..99a4c99ddd57 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7526,9 +7526,6 @@ static int __igc_resume(struct device *dev)
 	struct igc_hw *hw = &adapter->hw;
 	u32 err, val;
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	if (!pci_device_is_present(pdev))
 		return -ENODEV;
 	err = pci_enable_device_mem(pdev);
@@ -7538,9 +7535,6 @@ static int __igc_resume(struct device *dev)
 	}
 	pci_set_master(pdev);
 
-	pci_enable_wake(pdev, PCI_D3hot, 0);
-	pci_enable_wake(pdev, PCI_D3cold, 0);
-
 	if (igc_is_device_id_i226(hw))
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
-- 
2.50.1

