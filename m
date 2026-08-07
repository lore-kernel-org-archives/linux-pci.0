Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF274746AE;
	Fri,  7 Aug 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114660; cv=none; b=cUxc6y+f9vPkTvlG4qlHFOB7JTWshsupTjvZPWQu7B/pQSU0hSz+7XpC18Z3E2doLoDnAqtvIErEYjLnHOPtJZ7cemIB5tE3k2Cm8M7ICXlHF6jpCz80tquA4atjmZC3VD9QoZ3hn3lpqYHN2hJ7vufJirgyQ42JGOfXI/LZbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114660; c=relaxed/simple;
	bh=GXla3rEiuoVy1r6X2ffYoXaqd7/8Dw7PH/mGtXsD/VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3e8LtKpaUqpGz2gCnYRj5Vzz7JNqqWMzhWRLkAWqn6J9h0sLswRaCgFkM/fPfyNFw2ad1J7LC5wcjatGDN1Xc1itpGk4qaAeSTFzDTd7G0wLFtUDzq8eVJo8hzvIYags/8yheojFY+WwuQp7/NvBKjcBsK6jV2Mpi8xeQ1rw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cc98RoWm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cc98RoWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114659; x=1817650659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GXla3rEiuoVy1r6X2ffYoXaqd7/8Dw7PH/mGtXsD/VQ=;
  b=Cc98RoWmUCZfKHGXvnKJ/mjk97muZ8CaX8vpHLREkp6JhwM4SGqKtKDG
   y9S4iPjZiZr5C4Y6rGDfrmCpN5nYZwweeW6CMW/pYKCmTdfAFfIpiFX8z
   z4ss4amer1cta3jXuv8KL2ZxF4XbA8jn46xzEYoZyba8+aPJBqCZiVbD+
   LdwfV+ZLaVist13WevlATlYsajr0Jzd7QkA1Uv0Tx4h5upllHFWQI5MYG
   c3yHj15/sJRDVhyioeta6e270v6bZeBRKlPOCTgP6D8JGOm7eBNJ3Kvu6
   PzqiLga4MBLZfZRew21QWgeIR53P4Jymy7R023cwrG2yCtolvF1eisYZ6
   w==;
X-CSE-ConnectionGUID: FIEDZ6fbT1+4P+XMJEuJ7A==
X-CSE-MsgGUID: Ybe+CbuLQ6+BflilYcSY1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485235"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485235"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:37 -0700
X-CSE-ConnectionGUID: Pw3PS3EnSdCoM/ktTPGfNQ==
X-CSE-MsgGUID: KSHIWB1ST56hZfekZ230Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809936"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:05 -0700
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
Subject: [PATCH V5 07/14] i3c: master: Fix potential UAF in i3c_device_match()
Date: Fri,  7 Aug 2026 17:56:31 +0300
Message-ID: <20260807145638.168865-8-adrian.hunter@intel.com>
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

i3c_device_match() dereferences i3cdev->desc without holding the bus
normal-use lock.  Since the descriptor pointer can be replaced
concurrently, the dereference can race with descriptor replacement and
result in a use-after-free.

Protect access to i3cdev->desc with the normal-use lock.  While the lock
is held, the descriptor is guaranteed to remain valid, so the NULL check
is also unnecessary and can be removed.

This change depends on "i3c: master: Fix recursive locking during device
registration".  Prior to that change, taking the normal-use lock in
i3c_device_match() could recurse on bus->lock during device
registration.

This fixes "i3c: master: match I3C device through DT and ACPI".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4 and V5:

	None

Changes in V3:

	New patch


 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index ee771ac0b203..83e04a2c202a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, const struct device_driver *drv)
 	i3cdev = dev_to_i3cdev(dev);
 	i3cdrv = drv_to_i3cdrv(drv);
 
-	if (i3cdev->desc && i3cdev->desc->boardinfo)
+	i3c_bus_normaluse_lock(i3cdev->bus);
+	if (i3cdev->desc->boardinfo)
 		static_addr_method = i3cdev->desc->boardinfo->static_addr_method;
+	i3c_bus_normaluse_unlock(i3cdev->bus);
 
 	/*
 	 * SETAASA-based devices need not always have a matching ID since
-- 
2.53.0

