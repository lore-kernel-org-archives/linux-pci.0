Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EF396B9C;
	Mon,  9 Mar 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054726; cv=none; b=pXu+sA/ccL9j9aNphBRpPGbmtQx+oinzTFUUZv2kHxCkMu+LNJn3V9t+XQh8l+9ZNY+HW55alQRMuGHPJL1/QAfaYtYhgSD0/leqP4FcNvFVXqueH7kQBiGqBGUShoyL2TNbt4pwrRQrSI/qURbwR0v0hFzLHUpLb8W7887ApBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054726; c=relaxed/simple;
	bh=UAF4L3W3XkviqAFTgOW7VEHQreqTnxXeNsGGT6LXUdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq4E0+kC9tebcROIMyys8461a21/uKmyjIM3NVNSZKBHQy59NYXglv+QGe4FOLyI6/kicWsX4o3Awxiu6qDQsbTS8Iaac+S/rC+WuUOlaUNkBYLl5BH1RkIqZwtc+4WGS1LSx+UOd4Xt6XDw2/AqRP9xfvqIiAAn48GNJEB55vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zer0FkqI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zer0FkqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773054723; x=1804590723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAF4L3W3XkviqAFTgOW7VEHQreqTnxXeNsGGT6LXUdk=;
  b=Zer0FkqIMVykoUo8FNQpPh/Tg8ENb56nV3ImAXWmtO4ntGgh2nrX+R+S
   /NUTggWbbPepk3tci0Z6EMnN1hQh++YS76fP3NSM8Tj1+HabznKjBNou1
   dmB+G6uyEUtDQ4pz5K1NCftRoE6kDj1BNCR1y2jr+iMcH27L3wXJBNgIV
   DXobfSA/Wlvem1OZu/b3zs0mjarjw3ARaKcm6SWk8dhwPO3qg8AzTDGHr
   FDZwmnvvfSY/ToeUWhvlgdatUGxNykQId8C0/Md2X0zCIu8zUZLgrdKSS
   +APPhIusaDGqYYyh1cScmhOWHH2xJdsKeI1bFzNvVNP4tH8Lwv16gBR2a
   g==;
X-CSE-ConnectionGUID: siitvxi0Q5OBJ5DBktoUrA==
X-CSE-MsgGUID: I/KhP28IR9GLeA4hUn9wlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84709481"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84709481"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:12:02 -0700
X-CSE-ConnectionGUID: ywfDS89NQJilEXe/K984FQ==
X-CSE-MsgGUID: q/GIchPFThSzo8NF9Ybkbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216663390"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Mar 2026 04:12:00 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzYWj-0000000007M-0WCv;
	Mon, 09 Mar 2026 11:11:57 +0000
Date: Mon, 9 Mar 2026 19:11:56 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, helgaas@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
Message-ID: <202603091845.8xKRO6rW-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on c23719abc3308df7ed3ad35650ad211fb2d2003d]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-of-Remove-max-link-speed-generation-validation/20260308-223128
base:   c23719abc3308df7ed3ad35650ad211fb2d2003d
patch link:    https://lore.kernel.org/r/20260308142629.75392-3-18255117159%40163.com
patch subject: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
config: i386-randconfig-004-20260308 (https://download.01.org/0day-ci/archive/20260309/202603091845.8xKRO6rW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260309/202603091845.8xKRO6rW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603091845.8xKRO6rW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c:128:19: error: invalid application of 'sizeof' to an incomplete type 'const unsigned char[]'
     128 |             max_speed >= ARRAY_SIZE(pcie_link_speed) ||
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
>> drivers/pci/controller/dwc/pcie-designware.c:255:9: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
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


vim +255 drivers/pci/controller/dwc/pcie-designware.c

13e9d3900c2024 Serge Semin 2022-06-24  252  
7a6854f6874ff4 Vidya Sagar 2019-08-13  253  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
7a6854f6874ff4 Vidya Sagar 2019-08-13  254  {
8ffc9f234fdf33 Hans Zhang  2025-08-13 @255  	return PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
a2582e05e39adf Qiang Yu    2025-11-09  256  				 NULL, pci);
7a6854f6874ff4 Vidya Sagar 2019-08-13  257  }
7a6854f6874ff4 Vidya Sagar 2019-08-13  258  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
7a6854f6874ff4 Vidya Sagar 2019-08-13  259  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
