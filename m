Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF031E84B;
	Tue, 28 Jul 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254002; cv=none; b=o2ZbJi82BUIhNePb2lyUHQ/w6soMVswqkhbwU0FIT8Zi5zJeCT7MfiRW27x5yhZdJJfefe1ZbY8zzqe9MfClPANin08PHUspFE+r7O39i6rc1+DCoDm2mKdk5mp8FE7sf3w5+FpyGjVoP4IsmEcMFJUrapI24UGxXBa/IjfK/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254002; c=relaxed/simple;
	bh=bdDTFgwVaJPzXbDXJHAYIe4NI0tDIzc2e4q5zy9J0l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elmQPT8Uipw2mWntqck5Yhn4H1evKTKMHid/JulWoQM7roudCG/htTc0hJrMJWJta8N7GtXPfuE9wLBUfVJwk986jJRj0Z3tJ0mHyxtUUHETAsyWSBGSoI6LrKtoZQS6vRExdh+rkF/hDZk1mfhJF3ojnACFg8Xrwk7sMmRi71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZ+rbe9O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZ+rbe9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254000; x=1816790000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bdDTFgwVaJPzXbDXJHAYIe4NI0tDIzc2e4q5zy9J0l0=;
  b=IZ+rbe9O7si+f7xieQxlAalGQDutwNK1oeolmupRFKwMBqffJgQmP+nz
   22iOLtKJGk/wb3xc9xp+q08eBnMNjFxW8TsrLCeKKNQbQkNnmAPTIRAs5
   Jk20487Whc2vqwn34piV1WAlwtZYUqfa7o5UhgirjwkLx6oGXJzlH8z6N
   f4yMLumArSy/lD6RBAsy4s5saFqLeqiVQ8mQlmAmVhTy2qS6LiSG8NDsC
   TqOstfx4+HrIO5kb0QNBra4xW8N9xIrm5eQ46JYCoSu0Kf538jfYOg5C/
   sNPciSz4ROg1jtsqvUY8377pxL/QoEQXZT1GydGE1QfIOgHA/yvFz6by9
   w==;
X-CSE-ConnectionGUID: Y+e7QJ+ITiyBjnmi62w7Uw==
X-CSE-MsgGUID: BuFCyZ+WQm+PKc5bSKHzJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696418"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696418"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:19 -0700
X-CSE-ConnectionGUID: cIMVD2ezQdeCpH+ToN2W+A==
X-CSE-MsgGUID: fZlV2llzQ3GoGR7sjyRd9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817355"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:16 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 0/8] i3c: Support IBI-based system wakeup
Date: Tue, 28 Jul 2026 18:53:00 +0300
Message-ID: <20260728155308.142713-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Intel LPSS I3C controllers support up to two I3C busses and can wake the
system from an In-Band Interrupt (IBI) via a PCI PME.  Today that wakeup
capability lives only at the PCI function, with no way to express which
I3C device is actually responsible for waking the system, and no way for
user space to enable or disable wakeup on a per-device basis.

This series pushes the wakeup capability down to the individual I3C
devices and then aggregates the resulting wakeup state back up to the PCI
device.

An IBI-capable I3C device on a bus whose controller can wake the system
is marked as wakeup capable, so it can be managed through the standard
device wakeup framework (e.g. via power/wakeup in sysfs).  When such a
device is enabled for wakeup, a wakeup event is reported each time it
queues an IBI.

At suspend time, the mipi-i3c-hci PCI driver aggregates the wakeup
configuration of the I3C devices across its HCI instances (up to two I3C
busses) and enables PCI wakeup (PME) only when at least one attached I3C
device is enabled as a wakeup source and has IBI enabled.  This keeps
the PCI wakeup state in sync with the actual requirements of the devices
on the busses.

The series is organised as follows:

 - Patch 1 fixes a pre-existing recursive acquisition of the bus rwsem
   in i3c_master_register_new_i3c_devs().  The remaining patches add
   work to that same function, so the locking is corrected first.

 - Patches 2-5 add the generic I3C core support: an ibi_wakeup flag for
   controllers, marking IBI-capable devices as wakeup capable, reporting
   wakeup events on IBIs, a helper to query whether any device on a bus
   has both wakeup and IBI enabled, and a fix to reject IBI requests
   from devices that do not advertise IBI capability.

 - Patches 6-8 wire this up for the mipi-i3c-hci driver: propagate the
   aggregated I3C wakeup requirements to the PCI function, factor out
   i3c_hci_sysdev() for the shared device lookup, and advertise IBI
   wakeup capability when the underlying system device can wake the
   system.

Note, since the PCI wakeup state is now derived from the wakeup
configuration of the attached I3C devices, the PCI device's
power/wakeup sysfs attribute no longer provides independent wakeup
control.


Changes in V2:

    Dropped the RFC tag.

    i3c: master: Fix recursive locking during device registration
	New patch

    i3c: master: Support IBI-based wakeup capability
	Dropped the redundant #include <linux/pm_wakeup.h>.  That header
	must not be included directly, and linux/device.h, which is
	already included, provides device_set_wakeup_capable().

    i3c: master: Add helper to query bus wakeup requirements
	i3c_master_any_wakeup_enabled() now also requires the device to
	have IBI enabled, not just system wakeup enabled, so that a
	device with no active IBI request does not keep PCI PME enabled.
	desc->ibi_lock is taken while checking.  The commit message and
	kernel-doc are updated to match.

    Rebased onto i3c/next.


Adrian Hunter (8):
      i3c: master: Fix recursive locking during device registration
      i3c: master: Support IBI-based wakeup capability
      i3c: master: Report wakeup events for IBIs
      i3c: master: Add helper to query bus wakeup requirements
      i3c: master: Reject IBI requests from non-IBI-capable devices
      i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
      i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
      i3c: mipi-i3c-hci: Advertise IBI wakeup capability

 drivers/i3c/device.c                               |  8 ++-
 drivers/i3c/master.c                               | 84 +++++++++++++++++++---
 drivers/i3c/master/mipi-i3c-hci/core.c             | 15 ++++
 drivers/i3c/master/mipi-i3c-hci/dma.c              | 15 +---
 drivers/i3c/master/mipi-i3c-hci/hci.h              |  2 +
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 23 +++++-
 include/linux/i3c/master.h                         |  5 ++
 7 files changed, 123 insertions(+), 29 deletions(-)


Regards
Adrian
