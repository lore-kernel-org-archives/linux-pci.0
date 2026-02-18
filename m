Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6F285CAD
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405126; cv=none; b=FyA/S/FJNsLAWwF5HNZ+knknLuSuXamv+7aqQwHnWrlb4pZMV0ISaRDvRNCdgdvOCS+GkHBhHWa4WEAwrxwQ9MwDHFF9Xohgd+063nAephwt8axlglhrTkd21dZZwHyGxILa9V7CCGvh0fD1xChWs1TT4L930wi55eLPfwrQmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405126; c=relaxed/simple;
	bh=FwCyi8+UpXRV2XJ3n60unAraNd2Kv5Hb7PIFy8eMQss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dtOcuKMicBm+LuGQ/Ww+eN4JlDnsy9gnl5v4ywiEo97pox2XsUtMgl2TsgjGOgZEshqNkifAxwLtR5KoiJnkWpS4uOaGesAJiR2NbYNCMo7N15JVGoanWpWCBRbFmGP4yI15z51en78rvf79QXmPmFZ9Vmu5ppHrdmqGovtjLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWCCFwHC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWCCFwHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771405125; x=1802941125;
  h=date:from:to:cc:subject:message-id;
  bh=FwCyi8+UpXRV2XJ3n60unAraNd2Kv5Hb7PIFy8eMQss=;
  b=iWCCFwHCV4LpqNR/AvsOzUVGPH3oO4fyMD341EPPX3Ndjd2yxNsMwckH
   B/aMhZ3WdMezRCOdoyaPwz1jichxT6kYYls0YZNS0EgaqNCjrJSQ+LjHg
   G0pxH9yzYMTGIwKRfInBC6Ih2pnEAshcoJc26RaqzqYXrgUcwRFoX6JZ3
   0GGuX597zOLV7D7V01FmValJaR5dZ3As0/UPjppIDibNdKipONDPd4eeG
   J0maOYGsa/d+VeDFSPjXUI7oh1y+Jq5TBCTjMyZ41vob06D0nagkfBxxP
   qMdIBpTYouaDFLkXZfbTdbBdTGo8bm8bVi/qfl0FFqBsm4wX3rdk27n7Z
   Q==;
X-CSE-ConnectionGUID: jm0MTMMGSLSZcDSy0+o2PA==
X-CSE-MsgGUID: oXfZBZ+QQoeUs8FkeuFzYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="90063174"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="90063174"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 00:58:44 -0800
X-CSE-ConnectionGUID: vv7HSNJnRNOs5xxGoQ7yVg==
X-CSE-MsgGUID: oeYsA7BURouSgTzVMXnrag==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2026 00:58:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsdOK-000000012DE-3oeG;
	Wed, 18 Feb 2026 08:58:40 +0000
Date: Wed, 18 Feb 2026 16:58:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 60c6a34d21504fb9182917f3b0667a473343befb
Message-ID: <202602181611.z4qRSGdf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: 60c6a34d21504fb9182917f3b0667a473343befb  PCI/ASPM: Fix pci_clear_and_set_config_dword() usage

elapsed time: 985m

configs tested: 261
configs skipped: 3

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
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260218    clang-23
arc                   randconfig-002-20260218    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                            hisi_defconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-23
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-23
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260218    clang-23
arm                   randconfig-002-20260218    clang-23
arm                   randconfig-003-20260218    clang-23
arm                   randconfig-004-20260218    clang-23
arm                         socfpga_defconfig    clang-23
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260218    clang-23
arm64                 randconfig-001-20260218    gcc-8.5.0
arm64                 randconfig-002-20260218    clang-23
arm64                 randconfig-003-20260218    clang-23
arm64                 randconfig-003-20260218    gcc-14.3.0
arm64                 randconfig-004-20260218    clang-23
arm64                 randconfig-004-20260218    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260218    clang-23
csky                  randconfig-001-20260218    gcc-15.2.0
csky                  randconfig-002-20260218    clang-23
csky                  randconfig-002-20260218    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260218    clang-16
hexagon               randconfig-002-20260218    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260218    clang-20
i386        buildonly-randconfig-002-20260218    clang-20
i386        buildonly-randconfig-003-20260218    clang-20
i386        buildonly-randconfig-004-20260218    clang-20
i386        buildonly-randconfig-004-20260218    gcc-13
i386        buildonly-randconfig-005-20260218    clang-20
i386        buildonly-randconfig-006-20260218    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260218    clang-20
i386                  randconfig-002-20260218    clang-20
i386                  randconfig-003-20260218    clang-20
i386                  randconfig-004-20260218    clang-20
i386                  randconfig-005-20260218    clang-20
i386                  randconfig-006-20260218    clang-20
i386                  randconfig-007-20260218    clang-20
i386                  randconfig-011-20260218    gcc-12
i386                  randconfig-011-20260218    gcc-14
i386                  randconfig-012-20260218    gcc-14
i386                  randconfig-013-20260218    clang-20
i386                  randconfig-013-20260218    gcc-14
i386                  randconfig-014-20260218    gcc-14
i386                  randconfig-015-20260218    gcc-14
i386                  randconfig-016-20260218    clang-20
i386                  randconfig-016-20260218    gcc-14
i386                  randconfig-017-20260218    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260218    clang-16
loongarch             randconfig-001-20260218    clang-23
loongarch             randconfig-002-20260218    clang-16
loongarch             randconfig-002-20260218    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           ip22_defconfig    gcc-15.2.0
nios2                         3c120_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260218    clang-16
nios2                 randconfig-001-20260218    gcc-11.5.0
nios2                 randconfig-002-20260218    clang-16
nios2                 randconfig-002-20260218    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260218    gcc-8.5.0
parisc                randconfig-002-20260218    gcc-8.5.0
parisc                randconfig-002-20260218    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-23
powerpc                     kmeter1_defconfig    clang-23
powerpc                 linkstation_defconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260218    clang-23
powerpc               randconfig-001-20260218    gcc-8.5.0
powerpc               randconfig-002-20260218    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260218    gcc-8.5.0
powerpc64             randconfig-002-20260218    clang-23
powerpc64             randconfig-002-20260218    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260218    clang-23
riscv                 randconfig-002-20260218    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260218    clang-23
s390                  randconfig-002-20260218    clang-23
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               alldefconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260218    clang-23
sh                    randconfig-001-20260218    gcc-15.2.0
sh                    randconfig-002-20260218    clang-23
sh                    randconfig-002-20260218    gcc-13.4.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260218    gcc-10.5.0
sparc                 randconfig-001-20260218    gcc-14.3.0
sparc                 randconfig-002-20260218    gcc-10.5.0
sparc                 randconfig-002-20260218    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260218    gcc-10.5.0
sparc64               randconfig-001-20260218    gcc-11.5.0
sparc64               randconfig-002-20260218    gcc-10.5.0
sparc64               randconfig-002-20260218    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260218    clang-23
um                    randconfig-001-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260218    gcc-14
x86_64      buildonly-randconfig-002-20260218    clang-20
x86_64      buildonly-randconfig-002-20260218    gcc-14
x86_64      buildonly-randconfig-003-20260218    clang-20
x86_64      buildonly-randconfig-003-20260218    gcc-14
x86_64      buildonly-randconfig-004-20260218    gcc-14
x86_64      buildonly-randconfig-005-20260218    gcc-14
x86_64      buildonly-randconfig-006-20260218    clang-20
x86_64      buildonly-randconfig-006-20260218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260218    gcc-14
x86_64                randconfig-002-20260218    gcc-14
x86_64                randconfig-003-20260218    gcc-14
x86_64                randconfig-004-20260218    gcc-14
x86_64                randconfig-005-20260218    gcc-14
x86_64                randconfig-006-20260218    gcc-14
x86_64                randconfig-011-20260218    clang-20
x86_64                randconfig-011-20260218    gcc-13
x86_64                randconfig-012-20260218    gcc-13
x86_64                randconfig-013-20260218    gcc-13
x86_64                randconfig-013-20260218    gcc-14
x86_64                randconfig-014-20260218    clang-20
x86_64                randconfig-014-20260218    gcc-13
x86_64                randconfig-015-20260218    gcc-13
x86_64                randconfig-016-20260218    gcc-13
x86_64                randconfig-016-20260218    gcc-14
x86_64                randconfig-071-20260218    clang-20
x86_64                randconfig-072-20260218    clang-20
x86_64                randconfig-073-20260218    clang-20
x86_64                randconfig-074-20260218    clang-20
x86_64                randconfig-075-20260218    clang-20
x86_64                randconfig-076-20260218    clang-20
x86_64                randconfig-076-20260218    gcc-14
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
xtensa                randconfig-001-20260218    gcc-10.5.0
xtensa                randconfig-001-20260218    gcc-9.5.0
xtensa                randconfig-002-20260218    gcc-10.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
