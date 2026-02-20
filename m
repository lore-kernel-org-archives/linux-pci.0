Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D033507D
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574647; cv=none; b=TEoiOPLrd0FUe2lMxjf6jkzr1KZpB44YgOYKMmDOdQVJZLyiSU5+UsJ3IIQqaGkkeoV1TQSZ/j50l0E2OSaNaDYKOLmb9A8cJPPaEVm3feDD/jZ32QOW7kEz85jz0gzt9PuPiOlKYjxJkRukMM3u8lg+v4E3/ySrtm+ouw+qgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574647; c=relaxed/simple;
	bh=Xz+OunQRW+nsLY6g+lRdTbnvCl6owBNJel8rP9jKy3M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LTu2RY4+NB6MMjeKdwVIEUXFokn09p4MYgSk7NaZW6gmgBbi9W0IrmCto3WGL4+rjEFHsUAcZibtT9sJzRAdl5wumTd8xduyx5WK6ZCmf3DUB0RRx5ksC7RRhY9Hs6Xy0isdCjOLFPcfZ9dxf+UqImwVnii/CsQpOnkCI5IGKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gve+jyWc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gve+jyWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771574646; x=1803110646;
  h=date:from:to:cc:subject:message-id;
  bh=Xz+OunQRW+nsLY6g+lRdTbnvCl6owBNJel8rP9jKy3M=;
  b=gve+jyWcfsQFS/D77L+JHa6YF6mRITxWbvm9qx7J9Hv4sBCwEdn+gKHL
   uC3PGj/6khJRv45F4w7JlNP1WwNvS8ShU0bkMHLoQ/Cm4Eo0kVwJ1epuo
   Jsc0bwkOXTOXPeVW4C2tbbQ7eC2Rz0qfAF7iu/nSzBEF+/TNRwcKOYw6D
   zkcwY5cWFGAiN6WpWFqGSTlvLd7F16TWg9WYrFBjLlXrJlW5Rg/4LQ5IF
   4FccypKaaKZDONJGvr1LnktsMWELdrjkHVISLTsnvhFdxeWRLPCTYz8r5
   PBKSVyFvBY4ORV3plNQjn/JsyXN89VLt7W0/Uz7RyPmhq2JvrrXLSgivR
   Q==;
X-CSE-ConnectionGUID: 0DqRnGODQmmEAaP20D2MeA==
X-CSE-MsgGUID: 5UapBtzuSfSfSk/esAhS1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83293614"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="83293614"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:04:05 -0800
X-CSE-ConnectionGUID: y8MXnspeS92IazmolF5/ow==
X-CSE-MsgGUID: 3f9NUAqATKa1E9lhr8EVfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213352613"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Feb 2026 00:04:04 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtLUX-000000013vT-2iJd;
	Fri, 20 Feb 2026 08:04:01 +0000
Date: Fri, 20 Feb 2026 16:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 8d275a84f0d117c0e68b9fe997b6b82885d5ca3c
Message-ID: <202602201640.o0fcD0Jh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 8d275a84f0d117c0e68b9fe997b6b82885d5ca3c  PCI: dwc: ep: Always clear IB maps on BAR update

elapsed time: 730m

configs tested: 245
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260220    gcc-8.5.0
arc                   randconfig-002-20260220    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                   randconfig-001-20260220    gcc-8.5.0
arm                   randconfig-002-20260220    gcc-8.5.0
arm                   randconfig-003-20260220    gcc-8.5.0
arm                   randconfig-004-20260220    gcc-8.5.0
arm                           sunxi_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260220    gcc-8.5.0
arm64                 randconfig-002-20260220    gcc-12.5.0
arm64                 randconfig-002-20260220    gcc-8.5.0
arm64                 randconfig-003-20260220    gcc-8.5.0
arm64                 randconfig-003-20260220    gcc-9.5.0
arm64                 randconfig-004-20260220    clang-16
arm64                 randconfig-004-20260220    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260220    gcc-15.2.0
csky                  randconfig-001-20260220    gcc-8.5.0
csky                  randconfig-002-20260220    gcc-15.2.0
csky                  randconfig-002-20260220    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260220    clang-17
hexagon               randconfig-001-20260220    clang-23
hexagon               randconfig-002-20260220    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260220    clang-20
i386        buildonly-randconfig-002-20260220    clang-20
i386        buildonly-randconfig-002-20260220    gcc-14
i386        buildonly-randconfig-003-20260220    clang-20
i386        buildonly-randconfig-004-20260220    clang-20
i386        buildonly-randconfig-004-20260220    gcc-13
i386        buildonly-randconfig-005-20260220    clang-20
i386        buildonly-randconfig-006-20260220    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260220    clang-20
i386                  randconfig-002-20260220    clang-20
i386                  randconfig-003-20260220    clang-20
i386                  randconfig-003-20260220    gcc-14
i386                  randconfig-004-20260220    clang-20
i386                  randconfig-004-20260220    gcc-13
i386                  randconfig-005-20260220    clang-20
i386                  randconfig-006-20260220    clang-20
i386                  randconfig-006-20260220    gcc-14
i386                  randconfig-007-20260220    clang-20
i386                  randconfig-011-20260220    gcc-14
i386                  randconfig-012-20260220    gcc-14
i386                  randconfig-013-20260220    gcc-14
i386                  randconfig-014-20260220    gcc-14
i386                  randconfig-015-20260220    gcc-14
i386                  randconfig-016-20260220    gcc-14
i386                  randconfig-017-20260220    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260220    clang-23
loongarch             randconfig-002-20260220    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260220    clang-23
nios2                 randconfig-001-20260220    gcc-9.5.0
nios2                 randconfig-002-20260220    clang-23
nios2                 randconfig-002-20260220    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260220    clang-23
parisc                randconfig-001-20260220    gcc-8.5.0
parisc                randconfig-002-20260220    clang-23
parisc                randconfig-002-20260220    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        cell_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260220    clang-23
powerpc               randconfig-001-20260220    gcc-13.4.0
powerpc               randconfig-002-20260220    clang-23
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260220    clang-23
powerpc64             randconfig-001-20260220    gcc-10.5.0
powerpc64             randconfig-002-20260220    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260220    gcc-11.5.0
riscv                 randconfig-002-20260220    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260220    gcc-11.5.0
s390                  randconfig-002-20260220    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                    randconfig-001-20260220    gcc-11.5.0
sh                    randconfig-002-20260220    gcc-11.5.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260220    clang-20
sparc                 randconfig-002-20260220    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260220    clang-20
sparc64               randconfig-002-20260220    clang-20
um                               alldefconfig    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260220    clang-20
um                    randconfig-002-20260220    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260220    clang-20
x86_64      buildonly-randconfig-002-20260220    clang-20
x86_64      buildonly-randconfig-003-20260220    clang-20
x86_64      buildonly-randconfig-004-20260220    clang-20
x86_64      buildonly-randconfig-005-20260220    clang-20
x86_64      buildonly-randconfig-005-20260220    gcc-14
x86_64      buildonly-randconfig-006-20260220    clang-20
x86_64      buildonly-randconfig-006-20260220    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260220    gcc-14
x86_64                randconfig-002-20260220    gcc-14
x86_64                randconfig-003-20260220    gcc-14
x86_64                randconfig-004-20260220    gcc-14
x86_64                randconfig-005-20260220    gcc-14
x86_64                randconfig-006-20260220    gcc-14
x86_64                randconfig-011-20260220    clang-20
x86_64                randconfig-011-20260220    gcc-14
x86_64                randconfig-012-20260220    clang-20
x86_64                randconfig-012-20260220    gcc-14
x86_64                randconfig-013-20260220    clang-20
x86_64                randconfig-013-20260220    gcc-14
x86_64                randconfig-014-20260220    gcc-14
x86_64                randconfig-015-20260220    clang-20
x86_64                randconfig-015-20260220    gcc-14
x86_64                randconfig-016-20260220    gcc-14
x86_64                randconfig-071-20260220    gcc-13
x86_64                randconfig-071-20260220    gcc-14
x86_64                randconfig-072-20260220    clang-20
x86_64                randconfig-072-20260220    gcc-14
x86_64                randconfig-073-20260220    gcc-14
x86_64                randconfig-074-20260220    clang-20
x86_64                randconfig-074-20260220    gcc-14
x86_64                randconfig-075-20260220    clang-20
x86_64                randconfig-075-20260220    gcc-14
x86_64                randconfig-076-20260220    clang-20
x86_64                randconfig-076-20260220    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260220    clang-20
xtensa                randconfig-002-20260220    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
