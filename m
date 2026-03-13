Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E5364946;
	Fri, 13 Mar 2026 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425962; cv=none; b=l+4Akc+iRlY7b71U7DXkcTvcrdxdzI3US9iMBMQMGtFhF6LD/bPDHnsUkzQz/XDZDILuVxQzzGZouatC8dvWFuIPoXpamyQEtWEtV6Uzz02H2JIhUxpaoQ1yUhTwaqxgSWqB2PhQP87GxHfZZnGnXieSiYocLYhfYs9nDzGq/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425962; c=relaxed/simple;
	bh=wGHHmea18QzDv20CIQ8/NkoCGCljzKpgR/2yblyc0Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9DFHzR5TZVWh1zJGLsvEuJ4e1V4nD2TR9ECbEXObLiMhmTxrl5jYXupN2M+LDHi33KQZ5bnHBwbUpgzNRF8l/ecpdtmJg8FGihn4ozrvsoLV/JnD7fCwc4W2cBUBFxIWyVh92Owiu5Lr6HboVQfMHoeGrfSQd3smPM3p6ciZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5pK6hhj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5pK6hhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773425960; x=1804961960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wGHHmea18QzDv20CIQ8/NkoCGCljzKpgR/2yblyc0Sk=;
  b=F5pK6hhjocPrUn74BVv8E0HdKeSxqJd+lLfIar4C9o8xJvaIph+2St+x
   xX36Rc4E141yyudPXfjAopNIs1hjfRYtMlLJnP5Rt/WWdtL9rpgw7VPwI
   jRuLN9ZB7e9Nj21Xfz2fJGFfJiqcjSxYjsbgTP71kg6h+hzFsZN/EDN2+
   VVuldfo539nWKub339SyWAuD6g3Liv2g2pemV12tHytIm/I0iVJXS9J8z
   jo+ZuWhleGOyiyr2bwlp314UVwFMkWK+Au/T+mtktlzh9M6BMzDBxm32I
   Ye38iFGflFxs/R4V+Wd4uJrQZ27beRXYimRMBsRqLF+GaK0y3Oq/wOnhp
   w==;
X-CSE-ConnectionGUID: TDsYYxbBQOGWR0aW5QS12g==
X-CSE-MsgGUID: JMFk49YyRr+g5Oxi2iKKHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74618906"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74618906"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:19:20 -0700
X-CSE-ConnectionGUID: IsUab5fAS8+RjETs0meTqA==
X-CSE-MsgGUID: tK2pfwEHS9KDtmikB151zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225347842"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 13 Mar 2026 11:19:15 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w176O-000000003h3-2O4L;
	Fri, 13 Mar 2026 18:19:12 +0000
Date: Fri, 13 Mar 2026 19:18:54 +0100
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, helgaas@kernel.org,
	florian.fainelli@broadcom.com, jim2101024@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v8 1/5] PCI: Add pcie_get_link_speed() helper for safe
 array access
Message-ID: <202603131934.SHJnSGL9-lkp@intel.com>
References: <20260312163652.113228-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312163652.113228-2-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 80234b5ab240f52fa45d201e899e207b9265ef91]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Add-pcie_get_link_speed-helper-for-safe-array-access/20260313-220734
base:   80234b5ab240f52fa45d201e899e207b9265ef91
patch link:    https://lore.kernel.org/r/20260312163652.113228-2-18255117159%40163.com
patch subject: [PATCH v8 1/5] PCI: Add pcie_get_link_speed() helper for safe array access
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260313/202603131934.SHJnSGL9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260313/202603131934.SHJnSGL9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603131934.SHJnSGL9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/probe.c:793 expecting prototype for pcie_link_speed_value(). Prototype was for pcie_get_link_speed() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
