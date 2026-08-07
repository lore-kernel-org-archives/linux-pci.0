Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AA442371;
	Fri,  7 Aug 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114659; cv=none; b=YX0RIRZ4cjdkMfeie/iMlA99xzszG3koDlMJ6yH68hEN54TH4hElTtaOEpeaqmKKF0/aHRxwQsdjNwnimWRzwi9fOEgq00s2hDWkJhPGw97Bq3PXWqLSOtqUD0O8JS9eKbVCt/4PveSerH64qqgjWEjlKQN96uPw/eidm0/U/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114659; c=relaxed/simple;
	bh=PoBnNTY7R/7wvVAa6p1CUs45T33ETASB2I+FQ3ox3a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edvS4z2XXlP2bw1800dX/mcpUQMbAjR9GeDvuk1ro6Y2DabePmGoHraFQUjVFpwdN4yE9FOQxDrIakniG8dF7CIJIK2bdOfuvuIuO0zvaTlOlqqSvWvC83Pcj7roJBjdy7dkBh7oVSXHxOG+Gj92OZMkR5ic2pIlTDOzDvUM0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBp3VJEa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBp3VJEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114658; x=1817650658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PoBnNTY7R/7wvVAa6p1CUs45T33ETASB2I+FQ3ox3a0=;
  b=CBp3VJEaVtar8zfNrLZSA1M1lpw+WOloimwhN93XC71L/aXjBC55TBiw
   t/4ikXB5tJXRNRqeYB1YMkGmzDTBf2SX24GUJVeQJjrLgN6VzlA9vuL9O
   NSZekrtOjaR7aYsGtCoAJ/LjxzHcCE8fh1+APhHLiFX0ki8gFN15oqh5i
   53i8unnBwlduKQZ0d3mgNYOCAj3qmZBb35UzV5E3GCil7ZUXdC5kujSS1
   XtP+hj0uo///vvkq8zZrgEl3SCguRJW0Dtt0gadEvzVOn8ZE9xF762j8/
   hn2KQkFnlvhpK6pPum5Zz0zDmWjnVOF2dwLpzAFgTUVznN62E1g+NWfv/
   g==;
X-CSE-ConnectionGUID: 8SjHeyZwTsm2TMxjd6Ztlw==
X-CSE-MsgGUID: NjsEkIcqQH+hYZGPgM/HkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485225"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:36 -0700
X-CSE-ConnectionGUID: fcbCQuZMTpCidWeSh80EIw==
X-CSE-MsgGUID: vrqrhy+mT5Wzk+6M8ae88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809898"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:03 -0700
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
Subject: [PATCH V5 06/14] i3c: master: Fix potential UAF in i3c_device_uevent()
Date: Fri,  7 Aug 2026 17:56:30 +0300
Message-ID: <20260807145638.168865-7-adrian.hunter@intel.com>
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
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V5:

	Added Frank's Rev'd-by

Changes in V4:

	Added Mukesh's Acked-by tag

Changes in V3:

	New patch


 drivers/i3c/master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2357874bb9d6..ee771ac0b203 100644
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

