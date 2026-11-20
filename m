Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182448;
	b=vTnATIpp3RNWy3YLPLVQILeD3MxIPb/1Ri1/bb+irWbWiWFKgQK0lKKZ4vT17G2zcWw9
	 N5e9+s2WqBPN6EHpRPYMv12azoYAlNCHolT0HDRD8hTcgCe3udlkgD1ASmnxQMz82rS8Z
	 uiX5ViAeKMktad52FcXZ7yt7VFdTulbTrAgChy5IybgNnfSc+JlsyeqdJpy6uXBo9I7wh
	 QLjPdNbXz1AQhB9x9c5oFAYaEeRvP2YJFwtS6uwmzv6E9CudYsgekahi29cJBmzkfKl1A
	 MF8jlcIDkbnRJZgbqCa70ND5QykodySxrMvOVLn/9pWyF++4tlgT4vf3GbFpaoNz7TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182448;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4LraybQfE1yQd3PjjmjSyb8YVEJVQeSQfcSql1slz1g=;
	b=hMesNmV5QTojvVx+w9e72nla/x32d1762Vq9n8EnMZlQwBNxH+mdGWshZGRunIKvrQGG
	 sYX/GbV2cISgc00IH4oW9zRT15d5DCOkFye3AGe2/fHJytX+Cj5nZ+RhxwSzNgwqsCki1
	 FAQFd5vKlyFmTkP8/pIHiKDSERIEcGN18huOXDZvUA5aEIyVeuOfLhtapcbsOlQYtyF+2
	 u3kJZWm2v04TZxVr5CDb79vLYyRiGyRzF6d+5KYaOnJrB/4Sm26bt4wI8KW4/OmqkcdZf
	 emzI5eQKIXNVCqrsA2H2NB149P2up13cAvgGqMBCzVO9r/XQ9hjq/MaOaYeMpKU8KkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ASBfDw7F;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BB606A320;
	Fri, 20 Nov 2026 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727BB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ASBfDw7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182448; x=1826718448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rYY166ikYX6+XRvaX9MhZJI+peSm82FdQzq+DN6mF8Y=;
  b=ASBfDw7FWTuwgweVf3bRFqR0EE/HyC/VtwBxO1y+DZVC7VUAD0fRJ1V5
   Bb9goP5yl/ZEAqtXptUJrPeGLLE5OsgDEduHHort9JXg/fptaKXiM3ZZY
   R1fIUSazZd9s0ifTNjoncpaIIPv5Av8frSuqY+v5hF2Ldk8TR7Gp4JHio
   zm3SQKi9+Uy0KNmTtLZOr5LTCrrlu32GwFgCr/4Rge502V5va/QKn2N0k
   FEm/st6dKscuMbZUcg+00KDhnt/KYwC9sVhUpnGdchOSzWoomFTju6hAc
   nE2PWa5LJsgkBFb9E0JtZYtkqCaGPSSp7xManQIHH9sjiBUrQXFJQgfMd
   Q==;
X-CSE-ConnectionGUID: L/vdLpIIRB6Xt47QX3eGlg==
X-CSE-MsgGUID: ITflNY6CT0KgOXIh8x0eYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4052840"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4052840"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:47:27 -0800
X-CSE-ConnectionGUID: y3rr/xtLTu2Nq0Eck1oEHg==
X-CSE-MsgGUID: GtC9Ar0pRvqk1SBXaKm90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11277346"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:47:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/16] PCI: Serialize bridge window sizing and resource assignment
Date: Fri, 20 Nov 2026 15:46:55 +0200
Message-ID: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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
use guard(). pci_res_setup_lock is added to serialize the sizing and
assignment passes. Last, the series converts the remaining
pci_bus_assign_resources() users and removes it.

Drivers that call pci_assign_resource() or pci_release_resource()
directly are not covered by this series.

I've another series coming up which will add struct pci_setup_data that
is to be held across the entire sizing and assignment algorithm, which
is another reason why those actions have to be kept together going
forward. The goal of that upcoming series is to size also assigned
bridge windows properly and we need a place to keep the alignment
because STARTALIGN is lost when a resource gets assigned.


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

Ilpo Järvinen (16):
  PCI: Add pci_bus_size_and_assign_resources()
  alpha/PCI: Convert to pci_bus_size_and_assign_resources()
  PCI: Use guard() for pci_bus_sem in
    pci_do_resource_release_and_resize()
  PCI: Add pci_assign_unassigned_slot_resources()
  PCI: acpiphp: Use pci_assign_unassigned_slot_resources()
  PCI: Hold pci_bus_sem across sizing and assignment entrypoints
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
 drivers/pci/hotplug/acpiphp_glue.c    |   8 +-
 drivers/pci/hotplug/octep_hp.c        |   2 +-
 drivers/pci/pci.h                     |   6 +-
 drivers/pci/setup-bus.c               | 128 +++++++++++++++++++++-----
 drivers/pcmcia/cardbus.c              |   3 +-
 drivers/platform/x86/asus-wmi.c       |   2 +-
 drivers/platform/x86/eeepc-laptop.c   |   2 +-
 include/linux/pci.h                   |   2 +-
 18 files changed, 126 insertions(+), 60 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

