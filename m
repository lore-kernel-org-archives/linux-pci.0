Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842660;
	b=ogofHPQ8J8hIHpdqht7f4/lqe/ExwgIsMbW3IAMWBZlUb9bWli2dfmX02YajhqQdxneA
	 xW3bp5gbJiQLvYw48v26Ha9WPKi4s5teUjHk+EQCW7jcs0jNdIvv2C+/lpRwniq4vMC5K
	 I9S2uQawXFsqMh8nNHJg1eTH7K1osspg3E3gYNMnBoXwQtrnuHgxScQvfaXKOz90jBbVc
	 slPddl5w+bVtuq2KNS/5Ly835AjaOqJBGclDzSiEyYI9CEWeQfEsfIoPZrPuWE3MVcL34
	 jnYO0EAj1lQp6E2imqiKy4lhSYANJNjGPQ7Rv/nXgPl1+CFWJSDm2U94fc+cttpeXaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842660;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4RSE+wXyi0xN30ryRSfOChXwaSf3kTtNfuycV+k+JYk=;
	b=hvBzY3Hrd1TuktfogbEuY9O9EMhtlfVkSsAylYVONlNW/m35mzh4wHWlwYfVy+z6pZFj
	 P+d0yc3RbcJh42QQFa+8klV0zPBEsjxS3kIu00UMlPnG/Fx3ifRQNaHna7odcHeBpt0Cl
	 6rhp6sBh7FudMKhQtrrfObScUyxmiyMx5TSOIIPAtQeEYQKwwzjtjtcU8LabtB/HywOLE
	 RNa2mc505dig/82Q/+h5QkeT34Z7DCprlIzjxIQ4r8JtdrjBceHyX8c/Ie+0IqM4qJCap
	 Es0YooBwNQ4zITpMVLVhaPhZQVZKpIP0frQZLY4RBe9BGFRl+o+LMdkCDNsOf+SFEww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=npeSP86+;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE6606A31C;
	Mon, 16 Nov 2026 15:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7DE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=npeSP86+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842660; x=1826378660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yl+pvOsBKMsDd7s1Q55/tMI6IW0+1NoTQbFquiReQv4=;
  b=npeSP86+LNd+vlQf8kDTv1qa0Gh6ZrupVOsR/OyREzhepipYJ1DYDUOz
   usuU38eOXSUgzDKvVuiqsn2l2IN/tu4fQZZsdR0hN0OOdg+RTwf/B8q4M
   a1rvAI7sWr84AhHWzVvrRGWhUxKa1vUH0XHLQTrWYk/2P/o1fL1aXVz55
   9topp1hGKr+aP3JPu9tEOslsTzJvLeJPzfsIi+Yu8TZX8kM4CGp+3cljO
   nfmmQ4YTZHYk3p6s7u6rQ7OdTJtlrXfLctXADwEUGybjHIHA6R5vh6xvw
   zQ9ukguGJiIh9BWxsE6guh1IeQl30r0AoqXWnQTobMpuTnN5FM2akxc9E
   Q==;
X-CSE-ConnectionGUID: 2negQR2gTsS5wuHR7g/vmQ==
X-CSE-MsgGUID: Lr6nrmW9RwWawgUke28gwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3457168"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3457168"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:19 -0800
X-CSE-ConnectionGUID: nveOcr43QlmTj9n2I5JMxA==
X-CSE-MsgGUID: 6eb1C6MiSSmCudzNTAuX4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9419795"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/13] PCI: Serialize bridge window sizing and resource assignment
Date: Mon, 16 Nov 2026 17:23:45 +0200
Message-ID: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
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
multiple entry points: rescan and hotplug under pci_rescan_remove_lock,
and BAR resize from sysfs or driver probe under device_lock() only. As
the entry points hold pci_bus_sem at most for read, nothing prevents two
sizing and assignment passes from running concurrently on the same
bridge windows and BARs.

Multiple issues due to these races could be reproduced some on a real
host and more in QEMU with a synthetic PCI host bridge (not part of
this series) by looping BAR resize against a rescan through sysfs. The
failures include spurious BAR resize failures, a WARN in
pci_dev_res_restore(), a NULL pointer dereference in
__release_resource(), and a bridge window programmed over RAM. None of
them occurred with this series applied.

The series first adds pci_bus_size_and_assign_resources() so that PCI
core can hold the locks across both phases and converting 1:1 callers
(alpha nautilus retains extra sizing call to avoid complex
refactoring). Secondly, convert setup-bus entrypoints to guard() and
pci_res_setup_lock to serialize the sizing and assignment passes.
Last, convert the remaining pci_bus_assign_resources() users and
remove it.

Drivers that call pci_assign_resource() or pci_release_resource()
directly are not covered by this series.

I've another series coming up which will add struct pci_setup_data that
is to be held across the entire sizing and assignment algorithm, which
is another reason why those actions have to be kept together going
forward. The goal of that upcoming series is to size also assigned
bridge windows properly and we need a place to keep the alignment
because STARTALIGN is lost when a resource gets assigned.

Ilpo Järvinen (13):
  PCI: Add pci_bus_size_and_assign_resources()
  alpha/PCI: Convert to pci_bus_size_and_assign_resources()
  PCI: Use guard(&pci_bus_sem) in pci_do_resource_release_and_resize()
  PCI: Hold pci_bus_sem across sizing and assignment entrypoints
  PCI: Serialize bridge window sizing and resource assignment
  i82875p_edac: Convert to pci_assign_unassigned_bus_resources()
  platform/x86: asus-wmi: Convert to
    pci_assign_unassigned_bus_resources()
  platform/x86: eeepc-laptop: Convert to
    pci_assign_unassigned_bus_resources()
  parisc/PCI: Convert to pci_assign_unassigned_bus_resources()
  PCI: hotplug: octep: Convert to pci_assign_unassigned_bus_resources()
  PCI: ftpci100: Convert to pci_assign_unassigned_bus_resources()
  PCI: hv: Convert to pci_assign_unassigned_bus_resources()
  PCI: Remove pci_bus_assign_resources()

 arch/alpha/kernel/sys_nautilus.c      |  2 +-
 arch/arm/kernel/bios32.c              |  5 +-
 arch/m68k/coldfire/pci.c              |  3 +-
 arch/mips/pci/pci-legacy.c            |  5 +-
 arch/sh/drivers/pci/pci.c             |  3 +-
 drivers/edac/i82875p_edac.c           |  2 +-
 drivers/parisc/dino.c                 |  2 +-
 drivers/parisc/lba_pci.c              |  7 +--
 drivers/pci/controller/pci-ftpci100.c |  2 +-
 drivers/pci/controller/pci-hyperv.c   |  2 +-
 drivers/pci/hotplug/acpiphp_glue.c    |  4 +-
 drivers/pci/hotplug/octep_hp.c        |  2 +-
 drivers/pci/pci.h                     |  1 +
 drivers/pci/setup-bus.c               | 78 ++++++++++++++++++++++-----
 drivers/pci/setup-cardbus.c           |  3 ++
 drivers/pcmcia/cardbus.c              |  3 +-
 drivers/platform/x86/asus-wmi.c       |  2 +-
 drivers/platform/x86/eeepc-laptop.c   |  2 +-
 include/linux/pci.h                   |  2 +-
 19 files changed, 88 insertions(+), 42 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

