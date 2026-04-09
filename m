Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548F2C158E;
	Thu,  9 Apr 2026 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713801; cv=none; b=MTMWsSG2DnIL1jaXGPxd8Ivc/bHhaPmWwD1m8Oo3pWA1lfmFy2tMFNFbme7rCgojTpdQUDdqCRtrouRN+8phVUuwQnlxD4UVs+fCl4jqdFhYyvEwPGlxhHssPoAp19Ev0yvx16LoTkrn9l+y3vMwj/kCzmu7alIHksNYrM52wgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713801; c=relaxed/simple;
	bh=gmK9fO57H8CzjbT04SrW/vYQmhsYcl3MVSHTnzmSIfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orDeCXnF+Tn+He70x8AOyisHRBJwziub418mOO1XPEhM6AH0gNQByMghfsXzyYM7QtyBee8J95r5MN7xoXDhtv5U3FAoxX33o0A3vMpAD+JNex/nY71y2qCLD9aesKCVDwYnoqTDfR03GzFxR0nQkw1IxKcbUg/ysGpidlfkP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPuFZBRX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPuFZBRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775713800; x=1807249800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gmK9fO57H8CzjbT04SrW/vYQmhsYcl3MVSHTnzmSIfA=;
  b=fPuFZBRXyzovUgLdBDX4cua+lrKq18ZWWu048zEI9TZerLZmIN35YQVl
   DGmeq5+RCcODk6xClfAliT/aY6ECliuFClNA17FYB7ixqMw07hjCM3myf
   rP4Qvz9i4KsH7hqC6lKtUNF9n9X0QAsLxv957j1uj+GO7NtFxKvRAz5Di
   M9sPWMAzjCSOwucxOE5IaBzRRP8aRX1SHfsMMfChNqrUmOsXLzar+D57h
   eNna1H7KJU0lcFXGLy8ACWM6RdNFb6fy7KBttqehOENkMNSkkf+JPqI6D
   FMCcRvIk6qZIEyMsLS6ETGTN81fsS5cGwBvhMgJTpJZmRpxRomz9DxOup
   w==;
X-CSE-ConnectionGUID: oFECVLDYQ/WIq6KIlcKxRg==
X-CSE-MsgGUID: kNnAFB/kQoOXn9WLLTFjXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="102162029"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="102162029"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 22:49:59 -0700
X-CSE-ConnectionGUID: LoOk7JWzSsKmetrhoBD2Lg==
X-CSE-MsgGUID: U++zH3i5QNytl0T6XmJt7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227815788"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 22:49:55 -0700
Message-ID: <14230b61-d589-4f82-8dc5-aeecddadca65@linux.intel.com>
Date: Thu, 9 Apr 2026 13:48:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org,
 oe-kbuild-all@lists.linux.dev, chao.gao@intel.com, dave.jiang@intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-20-yilun.xu@linux.intel.com>
 <202603290006.za7iiDgF-lkp@intel.com>
 <4be868dc-d6e1-4488-8f28-34ef1d3659ac@linux.intel.com>
 <adZFCF01fxt4gBh8@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <adZFCF01fxt4gBh8@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/26 20:07, Xu Yilun wrote:
> On Tue, Mar 31, 2026 at 03:20:44PM +0800, Baolu Lu wrote:
>> On 3/29/26 00:57, kernel test robot wrote:
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]
>>>
>>> url:https://github.com/intel-lab-lkp/linux/commits/Xu-Yilun/x86-tdx-Move-
>>> all-TDX-error-defines-into-asm-shared-tdx_errno-h/20260328-151524
>>> base:   11439c4635edd669ae435eec308f4ab8a0804808
>>> patch link:https://lore.kernel.org/r/20260327160132.2946114-20-
>>> yilun.xu%40linux.intel.com
>>> patch subject: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for the TDX module
>>> config: i386-randconfig-141-20260328
>>> (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF-
>>> lkp@intel.com/config)
>>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>>> smatch: v0.5.0-9004-gb810ac53
>>> reproduce (this is a W=1 build):
>>> (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF-
>>> lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot<lkp@intel.com>
>>> | Closes:https://lore.kernel.org/oe-kbuild-all/202603290006.za7iiDgF-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: iommu_max_domain_id+0x55 (section: .text.iommu_max_domain_id) -> acpi_table_parse_keyp (section: .init.text)
>>
>>
>> acpi_table_parse_keyp() is marked as __init. But this patch causes the
>> intel iommu driver to call it from a runtime function.
>>
>> int __init_or_acpilib
>> acpi_table_parse_keyp(enum acpi_keyp_type id,
>>                        acpi_tbl_entry_handler_arg handler_arg, void *arg)
>> {
>>          return __acpi_table_parse_entries(ACPI_SIG_KEYP,
>>                                            sizeof(struct acpi_table_keyp),
>> id,
>>                                            NULL, handler_arg, arg, 0);
>> }
> 
> Is it better we configure ACPI table as library, so that drivers could
> use it freely at runtime? tdx-host also uses this function.
> 
> --------8<--------
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 5471f814e073..55188d6d38bb 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   # Intel IOMMU support
>   config DMAR_TABLE
> +       select ACPI_TABLE_LIB
>          bool
> 
>   config DMAR_PERF
> 

This looks better.

Thanks,
baolu
