Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92E331ECB;
	Thu,  6 Aug 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022377; cv=none; b=DqoRBLrg6RN1AI8ch8yZSZ1V78nyosBeVKtiaNyU1mgX8hOp0w8Ag7Zy7KzVSfZ4wMNLILlEYLzLArhsGJFdWiOqRn0HXsXhd7VK/AqnxWyANfipX+Ztjbys5EnVDgzEWe/y+QW5hcAh++pjLQHt4blC6XH/Zq110Val1VK2Zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022377; c=relaxed/simple;
	bh=HlQruraA7agKiqxVYRqDPlUkqImO4uUYgYC2j57DVk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggJuGLQnC667o9Acm4NBDmXfBhtv4tn9806kaxR0aesaO+S47hLTEfiZE8OrK+RNCQixyggIOaBa7jA6Gj+Ix+Fec/8R9zTISc7NS9lgfTEhu3vDEk0cogn2EpdVctbsH/4E6D6ejxfpeJ7ekCDHlH+W/ssEFSEDk15zeoR9M/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZNWwiCe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZNWwiCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022374; x=1817558374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HlQruraA7agKiqxVYRqDPlUkqImO4uUYgYC2j57DVk0=;
  b=nZNWwiCe6dTqvBpkTV1Rik7MLN3yXYksHTVWBFV+wEtqBRlzTRpjEK4Q
   olbGU+QoRRaUGEs+keTewWWzhjR1csB9wN9cBKCG7gzVsuSec9Frt86QX
   aWsy6NJOxbPs+hjDvSEOIWaXObVGCt7453nDtL4BoZBB8l8lUi2DjjX5F
   YYJR+kREfAht+89/vxsXP4Tf5M9wNQL/zmjLONkNyvTmt72kXrmS4tbMi
   S4WwFqAAEeif5eUDBL4TpBAKBJL7HE5Hiu48OObC8A/rqQKCgQ2T+0XfC
   ODEs+6g1HdIyfTgGGuRlCYi1+zDTaxDIBETEavOO5wZ/teAqFGj1ldqsE
   A==;
X-CSE-ConnectionGUID: zswBaQKxRFuRARiVjoxdrg==
X-CSE-MsgGUID: by4cdbdoQ1SZDqNzzA14Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149577"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149577"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:26 -0700
X-CSE-ConnectionGUID: ECrO4ecXS0atukBeJI+Grw==
X-CSE-MsgGUID: fXyMbzWIRK+RDz74/dKaqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338168"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:23 -0700
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
Subject: [PATCH V4 06/14] i3c: master: Fix potential UAF in i3c_device_uevent()
Date: Thu,  6 Aug 2026 16:18:49 +0300
Message-ID: <20260806131857.119830-7-adrian.hunter@intel.com>
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
---


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

