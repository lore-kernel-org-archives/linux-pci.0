Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7A390235;
	Wed, 29 Apr 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465590; cv=none; b=qdfzP/UUtDp+p9ATH7EEiBB3SdYHJRWQdRAeVnK4MqpDJEhVGCudRBfrNWtXXh8bq5WJ9fx1bpx1WxE/VfUp6nX51tJfHT3gsqYepnwTzVjwzhFtkBgBVkmBCBdVYqiE1PWnX0y8aEqFf7X+aUO+FQC1mwWw+mwM86uz/DPpbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465590; c=relaxed/simple;
	bh=StUIvDAZe7jSwmt+KbusiTw3cp/VUh8LhDiUJd1ZEnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E5zQeAm10NwWGjqqtDvnQnSfsmmW7c5zWYABxQxc9GblndB81j6sfi00DhG4n3dsTbnkzGVN6tHPLrryQnNP0cDxbX0xzojS3pnDqMKkS4qT4XS7j9oyYStnrySyqfjlSyt/8HPt4BGxJyqmtdqswHJJ+3B4QRC3e0ItqBolkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQpPlTT1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQpPlTT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465589; x=1809001589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=StUIvDAZe7jSwmt+KbusiTw3cp/VUh8LhDiUJd1ZEnM=;
  b=VQpPlTT1VLTLo0P0/zRjuHxOVGv8C6pVOhYNAA9Y6Z0aLOWg9Zk17TWP
   2iUHy1SlFYHe61LMOqCOBL3ZUoI4n+Cq4I59ywdOmWgSCg6XfM7DFVERV
   AU6RCb8DaV1OEK596elepHGI8/vZeIOo2QOLzVtDDnyJpYeCQVcfWYJ1H
   b/y4zp9K8sSRmkIOaMC+RYUUxGabLeUgEzSbox9DFz8g+B73T8QZOEoOU
   Xj4aTJIV7GdH2HSVDM3Y9gnTNgCyq0RGD/J8GPrpjOT7uRXHWGlgHUmn+
   m7QIHNylQ2xp6elUyFHPqvJ+qLQ5ZEUj4MOIr5GBIqwvrd7malHWSib/p
   w==;
X-CSE-ConnectionGUID: R19vFmwvS3eICsDRe9FlNw==
X-CSE-MsgGUID: 1u9xOIr3Q1+lHXTCppVi0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557641"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:28 -0700
X-CSE-ConnectionGUID: e2ynKkGnQ/mCfV7EGabTDQ==
X-CSE-MsgGUID: UMOQ/jvuTpGe6w8nQEajNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669615"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/11] PCI: pci_resource_alignment() improvement + cleanups
Date: Wed, 29 Apr 2026 15:26:06 +0300
Message-Id: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_resource_alignment() returns 0 when resource is already assigned
and in case of disabled bridge windows. This has caused problems to
calculations relying on pci_resource_alignment():

https://lore.kernel.org/linux-pci/LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM/

This series reworks pci_resource_alignment() interface to return always
non-zero alignment if the resource exists. For assigned bridge windows,
the calculation is using heuristic based on size and start address
alignment as calculating the alignment again is costly (would require
sizing the entire sub-hierarchy).

As pci_resource_alignment() is becoming more complicated, it's also
moved to setup-res.c. While moving pci_resource_alignment()'s arguments
are converted into const to tell compiler it can rely on resource
remaining the same across the call.

This was intended to be part of a larger series that addresses some
shortcomings in pci=realloc. The pci=realloc changes will recalculate
bridge window sizes considering also assigned resources which required
making these changes to pci_resource_alignment().

As this also relates to the issue linked above, I'm sending it already
now without pci=realloc changes that are still incomplete. The first
patches originate from the large pci=realloc work but seem generally
useful even if independent of the alignment improvements so I've
included them here without reorganizing the series to contain only
alignment related changes.

Ilpo Järvinen (11):
  PCI: Log all resource claims
  PCI: Rename added to add_list
  PCI: Consolidate add_list (aka realloc_head) empty sanity checks
  PCI: Remove const removal cast
  resource: Make resource_alignment() input const resource
  powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get()
    pci_dev const
  PCI: Make pci_sriov_resource_alignment() pci_dev const
  PCI: Convert pci_resource_alignment() input parameters to const
  PCI: Move pci_resource_alignment() to setup-res.c file
  PCI: Lower bound bridge windown alignment
  PCI: Return valid alignment for assigned resources

 arch/powerpc/include/asm/machdep.h         |  2 +-
 arch/powerpc/kernel/pci-common.c           |  2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c |  4 +-
 arch/powerpc/platforms/powernv/pci.h       |  5 ++-
 arch/powerpc/platforms/pseries/setup.c     |  5 ++-
 drivers/pci/iov.c                          |  7 +--
 drivers/pci/pci.h                          | 24 ++++-------
 drivers/pci/setup-bus.c                    | 50 ++++++++++++----------
 drivers/pci/setup-cardbus.c                |  2 +-
 drivers/pci/setup-res.c                    | 37 ++++++++++++++++
 include/linux/ioport.h                     |  2 +-
 include/linux/pci.h                        |  8 ++--
 kernel/resource.c                          |  2 +-
 13 files changed, 94 insertions(+), 56 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.39.5

