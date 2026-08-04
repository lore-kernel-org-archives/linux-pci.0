Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA446C841;
	Tue,  4 Aug 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850731; cv=none; b=GbcD0QjPsACle237DrcwNmlGFmT59tJDUdEjGfRoxJjaS0eXyfjRLZboL8PTnhMYhOVu8yKXVwo/H8eEbsXRfNDwf5twvRYYULknv9SmbnmOEkJoztSMvKkNAoKXeB5ocvqoJxMFHjkgogZIxkd7Ap822Ty1D4OGPF51/npeDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850731; c=relaxed/simple;
	bh=ZkUaZuL70LekaMXKH0xasjz56ftvkRCLeoG4ImrPSCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaeGPEz0osic9IgYMeqLNI9v5QDIPrRAHdidG6VNFGC/t/P9b4rQ9jccafhOtqQbuBFN/WM6grenhxodYDNR08sc8I72BkpkpRbAZo47Y++ZDBl21f+AiiBNF/XcwqcMtk6VED5UedlTx0Wo21edwz+N5iRh6LkMRq1n7ZAowFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLjDznVi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLjDznVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850730; x=1817386730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZkUaZuL70LekaMXKH0xasjz56ftvkRCLeoG4ImrPSCQ=;
  b=dLjDznVihU9miDlhvR+xSgIQg0ZEsapYoUq55lECwD9ZN1+DskWszs3X
   y4l5zr33Cn8HFNlf+ybcjqadNkjSbXTqyxo+Y+FAw2yLXqtdIbasI7poh
   ovy2qeYZUvhOjVeLWHH6HRvkGOhKdbK98DOlVSydk9ZZ4rLUnhq2n1lw8
   zUmePRawsguGyI2iMlww4noX16tdnnz4lvDOL5mnXvWuIy9wqZatTJdUn
   NCG+fPtqGkeLvhigrhO0SJuA/6j5otSw0jsM2H5XI5DWl9aGJWttgEQ1B
   hhLOtYBNAqnm5XvtYoQM1csJaBqik0DdmQocrgYiSshYczzGIF0ZUIs54
   w==;
X-CSE-ConnectionGUID: rlpNpTpeQ8exeePjtp4AcQ==
X-CSE-MsgGUID: 7Y7u7I4NS1yfsXbkmdT8pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410167"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410167"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:50 -0700
X-CSE-ConnectionGUID: 2Xc+d9tmS8mqeONIWEnk1Q==
X-CSE-MsgGUID: gVIB+3M+QgimrWrBQyQSIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501059"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:47 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 11/14] i3c: master: Reject IBI requests from non-IBI-capable devices
Date: Tue,  4 Aug 2026 16:38:07 +0300
Message-ID: <20260804133810.184905-12-adrian.hunter@intel.com>
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

i3c_device_request_ibi() does not verify that a device advertises IBI
support before attempting to set up IBI handling.

Add a check for I3C_BCR_IBI_REQ_CAP and fail with -EOPNOTSUPP when IBI
support is not reported by the device.  This keeps IBI setup consistent
with other IBI-related functionality, such as exposing wakeup capability
only for IBI-capable devices.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


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

