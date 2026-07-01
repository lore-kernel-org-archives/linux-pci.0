Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BC3B6BE5;
	Wed,  1 Jul 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936955; cv=none; b=EkGh0EuQuLl6Jbye9pVBDmE/1Ssd2fANzIV8OHe7GOfQLzsnA4PFgtmcxhc7Lrn6fet0NW8Z49Qdww/OIY9Aww78ra3i9x8qvhF0ihJKp+uEhsywrTTRI9dPPG1e/zKTHsOlw2j7WmMhyncUbdVAWTvfX/4XGHfDXcqhPBQ7iBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936955; c=relaxed/simple;
	bh=VTAvYFO3S4nTpXuNRTDSeK7JhvfP65YCWkQJ/dIE6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCq9Gk+0I5U0tDuUR0MxItqaA0iWCJN9p9uN+H8lINmPB706AD7Kw+edsGQogzJX3k0csv+amMJ7W8jE2GnS2OAD17yyUCUMnZfvIMUlEtzaqkfIIILPeUmoVhGn0SzUquFNSpNKieimWJGUJVwtRTVVqgHm56IBNHqMUXQbj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKX8J1zz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKX8J1zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936954; x=1814472954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VTAvYFO3S4nTpXuNRTDSeK7JhvfP65YCWkQJ/dIE6tQ=;
  b=LKX8J1zzlVFl/xDxZv8DfYztyIEJsA7sXwnGO5sGFHH3qq4nescvGKR7
   o73BqVPtdkd5K6mPdKQJ6k62XVQ8K73Yt9PmxhHsoypukgU5HmAzp42/e
   E5LDsHKWuailhfnLsbbxWxp+fafHq1xijg7MVm1NTFXEgk6/wnqGcLRBR
   il2YCOo3EM9Jyc39edDiDujdYWyNUWZw9pbV/7VjuDiPNkCUeKOqpnMJI
   D/yU/Cey/+BdJCMbRCMr8IgchNE1mfzJnSmiv2Mou9SK8Fkgj9TTo82bG
   SihuSY4uDSwUAAHP17djxJDK0Q3saM5KPvrRDvavMJrl/LTD4CSb2gfEJ
   A==;
X-CSE-ConnectionGUID: 2cmFxjvYR0+uT/2O830F4A==
X-CSE-MsgGUID: 1cuy65O7RjyP+zZpuk0raw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671803"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671803"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:53 -0700
X-CSE-ConnectionGUID: NBzLgdcLS5+WbiDqbxZd+Q==
X-CSE-MsgGUID: lK30DXguR22GivIUxBET2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737063"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:51 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 4/7] i3c: master: Reject IBI requests from non-IBI-capable devices
Date: Wed,  1 Jul 2026 23:15:30 +0300
Message-ID: <20260701201533.220818-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701201533.220818-1-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

i3c_device_request_ibi() does not verify that a device advertises IBI
support before attempting to set up IBI handling.

Add a check for I3C_BCR_IBI_REQ_CAP and fail with -EOPNOTSUPP when IBI
support is not reported by the device.  This keeps IBI setup consistent
with other IBI-related functionality, such as exposing wakeup capability
only for IBI-capable devices.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 101eaa77de68..307ca6dc04ca 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -205,12 +205,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 		return ret;
 
 	i3c_bus_normaluse_lock(dev->bus);
-	if (dev->desc) {
+	if (!dev->desc) {
+		ret = -ENOENT;
+	} else if (!(dev->desc->info.bcr & I3C_BCR_IBI_REQ_CAP)) {
+		ret = -EOPNOTSUPP;
+	} else {
 		mutex_lock(&dev->desc->ibi_lock);
 		ret = i3c_dev_request_ibi_locked(dev->desc, req);
 		mutex_unlock(&dev->desc->ibi_lock);
-	} else {
-		ret = -ENOENT;
 	}
 	i3c_bus_normaluse_unlock(dev->bus);
 
-- 
2.53.0

