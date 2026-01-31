Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D036921C
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886388; cv=none; b=FfVnCpYyXyj8C6TlE0Q4uLHFVa7RXW4XlpGRak9OdZBQPAA/xlZj/i1+LKB8d88n34PSFdrZBjjfSFBPYPkVVCmx89ZoAPT2NdMtbsTHPzy853H5kH2BwcU0M36RzWuVoh/qlhuI42SDuf27fq5ZwNTXxOxOG8xLU3pPlV4EX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886388; c=relaxed/simple;
	bh=DxTvXhEQ57Jw8Ayy01/3xOzq3bNFP9wrNRuWavpI+ls=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jv+a0X5YhlyJICDcvFcWPV8eUFcSSaJ7kosqbIFBRVyYWfo6bQdaqSgiVzuUAhp+2A/RJ30IgX9HjIQ2Vi46CYCd4wwqGDzptMc1TQGNace/dYfoHfolV1x4R8Zb3bxe7Vo81eXB3wVvPMtRzX1hiP5+fS67Z0d55mln//2PksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzJIoRAu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzJIoRAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769886387; x=1801422387;
  h=date:from:to:cc:subject:message-id;
  bh=DxTvXhEQ57Jw8Ayy01/3xOzq3bNFP9wrNRuWavpI+ls=;
  b=ZzJIoRAuXJE5CAYhKXI54jf/wE9ZfXeRghhNuFXEY6Eq+ZKK20JYhoXR
   k+lZB6HM22boNlJDeRpY1nH3G62aAFb+d+2vQgBo01LN8W6KgDiY7LfQl
   sxrJvtha5ITsTlds1Jd2fs/ZY6DVTcrLUbHKy42mUR5kfiC25XT/Hk+0w
   kkG++VVTLAETgwb2Sz16W5IfzFHXUrXbDjjBo9pPUsm7tuMGo78M8TDfV
   WP0ON5bJDuf7EOuSBcj0Q3hWBhzBjht+r0ggcFW53jgzNKgjNbcStrfgU
   y0uxrKdM+B+GEf13tycE0UUIN4gw8Fhz9mElIPG636xI1stt2ED4TUwhB
   g==;
X-CSE-ConnectionGUID: 1fBlto33RYKzb8XbiUgblg==
X-CSE-MsgGUID: 9Re7wub0TTqfXWq2nKPsfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="71003694"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="71003694"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 11:06:27 -0800
X-CSE-ConnectionGUID: JazzxTDDQiuzUI/aG+KQcw==
X-CSE-MsgGUID: h/MqaCwxQRG/afKADbNysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="209043334"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Jan 2026 11:06:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmGIY-00000000eJQ-2bCB;
	Sat, 31 Jan 2026 19:06:22 +0000
Date: Sun, 01 Feb 2026 03:05:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
Message-ID: <202602010332.eiWyl6zT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba  Merge branch 'pci/misc'

elapsed time: 1117m

configs tested: 164
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260131    gcc-10.5.0
arc                   randconfig-002-20260131    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260131    clang-22
arm                   randconfig-002-20260131    gcc-8.5.0
arm                   randconfig-003-20260131    gcc-8.5.0
arm                   randconfig-004-20260131    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260131    gcc-12.5.0
arm64                 randconfig-002-20260131    clang-22
arm64                 randconfig-003-20260131    clang-22
arm64                 randconfig-004-20260131    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260131    gcc-14.3.0
csky                  randconfig-002-20260131    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20260131    clang-22
hexagon               randconfig-002-20260131    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260131    gcc-14
i386        buildonly-randconfig-002-20260131    gcc-14
i386        buildonly-randconfig-003-20260131    gcc-14
i386        buildonly-randconfig-004-20260131    gcc-14
i386        buildonly-randconfig-005-20260131    clang-20
i386        buildonly-randconfig-006-20260131    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20260131    gcc-14
i386                  randconfig-002-20260131    gcc-14
i386                  randconfig-003-20260131    gcc-12
i386                  randconfig-004-20260131    clang-20
i386                  randconfig-005-20260131    gcc-14
i386                  randconfig-006-20260131    gcc-14
i386                  randconfig-007-20260131    gcc-14
i386                  randconfig-011-20260131    gcc-14
i386                  randconfig-012-20260131    clang-20
i386                  randconfig-013-20260131    gcc-14
i386                  randconfig-014-20260131    gcc-14
i386                  randconfig-015-20260131    gcc-14
i386                  randconfig-016-20260131    gcc-14
i386                  randconfig-017-20260131    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260131    clang-22
loongarch             randconfig-002-20260131    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260131    gcc-10.5.0
nios2                 randconfig-002-20260131    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260131    gcc-8.5.0
parisc                randconfig-002-20260131    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260131    gcc-9.5.0
powerpc               randconfig-002-20260131    gcc-8.5.0
powerpc64             randconfig-001-20260131    gcc-8.5.0
powerpc64             randconfig-002-20260131    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260131    gcc-8.5.0
riscv                 randconfig-002-20260131    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260131    gcc-8.5.0
s390                  randconfig-002-20260131    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260131    gcc-9.5.0
sh                    randconfig-002-20260131    gcc-15.2.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7712_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260131    gcc-15.2.0
sparc                 randconfig-002-20260131    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260131    clang-22
sparc64               randconfig-002-20260131    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260131    gcc-14
um                    randconfig-002-20260131    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260131    gcc-14
x86_64      buildonly-randconfig-002-20260131    gcc-14
x86_64      buildonly-randconfig-003-20260131    gcc-14
x86_64      buildonly-randconfig-004-20260131    gcc-14
x86_64      buildonly-randconfig-005-20260131    gcc-14
x86_64      buildonly-randconfig-006-20260131    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260131    clang-20
x86_64                randconfig-002-20260131    clang-20
x86_64                randconfig-003-20260131    clang-20
x86_64                randconfig-004-20260131    gcc-13
x86_64                randconfig-005-20260131    clang-20
x86_64                randconfig-006-20260131    clang-20
x86_64                randconfig-011-20260131    gcc-12
x86_64                randconfig-012-20260131    clang-20
x86_64                randconfig-013-20260131    gcc-14
x86_64                randconfig-014-20260131    gcc-14
x86_64                randconfig-015-20260131    gcc-14
x86_64                randconfig-016-20260131    clang-20
x86_64                randconfig-071-20260131    gcc-14
x86_64                randconfig-072-20260131    clang-20
x86_64                randconfig-073-20260131    gcc-14
x86_64                randconfig-074-20260131    clang-20
x86_64                randconfig-075-20260131    gcc-14
x86_64                randconfig-076-20260131    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260131    gcc-14.3.0
xtensa                randconfig-002-20260131    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
