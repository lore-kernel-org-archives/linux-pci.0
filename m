Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117102;
	b=cXOg5JTc2A6wz3z0qE0y/LgWhXXQ75qWFLQ5Vstlt48u0zEMVd9DWGPbbeOqAEu89IEV
	 n7HvR6TN+k0LzYbVe7eL1j4Vv1kWa4IkHLfeMT4EfoEGqZwiXJNo88h88oRTBv5gUNq2p
	 s4ep83zDdGJDOzr7LVe3BrucXAkqg/45G7adUXw2oj6TDACvfs5HBrC7tP8IUrdqD6l2d
	 CnLED9KHdc2jnRvhHVCp2+NWSUyOtX61siiDunabnP4Ybvz6kjHxxiGPA4xLIvtRRAyN9
	 jIQA8rMDYxqkENPvN5wtMUhC0ZTRaObsxuONMg0RHIM2T13dXtgFTql5oJYTcbhlkRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117102;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xQsMP+lrBgTN6MoyUahidxPsqRNrb5J2WXgZ5OTTlBM=;
	b=PzvuuUzSs09UFoctlsnVBfaqLK9Q5/LXPlJeJMRxnO49zegl7lxJtXhCs7/y2xsQAhcR
	 tXhysVP2rPPNOiu2Z+rNSOU/3Z+zpT1Ru7mHRhvnHp5vRGh33WNpTn7JokiXBLHMMzFVb
	 HP/PVchBIb/e2IKPTbpXTS6JBQuFkMfuPgqE5hcj8SC/EmzjC3rywWXlUhhOSa49xNTtI
	 Yf31mnHkeQN2v5MJxGNRdVr5KRxBU18D2qhdOC2YO9ARlq6iIMjaVv99E77qMbWn697el
	 U75QMFwPuZXyFbcGn/yR31iTBdx4o9REDDrTsN42wFX1HDn9hko9IlX5IYKi6cTzgCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NtUA51VM;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AA60A2605
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C86AA60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NtUA51VM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117101; x=1824653101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uKqy8DQJK1y1iwbFegTjPjh0qkdhTY1TpD7Xt8vtLPs=;
  b=NtUA51VMaE+c8BRYjaLI9KnqjeYRgIaVi8NMiCJbQBnEyxm7u1BAXIFh
   e3nMb4x4jzc+sWofpGRIX1jcrfRYzgkSasCMJ6UA5frGHuzVe+7KzsaXD
   MWLmGGQHaYYpjG2uCK2YNkzc2j9oDQaIUlEeNPjjOC/yJ5tXsJEuJQUFm
   3Q8Ff2VA8LEW0zCpBGqL4REPxhtJQ6QO/1nqIKXokz4O9FbrWOFPcS8Gc
   Crj8Lq3L5UL2FUN/bfbu70x3+2eCs2qCJBvOPzOKC2t/R5oqXl+ywTz0q
   VxFM2iKft06WakqOPj9e1GebG0WWlNL/0aKAt9Qa1OIo5Bb81wFNA9IFl
   A==;
X-CSE-ConnectionGUID: BI/RLdTSQVigStyy+YEBeQ==
X-CSE-MsgGUID: ebTl6nfpTh2ID96KOgteig==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1852162"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1852162"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:00 -0700
X-CSE-ConnectionGUID: CVZWlXp2QECfe1KIxvp0Eg==
X-CSE-MsgGUID: a8eeSotYQcmFKpcBKmVtTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5111751"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:04:58 -0700
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
Subject: [PATCH v2 00/13] PCI/IOV: Improve reset handling with VFs enabled
Date: Tue, 27 Oct 2026 17:04:33 +0100
Message-ID: <20261027160446.858300-1-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
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

 3. VFs on an SR-IOV virtual bus are not handled during bus and slot
    reset. The walk recurses only through dev->subordinate, so it never
    reaches them, as such a bus has no bridge. Those VFs are reset
    without being locked, without driver notification and without
    config space save/restore.

 4. The "bus" reset method is unavailable for a PF with VFs enabled.
    pci_parent_bus_reset() accepts a device only if no other devices
    are on its bus. A PF's VFs typically sit on the same bus as the PF,
    so enabling VFs makes the PF fail this check. The VFs are in the
    PF's reset domain, so they should not block a bus reset of the PF.

This series addresses these gaps as follows:

 - Patches 1-3 add the PCI core helpers used by the rest of the series.

 - Patch 4 fixes (1), (2) and (3). It locks all VFs together with the PF
   around a function reset, saves and restores the VFs' config state,
   and calls the VF drivers' .reset_prepare() / .reset_done()
   callbacks, so both architected and device-specific state can be
   preserved. During bus and slot resets, VFs are skipped in the device
   walk and handled through their PF, so VFs on an SR-IOV virtual bus
   are covered as well. VFs are prepared before the PF and restored
   after it. As a result, pci_reset_function_locked() now requires PF
   callers to hold the device locks of all enabled VFs as well.

 - Patches 5-7 adapt PF drivers to the new core behavior. ionic and
   pds_core call pci_reset_function_locked() from their error resume
   handlers, so they now need to lock the VFs around it. i40e no longer
   needs to restore the VFs' MSI state in its .reset_done(), since the
   PCI core now restores the VFs' config state.

 - Patch 8 fixes (4). pci_parent_bus_reset() now ignores the PF's own
   VFs when it checks for other devices on the bus.

 - Patches 9-13 replace open-coded VF lookups with the new helpers.
   PCI/TSM and ixgbe use the VF iterators, and ice, liquidio and xe
   use pci_iov_get_virtfn(). These patches depend on patches 1-2 and
   are independent of the reset changes.

Link: https://lore.kernel.org/linux-pci/20261019083514.838640-1-lukasz.laguna@intel.com/ [v1]

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
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  26 ---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   3 -
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  25 +-
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   5 +-
 drivers/pci/iov.c                             |  88 ++++++-
 drivers/pci/pci.c                             | 217 +++++++++++++++---
 drivers/pci/tsm.c                             |  25 +-
 include/linux/pci.h                           |  63 +++++
 13 files changed, 357 insertions(+), 137 deletions(-)

-- 
2.43.0

