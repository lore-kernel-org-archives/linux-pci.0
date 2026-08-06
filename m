Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA131F98F;
	Thu,  6 Aug 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022383; cv=none; b=khKfjNso80Yy5s3eJkKpC6nGDdBmfFvnLFARKDQw1Ngy5OEve3eI3Ji05lvD/DNVp/SwCQ6kEVKJgJciMoNLceCR7kxuIt8hxeuSSW1vyNlEGvtvDnLUiUSyVdwENdsn1WVrh6N4FL6fasc52kDQyF9LErv83v4mlmaIN8ed5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022383; c=relaxed/simple;
	bh=8cXJv+a33kqp6eilmp46Qbbm+eANnhR9qHTgafUpDR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCoid+7QBBM13k6HsCycbxIyregRjLsZOKNOaEcQUFeITq8eOLxrlEyXTRhBjsrQlDLMdaI0Z99PjNH/0ZE0Tc60u7IejiMZyUa8GcObL+/LUeiHKPabW4RKAlkSdlbR/sE1rStLAijNnRMkDzA03mieVikH1r2xdREGQ8zFZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQWWOQOr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQWWOQOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022379; x=1817558379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8cXJv+a33kqp6eilmp46Qbbm+eANnhR9qHTgafUpDR0=;
  b=mQWWOQOr+bKhIZktjom3aRza1PqNPtIFAcQsXnB7uD7eQSjB6ONWYdkI
   EJjXqtbbiNg251DSEej5pjRBHcH8fvWmxTpMRI0MEI7Pn6xW/Kl2fqbNr
   n1IQwHVbiSvn7ZWKSWGLrdmr7yLr2bo/X7C/HT2WG77wqa3+p/k6YKZSk
   51L7BkaWtb19v4y7ZRy4+HRwkTVLBQYCW3itY7tVE/RPzUHE85J1anUJa
   eportzEU5je1pGk9cqcAWIGanmIMP+fda2gsx/0UpvnXzfg83RXgKml4y
   rCBsIOrvdKLBKu8yl1CiADcx1EKV6uaaull5un63ApxQbhhHDWaoNY5Pu
   g==;
X-CSE-ConnectionGUID: XyJrNK3jRGaAPcylkiMHtg==
X-CSE-MsgGUID: xl+mZtgyR5Cfw3U3c2jIIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149614"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149614"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:34 -0700
X-CSE-ConnectionGUID: FDHh+cuwTpKvjBriPUT4PQ==
X-CSE-MsgGUID: ZfkrfyC7SYiat7ESCcIxAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338228"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:32 -0700
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
Subject: [PATCH V4 09/14] i3c: master: Report wakeup events for IBIs
Date: Thu,  6 Aug 2026 16:18:52 +0300
Message-ID: <20260806131857.119830-10-adrian.hunter@intel.com>
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

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI).

When an IBI is queued for processing, record a wakeup event for the
device if wakeup is enabled.  Use a 100 ms processing interval to give
the I3C device driver time to process the IBI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:

	None

Changes in V2 and V3:

	None


 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2616354dbe54..6c5341491944 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3384,6 +3384,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+/* Approximate time for IBI handler to run */
+#define I3C_WAKEUP_PROCESSING_TIME_MS 100
+
 /**
  * i3c_master_queue_ibi() - Queue an IBI
  * @dev: the device this IBI is coming from
@@ -3397,6 +3400,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 	if (!dev->ibi || !slot)
 		return;
 
+	if (device_may_wakeup(&dev->dev->dev))
+		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }
-- 
2.53.0

