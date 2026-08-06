Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04680332EBD;
	Thu,  6 Aug 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022391; cv=none; b=sFIkiirxlHadXidEQnduETc6/u9yIc1VcUUBhGoRW58zC9brpvS3K50L4kn1Yk2NQAK3MFS/4QYWgMN/vCEth6HOISbgLxfeBHpNmsLJn7FJ95bDB6Uu7ZiexYd30WdhbJoY/MzzUB4LvtgUlVFZzVbh3fFUz0Y+55xfzElFQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022391; c=relaxed/simple;
	bh=nX3Q4Ck76KKHbqDDEK/0Elh/XWuHke9+jxodTd88M7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHp5RP7jA0pZwTeFbMdq7ikKfpvD7AaULppcyDmvetUoe3L30Uz/Dy+dH6y1o883hMgWR2Qk/Jt54eE6oyGcnfLnbgTjmWwTFHpQGdlXwvpyqhInE2J+XYOvllz8jcEKGNXJETNOVEWVwogoTc1oHMIV6ChZAyxHtKldWW/p6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SczSArBw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SczSArBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022386; x=1817558386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nX3Q4Ck76KKHbqDDEK/0Elh/XWuHke9+jxodTd88M7I=;
  b=SczSArBwC7kOlWghLCNSKE47uYxCyY+7edQCJE98e8MmRNd1u6NfTIph
   D98w025ytH19VFyDzOCJLcFvV6BbeB/y1lrpd26C/IIDQM6BXZIrFK4TN
   XUU5SztX1STwrLj8Yx1vRjrUVrVS0bPVmuRSBJNXNuYnfbIGJKiywD292
   HvgcOIk3E8QV4xv/OLsTFtouhSaAQahZsxYASQt8IyYU0Bcip++nesYWE
   SUSW6X7mow/5Sdy8D+4q67ng7O0BlzJDo5Bt9Ry2uGdVEVGgTOS8QsZTi
   5UeQ1WnunpTUKhz1asIkDya8Sqcm2onWLQF8o1DImbd+75WMo0U7Ymbov
   g==;
X-CSE-ConnectionGUID: q4MbZatMQJqTq3iZFjOqSg==
X-CSE-MsgGUID: PsX9a8U7Qc6d1CBiCwQ3uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149633"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149633"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:40 -0700
X-CSE-ConnectionGUID: GJapqe8GTKqZ89quraQLnQ==
X-CSE-MsgGUID: 89gP3eSOQPieWvbSTUp0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338258"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:38 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V4 11/14] i3c: master: Reject IBI requests from non-IBI-capable devices
Date: Thu,  6 Aug 2026 16:18:54 +0300
Message-ID: <20260806131857.119830-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806131857.119830-1-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V4:

	None

Changes in V3:

	Added Frank's Rev-by tag

Changes in V2:

	None


 drivers/i3c/device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 5e6df6de0283..f1ba363b22a1 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -204,12 +204,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
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

