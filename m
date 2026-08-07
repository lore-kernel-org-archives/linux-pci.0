Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD0476690;
	Fri,  7 Aug 2026 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114663; cv=none; b=aFBn4AEFVsIR+5hIRvpovvW6dr3FDRJNkGzjWja7adisVEsyfRAWjd5oNWK5V6WGcFgd1Mm35mQhppjW7VCypbhf4sNeWSulcNF+lM74mh2patdSurMd9VXFaVOAsNWsF8+2ceDHol0sq1HIPIyg8so7af9+F10E5f4W74XzQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114663; c=relaxed/simple;
	bh=b/3nCbbeIos8TapZNKsjIUGLe8mZz8XEWaAijxlyQEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhOu1dmZyWowCnvVFo6S4n2TwiEyf62GOlZa+eN8vCworjykERI4CfWjTmLEeO8WLhBoihX3OrtEwHWQRajLeGMKXYG96BZk9qi/0sNWLEVygEXiHcQ4hoss0RAvMONnCZdHflJ9CmpF5uPTwO3IYOoQvl31xPKgHan2AochduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvFF4bCE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvFF4bCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114662; x=1817650662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/3nCbbeIos8TapZNKsjIUGLe8mZz8XEWaAijxlyQEE=;
  b=LvFF4bCEkxbbx1kX2L1kPc/G8ZXGP9xrUWVdSS764LmpQfyGntxLK+x3
   4FiCyxe2Eye2euFdh/d3EIbjIFYLV9bFr3ZjY+vmoKWjVqPIdDkuxfTZ1
   gDC2oV2WFno72LtoCPbUBlgqYojS/Xbgmpf6wQqhEFF78glYvFNJSdgkP
   6LT2OuUHs8KWZklyTzEmXCOw9bOoA/pAaSs4tw/cTT+XYQg9K/isOJdtu
   lRAe1najbE/VCl47aUSQhsH3Kvs4wb9AwP8q8a48QB3YWjpHK6mLEQxBW
   itZwQ+QUPQm+HGk85Y9HpBpghCtJppDEsH8CAtpJAXma1SDAS/IXCh0dT
   Q==;
X-CSE-ConnectionGUID: eMtI7tjkTnepN7nUcLq9Qw==
X-CSE-MsgGUID: Qf64Fiw8T7WF8nCnU2+knQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485267"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:41 -0700
X-CSE-ConnectionGUID: Wd2TuOILQeG9Ed81BLZv5Q==
X-CSE-MsgGUID: 5VsMs/PrQ1yu+yejmSZrrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809948"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:16 -0700
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
Subject: [PATCH V5 11/14] i3c: master: Reject IBI requests from non-IBI-capable devices
Date: Fri,  7 Aug 2026 17:56:35 +0300
Message-ID: <20260807145638.168865-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
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


Changes in V4 and V5:

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

