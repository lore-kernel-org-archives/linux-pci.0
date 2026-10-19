Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59C485508
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398931; cv=none; b=WXCC+NNFmqP3HQSDKR9uZKs+iswXA04w7RW3HeIlYly9ssoeDG07eBoDv6RMaaVwp2jXFysrxOxzK90axBgrNieBArYaE77yybX7lh6mzkjcrovorGvTP8U3v/8GHhZygUqjrszfPCisx6Uh+6xI+VsGw76Wprle0YlqcUKPsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398931; c=relaxed/simple;
	bh=sM/lmbiyMj4k0mQgK/8nlNgNepkFAOrk9iwclinrh80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jEyjJNIllsFuSNsCuu0h2+ESWDHKxSn17OICcdUOYngaV+BxQa4NMQwgOWMRIfCinp/kbJxgFyB4Hbz5DNGlsDMLZuOEt9N5kRf9CJ13NV5qO+8z1E/32kSn7GdNWBSIDyiiDZOiI9KudkmWc+LcnUCYq968I2IsOxi8NWMEUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFj903uw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFj903uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792398928; x=1823934928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sM/lmbiyMj4k0mQgK/8nlNgNepkFAOrk9iwclinrh80=;
  b=ZFj903uwWCqvm7E4J1Zd6q5tELQLHXPI6iCAL49jX7VJHds6PTyafsYQ
   jMUTPNrnzZGrL/fJGJcapKzr0i8706Bx13ywyAkxR6ZZ1Y1HZFaV+t++5
   rbHXiAcvkIxQ+FB0BjWdBGvTX3zFdCaoTeNCsqrtnxtAm/9seRdOj1MmP
   UP0sd5snz5KVp1+vg9hfwktO71ODckK75nAJPR8ORSFGPC5WwU90QHbd/
   lorZ0RM6L/2VC3OZbPSUArJSkHPkGFfOCsUVdZEiN2+TPLl/kuIaG8rfT
   rWomkF5oOIQj5FEYQf83XuIq6KS4Vit6mctAIZkFbti8YlHMNXAaJK9wi
   w==;
X-CSE-ConnectionGUID: 5myUfUK+SBuUq9tGisP36Q==
X-CSE-MsgGUID: 5hIm78n5T0iliJj1keJu6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1061659"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1061659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:28 -0700
X-CSE-ConnectionGUID: Vluoc/k0QI6JEdktUS88aw==
X-CSE-MsgGUID: llCQfAyyTeqoWymkDyV4zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2857708"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:25 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v1 00/13] PCI/IOV: Improve reset handling with VFs enabled
Date: Mon, 19 Oct 2026 10:35:01 +0200
Message-ID: <20261019083514.838640-1-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series improves reset handling for SR-IOV devices. Today there
are a few gaps when resets happen with VFs enabled:

 1. VF state is lost across PF reset. The PCI core saves and restores
    the PF's config state, including its SR-IOV capability, and the
    kernel representation of each VF (struct pci_dev / struct device)
    survives the reset, but the VFs' hardware state does not. From the
    PCI point of view, the VFs do not exist between the PF reset and
    the restore of the PF IOV state. Their config space is lost, and
    their drivers are never notified about the reset.

 2. VFs are prepared in the wrong order during bus and slot reset. VFs
    are handled like any other device on the bus, and because the walk
    is top-down, the PF's .reset_prepare() runs before its VFs'
    callbacks.

 3. The "bus" reset method is unavailable for a PF with VFs enabled.
    pci_parent_bus_reset() accepts a device only if no other devices
    are on its bus. A PF's VFs sit on the same bus as the PF, so
    enabling VFs makes the PF fail this check. The VFs are in the PF's
    reset domain, so they should not block a bus reset of the PF.

This series addresses these gaps as follows:

 - Patches 1-3 add the PCI core helpers used by the rest of the series.

 - Patch 4 fixes (1) and (2). It locks all VFs together with the PF
   around a function reset, saves and restores the VFs' config state,
   and calls the VF drivers' .reset_prepare() / .reset_done()
   callbacks, so both architected and device-specific state can be
   preserved. During bus and slot resets, VFs are skipped in the device
   walk and handled through their PF. VFs are prepared before the PF
   and restored after it. As a result, pci_reset_function_locked() now
   requires PF callers to hold the device locks of all enabled VFs as
   well.

 - Patches 5-7 adapt PF drivers to the new core behavior. ionic and
   pds_core call pci_reset_function_locked() from their error resume
   handlers, so they now need to lock the VFs around it. i40e no longer
   needs to restore the VFs' MSI state in its .reset_done(), since the
   PCI core now restores the VFs' config state.

 - Patch 8 fixes (3). pci_parent_bus_reset() now ignores the PF's own
   VFs when it checks for other devices on the bus.

 - Patches 9-13 replace open-coded VF lookups with the new helpers.
   PCI/TSM and ixgbe use the VF iterators, and ice, liquidio and xe
   use pci_iov_get_virtfn(). These patches depend on patches 1-2 and
   are independent of the reset changes.

Lukasz Laguna (12):
  PCI/IOV: Introduce pci_iov_get_virtfn()
  PCI/IOV: Introduce VF iterators
  PCI/IOV: Introduce VF locking helpers
  ionic: Lock VFs around pci_reset_function_locked()
  pds_core: Lock VFs around pci_reset_function_locked()
  i40e: Drop VF MSI state restore from PF reset_done
  PCI/IOV: Allow bus reset_method for PF with VFs enabled
  PCI/TSM: Use generic VF iterators
  ixgbe: Use generic VF iterator
  ice: Use pci_iov_get_virtfn()
  liquidio: Use pci_iov_get_virtfn()
  drm/xe/pf: Use pci_iov_get_virtfn()

Michał Winiarski (1):
  PCI/IOV: Allow VF drivers to handle resets

 drivers/gpu/drm/xe/xe_pci_sriov.c             |   4 +-
 drivers/net/ethernet/amd/pds_core/main.c      |   5 +-
 .../ethernet/cavium/liquidio/octeon_mailbox.c |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 -
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  26 ----
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   3 -
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +--
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  25 +--
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   5 +-
 drivers/pci/iov.c                             |  88 ++++++++++-
 drivers/pci/pci.c                             | 146 +++++++++++++++++-
 drivers/pci/tsm.c                             |  25 +--
 include/linux/pci.h                           |  63 ++++++++
 13 files changed, 308 insertions(+), 115 deletions(-)

-- 
2.43.0

