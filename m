Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A733A70F;
	Sat, 28 Mar 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774727939; cv=none; b=nNEhZ3UEjUXFiGH0WNmOSNM3RBieg7Y8+7xCeit5nFtC0VFbjsNuAbdpkkO7N0tG95Gzed+8VOpsxkPXU+Ra3aMFuiTSfpmtdoMaWxEXx5j5mfSBmlLd+3TAttFExLLBLAfuyOypeGZvaOTcPxGPVUWEXymSILawtRYGuhoDCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774727939; c=relaxed/simple;
	bh=cy9GXw5t/wXh0caSG/6pf6d4N6q2KotxV8ZwIQvq7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL47iDO12HoEj9DFkwuYJnUJafk6ounna3l5kkNbGeu8PHno3xKqZalsGUZiUPGRTheLF9fqacemsfAek9toJzzpFqK10aGFxzZ0V1RuDegiDJFP25c6Wc2g/ga3EBohQzKn1qTw4Yx8DDURNoeqnErvqmN3s1yPVCchZNf1Goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uj4tr5e+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uj4tr5e+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774727937; x=1806263937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cy9GXw5t/wXh0caSG/6pf6d4N6q2KotxV8ZwIQvq7ac=;
  b=Uj4tr5e+6XUQVC5IGbGg+AGMQJ0xKmaW2jQpiaMWFldYAQO+9PP0XOHO
   f9W8+OhlUWhu8cA9a+Xh6cZoZuAPpsdEEdCFN+JyKAJzGkxAzr+O/bOIV
   8vYvVg+nplS87pWebDrKkx3CjEo2Zx4cjGxZzKDlvnco8NyNkZ787UoNh
   4hHoVh9iRLp+75NRWa9di3/LA0Fxft6yVRazyXXW6dDGE5H5UVd/BwR8Z
   0MP+98GpEBEjTL7uEZhIY6HVENKxRhUwV+q8MLkDTGJ3PanaPk1PvIq0I
   JusKkwQRmbUWmZrTTNpIK1I/AXxpAg1WYUF9HYf6v71k62nYfk6OmgTOC
   w==;
X-CSE-ConnectionGUID: ERB0ybCtTBC7RJ988MwbLg==
X-CSE-MsgGUID: gKUwAl0mTDya07awSe+oMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="87158408"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="87158408"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 12:58:57 -0700
X-CSE-ConnectionGUID: d45D8WvkQKSEh8Z+cmPkvw==
X-CSE-MsgGUID: WC6z1TObQiWYd85xGEhUxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="227246231"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Mar 2026 12:58:53 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Zo3-00000000BjB-0aGI;
	Sat, 28 Mar 2026 19:58:51 +0000
Date: Sun, 29 Mar 2026 03:58:16 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chao.gao@intel.com, dave.jiang@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@linux.intel.com,
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Message-ID: <202603290317.BVIn0aoy-lkp@intel.com>
References: <20260327160132.2946114-20-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327160132.2946114-20-yilun.xu@linux.intel.com>

Hi Xu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Yilun/x86-tdx-Move-all-TDX-error-defines-into-asm-shared-tdx_errno-h/20260328-151524
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260327160132.2946114-20-yilun.xu%40linux.intel.com
patch subject: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for the TDX module
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20260329/202603290317.BVIn0aoy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290317.BVIn0aoy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603290317.BVIn0aoy-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: alloc_iommu.cold+0x49 (section: .text.unlikely) -> acpi_table_parse_keyp (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
