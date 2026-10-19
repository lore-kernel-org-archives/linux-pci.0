Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442779;
	b=mVbtlHMCQirReMn+BiKdIcPbVraD0Wa7znylyJsN5YLfYebsnLI3onoe1Kb+ao0kwBc2
	 ADVUqPVQSHjYI5KmqibWVSsoJAyFoKikIm5qVB8Kxrb3nbamqpC2o7ukC7RqN38Ph6A6e
	 GNWGO7sVjgFs0QSaJ1IUgiDHH7VVrKQXOaIVOLch+On7xXcehkxNzBa5dCG7xKNYiUJae
	 Bv/WLAEYQJH2yvKc6cReT70p0wakpbEy1eQ5guktGkb7l5cT7H26Bo08FguZUBg4+BLWN
	 3JxvHT891w8H24kW2zEQmHk6cys+Ogk1eEwfwApR1oAMsWmb/wpdwmayZkZEvdlXIuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442779;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=26rFftVWg3BQetk+2+hV1kDO5oxZKU6oU2x+jE3vKwM=;
	b=45KT5z/EWNv39qv6ehb95mPvaDEmY9yk9Qk1Wt7xNeuuGj5tcrUi5fI8xakPSwqLIy67
	 NzZ2QFBk/Dw6PsjlKjntcdA1G4OzZfLz6GO+PYX5mCG/yWzKohDejY1nYUFASUARkm5E3
	 opT9MTDl2X8F3UVAbGe2tiPpfc/OzlIug1GjpojUrTVt2xt+Bg14da1g1kLg+AyqjUcPv
	 eowuDbZ3/tEGsU1roIUotzFlDwySO88zEUHykCs7yXiVkbMKtOwN/TTESmj3O1FNdjTYe
	 O1d5gJhjzr9cYEkz2LorBmDU5N2SXtGrMq9ieOLDEKDE4dwcc5zabU8/hhs5xqJkjnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E38UPn2r;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25125606A319
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25125606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E38UPn2r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792442779; x=1823978779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPaKfxrJTwuGXpNqJn91Xad8Zve1NjywuhAkFJLP6Tc=;
  b=E38UPn2rgH7rX4XIEs9xoUJF0ay0h7u8rHhC0ycQUpK7qz62HcvyN65O
   a1vh/zDjBA9AjjCqNkqZmT5YQdhmeaToXfo+xbLkjqkeNo+jzYMRkJjSd
   oID1OtbFXfK2YWCgQJAQJWit6ln+ZxQzncaJdOX9p8T+WZfK33jCjRFlV
   THOuNfgcMhE8/whpvV8W9ZEVCHh7szv+XdN3NunDPZvFddVNbwc1/K9Ax
   NoiWYF6JpBDIByIkBS6FAjGJ2RJnA0xlCu7GULaWttyWOiPiBcndbCjSY
   fRtJR9GmpO4cPWYf2HHWBiAwc5PfkIZcx0pGH+uRr6fI537EstDTPbK7p
   w==;
X-CSE-ConnectionGUID: 5vXmziMoSROJDmA1bMHDeg==
X-CSE-MsgGUID: mCLACKXPRHuxmsp023Rdmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1041463"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1041463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:46:18 -0700
X-CSE-ConnectionGUID: 46avrWP0QweOGadN9LhM5A==
X-CSE-MsgGUID: ak8vEZwiQ3KRBKTFOCEBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2683900"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Oct 2026 13:46:15 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIuFJ-00000000MNC-0m8k;
	Mon, 19 Oct 2026 20:46:13 +0000
Date: Tue, 20 Oct 2026 04:45:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@gmail.com, simona@ffwll.ch, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Message-ID: <202610200440.fq7Zgnxm-lkp@intel.com>
References: <20261015124843.203905-1-mario.limonciello@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015124843.203905-1-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.3 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-amdgpu-Gate-VFCT-bus-fallback-on-pci-realloc/20261015-074842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20261015124843.203905-1-mario.limonciello%40amd.com
patch subject: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261020/202610200440.fq7Zgnxm-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610200440.fq7Zgnxm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610200440.fq7Zgnxm-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/gpu/drm/amd/amdgpu/amdgpu.ko: symbol 'pci_realloc_enabled_by_user' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
