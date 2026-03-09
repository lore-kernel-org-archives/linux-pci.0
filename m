Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA0389459;
	Mon,  9 Mar 2026 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095881; cv=none; b=IcjeRbLpngWsKCaUv72l4/dw0v7R6jihHiNv5TU2GKkkvQdxBMJoSPnljP51bcvMMCNuiXFwOtCTdQ3bGNXj3babNPdATWazBolHRPxjHvvKyTt2GZ3v+QRivxOihcv6aK1xUjpO4VNJzuN9kDOEq6beboGPw5y/kaEqDvPCWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095881; c=relaxed/simple;
	bh=6Yjhqb9ueGzFlGJSHSCUdfpOmaiiWp/pVSSdW0bOohs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1sXkD92TJmkTMUD3RkCW68Qg72AmoBT0hlsbYd9cn4EXKdaVUt6wCqfTMrNZDjk66rezGP3zOCMCr5d8fWC9E+TmQUzwGgZ5x/UQahOj+xtFXEIJ6gsABP2vLD28d1oGOXKkVjPQGoIN5Kz2cnt3Wvgw6o+qnYY4RBf4varFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiTIHdWD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiTIHdWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773095879; x=1804631879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Yjhqb9ueGzFlGJSHSCUdfpOmaiiWp/pVSSdW0bOohs=;
  b=AiTIHdWDgcjEu3L7I+jhKBeNC3xuNp4Lp0UjeniNh/h1LqHChlx1ObgS
   tqYrEOZBUpUTlLVq7Djh2WG7foehFW/qPytI49S+3Pxcp5bkEDS+YfZfr
   wRErsqbzgT9k1FL9x9laEF/fZl7so+Vzud+yUhjfRBKEUnxCQQaPe+5xG
   UnMCErh/PCdOvWyTkMuPw+Yfo2GJsjLlICUcjFOpC/WpnbryDoD6/nyn+
   tMh0ZrTjs0io4yjNa1M2KKn7009l6OAs+6tF2NJ7aAaAubRhcH3CBjMen
   D1kMtTIRV5q/jv+ADS/Pfr7VF5j9xRMKKKvN8Pv2BRzUrK+s5wo4icCj6
   A==;
X-CSE-ConnectionGUID: aq5iU7q2T2ODd24rHn45kQ==
X-CSE-MsgGUID: 4IshWDIGRKixONAmITFNZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73332541"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="73332541"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:37:58 -0700
X-CSE-ConnectionGUID: vxNZlvNcSdSCqrzh44GR6g==
X-CSE-MsgGUID: f3l4l4g+TO2mZn4MTJcHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224597292"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:37:56 -0700
Message-ID: <0a9380fe-33b9-4527-a9d7-edc94786ce56@intel.com>
Date: Mon, 9 Mar 2026 15:37:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] CXL: Add cxl_reset sysfs attribute for PCI devices
To: smadhavan@nvidia.com, bhelgaas@google.com, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net
Cc: alwilliamson@nvidia.com, jeshuas@nvidia.com, vsethi@nvidia.com,
 skancherla@nvidia.com, vaslot@nvidia.com, sdonthineni@nvidia.com,
 mhonap@nvidia.com, vidyas@nvidia.com, jan@nvidia.com, mochs@nvidia.com,
 dschumacher@nvidia.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306092322.148765-1-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/26 2:23 AM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Hi folks!
> 
> This patch series introduces support for the CXL Reset method for CXL
> Type 2 devices, implementing the reset procedure outlined in CXL Spec [1]
> v3.2, Sections 8.1.3, 9.6 and 9.7.
> 
> v5 changes (from v4):
> - Rebased on v7.0-rc1 and applied fixes from the review v4.
> - Added CXL DVSEC and HDM save/restore as a prerequisite series [2]
> - Switched from PCI reset method to sysfs
>   interface at /sys/bus/pci/devices/.../cxl_reset (Dan, Alex)
> - Removed all PCI core changes - reset logic stays in CXL driver
> - Use cpu_cache_invalidate_memregion() instead of arch-specific code
> - Removed CONFIG_X86/CONFIG_ARM64 ifdefs
> - Added ABI documentation for sysfs interface
> 
> v4 changes:
> - Fix CXL reset capability check parentheses warning
> - Gate CXL reset path on CONFIG_CXL_PCI reachability
> 
> v3 changes:
> - Restrict CXL reset to Type 2 devices only
> - Add host and device cache flushing for sibling functions and region peers
> - Add region teardown and memory online detection before reset
> - Add configuration state save/restore (DVSEC, HDM, IDE)
> - Split the series by subsystem and functional blocks
> 
> Motivation:
> -----------
> - As support for Type 2 devices [6] is being introduced, more devices will
>   require finer-grained reset mechanisms beyond bus-wide reset methods.
> 
> - FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
>   the preferred method in some cases.
> 
> - The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
>   cases like function rebinding and error recovery, where CXL Reset is
>   explicitly mentioned.
> 
> ABI Change reasoning (v5):
> -------------------------
> Previous versions (v1-v4) integrated CXL reset as a new PCI reset method
> in pci_reset_methods[]. Based on feedback from Dan Williams and Alex
> Williamson, v5 switches to a sysfs-based approach.
> 
> The key reasoning is that CXL Reset has expanded scope than existing PCI
> reset methods. Mixing these in the same reset infrastructure causes
> problems. Therefore selectively exposing a cxl_reset method in pci-sysfs
> and leaving the existing interface unaffected.
> 
> Change Description:
> -------------------
> 
> Patch 1: PCI: Add CXL DVSEC reset and capability register definitions
> - Add reset and cache control bit definitions to pci_regs.h
> 
> Patch 2: PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
> - Export for sibling function save/restore during CXL reset
> 
> Patch 3: cxl: Add memory offlining and cache flush helpers
> - Offline CXL memory regions before reset
> - Flush CPU caches using cpu_cache_invalidate_memregion()
> 
> Patch 4: cxl: Add multi-function sibling coordination for CXL reset
> - Identify CXL.cachemem sibling functions via Non-CXL Function Map DVSEC
> - Save/disable and restore sibling PCI functions around reset
> 
> Patch 5: cxl: Add CXL DVSEC reset sequence and flow orchestration
> - Implement cxl_dev_reset() to trigger reset via DVSEC
> - Poll for reset completion with timeout
> - cxl_do_reset() orchestrates the complete reset sequence with
>   proper locking and error handling
> 
> Patch 6: cxl: Add cxl_reset sysfs interface for PCI devices
> - Expose /sys/bus/pci/devices/.../cxl_reset
> - Only visible for devices with Reset Capable bit set
> - Write "1" to trigger reset
> 
> Patch 7: Documentation: ABI: Add CXL PCI cxl_reset sysfs attribute
> - Document the new sysfs interface
> - Explain scope, visibility, and error conditions
> 
> Dependencies:
> -------------
> 
> This series depends on:
>   [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state across resets
>   https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/T/#t
> 
> The cpu_cache_invalidate_memregion() call used for CPU cache flush currently
> has support on x86. ARM64 support will be addressed in a separate RFC.
> 
> Command line to test the CXL reset on a capable device:
>     echo 1 > /sys/bus/pci/devices/<pci_device>/cxl_reset
> 
> Basic cxl_reset testing was done on a CXL Type-2 device: writing to the
> sysfs attribute, exercising the DVSEC reset sequence including WB+I and
> init reset, restore. Further testing is in progress.
> 
> This series is based on v7.0-rc1.
> 
> Srirangan Madhavan (7):
>   PCI: Add CXL DVSEC reset and capability register definitions
>   PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
>   cxl: Add memory offlining and cache flush helpers
>   cxl: Add multi-function sibling coordination for CXL reset
>   cxl: Add CXL DVSEC reset sequence and flow orchestration
>   cxl: Add cxl_reset sysfs interface for PCI devices
>   Documentation: ABI: Add CXL PCI cxl_reset sysfs attribute
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  22 +
>  drivers/cxl/core/core.h                 |   2 +
>  drivers/cxl/core/pci.c                  | 537 ++++++++++++++++++++++++
>  drivers/cxl/core/port.c                 |   3 +
>  drivers/pci/pci.c                       |  21 +-
>  include/linux/pci.h                     |   3 +
>  include/uapi/linux/pci_regs.h           |  14 +
>  7 files changed, 600 insertions(+), 2 deletions(-)
> 
> base-commit: 6de23f81a5e0

The commit is 7.0-rc1. But b4 shazam seems to fail when attempting to apply.

Applying: PCI: Add CXL DVSEC reset and capability register definitions
Patch failed at 0001 PCI: Add CXL DVSEC reset and capability register definitions
error: patch failed: include/uapi/linux/pci_regs.h:1349
error: include/uapi/linux/pci_regs.h: patch does not apply


> --
> 2.43.0
> 

