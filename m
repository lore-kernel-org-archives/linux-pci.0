Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8732D5922;
	Tue,  7 Jul 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464332; cv=none; b=o5lXHATO0mojq3UXYL39215WEJPx9iL3kRB0uDITGYoX2gnwBeSGO+qcqu6W6BCwraqy8kp3MUgm7b/K5Fac2dwlLJp4WUoMZKLBmAw0gefbLzcLTKaovGDnWADEdtEt8YUNBjbR6RXbyu8g3lIuOAi9hl87qr0vfjYSPLkdxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464332; c=relaxed/simple;
	bh=sZwiz2eVxWztoQMefmjyUqkkIzuJA+iJonL7ZG5O7QQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GDI/OcoYiw9CaZ5qNDZIm60j3TPjQ8rARdEzV/4wrVNi8bi511JTWiysDJtoxtgIOWX7g04QoEcPOAP//TFWyxQNB08jUVMPkglMFuNqp5LNUCNBF0/PaVsHIByIR6UBw8T96JPRfVKOLJcbEOcaISGM5KLi2X2Wtvav8DZ+saM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdysflH3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdysflH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783464331; x=1815000331;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sZwiz2eVxWztoQMefmjyUqkkIzuJA+iJonL7ZG5O7QQ=;
  b=RdysflH3M61WPZ1KvjkdcNyfCJQEP2IKhQ1u13nTrSBTRWjuvpwXqGmp
   QYhgMCPz42EounIGUujnCxtTrF1x4BDdqT4ep0oym0hTjyQ/VYlkwqI88
   RvN4+6STujLZe+4JHI00VfFYpDsu5tdNJlVeFC5iSxOOEJBhoR8lWiLbq
   bnZ2Y3wsG5kZ5DhGVTlL6Occe0r1gqyy8pt7D275ay1SBDU5lBVGL9Tk/
   BrquhZssdX2nf+XJ/tmeLkXelDkxqoYxKsT1X8lKiOtK26P+72JnJZ8jI
   S7VcQ+QmryUnnHiNWQgyy/iuaXZdrXiyOR2d84XsC0zucRtouz2RCEN6u
   g==;
X-CSE-ConnectionGUID: UZrhHM/SRd+w7dTvjwMagg==
X-CSE-MsgGUID: FDcvyyKWTqmysV72LBd0KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95500896"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95500896"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 15:45:30 -0700
X-CSE-ConnectionGUID: BEWoIcs7TTKJKrlCS7VTSw==
X-CSE-MsgGUID: MMMoGoZWRoaVtzxxCE0oQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254767503"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 15:45:27 -0700
Message-ID: <103e562b-1685-412f-adaa-679409818d7f@intel.com>
Date: Tue, 7 Jul 2026 15:45:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] PCI/CXL: Add CXL reset support for Type 2
 devices
From: Dave Jiang <dave.jiang@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <fb9a53ea-2743-4e4c-b3b3-faa81dfac156@intel.com>
Content-Language: en-US
In-Reply-To: <fb9a53ea-2743-4e4c-b3b3-faa81dfac156@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/6/26 4:13 PM, Dave Jiang wrote:
> 
> 
> On 7/3/26 3:04 PM, Srirangan Madhavan wrote:
>> Hi folks!
>>
>> This series adds CXL Reset support for CXL Type 2 devices through the
>> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
>> specification [1], including CXL.cache disable, optional cache
>> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
>> reporting.
>>
>> The userspace ABI is the existing PCI reset interface:
>>
>>     /sys/bus/pci/devices/.../reset_method
>>     /sys/bus/pci/devices/.../reset
>>
>> Userspace can select "cxl_reset" in reset_method and then trigger reset
>> through the existing reset attribute.
>>
>> Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
>> with the existing PCI reset_method interface.
>>
>> v8 changes from v7 [2]:
>> - Drop the PCI helper export patch.
>> - Drop the multi-function sibling coordination patch. cxl_reset is only
>>   exposed as a function-scoped reset method when the CXL reset scope is
>>   limited to the target function.
>> - Keep the reset-scope discovery needed to reject non-function-scoped
>>   CXL resets.
>> - Cache HDM location as BAR-relative metadata instead of keeping an
>>   enum-time MMIO mapping.
>> - Restore HDM through a temporary mapping based on the current BAR
>>   assignment after PCI config state is restored.
>> - Cache raw HDM decoder register state so uncommitted decoders can be
>>   restored as uncommitted, while committed decoders are recommitted
>>   through the normal HDM commit flow.
>> - Share HDM decoder decode and validation between normal CXL core
>>   enumeration and early PCI HDM caching.
>> - Put cxl_reset ahead of FLR in reset_method priority because FLR does
>>   not reset CXL.cache or CXL.mem protocol state.
>>
>> Motivation:
>> -----------
>> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>>   reset methods.
>>
>> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>>   the architectural reset mechanism for those protocols.
>>
>> - The PCI reset_method ABI lets userspace select this narrower CXL reset
>>   before falling back to broader bus reset methods.
>>
>> Change Description:
>> -------------------
>>
>> Patch 1: cxl/hdm: Split decoder programming into a reusable helper
>> - Move shared decoder settings to include/cxl/cxl.h.
>> - Factor low-level HDM register programming into cxl_commit().
>>
>> Patch 2: cxl/hdm: Cache decoder settings on PCI devices
>> - Cache CXL core HDM decoder settings in pci_dev->hdm.
>> - Refresh the cache as decoders are enumerated, committed, or reset.
>>
>> Patch 3: cxl/hdm: Share HDM decoder decode logic
>> - Share HDM decoder decode and validation between normal CXL core
>>   enumeration and early PCI HDM cache setup.
>>
>> Patch 4: cxl/hdm: Cache endpoint decoder settings during PCI enumeration
>> - Snapshot endpoint HDM state during PCI capability initialization.
>> - Cache the HDM register locator as BAR-relative metadata.
>> - Cache raw decoder register state in addition to committed decoder
>>   settings.
>>
>> Patch 5: PCI/CXL: Add CXL Device Reset helper
>> - Add the internal DVSEC reset sequence.
>> - Disable CXL.cache, perform cache writeback where supported, initiate
>>   CXL Reset, and wait for completion.
>>
>> Patch 6: PCI/CXL: Validate HDM ranges before CXL reset
>> - Collect enabled cached HDM ranges.
>> - Reject reset if affected ranges are busy.
>> - Invalidate CPU caches when runtime cache-invalidation support is
>>   available, otherwise continue after warning.
>>
>> Patch 7: PCI/CXL: Discover the CXL reset scope
>> - Discover whether CXL Reset is function-scoped using the Non-CXL
>>   Function Map and CXL cache/mem capability bits.
>>
>> Patch 8: cxl/pci: Restore CXL HDM state after PCI reset
>> - Restore cached global and per-decoder HDM state after reset.
>> - Re-map HDM registers from the current BAR assignment during restore.
>> - Replay raw decoder state for uncommitted decoders and recommit
>>   decoders that were committed before reset.
>>
>> Patch 9: PCI/CXL: Expose CXL Reset as a PCI reset method
>> - Add "cxl_reset" to the PCI reset_method table for Type 2 reset-capable
>>   CXL devices.
>> - Prioritize cxl_reset ahead of FLR.
>>
>> Patch 10: Documentation/ABI: Document CXL Reset PCI reset method
>> - Document the new reset_method value and reset behavior.
>>
>> The CPU cache invalidation step depends on
>> cpu_cache_invalidate_memregion() support for the affected address ranges.
>> If no runtime provider is available, the kernel emits a warning and
>> continues after the affected HDM ranges have been reserved.
>>
>> Example:
>>
>>     echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
>>     echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset
>>
>> Testing:
>> - Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
>>   CXL Type 2 device. All iterations completed successfully and
>>   ResetComplete was observed.
>> - Exercised cxl_bus reset separately with an add-on HDM restore patch.
>>
>> References:
>> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
>> [2] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/
>> [3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/
>>
>> Srirangan Madhavan (10):
>>   cxl/hdm: Split decoder programming into a reusable helper
>>   cxl/hdm: Cache decoder settings on PCI devices
>>   cxl/hdm: Share HDM decoder decode logic
>>   cxl/hdm: Cache endpoint decoder settings during PCI enumeration
>>   PCI/CXL: Add CXL Device Reset helper
>>   PCI/CXL: Validate HDM ranges before CXL reset
>>   PCI/CXL: Discover the CXL reset scope
>>   cxl/pci: Restore CXL HDM state after PCI reset
>>   PCI/CXL: Expose CXL Reset as a PCI reset method
>>   Documentation/ABI: Document CXL Reset PCI reset method
>>
>>  Documentation/ABI/testing/sysfs-bus-pci |   14 +
>>  drivers/cxl/Kconfig                     |    4 +
>>  drivers/cxl/core/Makefile               |    2 +-
>>  drivers/cxl/core/hdm.c                  |  257 ++---
>>  drivers/cxl/core/region.c               |    6 +-
>>  drivers/cxl/core/regs.c                 |    4 +
>>  drivers/cxl/core/reset.c                | 1354 +++++++++++++++++++++++
>>  drivers/cxl/cxl.h                       |   43 -
>>  drivers/pci/pci.c                       |    2 +
>>  drivers/pci/probe.c                     |    3 +
>>  include/cxl/cxl.h                       |  102 +-
>>  include/linux/pci.h                     |    8 +-
>>  include/uapi/linux/pci_regs.h           |   15 +
>>  tools/testing/cxl/test/cxl.c            |   10 +-
>>  14 files changed, 1615 insertions(+), 209 deletions(-)
>>  create mode 100644 drivers/cxl/core/reset.c
>>
>> base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658
> 
> 
> Hi Srirangan,
> I am not able to apply the patch series using b4 with the above base commit.
> b4 picks up the last RFC patch as the first patch and fails to apply. However, skipping it b4 is still having trouble. Can you push a public git branch somewhere please? Also in the future the last RFC patch should be labeled 11/11. Thanks!
> 

BTW, can this be applied cleanly against a Linus rc tag? If so please do that next rev. I understand you need the type2 stuff for testing. But preferably when posting, post it against a Linus tag if there are no symbol dependencies. I'd really like sashiko run a review through it and currently it is not able to. Thank you.

