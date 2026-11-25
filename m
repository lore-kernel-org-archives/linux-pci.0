Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648183;
	b=4+CF7cRBb1w6BcnsOXtSf0EeMHskkAL/kS485c224uYulOMefOJFe24gZrDhMZE/P5rp
	 Jfo+0sjD2dRvSpNCbYiW3MQqFcAjeoTBzjxlFqMIezfGiFQ1oF1EEE1poBtIozhpbnyKl
	 a9T5/A0gxLKK5SpurXYT3+szuQIdB/yuz8J0HeagmyghMwwznhrLR8Uc3Y67JMn+dxFFe
	 bkip0nVEkJ3ope7ftrLyNsR+c7YUI4eZdZjOT083or4XS5NtqZwtsNaDPIylK5mxbQZvM
	 DjA4tQJVjDWd/QtFbEEPFW5TbY2iE8L24cJhoNDGdJptVqNxG1pR1J5JjAYyIUIz2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0K2q2UEeZYBetOeifmL58FNhfj12r0n3qbkEwWcwggE=;
	b=Z8I0aHhU/mDXqyCi98h8sUd88DGJ7m9AnJG9urGFWw9eGdf2D6nu56YQewjazAbWjEI7
	 0e/veLXFEXz2J9c1/e9lJ81Tfoa8Vs3IpBo4Z8ppZnCC1uG5uEgPgMFJq4huGIhxLs95p
	 kIg/61sJ5xMY0Pjm0Hoi7F4ahUUzIchYhuOUoj64Hq0tnIt7unQe7bR0gOnFT75EUiMke
	 cGmxFNw5zG9K1kWfCd+mCNvbHMgiof2dvfbenZWFAqWkK8hseqAOLBodg5NzDqwAryrbL
	 CrycNEbmAtNsCbLzmHz4c7qr9K/of1SsjSYh8EUQOueopMvT+wTQwjyYGwW6hqPTdIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lvs3zutK;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58EB606A31E;
	Wed, 25 Nov 2026 23:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B58EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lvs3zutK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648182; x=1827184182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=91cCZ6mfixzb2eXdcEC2OVnV1XVH8aSgNnKVaLSbNMs=;
  b=Lvs3zutKyoKsTVhpVftVkdY4dS7a1P2agphKk2oTWDqyMAF9WTpeOQbO
   XP3OQKMXXeNYveU5PtyffrGua/iQe17ZI/Z2uC5dbOYve5nn+myILyWjJ
   B4L2iA17Giej4bEwBgcRWVxfCxjSA985YiXOMH+0ziwfLvsJEFPhaRPOs
   idT0A3p+LwZtfVDyRPd65UbMDjJxX2E+/XUNU4uaBsUvMSraQotjQ+Vc9
   NdTQY9x5CKXGSHDn0Aw47WaIpZ+F/WDJmphjmVkwZHtnwZ3y/TNdJump5
   2egHahOomMNpi6GA+ROkGxj0/Z7azyQaVGUJn2whALjSiV3oJEKsX5vxG
   Q==;
X-CSE-ConnectionGUID: 06BcWXAiTKuwgKK6GABZ/w==
X-CSE-MsgGUID: U0eHTzsWT/a8O3s9nc1Kjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4627801"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4627801"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:09:41 -0800
X-CSE-ConnectionGUID: kXqxO/w9Rt24pZgpcbW5wQ==
X-CSE-MsgGUID: y1EptVulRvmFsIoNCEsJyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12475736"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:09:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/17] PCI: Serialize bridge window sizing and resource assignment
Date: Thu, 26 Nov 2026 01:08:59 +0200
Message-ID: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Bridge window sizing and resource assignment can be started from
multiple entrypoints: rescan and hotplug under pci_rescan_remove_lock,
and BAR resize from sysfs or driver probe under device_lock() only. As
the entrypoints hold pci_bus_sem at most for read, nothing prevents two
sizing and assignment passes from running concurrently on the same
bridge windows and BARs.

Multiple issues due to these races could be reproduced some on a real
host and more in QEMU with a synthetic PCI host bridge (not part of
this series) by looping BAR resize against a rescan through sysfs. The
failures include spurious BAR resize failures, a WARN in
pci_dev_res_restore(), a NULL pointer dereference in
__release_resource(), and a bridge window programmed over RAM. None of
them occurred with this series applied.

The series adds pci_bus_size_and_assign_resources() and
pci_assign_unassigned_slot_resources() so that PCI core can hold the
locks across both phases. It converts the callers (alpha nautilus
retains an extra sizing call to avoid complex refactoring). The
entrypoints are made to consistently hold pci_bus_sem for read and
use guard(). A per host bridge pci_res_setup_lock is added to
serialize the sizing and assignment passes. Last, the series converts
the remaining pci_bus_assign_resources() users and removes it.

Drivers that call pci_assign_resource() or pci_release_resource()
directly are not covered by this series.

I've another series coming up which will add struct pci_setup_data that
is to be held across the entire sizing and assignment algorithm, which
is another reason why those actions have to be kept together going
forward. The goal of that upcoming series is to size also assigned
bridge windows properly and we need a place to keep the alignment
because STARTALIGN is lost when a resource gets assigned.

v3:
- Move the new lock under pci_host_bridge
- Make pci_find_host_bridge() input const bus
- Reduce number of lockdep asserts as finding the lock is more costly now

v2:
- Expand BAR Resize lock coverage to include the parent window acquire
  (sashiko)
- Add pci_assign_unassigned_slot_resources()
- Refactor acpiphp, replaces sizing call in the loop with one
  pci_assign_unassigned_slot_resources() after the loop to not hold
  locks across scan
- Keep pci_res_setup_lock local to setup-bus.c (drops setup-cardbus.c
  assert that was of minor importance anyway)
- Minor language tweaks to changelogs


Ilpo Järvinen (17):
  PCI: Add pci_bus_size_and_assign_resources()
  alpha/PCI: Convert to pci_bus_size_and_assign_resources()
  PCI: Use guard() for pci_bus_sem in
    pci_do_resource_release_and_resize()
  PCI: Add pci_assign_unassigned_slot_resources()
  PCI: acpiphp: Use pci_assign_unassigned_slot_resources()
  PCI: Hold pci_bus_sem across sizing and assignment entrypoints
  PCI: Make pci_find_host_bridge() take a const bus
  PCI: Serialize bridge window sizing and resource assignment
  PCI: Make internal sizing and assignment functions static
  EDAC/i82875p: Convert to pci_assign_unassigned_bus_resources()
  platform/x86: asus-wmi: Convert to
    pci_assign_unassigned_bus_resources()
  platform/x86: eeepc-laptop: Convert to
    pci_assign_unassigned_bus_resources()
  parisc/PCI: Convert to pci_assign_unassigned_bus_resources()
  PCI: octep_hp: Convert to pci_assign_unassigned_bus_resources()
  PCI: ftpci100: Convert to pci_assign_unassigned_bus_resources()
  PCI: hv: Convert to pci_assign_unassigned_bus_resources()
  PCI: Remove pci_bus_assign_resources()

 arch/alpha/kernel/sys_nautilus.c      |   2 +-
 arch/arm/kernel/bios32.c              |   5 +-
 arch/m68k/coldfire/pci.c              |   3 +-
 arch/mips/pci/pci-legacy.c            |   5 +-
 arch/sh/drivers/pci/pci.c             |   3 +-
 drivers/edac/i82875p_edac.c           |   2 +-
 drivers/parisc/dino.c                 |   2 +-
 drivers/parisc/lba_pci.c              |   7 +-
 drivers/pci/controller/pci-ftpci100.c |   2 +-
 drivers/pci/controller/pci-hyperv.c   |   2 +-
 drivers/pci/host-bridge.c             |   8 +-
 drivers/pci/hotplug/acpiphp_glue.c    |   8 +-
 drivers/pci/hotplug/octep_hp.c        |   2 +-
 drivers/pci/pci.h                     |   6 +-
 drivers/pci/probe.c                   |   2 +
 drivers/pci/setup-bus.c               | 108 ++++++++++++++++++++------
 drivers/pcmcia/cardbus.c              |   3 +-
 drivers/platform/x86/asus-wmi.c       |   2 +-
 drivers/platform/x86/eeepc-laptop.c   |   2 +-
 include/linux/pci.h                   |  16 +++-
 20 files changed, 125 insertions(+), 65 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

