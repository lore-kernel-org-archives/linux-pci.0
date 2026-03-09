Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B83DBD71;
	Mon,  9 Mar 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071142; cv=none; b=mPWinpZ9Si9XKLnp00CH83dCZK2KvNgbpnyaGuDGpQh5lY89KzvkQzpOSJSyZuLBbPkeL8cUy8YY3upZkl1AlH6ilp1x/JUw4FszE7Adu7bp+tsv8HeniH5WyQoJBrDIHdKNpB+pDHnra/tH7jTC6JiR95dTAffnY2sIc6eD/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071142; c=relaxed/simple;
	bh=jwi9ebvnM0hO6++49RVnkk82lZ9CJamEzE6bQ8Tn474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZJv1d+VtjuhkMf/d0Hmk89Fbg2jeVK/pbtuTisw3QCiL0Wkh4IohB8WfwGBenNhFhY0h0SjNEsOtmjk2dxZ5Ju7AknPoUxQGnkbbOcdzuQTH24NA/fLV3P9C+LtaFUys0+TWxCmNttqwNqRqi1kbr/DltFzOccLbfENBDUxrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZc2vjMY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZc2vjMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773071140; x=1804607140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jwi9ebvnM0hO6++49RVnkk82lZ9CJamEzE6bQ8Tn474=;
  b=nZc2vjMYtDqeosG19kiW00GcUhg1A3Sez9groUaeRcO9r+rULW6FiwBh
   E/MjilmiMSs21ft/GOot3j7oowv/oE95j1UL37A25UEzSUTtQwjw0esS/
   bsmrrpeeiUK0nrkBBTxjSdPHRQUUfD0+1ErcUEnmKwDvBUp/qT24E7cly
   MANVxUa3iTK1QGkGqWtQyah3FuKq72dMKqzZ//tBMsydVmE4XrBRWmjxf
   baozqT3BehlUGWTrBFCg3O4BqRyyzn426jylNEKPaHV/NJwGC6ZkLo1zi
   d03GvcohSi2yOG7CatArHt7jEfqc4FOm6bSTA+u9HrrdF53xfwO0htZwE
   Q==;
X-CSE-ConnectionGUID: nC20N4XPStKAiAHYvHArgA==
X-CSE-MsgGUID: KXPIEMR1TjmdFz91o+scvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84425137"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84425137"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:45:39 -0700
X-CSE-ConnectionGUID: y8kklu2jQ+GS/rDGkR2w+A==
X-CSE-MsgGUID: Kk/LttEYQ8az5973KwI19g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218939087"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 08:45:37 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzcnV-000000000S0-1FRM;
	Mon, 09 Mar 2026 15:45:33 +0000
Date: Mon, 9 Mar 2026 23:44:47 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, helgaas@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
Message-ID: <202603092301.uROFb9mn-lkp@intel.com>
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
config: i386-randconfig-004-20260308 (https://download.01.org/0day-ci/archive/20260309/202603092301.uROFb9mn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260309/202603092301.uROFb9mn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603092301.uROFb9mn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware.c:128:19: error: invalid application of 'sizeof' to an incomplete type 'const unsigned char[]'
     128 |             max_speed >= ARRAY_SIZE(pcie_link_speed) ||
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   drivers/pci/controller/dwc/pcie-designware.c:255:9: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
     255 |         return PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     256 |                                  NULL, pci);
         |                                  ~~~~~~~~~~
   drivers/pci/controller/dwc/../../pci.h:159:5: note: expanded from macro 'PCI_FIND_NEXT_CAP'
     159 |                                 *(u8 *)prev_ptr = __prev_pos;           \
         |                                 ^~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:255:9: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
   drivers/pci/controller/dwc/../../pci.h:159:5: note: expanded from macro 'PCI_FIND_NEXT_CAP'
     159 |                                 *(u8 *)prev_ptr = __prev_pos;           \
         |                                 ^
   drivers/pci/controller/dwc/pcie-designware.c:262:9: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
     262 |         return PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, NULL, pci);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/../../pci.h:207:5: note: expanded from macro 'PCI_FIND_NEXT_EXT_CAP'
     207 |                                 *(u16 *)prev_ptr = __prev_pos;          \
         |                                 ^~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:262:9: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
   drivers/pci/controller/dwc/../../pci.h:207:5: note: expanded from macro 'PCI_FIND_NEXT_EXT_CAP'
     207 |                                 *(u16 *)prev_ptr = __prev_pos;          \
         |                                 ^
   drivers/pci/controller/dwc/pcie-designware.c:329:17: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
     329 |         while ((vsec = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, vsec,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     330 |                                              PCI_EXT_CAP_ID_VNDR, NULL, pci))) {
         |                                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/../../pci.h:207:5: note: expanded from macro 'PCI_FIND_NEXT_EXT_CAP'
     207 |                                 *(u16 *)prev_ptr = __prev_pos;          \
         |                                 ^~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:329:17: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
   drivers/pci/controller/dwc/../../pci.h:207:5: note: expanded from macro 'PCI_FIND_NEXT_EXT_CAP'
     207 |                                 *(u16 *)prev_ptr = __prev_pos;          \
         |                                 ^
   3 warnings and 1 error generated.


vim +128 drivers/pci/controller/dwc/pcie-designware.c

   112	
   113	static void dw_pcie_get_link_speed(struct dw_pcie *pci)
   114	{
   115		struct device_node *np = dev_of_node(pci->dev);
   116		int max_speed;
   117	
   118		max_speed = of_pci_get_max_link_speed(np);
   119		if (max_speed < 0) {
   120			dev_warn(pci->dev,
   121				 "Failed to get max-link-speed, using default (Gen1)\n");
   122			pci->max_link_speed = 1;
   123			return;
   124		}
   125	
   126		/* Validate against known speeds in pcie_link_speed */
   127		if (max_speed == 0 ||
 > 128		    max_speed >= ARRAY_SIZE(pcie_link_speed) ||
   129		    pcie_link_speed[max_speed] == PCI_SPEED_UNKNOWN) {
   130			dev_warn(pci->dev,
   131				 "Invalid max-link-speed %d, using default (Gen1)\n",
   132				 max_speed);
   133			pci->max_link_speed = 1;
   134			return;
   135		}
   136	
   137		pci->max_link_speed = max_speed;
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
