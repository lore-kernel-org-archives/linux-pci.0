Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44B3876AE
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198977; cv=none; b=dw0XG2DKBvOiYdaGTT4D+XQNskZS3ixKx0bZ0gtwCtZnJBFlihMCt2hUlBS6CDRvWONupVsYGdiKBjUrHBSgIf17zmzPd3gv8zSGBQgv2ZZc8/8tgI06nqGXv1P1OwhMKYfsap3JQcE4Ly5ZQTBDTdcoFGMv5q9D+2WImVEoj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198977; c=relaxed/simple;
	bh=jcplpK7tjlYIsPMW6i5lkgoCIu7ts7k9YMQzKM0ZuHc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NmZzUxo8TAvHy7OGWq6tzUrTvAN5M56c4uqi8JzqZoodzzyeEsD+XB2aahAuSkciCju3pImK9NIe0UWOZFheCD8V679uFXDwQKsMh2ntsijzbGJ93UY3WATcfK1QXyHCvIwGhk3tq3x7P3M8G4K86CGrnwwjYl/p1roVewQG3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7APCs84; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7APCs84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770198977; x=1801734977;
  h=date:from:to:cc:subject:message-id;
  bh=jcplpK7tjlYIsPMW6i5lkgoCIu7ts7k9YMQzKM0ZuHc=;
  b=c7APCs84j3o9g3Fqx6u2y0s6+o/FcuWmEgS8J1nmqMDzu5mgguS+V+fn
   Xw4/o+P9Du9sjSaOBEY9zwU6LUOtjE6aTAOUAxw8K0+cZGH7thTP27IPA
   GtA7gTAhbn+W2WzaBhyKyVkESjXt2Ff/NkB8fCPch6z2MRjcGvyPhDX9w
   MtsQ6Uv+fI9G4z2X8HlcCIm+jMKq1m5G5jwFCcYrhoiztxIJyFdvariwb
   sWIdXA6qO0pX7rAK0wQI5jXLwW5OOPv19G4h5X06fwXS34R5Qx9Mx+OFa
   sUhgnVMx8fcV4HSd7vchYwmaGXcB/j5Y5KCy/Z2WlqpjpItxQFfZo/FC0
   A==;
X-CSE-ConnectionGUID: 81EzegW6SNWr5Rw5g8gVWg==
X-CSE-MsgGUID: +TPGnmo/R3iPlPc3M9c29g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71111769"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71111769"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:56:17 -0800
X-CSE-ConnectionGUID: wSfmetf4QOu1rkSEQsqvRA==
X-CSE-MsgGUID: qmowmLBiRsyBLrabxghStg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209916135"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Feb 2026 01:56:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnZcK-00000000hf2-3ap6;
	Wed, 04 Feb 2026 09:56:12 +0000
Date: Wed, 04 Feb 2026 17:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-nxp-s32g] BUILD SUCCESS
 b79e0875fe8144fcb09e4fc1cf386cb3b2262480
Message-ID: <202602041707.qE0M4BiK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-nxp-s32g
branch HEAD: b79e0875fe8144fcb09e4fc1cf386cb3b2262480  PCI: s32g: Skip Root Port removal during success

elapsed time: 1243m

configs tested: 262
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    gcc-15.2.0
arc                          axs103_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260203    gcc-12.5.0
arc                   randconfig-001-20260204    gcc-8.5.0
arc                   randconfig-002-20260203    gcc-12.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    gcc-15.2.0
arm                          moxart_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.2.0
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260203    gcc-12.5.0
arm                   randconfig-001-20260204    gcc-8.5.0
arm                   randconfig-002-20260203    gcc-12.5.0
arm                   randconfig-002-20260204    gcc-8.5.0
arm                   randconfig-003-20260203    gcc-12.5.0
arm                   randconfig-003-20260204    gcc-8.5.0
arm                   randconfig-004-20260203    gcc-12.5.0
arm                   randconfig-004-20260204    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260204    gcc-11.5.0
arm64                 randconfig-002-20260204    gcc-11.5.0
arm64                 randconfig-003-20260204    gcc-11.5.0
arm64                 randconfig-004-20260204    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-002-20260204    gcc-11.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260204    gcc-15.2.0
hexagon               randconfig-002-20260204    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260204    gcc-14
i386        buildonly-randconfig-002-20260204    gcc-14
i386        buildonly-randconfig-003-20260204    gcc-14
i386        buildonly-randconfig-004-20260204    gcc-14
i386        buildonly-randconfig-005-20260204    gcc-14
i386        buildonly-randconfig-006-20260204    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260203    clang-20
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-002-20260203    clang-20
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-003-20260203    clang-20
i386                  randconfig-003-20260204    gcc-14
i386                  randconfig-004-20260203    clang-20
i386                  randconfig-004-20260204    gcc-14
i386                  randconfig-005-20260203    gcc-14
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-006-20260203    clang-20
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-007-20260203    gcc-14
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-011-20260203    gcc-14
i386                  randconfig-011-20260204    clang-20
i386                  randconfig-012-20260203    gcc-14
i386                  randconfig-012-20260204    clang-20
i386                  randconfig-013-20260203    gcc-14
i386                  randconfig-013-20260204    clang-20
i386                  randconfig-014-20260203    gcc-14
i386                  randconfig-014-20260204    clang-20
i386                  randconfig-015-20260203    gcc-14
i386                  randconfig-015-20260204    clang-20
i386                  randconfig-016-20260203    gcc-14
i386                  randconfig-016-20260204    clang-20
i386                  randconfig-017-20260203    gcc-14
i386                  randconfig-017-20260204    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-002-20260204    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                            gpr_defconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    clang-22
mips                      pic32mzda_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260204    gcc-15.2.0
nios2                 randconfig-002-20260204    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-002-20260204    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    clang-22
powerpc                     kmeter1_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260204    gcc-8.5.0
powerpc               randconfig-002-20260204    gcc-8.5.0
powerpc                     redwood_defconfig    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20260204    gcc-8.5.0
powerpc64             randconfig-002-20260204    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260203    gcc-8.5.0
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-002-20260203    gcc-8.5.0
riscv                 randconfig-002-20260204    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260203    gcc-8.5.0
s390                  randconfig-001-20260204    gcc-8.5.0
s390                  randconfig-002-20260203    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-8.5.0
sh                    randconfig-001-20260204    gcc-8.5.0
sh                    randconfig-002-20260203    gcc-8.5.0
sh                    randconfig-002-20260204    gcc-8.5.0
sh                          rsk7201_defconfig    clang-22
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                            shmin_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260204    gcc-8.5.0
sparc64               randconfig-002-20260204    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-15.2.0
um                    randconfig-001-20260204    gcc-8.5.0
um                    randconfig-002-20260204    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260203    clang-20
x86_64      buildonly-randconfig-001-20260204    clang-20
x86_64      buildonly-randconfig-002-20260203    clang-20
x86_64      buildonly-randconfig-002-20260204    clang-20
x86_64      buildonly-randconfig-003-20260203    clang-20
x86_64      buildonly-randconfig-003-20260204    clang-20
x86_64      buildonly-randconfig-004-20260203    clang-20
x86_64      buildonly-randconfig-004-20260204    clang-20
x86_64      buildonly-randconfig-005-20260203    clang-20
x86_64      buildonly-randconfig-005-20260204    clang-20
x86_64      buildonly-randconfig-006-20260203    clang-20
x86_64      buildonly-randconfig-006-20260204    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260204    gcc-14
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-005-20260204    gcc-14
x86_64                randconfig-006-20260204    gcc-14
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-012-20260204    clang-20
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-014-20260204    clang-20
x86_64                randconfig-015-20260204    clang-20
x86_64                randconfig-016-20260204    clang-20
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-076-20260204    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260204    gcc-8.5.0
xtensa                randconfig-002-20260204    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
