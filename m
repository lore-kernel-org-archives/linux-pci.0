Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C03D6CCF;
	Thu,  2 Apr 2026 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170653; cv=none; b=Lea5wfpFH+WBp7jNhG2BpIZSLpwPkKU3P0pPmu+qB3I0NSkEHjMP7ZvSIIIs6B5SkIEbYgdkd60oLbrRC//h0u7XRlq3G/zVYI0UcPqU+qYcjVXzqJs1ITlx+4MPZSg8h3GJneKamodWikXlRuI9aic7k24/rCeaWvmGOyuO95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170653; c=relaxed/simple;
	bh=15K8mXYMWJzSX7LYoqjquZFaGkWetpo55iEai3+MFH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUw5bg6X3ZuEcFPChJqupMNX2bG8P+Q4yhgUXCLWQmqTjIJzBDplXUzXDNZqstz+4PrXwEnZG2cYrJmegMybvWY8/I7tscJG9mfryhK49zXxg7qCkFAHv6A3omEVrJrt6CM8mGtr/ELoD2s/lR7mtx/miUu3kJKW8RkXwgwr2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0l2V328; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0l2V328"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775170650; x=1806706650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15K8mXYMWJzSX7LYoqjquZFaGkWetpo55iEai3+MFH8=;
  b=K0l2V328izJFTWpVnKaqLLI2Fr94OWrUH+Z+thAlhKyhzGbPOnOZuxTo
   VjbBXNTJm6ljWkQj7/FpHxX+ngJSbBFBGjSmeqMo2djIh9DXaJUNqZhaJ
   coiNomsIu95dq5TGUhGk5es0DbTLStpz45rOJ1vC6gwWAGc21tX6y9oNn
   B4q/HIx725roB5971KObTR8LSfsftpw79dVPs+4ekHYrDUv8Zt85QZbPC
   Hw703mYtJXvSa9HCUQBlLzAJEqqHXsikPB9xmC64vtFZXwF1ZpS+muYln
   lOZ9x4/Jy1lzXQSQGFwL67BZ3/A1GtVh+Ug4I8I+47G1dIDgG4r1whm/y
   g==;
X-CSE-ConnectionGUID: 0QKKleq3SQ2xZXfl5mwglQ==
X-CSE-MsgGUID: 0zJ85QleQbOXgl9P2BQPMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76304288"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76304288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 15:57:29 -0700
X-CSE-ConnectionGUID: WO6gRj2yTGG9Demu2aQJcA==
X-CSE-MsgGUID: bNGBqwP6SKys7vrNq2UD7Q==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 02 Apr 2026 15:57:27 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8Qya-000000009B7-3Fm6;
	Thu, 02 Apr 2026 22:57:24 +0000
Date: Fri, 3 Apr 2026 00:56:47 +0200
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	brgl@kernel.org, robh@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	mani@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] power: sequencing: pcie-m2: Guard the helper
 functions making use of PCI bus notifier
Message-ID: <202604030008.5exLAPFm-lkp@intel.com>
References: <20260401070735.107162-4-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401070735.107162-4-manivannan.sadhasivam@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linux-next/master]
[also build test WARNING on linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/serdev-Add-missing-stubs-for-serdev-APIs-when-CONFIG_SERIAL_DEV_BUS-is-not-selected/20260402-225703
base:   linux-next/master
patch link:    https://lore.kernel.org/r/20260401070735.107162-4-manivannan.sadhasivam%40oss.qualcomm.com
patch subject: [PATCH 3/3] power: sequencing: pcie-m2: Guard the helper functions making use of PCI bus notifier
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260403/202604030008.5exLAPFm-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604030008.5exLAPFm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604030008.5exLAPFm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/tty_port.c:20:
>> include/linux/serdev.h:268:83: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     268 | static inline struct serdev_device *serdev_device_alloc(struct serdev_controller *)
         |                                                                                   ^
   include/linux/serdev.h:272:59: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     272 | static inline int serdev_device_add(struct serdev_device *)
         |                                                           ^
   include/linux/serdev.h:276:63: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     276 | static inline void serdev_device_remove(struct serdev_device *) {}
         |                                                               ^
   include/linux/serdev.h:284:67: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     284 | static inline int serdev_controller_add(struct serdev_controller *)
         |                                                                   ^
   include/linux/serdev.h:288:71: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     288 | static inline void serdev_controller_remove(struct serdev_controller *) {}
         |                                                                       ^
   5 warnings generated.


vim +268 include/linux/serdev.h

   267	
 > 268	static inline struct serdev_device *serdev_device_alloc(struct serdev_controller *)
   269	{
   270		return NULL;
   271	}
   272	static inline int serdev_device_add(struct serdev_device *)
   273	{
   274		return -ENODEV;
   275	}
   276	static inline void serdev_device_remove(struct serdev_device *) {}
   277	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
