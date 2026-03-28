Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D3260592;
	Sat, 28 Mar 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774717071; cv=none; b=MfyPKXTYaJKOyPUUEO6D5WbBS0E0t4v0vZBSm11+bzWtyg/sE++BhoJy7/Y0ixX0f77GO4Mk8yWGqbkwtLt8yhdRHTfCqlwd5Lc5qHaajcuYVV5yVluIQUJyRtn9Zam9cG05QhALsMsS02cWhiqt0iQv4VN5dB9YZlLgZvSWBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774717071; c=relaxed/simple;
	bh=y/qxSyVeI3PObxX+49CAWDn0IKCh/fhFCy1cSY5dJSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnzzbP/6oQPZMcPuIWsalVwyBc9xtqLAIJ+m6botCju/CWlFxZ2WsU7EYcrxvBQyNa8XQ6Y4t/vudyjl9OoK7p5TdtX68oEVNXPZqqKJvzghpC4DbOnqRlj9TMRgbYEkwM9WolF31GHIdTPvPrcaceX5mnCyHYsee5MUL66UKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co6t69Sk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co6t69Sk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774717069; x=1806253069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y/qxSyVeI3PObxX+49CAWDn0IKCh/fhFCy1cSY5dJSo=;
  b=Co6t69SkVuDrZt3FjGWGGWzwIHAJ34O4Mc8MacHYyMZ9OVunryTNHxNP
   btnu2kqfRgYv/KDlcRuDeoKEyJ4feTAoLwn2jmdtOAvHPQvWffUZgpxyt
   acg47OPDYtfIPZOZ8pRlyP9rYff2QZSu4tGBjMVdoNvWUwRtmi29F9Ort
   unewwHD0sVeIsbXIH7TdS4KPUhMsHk/LPTCmoiOwEI9F00juy17jcCcFP
   fNkNZn36wkJQzvYn1zYdjAg5a11O+BpDEHtkBW6bAgfpqVo3JsjUz8/4m
   sctCLye90K5wB1dsxs3S01X4RHXkApwEMsXDI2Z/UKQqmQp8KrAM84kpn
   A==;
X-CSE-ConnectionGUID: TykyYVGgSDuRqReisKS19Q==
X-CSE-MsgGUID: 8ZesbqxyRpOj5JTBe4+AQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75829241"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="75829241"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 09:57:48 -0700
X-CSE-ConnectionGUID: JkixPn/tT2WqHybIc5qRGA==
X-CSE-MsgGUID: bsYNMB26TkGx4Koyv2usaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="225499237"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Mar 2026 09:57:43 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Wyi-00000000BbF-2MxD;
	Sat, 28 Mar 2026 16:57:40 +0000
Date: Sun, 29 Mar 2026 00:57:23 +0800
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
Message-ID: <202603290006.za7iiDgF-lkp@intel.com>
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
config: i386-randconfig-141-20260328 (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290006.za7iiDgF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603290006.za7iiDgF-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: iommu_max_domain_id+0x55 (section: .text.iommu_max_domain_id) -> acpi_table_parse_keyp (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
