Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF593806D4;
	Sun,  8 Mar 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993457; cv=none; b=XUTs9JHrEMSGqWgIUMYO0GmFhkqvo65nlpCzMRVnWtDwfph61d11Z02C2DU8ggYR/uAyJQnY3EHzzKwQnVG3GzLqvi7KmoiZOB/Doc68OLoNXlc+T2b86HJtK0B0SSob+wWo6b57SOdJoSe2NEe0PZWG21xlAUck3nRxK5BJrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993457; c=relaxed/simple;
	bh=6Ntq63r4nEfjhZuClxcNg+CH4AgZvHyEV54ooP79AKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5aME9J9uZTM/vg7XNCWIUjdbBZaIUbdm8fanNV4X6NtLzQA8FjkvXve7hVoRAdHuAqnUahIbgWzC2zJPpymt6dToGGseCrb9QhRHp+iKeG//U6NcKJZexIbsHMFFU1/MgeDAQ+QReoe4oeZKkgwD1hF8z2Us0m3es3MxDlplEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4UEub1z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4UEub1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772993455; x=1804529455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Ntq63r4nEfjhZuClxcNg+CH4AgZvHyEV54ooP79AKc=;
  b=k4UEub1z9Vqq+1kQAMj5bUgqn/JNrRvGH9olIQCuR9eDVBYAr54vn9Qq
   DOO2lIPnXBnsRfJi2LI9fDlXGkrYyxTYiZ0LbxCoFvd1B3dXqP2ZzkkGV
   8KBzv2XePincDcEiEH4TrelT/2mpEmm1riZapZRb1ipZHJdQMdF+nVNMU
   rcovT5Ph2SnBKdXuYZGpo97DKH17Yf3UTvvVy5NlnshnDXd1XHyraD7Tz
   XESfemEJjVrgus3MtH8/XUrGxjp7jTe1bwKMTGBflBVJz8R+FAFyuLIrE
   aXxF3SRWySWdROZRUZdzUL1jmKZPljtOhOvZqgDJJWIfhXiQXNA5yLkzy
   Q==;
X-CSE-ConnectionGUID: 9TjceVZzT028BynYzmRjNQ==
X-CSE-MsgGUID: K7IvGcyVTYC2ESuOVng2Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73930620"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73930620"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 11:10:54 -0700
X-CSE-ConnectionGUID: KTB2GjEGTH+26Ss//Oeu4A==
X-CSE-MsgGUID: Cv9bL8FjS/a65Vb+fPs2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216536074"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Mar 2026 11:10:51 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzIaW-000000003JA-3xir;
	Sun, 08 Mar 2026 18:10:48 +0000
Date: Mon, 9 Mar 2026 02:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, helgaas@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
Message-ID: <202603090252.S3qQ67Kh-lkp@intel.com>
References: <20260308142629.75392-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308142629.75392-3-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on c23719abc3308df7ed3ad35650ad211fb2d2003d]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-of-Remove-max-link-speed-generation-validation/20260308-223128
base:   c23719abc3308df7ed3ad35650ad211fb2d2003d
patch link:    https://lore.kernel.org/r/20260308142629.75392-3-18255117159%40163.com
patch subject: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
config: csky-randconfig-r071-20260308 (https://download.01.org/0day-ci/archive/20260309/202603090252.S3qQ67Kh-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260309/202603090252.S3qQ67Kh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603090252.S3qQ67Kh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:16,
                    from include/linux/clk.h:13,
                    from drivers/pci/controller/dwc/pcie-designware.c:13:
   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_get_link_speed':
>> include/linux/array_size.h:11:32: error: invalid application of 'sizeof' to incomplete type 'const unsigned char[]'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
   drivers/pci/controller/dwc/pcie-designware.c:128:19: note: in expansion of macro 'ARRAY_SIZE'
     128 |      max_speed >= ARRAY_SIZE(pcie_link_speed) ||
         |                   ^~~~~~~~~~


vim +11 include/linux/array_size.h

3cd39bc3b11b8d Alejandro Colomar 2023-10-03   6  
3cd39bc3b11b8d Alejandro Colomar 2023-10-03   7  /**
3cd39bc3b11b8d Alejandro Colomar 2023-10-03   8   * ARRAY_SIZE - get the number of elements in array @arr
3cd39bc3b11b8d Alejandro Colomar 2023-10-03   9   * @arr: array to be sized
3cd39bc3b11b8d Alejandro Colomar 2023-10-03  10   */
3cd39bc3b11b8d Alejandro Colomar 2023-10-03 @11  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
3cd39bc3b11b8d Alejandro Colomar 2023-10-03  12  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
