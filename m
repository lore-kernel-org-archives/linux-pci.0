Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A23D8119;
	Fri, 13 Mar 2026 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443974; cv=none; b=OaXHfsjGScA8UVHuVTatwRSem2scJLfh9413ZwSQfacBX7DsAE6q/48LMbVFV9wB7l3Afm1bnQzhiLAbHToe4qCY7YAgtY+9gCNm8vjEenAsf51Pd7Q26iFMzGLYU2CFlARbOHQ7AaVmqMEl7IvvX8spvlzex6nNHndl0hcznZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443974; c=relaxed/simple;
	bh=taL4VuSTv2A1JaSTkD9QBZhRkJcauZHEdBcYGm6zPLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThRTCrpwslF+JkoiwTHxF5qjs5bF2nKm9CxtCts+jwwoln8v8n47g3A5NyYFMBF/JQhl8TaUZEJLIjcrMsz7nkqcdfdXtv4TV4xr+/zjfundX8IJbRTlk/XyRpnS4C9y/k+mszHpbo30I5JVZtnfMq7LxalEYiXMVMHujRA1Rew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANVgSB1I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANVgSB1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773443971; x=1804979971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taL4VuSTv2A1JaSTkD9QBZhRkJcauZHEdBcYGm6zPLA=;
  b=ANVgSB1IGfaL7yy+pg+djyynKkd5tWUUCzzmjcVfCoPgOke0TuZ4Yeva
   2UzqEwcuRCx4d0ZpcNTBYHBG67rr/zkNT0Ovhnd9ROWtexAWQ52hHd0sA
   ScZSaVEw3NEaQYiBxJyx9QJ7FDa+RKjUdgPWmTQbGqSifk3VZEi+1eoYQ
   9457FJBb6mliyZNHgnx9zAeedPq63Q00SjQRQbkd506yyjINxN6dxTjNY
   pB0NMHRKXU9Yrwe9KYJWDgeTiXwxN3TbmgVWBnjth/KKVo6TKrypVsjX8
   NDlSr7wa0O4gOHDVhLWVkFpeqSuerHx5lnMsOAbIJnMxtFntYasBp0UPU
   A==;
X-CSE-ConnectionGUID: AIdbteINQu6BLcfWMssTIA==
X-CSE-MsgGUID: MLg6OsTHRW2kReUlFa/M4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="77163505"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="77163505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 16:19:30 -0700
X-CSE-ConnectionGUID: 20DZDlkLT22uPy9QR+yoag==
X-CSE-MsgGUID: I5XDbt38SwKG+gCbSTqdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="217268540"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Mar 2026 16:19:25 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1Bms-000000004OZ-3Iu0;
	Fri, 13 Mar 2026 23:19:22 +0000
Date: Sat, 14 Mar 2026 07:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, helgaas@kernel.org,
	florian.fainelli@broadcom.com, jim2101024@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v8 1/5] PCI: Add pcie_get_link_speed() helper for safe
 array access
Message-ID: <202603140748.u17h0ZM8-lkp@intel.com>
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
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260314/202603140748.u17h0ZM8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603140748.u17h0ZM8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603140748.u17h0ZM8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/probe.c:793 expecting prototype for pcie_link_speed_value(). Prototype was for pcie_get_link_speed() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
