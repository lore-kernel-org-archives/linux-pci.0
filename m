Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15375801
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002176; cv=none; b=Nm7ESqEG5HYND27crzuvzHo7z/tWm4nutuO7b+G1Tk5tMmmGNxSErhPsTjL1an6Rw5SiGKpDDfopT7KjQEku5f4NR24ST96RsYQal0J/nWQAevoBEW+/MRu6Qn8e4QMQqAihzCJK99mwMGZbnzxeFjo2s9P5RAnacANp9DBvOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002176; c=relaxed/simple;
	bh=6wi0htUCLto2TPn6lh8sQaRUqNsjV+sjAXwTdvXRj2A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ixJ3CpAgfjHXOtZJGqQ+WqX5Z3tLodseBiLm/rnSyyhIf4wdpyJHXWH8StB2D0eM3L2+hda7N+hnbRPs1lt43mV5BEfe8ZjdTVvSam3TWZofLxTwkno6Gt35qC826/kxcpBpnX7e9CR18EMjP0NafYsHCPlUp8Apl+xYH9IHT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB5GrJ23; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB5GrJ23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772002173; x=1803538173;
  h=date:from:to:cc:subject:message-id;
  bh=6wi0htUCLto2TPn6lh8sQaRUqNsjV+sjAXwTdvXRj2A=;
  b=FB5GrJ23bBzJnghp5Ek3Dndbz6V9qRfzKu61JAMHm8L5PPmcAYW9WkdL
   +RUJaVLk3xEyaDgU9I7GULkPsk84BjbF9QFJVt6+ZzAklJ1Cqr3vUAGhU
   6vHDheBC6E6S9Izc4a6naQYvEEXVq+9Sry2vHJ6pEM9zHUetdXOO8Fyrq
   A8qYpUdMcp36geT5GvHUARqGulCQFtwIukIrLNRZulz16EfYFXCrvsOR3
   pfW2cd7q4za7jzRRGbgKXKcrM1TTucyWbu7hcDTCdmpngI3ChjYF2KoVx
   AO8xaxdhwGmaQXpfydSBFiDp6+jcYehoAlgEAcRqp8SxZjWd2Mi1SPLHk
   g==;
X-CSE-ConnectionGUID: UHKVXJILRGaG0KmYt+V4Fw==
X-CSE-MsgGUID: ZhCFruVmT/al0cUn5rYPGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73006435"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73006435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 22:49:32 -0800
X-CSE-ConnectionGUID: XM6cFi8jSiahqtxb4utv6Q==
X-CSE-MsgGUID: SAhwh/7eRba0DZzY9/fDOw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Feb 2026 22:49:31 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vv8hw-0000000042N-3Mmv;
	Wed, 25 Feb 2026 06:49:22 +0000
Date: Wed, 25 Feb 2026 14:44:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:ptm] BUILD SUCCESS
 4bd6ca14dab60334b2dbfb6b157bd3dc85bb3ad2
Message-ID: <202602251404.okd4S8ta-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ptm
branch HEAD: 4bd6ca14dab60334b2dbfb6b157bd3dc85bb3ad2  PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports

elapsed time: 803m

configs tested: 293
configs skipped: 6

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
arc                   randconfig-001-20260225    gcc-8.5.0
arc                   randconfig-002-20260225    gcc-15.2.0
arc                   randconfig-002-20260225    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     am200epdkit_defconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    clang-23
arm                   randconfig-001-20260225    clang-23
arm                   randconfig-001-20260225    gcc-8.5.0
arm                   randconfig-002-20260225    gcc-8.5.0
arm                   randconfig-003-20260225    clang-23
arm                   randconfig-003-20260225    gcc-8.5.0
arm                   randconfig-004-20260225    gcc-14.3.0
arm                   randconfig-004-20260225    gcc-8.5.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260225    gcc-9.5.0
arm64                 randconfig-002-20260225    clang-23
arm64                 randconfig-002-20260225    gcc-9.5.0
arm64                 randconfig-003-20260225    gcc-13.4.0
arm64                 randconfig-003-20260225    gcc-9.5.0
arm64                 randconfig-004-20260225    gcc-12.5.0
arm64                 randconfig-004-20260225    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260225    gcc-14.3.0
csky                  randconfig-001-20260225    gcc-9.5.0
csky                  randconfig-002-20260225    gcc-13.4.0
csky                  randconfig-002-20260225    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260225    clang-23
hexagon               randconfig-002-20260225    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260225    clang-20
i386        buildonly-randconfig-002-20260225    clang-20
i386        buildonly-randconfig-003-20260225    clang-20
i386        buildonly-randconfig-003-20260225    gcc-14
i386        buildonly-randconfig-004-20260225    clang-20
i386        buildonly-randconfig-005-20260225    clang-20
i386        buildonly-randconfig-006-20260225    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260225    clang-20
i386                  randconfig-001-20260225    gcc-14
i386                  randconfig-002-20260225    gcc-14
i386                  randconfig-003-20260225    clang-20
i386                  randconfig-003-20260225    gcc-14
i386                  randconfig-004-20260225    gcc-14
i386                  randconfig-005-20260225    clang-20
i386                  randconfig-005-20260225    gcc-14
i386                  randconfig-006-20260225    clang-20
i386                  randconfig-006-20260225    gcc-14
i386                  randconfig-007-20260225    gcc-14
i386                  randconfig-011-20260225    gcc-13
i386                  randconfig-012-20260225    gcc-13
i386                  randconfig-013-20260225    gcc-13
i386                  randconfig-014-20260225    gcc-13
i386                  randconfig-015-20260225    gcc-13
i386                  randconfig-016-20260225    gcc-13
i386                  randconfig-017-20260225    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260225    clang-23
loongarch             randconfig-001-20260225    gcc-13.4.0
loongarch             randconfig-002-20260225    clang-23
loongarch             randconfig-002-20260225    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    gcc-15.2.0
m68k                            mac_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                       lemote2f_defconfig    gcc-15.2.0
mips                      loongson3_defconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-23
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260225    clang-23
nios2                 randconfig-001-20260225    gcc-8.5.0
nios2                 randconfig-002-20260225    clang-23
nios2                 randconfig-002-20260225    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260225    clang-19
parisc                randconfig-001-20260225    gcc-15.2.0
parisc                randconfig-002-20260225    clang-19
parisc                randconfig-002-20260225    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    gcc-15.2.0
powerpc                     asp8347_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                 mpc8315_rdb_defconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    gcc-15.2.0
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260225    clang-19
powerpc               randconfig-001-20260225    gcc-12.5.0
powerpc               randconfig-002-20260225    clang-19
powerpc                     skiroot_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260225    clang-19
powerpc64             randconfig-001-20260225    clang-23
powerpc64             randconfig-002-20260225    clang-19
powerpc64             randconfig-002-20260225    gcc-15.2.0
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260225    clang-23
riscv                 randconfig-001-20260225    gcc-12.5.0
riscv                 randconfig-002-20260225    gcc-12.5.0
riscv                 randconfig-002-20260225    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260225    gcc-12.5.0
s390                  randconfig-001-20260225    gcc-8.5.0
s390                  randconfig-002-20260225    clang-23
s390                  randconfig-002-20260225    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-23
sh                         ecovec24_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                    randconfig-001-20260225    gcc-12.5.0
sh                    randconfig-002-20260225    gcc-12.5.0
sh                    randconfig-002-20260225    gcc-14.3.0
sh                      rts7751r2d1_defconfig    clang-23
sh                   rts7751r2dplus_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    clang-23
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260225    gcc-11.5.0
sparc                 randconfig-002-20260225    gcc-11.5.0
sparc                 randconfig-002-20260225    gcc-12.5.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260225    clang-20
sparc64               randconfig-001-20260225    gcc-11.5.0
sparc64               randconfig-002-20260225    gcc-11.5.0
um                               alldefconfig    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260225    clang-18
um                    randconfig-001-20260225    gcc-11.5.0
um                    randconfig-002-20260225    clang-23
um                    randconfig-002-20260225    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260225    clang-20
x86_64      buildonly-randconfig-002-20260225    clang-20
x86_64      buildonly-randconfig-002-20260225    gcc-14
x86_64      buildonly-randconfig-003-20260225    clang-20
x86_64      buildonly-randconfig-003-20260225    gcc-14
x86_64      buildonly-randconfig-004-20260225    clang-20
x86_64      buildonly-randconfig-005-20260225    clang-20
x86_64      buildonly-randconfig-005-20260225    gcc-12
x86_64      buildonly-randconfig-006-20260225    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260225    gcc-13
x86_64                randconfig-001-20260225    gcc-14
x86_64                randconfig-002-20260225    clang-20
x86_64                randconfig-002-20260225    gcc-14
x86_64                randconfig-003-20260225    gcc-14
x86_64                randconfig-004-20260225    gcc-14
x86_64                randconfig-005-20260225    gcc-14
x86_64                randconfig-006-20260225    gcc-14
x86_64                randconfig-011-20260225    gcc-14
x86_64                randconfig-012-20260225    clang-20
x86_64                randconfig-012-20260225    gcc-14
x86_64                randconfig-013-20260225    clang-20
x86_64                randconfig-013-20260225    gcc-14
x86_64                randconfig-014-20260225    gcc-14
x86_64                randconfig-015-20260225    gcc-14
x86_64                randconfig-016-20260225    gcc-14
x86_64                randconfig-071-20260225    clang-20
x86_64                randconfig-072-20260225    clang-20
x86_64                randconfig-073-20260225    clang-20
x86_64                randconfig-074-20260225    clang-20
x86_64                randconfig-074-20260225    gcc-14
x86_64                randconfig-075-20260225    clang-20
x86_64                randconfig-075-20260225    gcc-14
x86_64                randconfig-076-20260225    clang-20
x86_64                randconfig-076-20260225    gcc-14
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
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260225    gcc-11.5.0
xtensa                randconfig-001-20260225    gcc-14.3.0
xtensa                randconfig-002-20260225    gcc-11.5.0
xtensa                randconfig-002-20260225    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
