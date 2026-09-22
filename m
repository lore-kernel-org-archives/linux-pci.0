Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F34F4CF4
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115988; cv=none; b=fD8nrEYptON75R4g3eXG0leIIgDnnGQvJAJ/FxoOY/ujeN3CtmDMkZxDZH3Z856329abAyAP+i7oRi21xV/wp3dyHc21OdVxEnzlZ/POdg0iHxKJFy3qPi0QsX0qWi51EBPuha9X3JQVZ/TRy79aoUp2a0TUVDPp+BFQ6GDC2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115988; c=relaxed/simple;
	bh=wzBfi/l4ZXcc5b+lAec2UmHJDNcJOtisi+Q0Y/3Ehpw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dLIQ4d/9tM23XR/YoG40UIFl7s73mAcxW/xzFw25S6F9s6/q8/0RSjdhUCU2UzxO3ZkrZgs4KqI6crCUEEK3hZHqz568/c2aJcisv/7o/sHiRsNsBrsRWYu70lX8t9bPWx+ckICJTnl9h6QqPq2BQHDUYL7cNj0dIc9o+d4A6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+mFChnm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+mFChnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790115982; x=1821651982;
  h=date:from:to:cc:subject:message-id;
  bh=wzBfi/l4ZXcc5b+lAec2UmHJDNcJOtisi+Q0Y/3Ehpw=;
  b=C+mFChnmMyvQjf61qc1xeoP3rzrPIJtu7i6HdA+O0gPBuxDsEAmMSwkF
   vbMdn29rKPhh1QE0qyUX5+O2j4AA9OyA2T/LpF9lBWZGJjroY/8A8c3IL
   nEUQ9YbbZTkjM35ZZ6WEQk3p8MEOaXuFtJC8g0zsJ+QauYUVTBDPrUWfG
   qGuX0FKrZC07Pfj6EIgi6zwI7HYzRMr0P5qYL5bdy2ft3q5UWCR1O7iIe
   loc9+p0ACXUaddDwHViuL2pdWP0uzoVclid2xqmQGEEOD8SfZIxaEBL5Q
   CT2r4L5/4q2iaO+nvrbwMFssU4+rqk+ZZLAUfXhJu/tr11hMAoxF89QdB
   A==;
X-CSE-ConnectionGUID: Zu+vO+oYT7SKzUb/Qg0U5Q==
X-CSE-MsgGUID: X1t+JrIBRtKjE3q2VEyt+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78315502"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="78315502"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 15:26:18 -0700
X-CSE-ConnectionGUID: ggP26848QrqcmzSi8VvQ+g==
X-CSE-MsgGUID: Dqtxx+aDQvmzC2XPxzYdFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4620750"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 22 Sep 2026 15:26:16 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x98wI-00000000GAy-2SPD;
	Tue, 22 Sep 2026 22:26:14 +0000
Date: Wed, 23 Sep 2026 06:25:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-keystone] BUILD SUCCESS
 0e279797d044f1afc962bff4a76a02711525c3bc
Message-ID: <202609230632.pGLlSv6f-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-keystone
branch HEAD: 0e279797d044f1afc962bff4a76a02711525c3bc  PCI: keystone: Remove device links to PHY

elapsed time: 4760m

configs tested: 273
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                          haps_hs_defconfig    gcc-16.1.0
arc                             hsdk_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260921    gcc-9.5.0
arc                   randconfig-1000-20260923    clang-24
arc                   randconfig-1001-20260921    gcc-15.2.0
arc                   randconfig-1001-20260923    clang-24
arc                  randconfig-r1308-20260921    gcc-8.5.0  sparse
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                          bcm2835_defconfig    clang-17
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                         multi_v7_defconfig    clang-20
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20260921    clang-24
arm                   randconfig-1000-20260923    clang-24
arm                   randconfig-1001-20260921    gcc-13.4.0
arm                   randconfig-1001-20260923    clang-24
arm                   randconfig-1002-20260921    gcc-15.2.0
arm                   randconfig-1002-20260923    clang-24
arm                   randconfig-1003-20260921    clang-24
arm                   randconfig-1003-20260923    clang-24
arm                          s5pv210_defconfig    gcc-16.1.0
arm                         spear3xx_defconfig    clang-20
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260922    clang-24
arm64                 randconfig-1000-20260923    clang-24
arm64                 randconfig-1001-20260922    gcc-11.5.0
arm64                 randconfig-1001-20260923    clang-24
arm64                 randconfig-1002-20260922    gcc-9.5.0
arm64                 randconfig-1002-20260923    clang-24
arm64                 randconfig-1003-20260922    gcc-11.5.0
arm64                 randconfig-1003-20260923    clang-24
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260922    gcc-16.1.0
csky                  randconfig-1000-20260923    clang-24
csky                  randconfig-1001-20260922    gcc-12.5.0
csky                  randconfig-1001-20260923    clang-24
csky                 randconfig-r1305-20260921    gcc-12.5.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260922    clang-17
hexagon               randconfig-1000-20260923    gcc-8.5.0
hexagon               randconfig-1001-20260922    clang-17
hexagon               randconfig-1001-20260923    gcc-8.5.0
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260921    clang-22
i386        buildonly-randconfig-1001-20260921    clang-22
i386        buildonly-randconfig-1002-20260921    clang-22
i386        buildonly-randconfig-1003-20260921    clang-22
i386        buildonly-randconfig-1004-20260921    gcc-14
i386        buildonly-randconfig-1005-20260921    clang-22
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260921    clang-22
i386                  randconfig-1001-20260921    clang-22
i386                  randconfig-1002-20260921    clang-22
i386                  randconfig-1003-20260921    gcc-14
i386                  randconfig-1004-20260921    gcc-13
i386                  randconfig-1005-20260921    clang-22
i386                  randconfig-1006-20260921    clang-22
i386                  randconfig-1007-20260921    gcc-14
i386                  randconfig-1007-20260923    gcc-14
i386                  randconfig-1008-20260921    clang-22
i386                  randconfig-1008-20260923    gcc-14
i386                  randconfig-1009-20260921    gcc-14
i386                  randconfig-1009-20260923    gcc-14
i386                  randconfig-1010-20260921    gcc-14
i386                  randconfig-1010-20260923    gcc-14
i386                  randconfig-1011-20260921    clang-22
i386                  randconfig-1011-20260923    gcc-14
i386                  randconfig-1012-20260921    clang-22
i386                  randconfig-1012-20260923    gcc-14
i386                  randconfig-1013-20260921    clang-22
i386                  randconfig-1013-20260923    gcc-14
i386                  randconfig-1300-20260922    clang-22   sparse
i386                  randconfig-1301-20260922    clang-22   sparse
i386                  randconfig-1302-20260922    gcc-14     sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260922    gcc-16.1.0
loongarch             randconfig-1000-20260923    gcc-8.5.0
loongarch             randconfig-1001-20260922    clang-18
loongarch             randconfig-1001-20260923    gcc-8.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                         m5307c3_defconfig    gcc-16.1.0
m68k                        m5475evb_defconfig    clang-20
m68k                         mvme147_defconfig    gcc-16.1.0
m68k                 randconfig-r1306-20260921    gcc-15.2.0 sparse
m68k                 randconfig-r1309-20260921    gcc-13.4.0 sparse
microblaze                        alldefconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    clang-24
mips                        bmips_be_defconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                         qi_lb60_defconfig    clang-24
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260922    gcc-10.5.0
nios2                 randconfig-1000-20260923    gcc-8.5.0
nios2                 randconfig-1001-20260922    gcc-11.5.0
nios2                 randconfig-1001-20260923    gcc-8.5.0
nios2                randconfig-r1304-20260921    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
parisc                            alldefconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1000-20260923    clang-22
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc                randconfig-1001-20260923    clang-22
parisc               randconfig-r1301-20260921    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                      mpc83xx_defconfig    clang-24
powerpc                       ppc44x_defconfig    clang-17
powerpc                      rainier_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1000-20260923    clang-22
powerpc               randconfig-1001-20260921    clang-24
powerpc               randconfig-1001-20260923    clang-22
powerpc                     socrates_defconfig    clang-24
powerpc                   storcenter_defconfig    clang-20
powerpc                      tqm8540_defconfig    gcc-16.1.0
powerpc                       tqm8xx_defconfig    clang-20
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1000-20260923    clang-22
powerpc64             randconfig-1001-20260921    gcc-8.5.0
powerpc64             randconfig-1001-20260923    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260921    gcc-12.5.0
riscv                 randconfig-1000-20260923    gcc-16.1.0
riscv                 randconfig-1001-20260921    gcc-8.5.0
riscv                 randconfig-1001-20260923    gcc-16.1.0
riscv                randconfig-r1302-20260921    clang-17   sparse
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260921    clang-24
s390                  randconfig-1000-20260923    gcc-16.1.0
s390                  randconfig-1001-20260921    clang-24
s390                  randconfig-1001-20260923    gcc-16.1.0
s390                 randconfig-r1307-20260921    clang-17   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                          ecovec24_defconfig    clang-24
sh                           r7785rp_defconfig    clang-20
sh                    randconfig-1000-20260921    gcc-9.5.0
sh                    randconfig-1000-20260923    gcc-16.1.0
sh                    randconfig-1001-20260921    gcc-16.1.0
sh                    randconfig-1001-20260923    gcc-16.1.0
sh                            se7343_defconfig    clang-20
sh                            se7722_defconfig    gcc-16.1.0
sparc                             alldefconfig    clang-20
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260921    gcc-8.5.0
sparc                 randconfig-1001-20260921    gcc-11.5.0
sparc                randconfig-r1303-20260921    gcc-16.1.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260921    clang-21
sparc64               randconfig-1001-20260921    clang-22
sparc64              randconfig-r1300-20260921    gcc-10.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260921    gcc-14
um                    randconfig-1001-20260921    gcc-14
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260921    clang-22
x86_64      buildonly-randconfig-1000-20260923    gcc-14
x86_64      buildonly-randconfig-1001-20260921    gcc-13
x86_64      buildonly-randconfig-1001-20260923    gcc-14
x86_64      buildonly-randconfig-1002-20260921    clang-22
x86_64      buildonly-randconfig-1002-20260923    gcc-14
x86_64      buildonly-randconfig-1003-20260921    clang-22
x86_64      buildonly-randconfig-1003-20260923    gcc-14
x86_64      buildonly-randconfig-1004-20260921    clang-22
x86_64      buildonly-randconfig-1004-20260923    gcc-14
x86_64      buildonly-randconfig-1005-20260921    clang-22
x86_64      buildonly-randconfig-1005-20260923    gcc-14
x86_64                               defconfig    gcc-14
x86_64                randconfig-1000-20260921    gcc-13
x86_64                randconfig-1001-20260921    clang-22
x86_64                randconfig-1002-20260921    gcc-14
x86_64                randconfig-1003-20260921    gcc-14
x86_64                randconfig-1004-20260921    clang-22
x86_64                randconfig-1005-20260921    clang-22
x86_64                randconfig-1006-20260921    gcc-14
x86_64                randconfig-1007-20260921    clang-22
x86_64                randconfig-1008-20260921    clang-22
x86_64                randconfig-1009-20260921    clang-22
x86_64                randconfig-1010-20260921    gcc-14
x86_64                randconfig-1011-20260921    clang-22
x86_64                randconfig-1012-20260921    clang-22
x86_64                randconfig-1013-20260921    clang-22
x86_64                randconfig-1014-20260921    clang-22
x86_64                randconfig-1015-20260921    clang-22
x86_64                randconfig-1016-20260921    clang-22
x86_64                randconfig-1017-20260921    gcc-12
x86_64                randconfig-1300-20260922    gcc-13     sparse
x86_64                randconfig-1301-20260922    gcc-13     sparse
x86_64                randconfig-1302-20260922    clang-22   sparse
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260921    gcc-11.5.0
xtensa                randconfig-1001-20260921    gcc-9.5.0
xtensa                     xip_kc705_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
