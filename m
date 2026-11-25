Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599765;
	b=CO2JGlIvSDjzE/SK96elGII5ypjHS6UHaBPhJbrP9VCkwX6tZf7ndS9uQh08pqMH2NX1
	 ig2Obmx91WXUbfkzm9WxmR6xe0sU3ORLDeJtkkU3tSnn3txena89PppxnARULSaNEwsVU
	 7eij/Av7oQKF+pbmrI74oZMMiY9pvxuU3bUpAE5V+hevzZGQUafj5N7i82HtRQDYfhuza
	 0ZUlfVacerDpIXi57zNi92pCI2rGk5jR9L48CG5OgpkzSnPxMmDdZqctcx+KaIt8CSt2d
	 XsxUR6rECXWGVa764YR7LD/Ohv12Kl4G72uzqyqF/J9SJqxlieLQDjewADU/yUImNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599765;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=y2OFdAXRZadeVVSCkuPcsPpvnYttO5ytKl7GccGQ2rE=;
	b=nk4rhOsBdhatHerUjUzyrj0QsXfXQ1Wag3O261bbFYO/9WmCBH/5AjzyLvEIgsalEba3
	 b22C1k5KyyeNFaLs3U1HuDmO/lNmYmzENCSHO6YvzXrrIHrelEFnbOsX20PpyX1eDAkmd
	 2mjdXVgpYJ12UeaqGLeyM2Wv8PaaNVbU6dTpf56WuZZOjhX/KlO2fCNbjM4Pq2QUPrKEW
	 v6TZ9mSOprfCa4iMEG86pcSepPv2MgoQa+nWMXabYmoIUYiG7/zZKXkkBs+NsnHpviAWe
	 9o7nMRG6al6oojg6E0Z8uDvtPt2AP3oO2qWeEpAD2MqAnaOImAMPj+PttSP1xnx8GCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AkN2bMOT;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA3606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 09:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FA3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AkN2bMOT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795599764; x=1827135764;
  h=date:from:to:cc:subject:message-id;
  bh=4fjDQxONYj19vtre/k7fxGAiVWeSAU9kkEeZ9IdaTbg=;
  b=AkN2bMOTkL6d3/5cLQuGIAXowuWB/i5kVn0d2SvKjRVrKdGy7CvST+yW
   50v+DQLf8z3FZkZVrgB7Jpo2t6r3NVAU0yQUBBXhvyrNFyV2T4YBvlwDX
   TSdZqVXjWCtjO6tKEmXzrksUUZlYTy2obOSMvWHITnOHzt4s9u4VjSQa7
   F/10ZM4z+0Jgka8W7Gp8CfDVNDXjarTXd8HJSczQ1G6puaGtOtw7bdv6H
   XOp6+zzaqbVIkMyQH83JVl2AONA9MiUoxkBs0BwO3F3QjajglshByAaqQ
   ROYFvrE9z7+m4WSR9OKLVOalQAW3M52x3TfNGuy2bF8q4+tLTlsSc3emQ
   g==;
X-CSE-ConnectionGUID: 6q+HQEsbQ+iOlkeBTWncbw==
X-CSE-MsgGUID: jkMVwH16QHyMKeWTVIUw+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4359151"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4359151"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:34:45 -0800
X-CSE-ConnectionGUID: HG2VG3iESCWFfwJrtyfWpg==
X-CSE-MsgGUID: 2m6KkV3STdWP7CdVy2A6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12250230"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2026 01:34:44 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW9Oj-00000001RIE-2beK;
	Wed, 25 Nov 2026 09:34:41 +0000
Date: Wed, 25 Nov 2026 17:33:46 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-rockchip] BUILD SUCCESS
 c72d9039a00dd28ce9f99ba73112c68ca0462b35
Message-ID: <20261125173346.aUsT5kQB-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rockchip
branch HEAD: c72d9039a00dd28ce9f99ba73112c68ca0462b35  dt-bindings: PCI: rockchip-dw: Allow endpoint supply

elapsed time: 929m

configs tested: 611
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261124    gcc-11.5.0
alpha                 randconfig-2001-20261124    gcc-11.5.0
alpha                 randconfig-2200-20261124    gcc-8.5.0  smatch
alpha                 randconfig-2200-20261125    gcc-10.5.0 smatch
alpha                randconfig-r2101-20261124    clang-22   cocci
alpha                randconfig-r2103-20261124    gcc-9.5.0  cocci
alpha                randconfig-r2111-20261125    gcc-13.5.0 cocci
alpha                randconfig-r2302-20261124    clang-17   sparse
alpha                randconfig-r2303-20261125    gcc-8.5.0  sparse
alpha                randconfig-r2307-20261125    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                          haps_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261125    gcc-8.5.0
arc                   randconfig-1001-20261125    gcc-8.5.0
arc                   randconfig-2000-20261124    gcc-11.5.0
arc                   randconfig-2000-20261125    gcc-10.5.0
arc                   randconfig-2001-20261124    gcc-11.5.0
arc                   randconfig-2001-20261125    gcc-10.5.0
arc                   randconfig-2002-20261124    gcc-11.5.0
arc                   randconfig-2002-20261125    gcc-10.5.0
arc                   randconfig-2003-20261124    gcc-11.5.0
arc                   randconfig-2003-20261125    gcc-10.5.0
arc                   randconfig-2004-20261124    gcc-11.5.0
arc                   randconfig-2004-20261125    gcc-10.5.0
arc                   randconfig-2005-20261124    gcc-11.5.0
arc                   randconfig-2005-20261125    gcc-10.5.0
arc                   randconfig-2200-20261124    gcc-8.5.0  smatch
arc                   randconfig-2200-20261125    gcc-14.4.0 smatch
arc                  randconfig-r2101-20261124    gcc-16.2.0 cocci
arc                  randconfig-r2106-20261124    clang-24   cocci
arc                  randconfig-r2107-20261125    gcc-13.5.0 cocci
arc                  randconfig-r2109-20261124    gcc-15.3.0 cocci
arc                  randconfig-r2110-20261124    clang-24   cocci
arc                  randconfig-r2300-20261124    clang-17   sparse
arc                  randconfig-r2300-20261124    gcc-16.2.0 sparse
arc                  randconfig-r2304-20261124    gcc-16.2.0 sparse
arc                  randconfig-r2307-20261124    clang-24   sparse
arc                  randconfig-r2311-20261124    gcc-9.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.2.0
arm                          axm55xx_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    clang-17
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    clang-17
arm                          lpc32xx_defconfig    clang-17
arm                           moxart_defconfig    clang-17
arm                           moxart_defconfig    clang-24
arm                          mv78xx0_defconfig    clang-17
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                           pxa168_defconfig    clang-17
arm                           pxa168_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261125    gcc-8.5.0
arm                   randconfig-1001-20261125    gcc-8.5.0
arm                   randconfig-1002-20261125    gcc-8.5.0
arm                   randconfig-1003-20261125    gcc-8.5.0
arm                   randconfig-2000-20261124    clang-17
arm                   randconfig-2000-20261125    clang-22
arm                   randconfig-2001-20261124    clang-17
arm                   randconfig-2001-20261125    clang-22
arm                   randconfig-2002-20261124    clang-17
arm                   randconfig-2002-20261125    clang-22
arm                   randconfig-2200-20261124    clang-17   smatch
arm                   randconfig-2200-20261125    clang-21   smatch
arm                  randconfig-r2100-20261124    clang-24   cocci
arm                  randconfig-r2103-20261124    gcc-16.2.0 cocci
arm                  randconfig-r2105-20261124    gcc-16.2.0 cocci
arm                  randconfig-r2107-20261124    gcc-15.3.0 cocci
arm                  randconfig-r2110-20261124    clang-24   cocci
arm                  randconfig-r2300-20261124    clang-22   sparse
arm                  randconfig-r2300-20261124    gcc-16.2.0 sparse
arm                  randconfig-r2302-20261124    clang-18   sparse
arm                  randconfig-r2303-20261124    gcc-16.2.0 sparse
arm                  randconfig-r2304-20261124    gcc-16.2.0 sparse
arm                  randconfig-r2305-20261124    gcc-14.4.0 sparse
arm                  randconfig-r2307-20261124    gcc-9.5.0  sparse
arm                  randconfig-r2311-20261124    clang-24   sparse
arm                            sama7_defconfig    clang-17
arm                          socfpga_defconfig    clang-17
arm                           sp7021_defconfig    clang-24
arm                           sp7021_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261125    clang-24
arm64                 randconfig-1001-20261125    clang-24
arm64                 randconfig-1002-20261125    clang-24
arm64                 randconfig-1003-20261125    clang-24
arm64                 randconfig-2000-20261124    clang-17
arm64                 randconfig-2000-20261125    clang-22
arm64                 randconfig-2001-20261124    clang-17
arm64                 randconfig-2001-20261125    clang-22
arm64                 randconfig-2002-20261124    clang-17
arm64                 randconfig-2002-20261125    clang-22
arm64                 randconfig-2200-20261124    gcc-16.2.0 smatch
arm64                 randconfig-2200-20261125    gcc-13.5.0 smatch
arm64                randconfig-r2101-20261124    clang-24   cocci
arm64                randconfig-r2107-20261124    clang-24   cocci
arm64                randconfig-r2109-20261124    clang-24   cocci
arm64                randconfig-r2111-20261124    gcc-15.3.0 cocci
arm64                randconfig-r2300-20261124    gcc-16.2.0 sparse
arm64                randconfig-r2306-20261125    gcc-13.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261125    clang-24
csky                  randconfig-1001-20261125    clang-24
csky                  randconfig-2000-20261124    gcc-16.2.0
csky                  randconfig-2001-20261124    gcc-16.2.0
csky                  randconfig-2200-20261124    gcc-15.3.0 smatch
csky                  randconfig-2200-20261125    gcc-16.2.0 smatch
csky                 randconfig-r2101-20261124    gcc-8.5.0  cocci
csky                 randconfig-r2104-20261124    gcc-8.5.0  cocci
csky                 randconfig-r2105-20261124    clang-22   cocci
csky                 randconfig-r2302-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2309-20261124    clang-24   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261125    gcc-11.5.0
hexagon               randconfig-1001-20261125    gcc-11.5.0
hexagon               randconfig-2000-20261124    gcc-16.2.0
hexagon               randconfig-2001-20261124    gcc-16.2.0
hexagon               randconfig-2200-20261125    clang-17   smatch
hexagon              randconfig-r2103-20261124    clang-22   cocci
hexagon              randconfig-r2107-20261124    clang-24   cocci
hexagon              randconfig-r2107-20261124    gcc-14     cocci
hexagon              randconfig-r2107-20261125    gcc-11.5.0 cocci
hexagon              randconfig-r2302-20261124    gcc-16.2.0 sparse
hexagon              randconfig-r2309-20261125    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261125    clang-22
i386        buildonly-randconfig-1001-20261125    clang-22
i386        buildonly-randconfig-1002-20261125    clang-22
i386        buildonly-randconfig-1003-20261125    clang-22
i386        buildonly-randconfig-1004-20261125    clang-22
i386        buildonly-randconfig-1005-20261125    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261125    clang-22
i386                  randconfig-1001-20261125    clang-22
i386                  randconfig-1002-20261125    clang-22
i386                  randconfig-1003-20261125    clang-22
i386                  randconfig-1004-20261125    clang-22
i386                  randconfig-1005-20261125    clang-22
i386                  randconfig-1006-20261125    clang-22
i386                  randconfig-2000-20261124    gcc-14
i386                  randconfig-2000-20261125    gcc-14
i386                  randconfig-2001-20261124    gcc-14
i386                  randconfig-2001-20261125    gcc-14
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2002-20261125    gcc-14
i386                  randconfig-2003-20261124    gcc-14
i386                  randconfig-2003-20261125    gcc-14
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2004-20261125    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2005-20261125    gcc-14
i386                  randconfig-2100-20261124    gcc-14     cocci
i386                  randconfig-2101-20261124    gcc-14     cocci
i386                  randconfig-2102-20261124    gcc-14     cocci
i386                  randconfig-2103-20261124    gcc-14     cocci
i386                  randconfig-2104-20261124    gcc-14     cocci
i386                  randconfig-2105-20261124    gcc-14     cocci
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2200-20261125    clang-22   smatch
i386                  randconfig-2300-20261124    gcc-14     sparse
i386                  randconfig-2301-20261124    gcc-14     sparse
i386                  randconfig-2302-20261124    gcc-14     sparse
i386                 randconfig-r2103-20261124    gcc-16.2.0 cocci
i386                 randconfig-r2104-20261124    clang-22   cocci
i386                 randconfig-r2109-20261124    gcc-14     cocci
i386                 randconfig-r2110-20261124    gcc-15.3.0 cocci
i386                 randconfig-r2300-20261124    clang-18   sparse
i386                 randconfig-r2300-20261124    gcc-14.4.0 sparse
i386                 randconfig-r2301-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2303-20261124    clang-22   sparse
i386                 randconfig-r2303-20261124    gcc-14.4.0 sparse
i386                 randconfig-r2305-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2306-20261124    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261125    gcc-11.5.0
loongarch             randconfig-1001-20261125    gcc-11.5.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2000-20261125    clang-19
loongarch             randconfig-2001-20261124    clang-18
loongarch             randconfig-2001-20261125    clang-19
loongarch             randconfig-2200-20261124    gcc-16.2.0 smatch
loongarch             randconfig-2200-20261125    clang-18   smatch
loongarch            randconfig-r2100-20261124    gcc-16.2.0 cocci
loongarch            randconfig-r2100-20261124    gcc-9.5.0  cocci
loongarch            randconfig-r2106-20261124    gcc-15.3.0 cocci
loongarch            randconfig-r2106-20261125    gcc-11.5.0 cocci
loongarch            randconfig-r2304-20261124    gcc-14.4.0 sparse
loongarch            randconfig-r2306-20261125    clang-24   sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261124    gcc-11.5.0
m68k                  randconfig-2001-20261124    gcc-11.5.0
m68k                  randconfig-2200-20261124    gcc-10.5.0 smatch
m68k                  randconfig-2200-20261125    gcc-15.3.0 smatch
m68k                 randconfig-r2102-20261124    gcc-9.5.0  cocci
m68k                 randconfig-r2107-20261124    clang-20   cocci
m68k                 randconfig-r2300-20261124    gcc-15.3.0 sparse
m68k                 randconfig-r2300-20261125    gcc-8.5.0  sparse
m68k                 randconfig-r2301-20261125    gcc-8.5.0  sparse
m68k                 randconfig-r2308-20261124    gcc-9.5.0  sparse
m68k                           sun3x_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261124    gcc-11.5.0
microblaze            randconfig-2001-20261124    gcc-11.5.0
microblaze            randconfig-2200-20261124    gcc-8.5.0  smatch
microblaze            randconfig-2200-20261125    gcc-8.5.0  smatch
microblaze           randconfig-r2104-20261125    gcc-12.5.0 cocci
microblaze           randconfig-r2105-20261124    gcc-8.5.0  cocci
microblaze           randconfig-r2106-20261125    gcc-13.5.0 cocci
microblaze           randconfig-r2107-20261124    gcc-11.5.0 cocci
microblaze           randconfig-r2108-20261124    gcc-15.3.0 cocci
microblaze           randconfig-r2108-20261125    gcc-13.5.0 cocci
microblaze           randconfig-r2301-20261124    gcc-14.4.0 sparse
microblaze           randconfig-r2302-20261124    gcc-16.2.0 sparse
microblaze           randconfig-r2305-20261124    clang-17   sparse
microblaze           randconfig-r2305-20261125    gcc-8.5.0  sparse
microblaze           randconfig-r2307-20261124    gcc-9.5.0  sparse
microblaze           randconfig-r2309-20261124    gcc-9.5.0  sparse
microblaze           randconfig-r2310-20261125    gcc-13.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-17
mips                        bmips_be_defconfig    gcc-16.2.0
mips                      decstation_defconfig    clang-17
mips                  decstation_r4k_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                            ip30_defconfig    clang-17
mips                            ip30_defconfig    gcc-16.2.0
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    clang-24
mips                  randconfig-2000-20261124    gcc-16.2.0
mips                  randconfig-2000-20261125    gcc-16.2.0
mips                  randconfig-2001-20261124    gcc-16.2.0
mips                  randconfig-2001-20261125    gcc-16.2.0
mips                  randconfig-2002-20261124    gcc-16.2.0
mips                  randconfig-2002-20261125    gcc-16.2.0
mips                  randconfig-2200-20261124    clang-20   smatch
mips                  randconfig-2200-20261125    clang-24   smatch
mips                 randconfig-r2100-20261124    gcc-16.2.0 cocci
mips                 randconfig-r2101-20261124    gcc-16.2.0 cocci
mips                 randconfig-r2108-20261125    gcc-11.5.0 cocci
mips                 randconfig-r2110-20261124    gcc-14     cocci
mips                          rt305x_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261125    gcc-11.5.0
nios2                 randconfig-1001-20261125    gcc-11.5.0
nios2                 randconfig-2000-20261124    clang-18
nios2                 randconfig-2000-20261125    clang-19
nios2                 randconfig-2001-20261124    clang-18
nios2                 randconfig-2001-20261125    clang-19
nios2                 randconfig-2200-20261124    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261125    gcc-8.5.0  smatch
nios2                randconfig-r2100-20261124    clang-22   cocci
nios2                randconfig-r2104-20261124    gcc-16.2.0 cocci
nios2                randconfig-r2104-20261124    gcc-9.5.0  cocci
nios2                randconfig-r2108-20261124    clang-20   cocci
nios2                randconfig-r2109-20261125    gcc-13.5.0 cocci
nios2                randconfig-r2111-20261124    clang-24   cocci
nios2                randconfig-r2111-20261124    gcc-14     cocci
nios2                randconfig-r2304-20261124    clang-22   sparse
nios2                randconfig-r2305-20261124    clang-22   sparse
nios2                randconfig-r2305-20261124    gcc-15.3.0 sparse
nios2                randconfig-r2306-20261124    gcc-9.5.0  sparse
nios2                randconfig-r2307-20261125    gcc-13.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261124    gcc-16.2.0
openrisc              randconfig-2000-20261125    gcc-16.2.0
openrisc              randconfig-2001-20261124    gcc-16.2.0
openrisc              randconfig-2001-20261125    gcc-16.2.0
openrisc              randconfig-2002-20261124    gcc-16.2.0
openrisc              randconfig-2002-20261125    gcc-16.2.0
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc              randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc             randconfig-r2102-20261124    clang-22   cocci
openrisc             randconfig-r2103-20261124    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2106-20261124    gcc-15.3.0 cocci
openrisc             randconfig-r2110-20261125    gcc-11.5.0 cocci
openrisc             randconfig-r2111-20261124    clang-24   cocci
openrisc             randconfig-r2111-20261124    gcc-11.5.0 cocci
openrisc             randconfig-r2304-20261124    clang-17   sparse
openrisc             randconfig-r2310-20261125    clang-24   sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261125    clang-24
parisc                randconfig-1001-20261125    clang-24
parisc                randconfig-2000-20261124    clang-18
parisc                randconfig-2000-20261125    clang-19
parisc                randconfig-2001-20261124    clang-18
parisc                randconfig-2001-20261125    clang-19
parisc                randconfig-2200-20261124    gcc-9.5.0  smatch
parisc                randconfig-2200-20261125    gcc-12.5.0 smatch
parisc               randconfig-r2105-20261124    clang-24   cocci
parisc               randconfig-r2301-20261124    gcc-15.3.0 sparse
parisc               randconfig-r2304-20261125    gcc-8.5.0  sparse
parisc               randconfig-r2308-20261124    gcc-9.5.0  sparse
parisc               randconfig-r2311-20261124    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.2.0
powerpc                  mpc836x_rdk_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261125    clang-24
powerpc               randconfig-1001-20261125    clang-24
powerpc               randconfig-2000-20261124    clang-24
powerpc               randconfig-2000-20261125    gcc-9.5.0
powerpc               randconfig-2001-20261124    clang-24
powerpc               randconfig-2001-20261125    gcc-9.5.0
powerpc               randconfig-2002-20261124    clang-24
powerpc               randconfig-2002-20261125    gcc-9.5.0
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc               randconfig-2200-20261125    gcc-11.5.0 smatch
powerpc              randconfig-r2100-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2102-20261124    clang-22   cocci
powerpc              randconfig-r2102-20261124    gcc-16.2.0 cocci
powerpc              randconfig-r2104-20261124    gcc-16.2.0 cocci
powerpc              randconfig-r2106-20261124    clang-20   cocci
powerpc              randconfig-r2106-20261124    clang-24   cocci
powerpc              randconfig-r2301-20261124    clang-18   sparse
powerpc              randconfig-r2302-20261124    clang-22   sparse
powerpc              randconfig-r2304-20261124    gcc-15.3.0 sparse
powerpc              randconfig-r2311-20261125    gcc-13.5.0 sparse
powerpc                      tqm8555_defconfig    clang-17
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261125    clang-24
powerpc64             randconfig-1001-20261125    clang-24
powerpc64             randconfig-2000-20261124    clang-24
powerpc64             randconfig-2000-20261125    gcc-9.5.0
powerpc64             randconfig-2001-20261124    clang-24
powerpc64             randconfig-2001-20261125    gcc-9.5.0
powerpc64             randconfig-2002-20261124    clang-24
powerpc64             randconfig-2002-20261125    gcc-9.5.0
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
powerpc64             randconfig-2200-20261125    gcc-13.5.0 smatch
powerpc64            randconfig-r2101-20261124    clang-22   cocci
powerpc64            randconfig-r2102-20261124    gcc-8.5.0  cocci
powerpc64            randconfig-r2105-20261124    clang-22   cocci
powerpc64            randconfig-r2105-20261124    gcc-16.2.0 cocci
powerpc64            randconfig-r2105-20261125    gcc-12.5.0 cocci
powerpc64            randconfig-r2108-20261124    clang-24   cocci
powerpc64            randconfig-r2110-20261124    clang-24   cocci
powerpc64            randconfig-r2303-20261124    clang-17   sparse
powerpc64            randconfig-r2310-20261124    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261125    gcc-8.5.0
riscv                 randconfig-1001-20261125    gcc-8.5.0
riscv                 randconfig-2000-20261124    gcc-16.2.0
riscv                 randconfig-2000-20261125    gcc-13.5.0
riscv                 randconfig-2001-20261124    gcc-16.2.0
riscv                 randconfig-2001-20261125    gcc-13.5.0
riscv                 randconfig-2002-20261124    gcc-16.2.0
riscv                 randconfig-2002-20261125    gcc-13.5.0
riscv                 randconfig-2003-20261124    gcc-16.2.0
riscv                 randconfig-2003-20261125    gcc-13.5.0
riscv                 randconfig-2004-20261124    gcc-16.2.0
riscv                 randconfig-2004-20261125    gcc-13.5.0
riscv                 randconfig-2005-20261124    gcc-16.2.0
riscv                 randconfig-2005-20261125    gcc-13.5.0
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
riscv                 randconfig-2200-20261125    gcc-8.5.0  smatch
riscv                randconfig-r2102-20261124    gcc-16.2.0 cocci
riscv                randconfig-r2106-20261124    clang-24   cocci
riscv                randconfig-r2107-20261124    clang-24   cocci
riscv                randconfig-r2109-20261125    gcc-11.5.0 cocci
riscv                randconfig-r2110-20261124    gcc-11.5.0 cocci
riscv                randconfig-r2111-20261124    clang-20   cocci
riscv                randconfig-r2303-20261124    gcc-15.3.0 sparse
riscv                randconfig-r2305-20261124    clang-18   sparse
riscv                randconfig-r2305-20261124    gcc-16.2.0 sparse
riscv                randconfig-r2306-20261124    clang-24   sparse
riscv                randconfig-r2308-20261124    clang-24   sparse
riscv                randconfig-r2311-20261124    gcc-9.5.0  sparse
riscv                randconfig-r2311-20261125    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261125    gcc-8.5.0
s390                  randconfig-1001-20261125    gcc-8.5.0
s390                  randconfig-2000-20261124    clang-24
s390                  randconfig-2000-20261125    clang-24
s390                  randconfig-2001-20261124    clang-24
s390                  randconfig-2001-20261125    clang-24
s390                  randconfig-2002-20261124    clang-24
s390                  randconfig-2002-20261125    clang-24
s390                  randconfig-2003-20261124    clang-24
s390                  randconfig-2003-20261125    clang-24
s390                  randconfig-2004-20261124    clang-24
s390                  randconfig-2004-20261125    clang-24
s390                  randconfig-2005-20261124    clang-24
s390                  randconfig-2005-20261125    clang-24
s390                  randconfig-2200-20261124    clang-24   smatch
s390                  randconfig-2200-20261125    gcc-15.3.0 smatch
s390                 randconfig-r2102-20261125    gcc-12.5.0 cocci
s390                 randconfig-r2103-20261125    gcc-12.5.0 cocci
s390                 randconfig-r2106-20261124    gcc-14     cocci
s390                 randconfig-r2110-20261124    clang-20   cocci
s390                 randconfig-r2111-20261125    gcc-11.5.0 cocci
s390                 randconfig-r2303-20261124    clang-18   sparse
s390                 randconfig-r2308-20261125    gcc-13.5.0 sparse
s390                 randconfig-r2310-20261124    gcc-9.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                    randconfig-1000-20261125    gcc-8.5.0
sh                    randconfig-1001-20261125    gcc-8.5.0
sh                    randconfig-2000-20261124    gcc-11.5.0
sh                    randconfig-2000-20261125    gcc-14.4.0
sh                    randconfig-2001-20261124    gcc-11.5.0
sh                    randconfig-2001-20261125    gcc-14.4.0
sh                    randconfig-2002-20261124    gcc-11.5.0
sh                    randconfig-2002-20261125    gcc-14.4.0
sh                    randconfig-2003-20261124    gcc-11.5.0
sh                    randconfig-2003-20261125    gcc-14.4.0
sh                    randconfig-2004-20261124    gcc-11.5.0
sh                    randconfig-2004-20261125    gcc-14.4.0
sh                    randconfig-2005-20261124    gcc-11.5.0
sh                    randconfig-2005-20261125    gcc-14.4.0
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                    randconfig-2200-20261125    gcc-14.4.0 smatch
sh                   randconfig-r2100-20261125    gcc-12.5.0 cocci
sh                   randconfig-r2103-20261124    clang-22   cocci
sh                   randconfig-r2106-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2107-20261124    gcc-15.3.0 cocci
sh                   randconfig-r2109-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2302-20261124    gcc-15.3.0 sparse
sh                   randconfig-r2305-20261124    gcc-16.2.0 sparse
sh                   randconfig-r2307-20261124    clang-24   sparse
sh                   randconfig-r2309-20261124    gcc-9.5.0  sparse
sh                            se7343_defconfig    gcc-16.2.0
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261125    gcc-12
sparc                 randconfig-1001-20261125    gcc-12
sparc                 randconfig-2000-20261124    gcc-8.5.0
sparc                 randconfig-2000-20261125    gcc-8.5.0
sparc                 randconfig-2001-20261124    gcc-8.5.0
sparc                 randconfig-2001-20261125    gcc-8.5.0
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc                 randconfig-2200-20261125    gcc-14.4.0 smatch
sparc                randconfig-r2102-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2103-20261124    clang-24   cocci
sparc                randconfig-r2104-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2108-20261124    clang-24   cocci
sparc                randconfig-r2109-20261124    clang-24   cocci
sparc                randconfig-r2301-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2302-20261125    gcc-8.5.0  sparse
sparc                randconfig-r2303-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2309-20261124    clang-24   sparse
sparc                randconfig-r2310-20261124    clang-24   sparse
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261125    gcc-12
sparc64               randconfig-1001-20261125    gcc-12
sparc64               randconfig-2000-20261124    gcc-8.5.0
sparc64               randconfig-2000-20261125    gcc-8.5.0
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2001-20261125    gcc-8.5.0
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64               randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64              randconfig-r2104-20261124    clang-24   cocci
sparc64              randconfig-r2105-20261124    gcc-9.5.0  cocci
sparc64              randconfig-r2108-20261124    gcc-14     cocci
sparc64              randconfig-r2109-20261124    clang-20   cocci
sparc64              randconfig-r2109-20261124    gcc-15.3.0 cocci
sparc64              randconfig-r2306-20261124    gcc-9.5.0  sparse
sparc64              randconfig-r2310-20261124    gcc-9.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261125    gcc-12
um                    randconfig-1001-20261125    gcc-12
um                    randconfig-2000-20261124    gcc-8.5.0
um                    randconfig-2000-20261125    gcc-8.5.0
um                    randconfig-2001-20261124    gcc-8.5.0
um                    randconfig-2001-20261125    gcc-8.5.0
um                    randconfig-2200-20261124    gcc-14     smatch
um                    randconfig-2200-20261125    clang-17   smatch
um                   randconfig-r2100-20261124    clang-22   cocci
um                   randconfig-r2101-20261124    gcc-9.5.0  cocci
um                   randconfig-r2101-20261125    gcc-12.5.0 cocci
um                   randconfig-r2102-20261124    clang-24   cocci
um                   randconfig-r2103-20261124    gcc-16.2.0 cocci
um                   randconfig-r2301-20261124    gcc-16.2.0 sparse
um                   randconfig-r2304-20261124    clang-18   sparse
um                   randconfig-r2308-20261124    clang-24   sparse
um                   randconfig-r2308-20261125    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261125    clang-22
x86_64      buildonly-randconfig-1001-20261125    clang-22
x86_64      buildonly-randconfig-1002-20261125    clang-22
x86_64      buildonly-randconfig-1003-20261125    clang-22
x86_64      buildonly-randconfig-1004-20261125    clang-22
x86_64      buildonly-randconfig-1005-20261125    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261125    clang-22
x86_64                randconfig-1001-20261125    clang-22
x86_64                randconfig-1002-20261125    clang-22
x86_64                randconfig-1003-20261125    clang-22
x86_64                randconfig-1004-20261125    clang-22
x86_64                randconfig-1005-20261125    clang-22
x86_64                randconfig-2000-20261124    gcc-14
x86_64                randconfig-2000-20261125    gcc-14
x86_64                randconfig-2001-20261124    gcc-14
x86_64                randconfig-2001-20261125    gcc-14
x86_64                randconfig-2002-20261124    gcc-14
x86_64                randconfig-2002-20261125    gcc-14
x86_64                randconfig-2003-20261124    gcc-14
x86_64                randconfig-2003-20261125    gcc-14
x86_64                randconfig-2004-20261124    gcc-14
x86_64                randconfig-2004-20261125    gcc-14
x86_64                randconfig-2005-20261124    gcc-14
x86_64                randconfig-2005-20261125    gcc-14
x86_64                randconfig-2100-20261124    gcc-14     cocci
x86_64                randconfig-2100-20261125    clang-22   cocci
x86_64                randconfig-2101-20261124    gcc-14     cocci
x86_64                randconfig-2101-20261125    clang-22   cocci
x86_64                randconfig-2102-20261124    gcc-14     cocci
x86_64                randconfig-2102-20261125    clang-22   cocci
x86_64                randconfig-2103-20261124    gcc-14     cocci
x86_64                randconfig-2103-20261125    clang-22   cocci
x86_64                randconfig-2104-20261124    gcc-14     cocci
x86_64                randconfig-2104-20261125    clang-22   cocci
x86_64                randconfig-2105-20261124    gcc-14     cocci
x86_64                randconfig-2105-20261125    clang-22   cocci
x86_64                randconfig-2200-20261124    gcc-14     smatch
x86_64                randconfig-2200-20261125    gcc-14     smatch
x86_64                randconfig-2300-20261124    gcc-14     sparse
x86_64                randconfig-2301-20261124    gcc-14     sparse
x86_64                randconfig-2302-20261124    gcc-14     sparse
x86_64               randconfig-r2109-20261124    clang-24   cocci
x86_64               randconfig-r2110-20261124    gcc-15.3.0 cocci
x86_64               randconfig-r2301-20261124    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    clang-17
xtensa                           iss_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261125    gcc-12
xtensa                randconfig-1001-20261125    gcc-12
xtensa                randconfig-2000-20261124    gcc-16.2.0
xtensa                randconfig-2001-20261124    gcc-16.2.0
xtensa                randconfig-2200-20261124    gcc-9.5.0  smatch
xtensa                randconfig-2200-20261125    gcc-16.2.0 smatch
xtensa               randconfig-r2100-20261124    gcc-16.2.0 cocci
xtensa               randconfig-r2101-20261124    gcc-16.2.0 cocci
xtensa               randconfig-r2108-20261124    clang-24   cocci
xtensa               randconfig-r2108-20261124    gcc-11.5.0 cocci
xtensa               randconfig-r2110-20261125    gcc-13.5.0 cocci
xtensa               randconfig-r2111-20261124    clang-24   cocci
xtensa               randconfig-r2301-20261124    clang-17   sparse
xtensa               randconfig-r2309-20261125    gcc-13.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
