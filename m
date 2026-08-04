Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03401466B0B;
	Tue,  4 Aug 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850711; cv=none; b=X1v3BWf1Zq0iLLTZvKE3t8R4PHVjXvcIV+rNRl7zs2ND2mzSxxWr1hSkI23C3SDsELAZ2frGtSLv5W+vbxWLZwVCF2nSLKqXqLtL5mcxl6yj6cwEQGlRw6yZjpWblYd+1oqXMv+BqHjVPRrI1/TT7W+zsqk5WdrbUwyXxpjcWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850711; c=relaxed/simple;
	bh=voeBAnGBFWyl9y6fsdJxZVdFpnCWoucAS4P5V6Enbi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im0fkGOW8/WB1jhNN2O+JW/M0kBs+36o2jCRzHSxlLf7KJyFecgHEqMO1+u8aObcfLwCAe7n1BuNaxUX0ap4GDoE3cfYk/wmZxhpn2FNkwI/opnKRfpvlMPAKguuWVKuEBdnbnX84Wr3yh4Q64MZvgQkJ+jjKQJF8N1ztuGmt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0BG90F/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0BG90F/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850709; x=1817386709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=voeBAnGBFWyl9y6fsdJxZVdFpnCWoucAS4P5V6Enbi4=;
  b=K0BG90F/ATOBzlJ83Zz2Zmu2tG9GohytGgJ+QNA2PhBWmmlnlzv8VxQQ
   QB3BfYKBXL5aYKYlIz6hxgZ1vvYLVfVVsySmn0d/F0euZQdD7tkM65inl
   lqYmAVV4pxnPsoM4leNb08IKREpoM3m2hzfBklWkpzpUJSxXsyB3skzzN
   CmjYGNDEs4xb4Z1v7tIyju1Ny4uMniFcwRUiHc+3K+9jcr9kV50LfbK5B
   Bych4c2Odq7dGRDEwHJYcSByC7qKCy6PVrsWd+gUvBNBI6z2HBy8C+Fwj
   zm/p3w9xquihlZcqKWbHKXmqUCK1aAZZS7yBAe4y9+RmSWkKMzqDjzeG6
   w==;
X-CSE-ConnectionGUID: GWudK5c9SfG8/F8EDFTBgg==
X-CSE-MsgGUID: 3VoeW7YySYOShQBfgSDCbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410097"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410097"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:29 -0700
X-CSE-ConnectionGUID: KlR37LwqQYGGpeUnydrrPA==
X-CSE-MsgGUID: OiGhG4D/TsyUrJucXriXRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501008"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:26 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 03/14] i3c: master: Do not treat master device as a duplicate target
Date: Tue,  4 Aug 2026 16:37:59 +0300
Message-ID: <20260804133810.184905-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804133810.184905-1-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
device with the same PID as the reference device.  The search can match
master->this, causing the controller itself to be returned as a
duplicate.

Since the controller is not a target device, it cannot be a duplicate of
one.  Exclude master->this from matching so that the function only
returns real duplicate target devices.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

	New patch


 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c7bb52b71d88..abb582645a2e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2545,7 +2545,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
 		if (i3cdev != refdev && i3cdev->info.pid &&
-		    i3cdev->info.pid == refdev->info.pid)
+		    i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

