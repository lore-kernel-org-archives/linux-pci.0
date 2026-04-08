Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F83612F6;
	Wed,  8 Apr 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651356; cv=none; b=GyCUQ/S9qS2AqhFWm5QIdCKNZ2VsnCjKJnrAEY6WA+1JPjauii4b7nI/KI9qBkFHnNmxONu8qoJOVpOUqmxMCrr+wWnzFgiHZPJyHL8McJWmxYKHUUFpQgyc3z4zeK0DfR3zZ+SyeADs5Df0jBWGUedcMezlThliBJ8cbICWqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651356; c=relaxed/simple;
	bh=RyPjlBk2oXw22XJ3XZElJPOkp9RBF5BLOF29crTwsoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpmMKgJIWbOO5Y3dEapRSaJwvnyawIrSH8Dqb1D6f/fbSM+c+pdc8WVq6msntA0mK0RzjCcjHjiTbhBlelCaeoppe+mMs22pc/zF3DeNodeR9HTclRclkNzlyAjMzz4ybzgNUXpPyenfh4OjPuQqLBPlKyYTPhYy64ODwx9cfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIdM0v1R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIdM0v1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775651354; x=1807187354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RyPjlBk2oXw22XJ3XZElJPOkp9RBF5BLOF29crTwsoQ=;
  b=cIdM0v1ROO//RlDUJbhh9Y2RjYsqT2cZHiuvHj5lc/FXVVm8SuhiSKbw
   6Mq+MIGBy57W9jBwsgPa7TfUDiMUiWVsJiY8aeaAGc7wBATmPWiyrOjgN
   gojgLxt/R9WsuzmAtd+gP4jRzvy8MLbgG/pdvW0qqTQ3XPyIHHK0fi+SP
   y6GQ/hfHdGPPZSoVEcTeRYR9pW3OjvZa1yFBopIkE2p3O6EqPJ+dLGkMI
   t6yaED+cEG0DDZmYZMLK6D5bQTBw4y4MCsUi8cMxpmzY9/RIjIta2U0Sx
   y/rLMXKq+7HtDuSUoS3beesti/yZMEGd1EQe6UkSNnZuHQswAmHZHOXh6
   w==;
X-CSE-ConnectionGUID: DYJAOOUdRe6tvhcrhg+Npg==
X-CSE-MsgGUID: eAQmXBU0SWGLu0kgSD18Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102084311"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102084311"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:29:13 -0700
X-CSE-ConnectionGUID: wpPR+5qCTKCfpiZxazO9Gw==
X-CSE-MsgGUID: egdSHuSsRXKyCaVnDn4z8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232821144"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 08 Apr 2026 05:29:09 -0700
Date: Wed, 8 Apr 2026 20:07:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org,
	oe-kbuild-all@lists.linux.dev, chao.gao@intel.com,
	dave.jiang@intel.com, yilun.xu@intel.com, zhenzhong.duan@intel.com,
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com, kas@kernel.org, xiaoyao.li@intel.com,
	vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Message-ID: <adZFCF01fxt4gBh8@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-20-yilun.xu@linux.intel.com>
 <202603290006.za7iiDgF-lkp@intel.com>
 <4be868dc-d6e1-4488-8f28-34ef1d3659ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be868dc-d6e1-4488-8f28-34ef1d3659ac@linux.intel.com>

On Tue, Mar 31, 2026 at 03:20:44PM +0800, Baolu Lu wrote:
> On 3/29/26 00:57, kernel test robot wrote:
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]
> > 
> > url:https://github.com/intel-lab-lkp/linux/commits/Xu-Yilun/x86-tdx-Move-
> > all-TDX-error-defines-into-asm-shared-tdx_errno-h/20260328-151524
> > base:   11439c4635edd669ae435eec308f4ab8a0804808
> > patch link:https://lore.kernel.org/r/20260327160132.2946114-20-
> > yilun.xu%40linux.intel.com
> > patch subject: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for the TDX module
> > config: i386-randconfig-141-20260328
> > (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF-
> > lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > smatch: v0.5.0-9004-gb810ac53
> > reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF-
> > lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot<lkp@intel.com>
> > | Closes:https://lore.kernel.org/oe-kbuild-all/202603290006.za7iiDgF-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > > > WARNING: modpost: vmlinux: section mismatch in reference: iommu_max_domain_id+0x55 (section: .text.iommu_max_domain_id) -> acpi_table_parse_keyp (section: .init.text)
> 
> 
> acpi_table_parse_keyp() is marked as __init. But this patch causes the
> intel iommu driver to call it from a runtime function.
> 
> int __init_or_acpilib
> acpi_table_parse_keyp(enum acpi_keyp_type id,
>                       acpi_tbl_entry_handler_arg handler_arg, void *arg)
> {
>         return __acpi_table_parse_entries(ACPI_SIG_KEYP,
>                                           sizeof(struct acpi_table_keyp),
> id,
>                                           NULL, handler_arg, arg, 0);
> }

Is it better we configure ACPI table as library, so that drivers could
use it freely at runtime? tdx-host also uses this function.

--------8<--------

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5471f814e073..55188d6d38bb 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Intel IOMMU support
 config DMAR_TABLE
+       select ACPI_TABLE_LIB
        bool

 config DMAR_PERF
