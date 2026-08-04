Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BC469837;
	Tue,  4 Aug 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850715; cv=none; b=nqvQo0MVGAbp6NP5ARxjSRHvzQwxL0jJjoRlqsKv1E2Hk+sa0IruIZeVJ+J96pPobdmdOrIYa0NiPDd3/3BnHtYnqTMaMfftyDcR/wwqKCYy2wwK5vXgnwtNsMdDkSDzHTLuU5oHfmVe0p62oyXmD2CXGQKWHIDac7JrKnm5Qoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850715; c=relaxed/simple;
	bh=Z2TA/miuqxxjPRFW0ZELLHvJKfQaSPolisc0yaOn6HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMZM4VpYRaNkHQ0Ybs4DkAGQ9ukmz341vGCzAuZHSaxP7n1wQjofoSWPFTNB8yLJY3hTr9g+XKDC7sDJs4XGfIXxbKpyyXBjIf76td1RlYVBnl0/zDDCrL2xRf2oGjAH87gBGAzF8Oko8Ak6rNnK+PHYWPDt5zYYuQBDT7X4WR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgOl2/us; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgOl2/us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850714; x=1817386714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z2TA/miuqxxjPRFW0ZELLHvJKfQaSPolisc0yaOn6HQ=;
  b=DgOl2/us84ODNibmOn6PqeEqA17hguiFvGHkjTNfqXLuvc0H661N+Ikd
   34+qWtvZGcxoQ3tUETEaJsfrDbv+k64TRBSyIJR/S1AXrKv508RA2YMwt
   LX+rI0aDefNoj2c35m3jXhyZNWJWLuMsQwmHMEcMGJf1FNEjvUxrTLCNF
   2j+0uoWp7pU3/4DXAEfyTihSFNQrdn4SsI+ksxHBebz88MO1CgCRgizEe
   yrxsPYV54Yp1qg+R9i9hQjQ62sTdvOsFkSQomT5sD373dDlbknmuFyWJm
   GXTvzAYVLmVt5sdZ90Lka1hiqv4aXQACgw8eKayVW4tzyVdGsh9SpWU3m
   A==;
X-CSE-ConnectionGUID: NVsFN1z/S4mzOFTQvF0jfg==
X-CSE-MsgGUID: SMQLua9tTaW9sO38RaHpvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410114"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:34 -0700
X-CSE-ConnectionGUID: LDTB3y78Q+mtzTsATUkFTQ==
X-CSE-MsgGUID: NJxJlSqeR/mCLrr2/sIvWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501017"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:32 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 05/14] i3c: Make dev->desc locking assumptions explicit
Date: Tue,  4 Aug 2026 16:38:01 +0300
Message-ID: <20260804133810.184905-6-adrian.hunter@intel.com>
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

i3c_device_get_info() takes the bus normal-use lock before accessing
dev->desc. Under that lock, the descriptor pointer is guaranteed to be
valid for the duration of the access.

Remove the unnecessary NULL check on dev->desc so the code more clearly
reflects the locking rules and expected descriptor lifetime.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

	New patch


 drivers/i3c/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index a3778282e84c..5e6df6de0283 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -101,8 +101,7 @@ void i3c_device_get_info(const struct i3c_device *dev,
 		return;
 
 	i3c_bus_normaluse_lock(dev->bus);
-	if (dev->desc)
-		*info = dev->desc->info;
+	*info = dev->desc->info;
 	i3c_bus_normaluse_unlock(dev->bus);
 }
 EXPORT_SYMBOL_GPL(i3c_device_get_info);
-- 
2.53.0

