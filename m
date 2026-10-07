Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D0475328
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368847; cv=none; b=KpFe9uRIJDfkvXHxKlkuiKU1uPfH/FJqPKSBSau8/vJ1I4Bf1MnMn+R1Rs0lXnakRSCHWyaaj3mhhhRJGA75w201svHDU6YRlWO4veMlQmVag2vJrBSbHYVqAYorsO8UL/ZJGvK0MtKlc/r8hzgcB1n5+eiFOewRiEj9sX8NZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368847; c=relaxed/simple;
	bh=/cB4wUjXtF2Yc3f9DpRSwN03kpE1GbZ1FgXfeEsx/MQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f62wXp1gPvcOdNebM0Zdk6aqCXX0ijkBqgIAsC6UOJxT71e4roj1rvaFbR5TLU8+Iyepzl2pDRNku7oJYINXDBm/c2yVSeQDOUsYYSr6NK+4eAEtr7sc8eVngW0X/jIzSENq2e2QJyIVuLSZ1uTdX2fpmWhO0TK/PjNFIMR2xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XV7lwhjc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XV7lwhjc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791368833; x=1822904833;
  h=date:from:to:cc:subject:message-id;
  bh=/cB4wUjXtF2Yc3f9DpRSwN03kpE1GbZ1FgXfeEsx/MQ=;
  b=XV7lwhjch8nzgOH+kPQnMRN4Z68Ln9ip1UbpV5UCZIRxb2wtm+HTS+Nh
   +vUoPPi0XVKSDw5dmXiBVDtp3ZCIo4YkADC0mi9rYwhN2CAgtyb6Hzmkt
   qZcLs2dTF2z9QQWA7wKMDo4hrCFcYPovcv+i2L7oWRIrw44WFDQF0a1Jz
   bDX8tOfpnMrY0JjLWQRelIwSrYPKWd30lVqRxx/p7dMjddIfE784AiFZ9
   hwITqffUVH4L22lxkQTmJC9pnwEHRG5RIrXyMlloQLZMnM8Zz/UTDGN3C
   vxnRGaifE5wUdDOp58jMRNjg3JljauYQdkP2N8L+fqGkDd/Vvc2h+M1Zq
   A==;
X-CSE-ConnectionGUID: bZX/iy4FQnisZo69a3A3WA==
X-CSE-MsgGUID: gH/lERrzTlSm1zavpPDw6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="135228"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="135228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 03:27:13 -0700
X-CSE-ConnectionGUID: 42aZhZJRRhSR/DcnlZEDPw==
X-CSE-MsgGUID: ySOp+szJSxiVAtkQqtFP3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="280648761"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:27:12 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEOrc-000000002ou-45jY;
	Wed, 07 Oct 2026 10:27:08 +0000
Date: Wed, 07 Oct 2026 18:26:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:doe] BUILD SUCCESS
 624ee129620a054466b6a29d98cd7a40ccc239cd
Message-ID: <202610071826.pAnkrfgI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
branch HEAD: 624ee129620a054466b6a29d98cd7a40ccc239cd  PCI/DOE: Fix double free of a duplicate feature's sysfs name

elapsed time: 1276m

configs tested: 368
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2103-20261006    gcc-8.5.0  cocci
alpha                randconfig-r2107-20261006    gcc-8.5.0  cocci
alpha                randconfig-r2307-20261006    clang-19   sparse
alpha                randconfig-r2308-20261006    clang-19   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261007    clang-24
arc                   randconfig-1001-20261007    clang-24
arc                  randconfig-r2202-20261006    gcc-9.5.0  smatch
arm                               alldefconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      davinci_all_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                            omap1_defconfig    gcc-16.1.0
arm                           pxa168_defconfig    gcc-16.1.0
arm                           pxa3xx_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261007    clang-24
arm                   randconfig-1001-20261007    clang-24
arm                   randconfig-1002-20261007    clang-24
arm                   randconfig-1003-20261007    clang-24
arm                  randconfig-r2104-20261006    clang-24   cocci
arm                  randconfig-r2105-20261006    clang-17   cocci
arm                  randconfig-r2105-20261006    gcc-14.3.0 cocci
arm                  randconfig-r2300-20261006    clang-18   sparse
arm                  randconfig-r2302-20261006    gcc-13.4.0 sparse
arm                  randconfig-r2303-20261006    gcc-13.4.0 sparse
arm                  randconfig-r2307-20261006    clang-22   sparse
arm                  randconfig-r2308-20261006    clang-22   sparse
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm                          wpcm450_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261007    gcc-13.4.0
arm64                 randconfig-1001-20261007    gcc-13.4.0
arm64                 randconfig-1002-20261007    gcc-13.4.0
arm64                 randconfig-1003-20261007    gcc-13.4.0
arm64                randconfig-r2104-20261006    gcc-11.5.0 cocci
arm64                randconfig-r2202-20261006    clang-17   smatch
arm64                randconfig-r2306-20261006    clang-22   sparse
arm64                randconfig-r2306-20261006    gcc-12.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261007    gcc-13.4.0
csky                  randconfig-1001-20261007    gcc-13.4.0
csky                 randconfig-r2106-20261006    gcc-8.5.0  cocci
csky                 randconfig-r2107-20261006    gcc-9.5.0  cocci
csky                 randconfig-r2201-20261006    gcc-9.5.0  smatch
csky                 randconfig-r2202-20261006    gcc-16.1.0 smatch
csky                 randconfig-r2309-20261006    gcc-14.3.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261007    gcc-12.5.0
hexagon               randconfig-1001-20261007    gcc-12.5.0
hexagon              randconfig-r2100-20261006    gcc-8.5.0  cocci
hexagon              randconfig-r2103-20261006    clang-24   cocci
hexagon              randconfig-r2104-20261006    gcc-9.5.0  cocci
hexagon              randconfig-r2106-20261006    gcc-11.5.0 cocci
hexagon              randconfig-r2301-20261006    gcc-13.4.0 sparse
hexagon              randconfig-r2304-20261006    gcc-13.4.0 sparse
hexagon              randconfig-r2304-20261006    gcc-14     sparse
hexagon              randconfig-r2305-20261006    clang-18   sparse
hexagon              randconfig-r2306-20261006    gcc-14.3.0 sparse
hexagon              randconfig-r2309-20261006    gcc-14.3.0 sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261007    gcc-14
i386        buildonly-randconfig-1001-20261007    gcc-14
i386        buildonly-randconfig-1002-20261007    gcc-14
i386        buildonly-randconfig-1003-20261007    gcc-14
i386        buildonly-randconfig-1004-20261007    gcc-14
i386        buildonly-randconfig-1005-20261007    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261007    clang-22
i386                  randconfig-1001-20261007    clang-22
i386                  randconfig-1002-20261007    clang-22
i386                  randconfig-1003-20261007    clang-22
i386                  randconfig-1004-20261007    clang-22
i386                  randconfig-1005-20261007    clang-22
i386                  randconfig-1006-20261007    clang-22
i386                  randconfig-1007-20261007    gcc-14
i386                  randconfig-1008-20261007    gcc-14
i386                  randconfig-1009-20261007    gcc-14
i386                  randconfig-1010-20261007    gcc-14
i386                  randconfig-1011-20261007    gcc-14
i386                  randconfig-1012-20261007    gcc-14
i386                  randconfig-1013-20261007    gcc-14
i386                  randconfig-2100-20261006    clang-22   cocci
i386                  randconfig-2101-20261006    clang-22   cocci
i386                  randconfig-2102-20261006    clang-22   cocci
i386                  randconfig-2103-20261006    clang-22   cocci
i386                  randconfig-2200-20261006    gcc-13     smatch
i386                  randconfig-2300-20261006    clang-22   sparse
i386                  randconfig-2300-20261006    gcc-14     sparse
i386                  randconfig-2301-20261006    gcc-14     sparse
i386                  randconfig-2302-20261006    gcc-14     sparse
i386                 randconfig-r2300-20261006    gcc-14     sparse
i386                 randconfig-r2305-20261006    gcc-13.4.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.1.0
loongarch             randconfig-1000-20261007    gcc-12.5.0
loongarch             randconfig-1001-20261007    gcc-12.5.0
loongarch            randconfig-r2101-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2102-20261006    gcc-13     cocci
loongarch            randconfig-r2104-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2106-20261006    gcc-16.1.0 cocci
loongarch            randconfig-r2200-20261006    clang-18   smatch
loongarch            randconfig-r2201-20261006    gcc-13.4.0 smatch
loongarch            randconfig-r2305-20261006    clang-24   sparse
loongarch            randconfig-r2307-20261006    gcc-14.3.0 sparse
loongarch            randconfig-r2309-20261006    clang-22   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.1.0
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                        m5282evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2105-20261006    gcc-9.5.0  cocci
m68k                 randconfig-r2107-20261006    gcc-8.5.0  cocci
m68k                 randconfig-r2201-20261006    gcc-8.5.0  smatch
m68k                 randconfig-r2202-20261006    gcc-8.5.0  smatch
m68k                 randconfig-r2300-20261006    gcc-13.4.0 sparse
m68k                 randconfig-r2304-20261006    clang-18   sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261006    clang-24   cocci
microblaze           randconfig-r2104-20261006    gcc-11.5.0 cocci
microblaze           randconfig-r2107-20261006    gcc-11.5.0 cocci
microblaze           randconfig-r2200-20261006    gcc-14.3.0 smatch
microblaze           randconfig-r2302-20261006    gcc-13.4.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                          bigsur_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
mips                 randconfig-r2105-20261006    gcc-16.1.0 cocci
mips                 randconfig-r2107-20261006    gcc-11.5.0 cocci
mips                 randconfig-r2202-20261006    gcc-13.4.0 smatch
mips                 randconfig-r2302-20261006    clang-24   sparse
mips                 randconfig-r2303-20261006    gcc-8.5.0  sparse
mips                 randconfig-r2304-20261006    gcc-13.4.0 sparse
mips                 randconfig-r2308-20261006    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261007    gcc-12.5.0
nios2                 randconfig-1001-20261007    gcc-12.5.0
nios2                randconfig-r2100-20261006    gcc-14.3.0 cocci
nios2                randconfig-r2106-20261006    gcc-11.5.0 cocci
nios2                randconfig-r2301-20261006    clang-18   sparse
nios2                randconfig-r2304-20261006    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2103-20261006    gcc-14.3.0 cocci
openrisc             randconfig-r2305-20261006    gcc-14     sparse
openrisc             randconfig-r2307-20261006    gcc-14.3.0 sparse
openrisc             randconfig-r2309-20261006    gcc-12.5.0 sparse
openrisc                        virt_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-32bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261007    gcc-15.2.0
parisc                randconfig-1001-20261007    gcc-15.2.0
parisc               randconfig-r2101-20261006    gcc-8.5.0  cocci
parisc               randconfig-r2107-20261006    gcc-14.3.0 cocci
parisc               randconfig-r2303-20261006    gcc-14     sparse
parisc               randconfig-r2305-20261006    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     ge_imp3a_defconfig    gcc-16.1.0
powerpc                         icon_defconfig    gcc-16.1.0
powerpc                  mpc8313_rdb_defconfig    gcc-16.1.0
powerpc                       pmac32_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261007    gcc-15.2.0
powerpc               randconfig-1001-20261007    gcc-15.2.0
powerpc              randconfig-r2100-20261006    clang-24   cocci
powerpc              randconfig-r2104-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2105-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2303-20261006    gcc-13.4.0 sparse
powerpc              randconfig-r2308-20261006    gcc-12.5.0 sparse
powerpc                  xes_mpc85xx_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261007    gcc-15.2.0
powerpc64             randconfig-1001-20261007    gcc-15.2.0
powerpc64            randconfig-r2102-20261006    clang-24   cocci
powerpc64            randconfig-r2103-20261006    gcc-8.5.0  cocci
powerpc64            randconfig-r2105-20261006    gcc-11.5.0 cocci
powerpc64            randconfig-r2303-20261006    clang-24   sparse
powerpc64            randconfig-r2307-20261006    clang-24   sparse
powerpc64            randconfig-r2309-20261006    gcc-14.3.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261007    clang-24
riscv                 randconfig-1001-20261007    clang-24
riscv                 randconfig-2000-20261006    gcc-16.1.0
riscv                 randconfig-2001-20261006    gcc-16.1.0
riscv                randconfig-r2100-20261006    gcc-13     cocci
riscv                randconfig-r2101-20261006    gcc-14.3.0 cocci
riscv                randconfig-r2301-20261006    gcc-13.4.0 sparse
riscv                randconfig-r2302-20261006    gcc-14     sparse
riscv                randconfig-r2303-20261006    clang-18   sparse
riscv                randconfig-r2307-20261006    gcc-12.5.0 sparse
riscv                randconfig-r2308-20261006    gcc-14.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261007    clang-24
s390                  randconfig-1001-20261007    clang-24
s390                  randconfig-2000-20261006    gcc-16.1.0
s390                  randconfig-2001-20261006    gcc-16.1.0
s390                 randconfig-r2101-20261006    gcc-13     cocci
s390                 randconfig-r2102-20261006    gcc-8.5.0  cocci
s390                 randconfig-r2106-20261006    gcc-14.3.0 cocci
s390                 randconfig-r2306-20261006    clang-19   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261007    clang-24
sh                    randconfig-1001-20261007    clang-24
sh                    randconfig-2000-20261006    gcc-16.1.0
sh                    randconfig-2001-20261006    gcc-16.1.0
sh                   randconfig-r2102-20261006    gcc-8.5.0  cocci
sh                   randconfig-r2105-20261006    gcc-11.5.0 cocci
sh                   randconfig-r2200-20261006    gcc-16.1.0 smatch
sh                   randconfig-r2201-20261006    gcc-16.1.0 smatch
sh                   randconfig-r2300-20261006    gcc-13.4.0 sparse
sh                   randconfig-r2306-20261006    clang-24   sparse
sh                           rsk7264_defconfig    gcc-16.1.0
sh                           sdk7780_defconfig    gcc-16.1.0
sh                            se7712_defconfig    gcc-16.1.0
sh                    secureedge5410_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261007    clang-17
sparc                 randconfig-1001-20261007    clang-17
sparc                 randconfig-2000-20261006    clang-24
sparc                 randconfig-2000-20261006    gcc-15.2.0
sparc                 randconfig-2001-20261006    clang-24
sparc                 randconfig-2001-20261006    gcc-16.1.0
sparc                randconfig-r2102-20261006    gcc-14.3.0 cocci
sparc                randconfig-r2104-20261006    gcc-14.3.0 cocci
sparc                randconfig-r2107-20261006    gcc-16.1.0 cocci
sparc                randconfig-r2300-20261006    clang-24   sparse
sparc                randconfig-r2301-20261006    gcc-14     sparse
sparc                randconfig-r2302-20261006    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261006    clang-24   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261007    clang-17
sparc64               randconfig-1001-20261007    clang-17
sparc64               randconfig-2000-20261006    clang-20
sparc64               randconfig-2000-20261006    clang-24
sparc64               randconfig-2001-20261006    clang-24
sparc64               randconfig-2001-20261006    gcc-8.5.0
sparc64              randconfig-r2106-20261006    gcc-14.3.0 cocci
sparc64              randconfig-r2106-20261006    gcc-9.5.0  cocci
sparc64              randconfig-r2301-20261006    gcc-8.5.0  sparse
sparc64              randconfig-r2302-20261006    clang-18   sparse
sparc64              randconfig-r2306-20261006    gcc-14.3.0 sparse
sparc64              randconfig-r2307-20261006    gcc-14.3.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261007    clang-17
um                    randconfig-1001-20261007    clang-17
um                    randconfig-2000-20261006    clang-24
um                    randconfig-2000-20261006    gcc-14
um                    randconfig-2001-20261006    clang-24
um                   randconfig-r2103-20261006    gcc-13     cocci
um                   randconfig-r2105-20261006    gcc-8.5.0  cocci
um                   randconfig-r2107-20261006    gcc-16.1.0 cocci
um                   randconfig-r2300-20261006    gcc-8.5.0  sparse
um                   randconfig-r2301-20261006    clang-24   sparse
um                   randconfig-r2309-20261006    clang-19   sparse
um                            x86_64_defconfig    gcc-14
um                            x86_64_defconfig    gcc-16.1.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261007    gcc-14
x86_64      buildonly-randconfig-1001-20261007    gcc-14
x86_64      buildonly-randconfig-1002-20261007    gcc-14
x86_64      buildonly-randconfig-1003-20261007    gcc-14
x86_64      buildonly-randconfig-1004-20261007    gcc-14
x86_64      buildonly-randconfig-1005-20261007    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261007    clang-22
x86_64                randconfig-1001-20261007    clang-22
x86_64                randconfig-1002-20261007    clang-22
x86_64                randconfig-1003-20261007    clang-22
x86_64                randconfig-1004-20261007    clang-22
x86_64                randconfig-1005-20261007    clang-22
x86_64                randconfig-1006-20261007    clang-22
x86_64                randconfig-1007-20261007    clang-22
x86_64                randconfig-1008-20261007    clang-22
x86_64                randconfig-1009-20261007    clang-22
x86_64                randconfig-1010-20261007    clang-22
x86_64                randconfig-1011-20261007    clang-22
x86_64                randconfig-1012-20261007    gcc-12
x86_64                randconfig-1013-20261007    gcc-12
x86_64                randconfig-1014-20261007    gcc-12
x86_64                randconfig-1015-20261007    gcc-12
x86_64                randconfig-1016-20261007    gcc-12
x86_64                randconfig-1017-20261007    gcc-12
x86_64                randconfig-2100-20261006    clang-22   cocci
x86_64                randconfig-2101-20261006    clang-22   cocci
x86_64                randconfig-2102-20261006    clang-22   cocci
x86_64                randconfig-2103-20261006    clang-22   cocci
x86_64                randconfig-2200-20261006    clang-22   smatch
x86_64                randconfig-2300-20261006    gcc-14     sparse
x86_64                randconfig-2301-20261006    clang-22   sparse
x86_64                randconfig-2301-20261006    gcc-14     sparse
x86_64                randconfig-2302-20261006    gcc-14     sparse
x86_64               randconfig-r2100-20261006    gcc-8.5.0  cocci
x86_64               randconfig-r2101-20261006    gcc-8.5.0  cocci
x86_64               randconfig-r2200-20261006    clang-22   smatch
x86_64               randconfig-r2201-20261006    gcc-12     smatch
x86_64               randconfig-r2304-20261006    gcc-8.5.0  sparse
x86_64               randconfig-r2305-20261006    gcc-13.4.0 sparse
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
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261007    clang-17
xtensa                randconfig-1001-20261007    clang-17
xtensa                randconfig-2000-20261006    clang-24
xtensa                randconfig-2000-20261006    gcc-9.5.0
xtensa                randconfig-2001-20261006    clang-24
xtensa               randconfig-r2102-20261006    gcc-8.5.0  cocci
xtensa               randconfig-r2202-20261006    gcc-9.5.0  smatch
xtensa               randconfig-r2306-20261006    gcc-14.3.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
