Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7793371D07;
	Wed,  1 Jul 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936945; cv=none; b=AXJ4EXGWupWEO7Y+1V6XqnCQSfnPzhAsqOhR4hqii6UT6sE6uuAv4yQ0oAUoj0ExLYq8NtZqJj/c4FfudVl/ShZa1Gm3tg2twoYFxfYtv/7G1iezJTq26Vmdqj6BM5rprMvhPesItVqflhYHgt8zGMsw5MEY9fu6qNgkS3UEmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936945; c=relaxed/simple;
	bh=5IxV5XbO4AnpYPehtaq3aUnzZA7FZgIQgSUmkIeGleQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgvhvPNhY1MxV3vjhQqfcDEpdEM+Gp4fFqHCXjrcRxO80cq4BMZIXLWJ+1ydmcjbWpZilzFP/y2dyLQBxAXUWhx147Kbpvq2jKbEUiR9q/DtavaOFtxEeMdYRH1v8CwcumcCprWonesnONx5Dt+60fsTZg5LTVOTixr9fCLYkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aID1ZVIo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aID1ZVIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936944; x=1814472944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5IxV5XbO4AnpYPehtaq3aUnzZA7FZgIQgSUmkIeGleQ=;
  b=aID1ZVIoFwZ9rnQGw56e6sFc+YMgtqkbkYFocvtYYE/tHG1Swzt8Gjuu
   dqPFrRdRd5j5oLC8qqhZvDHI9kVZzzizumC1lE7Kr2RdRK94N2Wv1Id09
   8P12nIjWhV2l1Ys47yZzTvmMdPFgycQWiJ5FOKGDF+gX3DOvtMfma7mzq
   LteWa36RJNwn7Pe8FgFxOIc+HyvH25FMXV1QTroW77OavOKSzBecotUSu
   Z9BRJRRx/fheOD5hhhiwWdDc86L+e5ySoIvyGiuk2vVfvqltTivVE52pf
   8MXvD9caXHaS6ZsfTCG0ZKZIskTXC9bvWpEOoVERGr2qCzMj2a0DAG635
   w==;
X-CSE-ConnectionGUID: 1u5zNvtHQo+ogUl984o16Q==
X-CSE-MsgGUID: mHjN7Vi/T72LiBQ2kV0q8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671776"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:43 -0700
X-CSE-ConnectionGUID: ctUYThKLQ8+DNvkr4dPZVA==
X-CSE-MsgGUID: NW1iyglNR36nO3JfkyzlMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737042"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:41 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 0/7] i3c: Support IBI-based system wakeup
Date: Wed,  1 Jul 2026 23:15:26 +0300
Message-ID: <20260701201533.220818-1-adrian.hunter@intel.com>
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

[ Re-sent to correct email addresses of linux-pci and linux-pm mailing lists ]

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
device is enabled as a wakeup source.  This keeps the PCI wakeup state in
sync with the actual requirements of the devices on the busses.

The series is organised as follows:

 - Patches 1-4 add the generic I3C core support: an ibi_wakeup flag for
   controllers, marking IBI-capable devices as wakeup capable, reporting
   wakeup events on IBIs, a helper to query whether any device on a bus
   has wakeup enabled, and a fix to reject IBI requests from devices that
   do not advertise IBI capability.

 - Patches 5-7 wire this up for the mipi-i3c-hci driver: propagate the
   aggregated I3C wakeup requirements to the PCI function, factor out
   i3c_hci_sysdev() for the shared device lookup, and advertise IBI
   wakeup capability when the underlying system device can wake the
   system.

Note, since the PCI wakeup state is now derived from the wakeup
configuration of the attached I3C devices, the PCI device's
power/wakeup sysfs attribute no longer provides independent wakeup
control.


Adrian Hunter (7):
      i3c: master: Support IBI-based wakeup capability
      i3c: master: Report wakeup events for IBIs
      i3c: master: Add helper to query bus wakeup requirements
      i3c: master: Reject IBI requests from non-IBI-capable devices
      i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
      i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
      i3c: mipi-i3c-hci: Advertise IBI wakeup capability

 drivers/i3c/device.c                               |  8 +++--
 drivers/i3c/master.c                               | 41 ++++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/core.c             | 15 ++++++++
 drivers/i3c/master/mipi-i3c-hci/dma.c              | 15 +-------
 drivers/i3c/master/mipi-i3c-hci/hci.h              |  2 ++
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 23 ++++++++++--
 include/linux/i3c/master.h                         |  3 ++
 7 files changed, 88 insertions(+), 19 deletions(-)


Regards
Adrian
