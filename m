Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489F3DAACF;
	Tue, 25 Aug 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692394; cv=none; b=foGInqFFin97173r57YJhhpqYFCCVASoEg9tbwd33UX/KILp7WM0P9NpXgijbhThvV8xet44lq9vFAmYLgIBZ+eytpGzrTUCo1+s+BUHZh1hZ7iSCOKi5bLctiEH6y+5T+odJWtTqV8r7dSJU9L10Ko8SzUU44sdG4PR5IREFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692394; c=relaxed/simple;
	bh=RUqv5+/gNyhj1F3HpadSYlyWATNCVZ9G+Xxxzxerkn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs5rBnCxmtH5Bqer//Jv1EUQdNoxbvnox+Dd7+OST7PzbrRZjKBcQc5mXzLqnPim75hwxOhU6590Nsm6nJ0wY/YHIj8+QRPvZi9uXjojr/HBX3nVRUNLC+gKNznbU+oEfxwKn5E+tvLHmWf1XmtTiJQ9jyA1xzNOKNLzGuCRy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yvquz5ZL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yvquz5ZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787692391; x=1819228391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RUqv5+/gNyhj1F3HpadSYlyWATNCVZ9G+Xxxzxerkn8=;
  b=Yvquz5ZLBtbkB5S7LYU7gqKcyBGMEQ2tDmVhNEIclNU9YR+sUd6JayfR
   /M/sUTfqJyQvOf1WB+TAxQQ1QBu+G6FDIJeZqCvgHKGu/HX7LewnS1+sF
   VOEgMxTs9+y0zFzexvk0qwSb6NyW4UFkaOhh/BXLpHh6m2HRRjo81Ru1o
   s8B2TManJmqEgyV5aDZ94YTkihVNI5tEiHPfOuLJxregJIOmeFhk6pblm
   WRcF/BjfBoWyDcU5nXPbzkHwcyGDNBYZcYbEd4NoXXQSQeIGabtZwgRc/
   vjask6pMmOwACWLaKi0cUfdTvyeMy8U9ygBJ1YHqO8YUjtK+diVsF16L4
   A==;
X-CSE-ConnectionGUID: //k/9p4eQ6SwbL07o4/frA==
X-CSE-MsgGUID: 3vY0gzO4SiCV6dVhcGJfxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88187125"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88187125"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 14:13:10 -0700
X-CSE-ConnectionGUID: +QMMoHsCQlmWeVQ8tAplag==
X-CSE-MsgGUID: 71+Ulur7T1mAMrsL6WompQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="267422966"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 14:13:09 -0700
Message-ID: <8eedb254-c942-4ee8-ab96-eb7c1ae577ad@intel.com>
Date: Tue, 25 Aug 2026 14:13:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Hi folks!
> 
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace can select "cxl_reset" in reset_method and then trigger reset
> through the existing reset attribute.

Srirangan,
Do we need to consider concurrent mailbox commands while reset is ongoing? Although rather than blocking them, maybe we just need to harden the mailbox path in CXL core so that when ~0s are read we return error and give up? and maybe a reset_prepare() to quiesce things. Just some random thoughts.

DJ

> 
> Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
> with the existing PCI reset_method interface.
> 
> v10 changes from v9 [2]:
> - Address review comments deferred from v9.
> - Split HDM decoder helper refactoring into smaller reviewable patches.
> - Rename the built-in CXL helper file to resource.c and keep reset-specific
>   logic separate from the decoder programming refactor.
> - Add a helper to resolve a CXL port's upstream PCI device.
> - Fix tools/testing/cxl Kbuild coverage for resource.o.
> - Keep early HDM decoder parsing shared with normal CXL HDM enumeration.
> - Gate CXL Reset execution on cached HDM state and current CXL.cache/CXL.mem
>   enablement.
> - Reject CXL Reset on multifunction devices to avoid reset scope ambiguity.
> - Order CXL cache disable/writeback before PCI reset quiesce and IOMMU reset
>   preparation.
> - Restore cached HDM state without replaying transient commit/error/lock
>   control bits.
> - Update ABI documentation to match the implemented reset ordering and CPU
>   cache invalidation behavior.
> 
> v9 changes from v8 [3]:
> - Rebase the series onto v7.2-rc2 so it applies cleanly on a Linus rc
>   tag.
> - Include the cxl_bus HDM restore add-on as patch 11/11 so b4 orders it
>   after the main CXL reset series.
> - Address only patch application issues in v9 to gather feedback on the
>   current direction. Other review comments, including Dave's code
>   structure/readability feedback, are deferred to v10.
> 
> v8 changes from v7 [4]:
> - Drop the PCI helper export patch.
> - Drop the multi-function sibling coordination patch. cxl_reset is only
>   exposed as a function-scoped reset method when the CXL reset scope is
>   limited to the target function.
> - Keep the reset-scope discovery needed to reject non-function-scoped
>   CXL resets.
> - Cache HDM location as BAR-relative metadata instead of keeping an
>   enum-time MMIO mapping.
> - Restore HDM through a temporary mapping based on the current BAR
>   assignment after PCI config state is restored.
> - Cache raw HDM decoder register state so uncommitted decoders can be
>   restored as uncommitted, while committed decoders are recommitted
>   through the normal HDM commit flow.
> - Share HDM decoder decode and validation between normal CXL core
>   enumeration and early PCI HDM caching.
> - Put cxl_reset ahead of FLR in reset_method priority because FLR does
>   not reset CXL.cache or CXL.mem protocol state.
> 
> Motivation:
> -----------
> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>   reset methods.
> 
> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>   the architectural reset mechanism for those protocols.
> 
> - The PCI reset_method ABI lets userspace select this narrower CXL reset
>   before falling back to broader bus reset methods.
> 
> Change Description:
> -------------------
> 
> Patch 1: cxl: Move HDM decoder programming helpers
> - Move low-level HDM decoder programming helpers into resource.c.
> - Keep the movement mechanical so later patches can change the interface
>   separately.
> 
> Patch 2: cxl: Pass decoder settings to HDM commit helpers
> - Introduce a decoder settings snapshot for HDM commit programming.
> - Route decoder commit through helpers that can be reused by reset restore.
> 
> Patch 3: cxl: Share HDM decoder decode logic
> - Add a small helper to resolve a CXL port's upstream PCI device.
> - Share HDM decoder decode and validation between normal CXL core
>   enumeration and early PCI HDM cache setup.
> 
> Patch 4: cxl: Cache decoder settings on PCI devices
> - Cache CXL core HDM decoder settings in pci_dev->hdm.
> - Refresh the cache as decoders are enumerated, committed, or reset.
> 
> Patch 5: cxl: Cache endpoint decoder settings during PCI enumeration
> - Snapshot endpoint HDM state during PCI enumeration.
> - Cache the HDM register locator as BAR-relative metadata.
> - Cache raw decoder register state in addition to committed decoder
>   settings.
> 
> Patch 6: cxl: Add CXL Device Reset helper
> - Add the internal DVSEC reset sequence.
> - Disable CXL.cache, perform cache writeback where supported, initiate
>   CXL Reset, and wait for completion.
> 
> Patch 7: cxl: Validate HDM ranges before CXL reset
> - Collect enabled cached HDM ranges.
> - Reject reset if affected ranges are busy.
> - Invalidate CPU caches when runtime cache-invalidation support is
>   available, otherwise continue after warning.
> 
> Patch 8: PCI/CXL: Reject CXL Reset on multifunction devices
> - Reject CXL Reset for multifunction devices to avoid reset scope ambiguity.
> 
> Patch 9: cxl: Restore CXL HDM state after PCI reset
> - Restore cached global and per-decoder HDM state after reset.
> - Re-map HDM registers from the current BAR assignment during restore.
> - Replay raw decoder state for uncommitted decoders and recommit
>   decoders that were committed before reset.
> 
> Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
> - Add "cxl_reset" to the PCI reset-method table for Type 2 reset-capable
>   CXL devices.
> - Prioritize cxl_reset ahead of FLR.
> 
> Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
> - Document the new reset_method value and reset behavior.
> 
> Patch 12: PCI/CXL: Restore HDM state after CXL bus reset
> - Restore cached CXL HDM decoder state after cxl_bus reset.
> 
> The CPU cache invalidation step depends on
> cpu_cache_invalidate_memregion() support for the affected address ranges.
> If no runtime provider is available, the kernel emits a warning and
> continues after the affected HDM ranges have been reserved.
> 
> Example:
> 
>     echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
>     echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset
> 
> Testing:
> - Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
>   CXL Type 2 device. All iterations completed successfully and
>   ResetComplete was observed.
> - Exercised cxl_bus reset separately with the HDM restore add-on patch.
> - Built drivers/cxl/core/resource.o and drivers/pci/pci.o during v10
>   preparation.
> 
> References:
> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [2] https://lore.kernel.org/linux-cxl/20260709010304.680422-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/
> [4] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/
> 
> Srirangan Madhavan (12):
>   cxl: Move HDM decoder programming helpers
>   cxl: Pass decoder settings to HDM commit helpers
>   cxl: Share HDM decoder decode logic
>   cxl: Cache decoder settings on PCI devices
>   cxl: Cache endpoint decoder settings during PCI enumeration
>   cxl: Add CXL Device Reset helper
>   cxl: Validate HDM ranges before CXL reset
>   PCI/CXL: Reject CXL Reset on multifunction devices
>   cxl: Restore CXL HDM state after PCI reset
>   PCI/CXL: Expose CXL Reset as a PCI reset method
>   Documentation/ABI: Document CXL Reset PCI reset method
>   PCI/CXL: Restore HDM state after CXL bus reset
> 
>  Documentation/ABI/testing/sysfs-bus-pci |   16 +
>  drivers/cxl/Kconfig                     |    4 +
>  drivers/cxl/core/Makefile               |    2 +-
>  drivers/cxl/core/core.h                 |    7 +
>  drivers/cxl/core/hdm.c                  |  351 +++---
>  drivers/cxl/core/port.c                 |   19 +
>  drivers/cxl/core/regs.c                 |    4 +
>  drivers/cxl/core/resource.c             | 1341 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |   41 -
>  drivers/pci/bus.c                       |    2 +
>  drivers/pci/pci.c                       |    8 +
>  drivers/pci/probe.c                     |    2 +
>  include/cxl/cxl.h                       |  116 +-
>  include/linux/pci.h                     |    8 +-
>  include/uapi/linux/pci_regs.h           |   14 +
>  tools/testing/cxl/Kbuild                |    2 +-
>  16 files changed, 1727 insertions(+), 210 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
> 
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda

