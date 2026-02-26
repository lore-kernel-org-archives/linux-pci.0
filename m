Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E328466B61
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135698; cv=none; b=GQVufZ+aMsYpAR1Y07FXFXN5hy/I5t/+KM97OA5iuCMk/viHPRGx2Phd14eXkA7SnW7UEXFahlihcq7GBc2xLpQRPArtoYJmYnFNtAPZNXTbHSKPE99WT9ZFY8Q+av0xT1Ei9xf6boR7v2PQVJFYiI3PvI3tvdQVwV2i97pK/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135698; c=relaxed/simple;
	bh=THgrlODmJKBdTY3yPp8wEx7DIQ35Iqiyj4ScfAwHcwM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dVHhbBQb4LBIDlsEwVGZi5b451EJ8mL9lqWXt+KQHe0M1D2d0q9v9d1yQcx6wVoFocTI6aq3Q9XsQunLoKRv996ofaMT4klOWQEwoBP2bBgjSjxDa5HXlXzenipomRY/XJ+51STjlPqUpgixbZtrvYN4ULuLu/wUS2NZ/HBv6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZm5/izi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZm5/izi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772135694; x=1803671694;
  h=date:from:to:cc:subject:message-id;
  bh=THgrlODmJKBdTY3yPp8wEx7DIQ35Iqiyj4ScfAwHcwM=;
  b=FZm5/iziog68naISo4CpQvLvL820pM7WYjd6urS89lB0w31SmrYoq9GO
   +VSjh61ydy/0U0hZ2fV5RSKhOYaJvBeZn+9Yecqqhbrn4YaymSRwzpA9Q
   3pzC5hCchWmcYdV8uwMSqnT+aKKGN2PvhbORDrl31KR9H/uPoggrLTaH2
   oEBCt+QfYvgYJcF2Rn6R8RwNsa7n9JR6NeX8aBNtdHxCCq3Ib4fy6wjU5
   gZno617JE14hu9+JG0jN7HrN7kMjquQOcJRwaqTbLpoN+S0HWChephANf
   GSc1ah6OrsWFG+rq7D6J3zAWxJA+ZgmfG/pbYeuH9ZR1M4p5tNtp/eIIL
   Q==;
X-CSE-ConnectionGUID: Ri8TUaw1TvG8UnbzDIsmbQ==
X-CSE-MsgGUID: 2sOhNR+GTzyJBUzr5NusnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83845640"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="83845640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 11:53:42 -0800
X-CSE-ConnectionGUID: x8ZpAMsDQPy/GxF8nEhP4Q==
X-CSE-MsgGUID: qIadat8FS/OOY1CMYIFsrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="214602509"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Feb 2026 11:53:41 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvhQY-000000009pL-3PNY;
	Thu, 26 Feb 2026 19:53:38 +0000
Date: Fri, 27 Feb 2026 03:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-imx6] BUILD SUCCESS
 3b55079d6387805ede687e234d84669aeb0f7e98
Message-ID: <202602270356.A6G1vnDX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: 3b55079d6387805ede687e234d84669aeb0f7e98  PCI: imx6: Fix device node reference leak in imx_pcie_probe()

elapsed time: 771m

configs tested: 308
configs skipped: 9

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
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260226    gcc-15.2.0
arc                   randconfig-001-20260227    gcc-8.5.0
arc                   randconfig-002-20260226    gcc-15.2.0
arc                   randconfig-002-20260226    gcc-8.5.0
arc                   randconfig-002-20260227    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-23
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    clang-18
arm                           imxrt_defconfig    gcc-15.2.0
arm                   randconfig-001-20260226    gcc-15.2.0
arm                   randconfig-001-20260227    gcc-8.5.0
arm                   randconfig-002-20260226    gcc-11.5.0
arm                   randconfig-002-20260226    gcc-15.2.0
arm                   randconfig-002-20260227    gcc-8.5.0
arm                   randconfig-003-20260226    gcc-15.2.0
arm                   randconfig-003-20260227    gcc-8.5.0
arm                   randconfig-004-20260226    gcc-15.2.0
arm                   randconfig-004-20260227    gcc-8.5.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260226    gcc-14.3.0
arm64                 randconfig-001-20260227    clang-23
arm64                 randconfig-002-20260226    gcc-14.3.0
arm64                 randconfig-002-20260227    clang-23
arm64                 randconfig-003-20260226    gcc-14.3.0
arm64                 randconfig-003-20260227    clang-23
arm64                 randconfig-004-20260226    gcc-14.3.0
arm64                 randconfig-004-20260227    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260226    gcc-14.3.0
csky                  randconfig-001-20260227    clang-23
csky                  randconfig-002-20260226    gcc-14.3.0
csky                  randconfig-002-20260227    clang-23
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260226    clang-23
hexagon               randconfig-001-20260227    clang-23
hexagon               randconfig-002-20260226    clang-23
hexagon               randconfig-002-20260227    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260226    gcc-14
i386        buildonly-randconfig-001-20260227    clang-20
i386        buildonly-randconfig-002-20260226    gcc-14
i386        buildonly-randconfig-002-20260227    clang-20
i386        buildonly-randconfig-003-20260226    gcc-14
i386        buildonly-randconfig-003-20260227    clang-20
i386        buildonly-randconfig-004-20260226    gcc-14
i386        buildonly-randconfig-004-20260227    clang-20
i386        buildonly-randconfig-005-20260226    gcc-14
i386        buildonly-randconfig-005-20260227    clang-20
i386        buildonly-randconfig-006-20260226    gcc-14
i386        buildonly-randconfig-006-20260227    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260226    clang-20
i386                  randconfig-001-20260226    gcc-14
i386                  randconfig-001-20260227    clang-20
i386                  randconfig-002-20260226    clang-20
i386                  randconfig-002-20260227    clang-20
i386                  randconfig-003-20260226    clang-20
i386                  randconfig-003-20260227    clang-20
i386                  randconfig-004-20260226    clang-20
i386                  randconfig-004-20260227    clang-20
i386                  randconfig-005-20260226    clang-20
i386                  randconfig-005-20260226    gcc-13
i386                  randconfig-005-20260227    clang-20
i386                  randconfig-006-20260226    clang-20
i386                  randconfig-006-20260227    clang-20
i386                  randconfig-007-20260226    clang-20
i386                  randconfig-007-20260227    clang-20
i386                  randconfig-011-20260226    clang-20
i386                  randconfig-011-20260226    gcc-14
i386                  randconfig-012-20260226    clang-20
i386                  randconfig-012-20260226    gcc-14
i386                  randconfig-013-20260226    gcc-12
i386                  randconfig-013-20260226    gcc-14
i386                  randconfig-014-20260226    gcc-14
i386                  randconfig-015-20260226    gcc-14
i386                  randconfig-016-20260226    clang-20
i386                  randconfig-016-20260226    gcc-14
i386                  randconfig-017-20260226    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260226    clang-23
loongarch             randconfig-001-20260226    gcc-15.2.0
loongarch             randconfig-001-20260227    clang-23
loongarch             randconfig-002-20260226    clang-20
loongarch             randconfig-002-20260226    clang-23
loongarch             randconfig-002-20260227    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-18
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260226    clang-23
nios2                 randconfig-001-20260226    gcc-11.5.0
nios2                 randconfig-001-20260227    clang-23
nios2                 randconfig-002-20260226    clang-23
nios2                 randconfig-002-20260226    gcc-11.5.0
nios2                 randconfig-002-20260227    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260226    clang-16
parisc                randconfig-001-20260226    gcc-14.3.0
parisc                randconfig-001-20260227    clang-17
parisc                randconfig-002-20260226    clang-16
parisc                randconfig-002-20260226    gcc-12.5.0
parisc                randconfig-002-20260227    clang-17
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc               mpc834x_itxgp_defconfig    clang-23
powerpc                  mpc866_ads_defconfig    clang-18
powerpc               randconfig-001-20260226    clang-16
powerpc               randconfig-001-20260226    gcc-11.5.0
powerpc               randconfig-001-20260227    clang-17
powerpc               randconfig-002-20260226    clang-16
powerpc               randconfig-002-20260227    clang-17
powerpc                  storcenter_defconfig    clang-18
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260226    clang-16
powerpc64             randconfig-001-20260226    gcc-8.5.0
powerpc64             randconfig-001-20260227    clang-17
powerpc64             randconfig-002-20260226    clang-16
powerpc64             randconfig-002-20260226    clang-23
powerpc64             randconfig-002-20260227    clang-17
riscv                            alldefconfig    clang-18
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-002-20260227    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-002-20260227    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                             espt_defconfig    clang-18
sh                            migor_defconfig    clang-18
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                              ul2_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260226    gcc-8.5.0
sparc                 randconfig-001-20260227    clang-23
sparc                 randconfig-002-20260226    gcc-8.5.0
sparc                 randconfig-002-20260227    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260226    gcc-8.5.0
sparc64               randconfig-001-20260227    clang-23
sparc64               randconfig-002-20260226    gcc-8.5.0
sparc64               randconfig-002-20260227    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260226    gcc-8.5.0
um                    randconfig-001-20260227    clang-23
um                    randconfig-002-20260226    gcc-8.5.0
um                    randconfig-002-20260227    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260226    gcc-14
x86_64      buildonly-randconfig-002-20260226    clang-20
x86_64      buildonly-randconfig-002-20260226    gcc-14
x86_64      buildonly-randconfig-003-20260226    gcc-14
x86_64      buildonly-randconfig-004-20260226    clang-20
x86_64      buildonly-randconfig-004-20260226    gcc-14
x86_64      buildonly-randconfig-005-20260226    gcc-14
x86_64      buildonly-randconfig-006-20260226    gcc-13
x86_64      buildonly-randconfig-006-20260226    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260226    gcc-14
x86_64                randconfig-002-20260226    gcc-14
x86_64                randconfig-003-20260226    gcc-14
x86_64                randconfig-004-20260226    gcc-14
x86_64                randconfig-005-20260226    gcc-14
x86_64                randconfig-006-20260226    gcc-14
x86_64                randconfig-011-20260226    clang-20
x86_64                randconfig-011-20260226    gcc-14
x86_64                randconfig-012-20260226    clang-20
x86_64                randconfig-012-20260226    gcc-14
x86_64                randconfig-013-20260226    clang-20
x86_64                randconfig-013-20260226    gcc-14
x86_64                randconfig-014-20260226    clang-20
x86_64                randconfig-014-20260226    gcc-14
x86_64                randconfig-015-20260226    clang-20
x86_64                randconfig-015-20260226    gcc-14
x86_64                randconfig-016-20260226    gcc-14
x86_64                randconfig-071-20260226    clang-20
x86_64                randconfig-071-20260226    gcc-14
x86_64                randconfig-072-20260226    clang-20
x86_64                randconfig-072-20260226    gcc-14
x86_64                randconfig-073-20260226    gcc-14
x86_64                randconfig-074-20260226    clang-20
x86_64                randconfig-074-20260226    gcc-14
x86_64                randconfig-075-20260226    gcc-13
x86_64                randconfig-075-20260226    gcc-14
x86_64                randconfig-076-20260226    clang-20
x86_64                randconfig-076-20260226    gcc-14
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
xtensa                randconfig-001-20260226    gcc-8.5.0
xtensa                randconfig-001-20260227    clang-23
xtensa                randconfig-002-20260226    gcc-8.5.0
xtensa                randconfig-002-20260227    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
