Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9C466AE3;
	Tue,  4 Aug 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850718; cv=none; b=TUdO2t5/oWrGLLg587ya4vJpH/MyVb+MtxUHzyuduOytD4Fj5ry/D5TcHRzhaQ6Acb78sSRETx9komDVgrEg+JVVWEUcWrXSxNHDQY+l0O0QwoBvSvN7Flcy05VMBoPRyYsYzpQSABnAE61NnLFatVo+03l4yoEtdubBJBoVTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850718; c=relaxed/simple;
	bh=Z/5ENodMgYfqvmrtqI5X0lDZjP+qbTBkC8CDKItDX9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIgvbnT7Rmgd2AfRwznLKkKsDyYqV3tW0MWEOgE0h8Q+fTz/Njh8E1DToKyH27gQLXWkoZQr3TJVIY/Zaf/TQmwSSL9LD5mjfawQDI5d2dKHN3dzEttGwyzW24MZVZuztcCoRl8Jk8kainVuDWZQQICvT9cYfNL9E/mcFXh4opo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzYLg/rn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzYLg/rn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850717; x=1817386717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/5ENodMgYfqvmrtqI5X0lDZjP+qbTBkC8CDKItDX9o=;
  b=GzYLg/rnFPjQu+68SWehDeE+kipxfJ7jwAxHeTHwCBD/73ISKywi/TmI
   i9mUfZUrMfgzUrnK4Jw5WYmV7FoXBlyJj9fMiGHKGF3NIizp5u8+uqtqO
   IYlM1XLsr5SMIwQbcgN5zNLi2gkzqoYFhU7r7YwShNuivr68/OSxQAxEw
   hZjuM5H1Py6L34M9wElogADpaQ9wPgF7gBJeY+hAuTzGaMEGvHtugSXl5
   aC3dgcLh+z9ssTm1pri5CsZdvkP/VQVF7pHO0r/2ZmNDRHNEGcJPxCeMr
   2oCcDEf3DgiO5jSJlqn5O0NP6rMdGHLwbrOjvkYTCpLcjCfOrl7czI92G
   w==;
X-CSE-ConnectionGUID: m3F9y7gISempnHgOesnmeA==
X-CSE-MsgGUID: /2pBFceRRx292qzNq4uSLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410121"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410121"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:37 -0700
X-CSE-ConnectionGUID: T16+ul3uRemZyyA5RJdc5Q==
X-CSE-MsgGUID: Lh9kcuOvRnm1kWEAks3TSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501021"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:34 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 06/14] i3c: master: Fix potential UAF in i3c_device_uevent()
Date: Tue,  4 Aug 2026 16:38:02 +0300
Message-ID: <20260804133810.184905-7-adrian.hunter@intel.com>
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

i3c_device_uevent() dereferences i3cdev->desc without holding the bus
normal-use lock.  Since the descriptor pointer can be replaced
concurrently, including when a uevent is generated from sysfs, this can
result in dereferencing a stale descriptor and lead to a use-after-free.

Use i3c_device_get_info() instead, which protects access to the
descriptor with the normal-use lock.

Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
i3c_device_get_info() to avoid deadlock") replaced the accessor with a
direct descriptor dereference because i3c_device_get_info() would
recursively acquire bus->lock during device registration.

This change depends on "i3c: master: Fix recursive locking during device
registration", which moves device registration out from under bus->lock
and removes the possibility of that deadlock.  Without that change,
restoring the i3c_device_get_info() call would reintroduce the deadlock.

Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock")
Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking during device registration"
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

	New patch


 drivers/i3c/master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 4839c1c186eb..947ab3c681d5 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -316,8 +316,7 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
 	struct i3c_device_info devinfo;
 	u16 manuf, part, ext;
 
-	if (i3cdev->desc)
-		devinfo = i3cdev->desc->info;
+	i3c_device_get_info(i3cdev, &devinfo);
 	manuf = I3C_PID_MANUF_ID(devinfo.pid);
 	part = I3C_PID_PART_ID(devinfo.pid);
 	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
-- 
2.53.0

