Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491221DF261
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262595; cv=none; b=ivcHcKcuLHOY2ctHrATZP4/dDU91lDnnfeR/1iiFmkI+dyC4HSVAxf4oz1Y8N2fIwxtGBTD3hZ9kfZe09nMDqWPeKzKQ2lSOKtbzIJsoUPmcnM9KdSSSe+sNgO0GlUi84doSRu+vkYx3XFo+dlzzLGtgeixcbWnvTxZ6y1NdXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262595; c=relaxed/simple;
	bh=1aRWNujh+BicxzlFrBLvL8jWdfFmKoOpPwzdOazqBoY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fPCsGm3rSdcFZ4RJBE89GXQ6D3cJQmivjgfdBJFLgF4hb7x2Uy+SuhGWJbmRzy8ZvP8+b8Yn48Ea1c9rwe+kSFs7DeqfC0KDUIZS/IHOnxMNr2Jt9piWuNTjy4d529Fok4iThjY+gwU76bEFsztJeAUWdW93cl9JUAGM7TqFIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNKoiYbS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNKoiYbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772262593; x=1803798593;
  h=date:from:to:cc:subject:message-id;
  bh=1aRWNujh+BicxzlFrBLvL8jWdfFmKoOpPwzdOazqBoY=;
  b=gNKoiYbSIIINMKJUmhGT+sJqcr3Mr7HkwKyblfhVpzDbpd73ZN1dIgMq
   ZtHnMMCuvEtIVxBGwJUQGA832COAFZXmiRD/tsCvxlFDG+Z23Wl5NwDn0
   M/P+DqHDqeOiQjIkUqniS05lPGQByBFQsdGbQSnFzc4wGmYyPGJB5YrQB
   tiqAvT1s+sSeCC1MMUwSW+UTXPp0qkNYhjRwmDXyhnwOOEbu9gHqXMO61
   wqAHKahzoSF+uV6OlDO6iVkyOKVkT+MtnzQIG4W3ywqUsFaDUju4MSt5d
   b27pLlDt8uK8KdmYb6klXPBmKRRERYvqXjtOT0nE1DxF6hVV4rX4FC4s6
   g==;
X-CSE-ConnectionGUID: 1ID12bIlTY2eo6aMSoU9Vw==
X-CSE-MsgGUID: bZTYfs5ARN+I7FFomFNsPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73254087"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73254087"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 23:09:52 -0800
X-CSE-ConnectionGUID: iSNkzWIKQMGTB/IQkcoyQg==
X-CSE-MsgGUID: NnuEJjOyRlK7/7l4jZ4LVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="215235848"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Feb 2026 23:09:50 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwER5-00000000BLr-3h08;
	Sat, 28 Feb 2026 07:08:50 +0000
Date: Sat, 28 Feb 2026 15:07:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:ptm] BUILD SUCCESS
 e1092d5e15e6a9b168bf830af9a26d7ea17cd57d
Message-ID: <202602281539.hFgJF52L-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ptm
branch HEAD: e1092d5e15e6a9b168bf830af9a26d7ea17cd57d  PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports

elapsed time: 770m

configs tested: 254
configs skipped: 7

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
arc                          axs101_defconfig    clang-23
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                        nsimosci_defconfig    clang-23
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260228    gcc-14.3.0
arc                   randconfig-002-20260228    gcc-14.3.0
arc                   randconfig-002-20260228    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                      integrator_defconfig    gcc-15.2.0
arm                        keystone_defconfig    gcc-15.2.0
arm                            mps2_defconfig    clang-23
arm                        multi_v5_defconfig    clang-23
arm                        mvebu_v5_defconfig    clang-23
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                             mxs_defconfig    clang-23
arm                   randconfig-001-20260228    clang-16
arm                   randconfig-001-20260228    gcc-14.3.0
arm                   randconfig-002-20260228    clang-23
arm                   randconfig-002-20260228    gcc-14.3.0
arm                   randconfig-003-20260228    clang-23
arm                   randconfig-003-20260228    gcc-14.3.0
arm                   randconfig-004-20260228    gcc-11.5.0
arm                   randconfig-004-20260228    gcc-14.3.0
arm                           sama5_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    clang-23
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260228    clang-23
arm64                 randconfig-002-20260228    clang-23
arm64                 randconfig-003-20260228    clang-23
arm64                 randconfig-004-20260228    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260228    clang-23
csky                  randconfig-002-20260228    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260228    clang-23
hexagon               randconfig-002-20260228    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260228    clang-20
i386        buildonly-randconfig-002-20260228    clang-20
i386        buildonly-randconfig-003-20260228    clang-20
i386        buildonly-randconfig-004-20260228    clang-20
i386        buildonly-randconfig-005-20260228    clang-20
i386        buildonly-randconfig-006-20260228    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260228    gcc-14
i386                  randconfig-002-20260228    gcc-14
i386                  randconfig-003-20260228    gcc-14
i386                  randconfig-004-20260228    gcc-14
i386                  randconfig-005-20260228    gcc-14
i386                  randconfig-006-20260228    gcc-14
i386                  randconfig-007-20260228    gcc-14
i386                  randconfig-011-20260228    gcc-14
i386                  randconfig-012-20260228    gcc-14
i386                  randconfig-013-20260228    gcc-14
i386                  randconfig-014-20260228    gcc-14
i386                  randconfig-015-20260228    gcc-14
i386                  randconfig-016-20260228    gcc-14
i386                  randconfig-017-20260228    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260228    clang-23
loongarch             randconfig-002-20260228    clang-23
loongarch             randconfig-002-20260228    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                            q40_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
mips                      loongson1_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
mips                          rm200_defconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260228    clang-23
nios2                 randconfig-001-20260228    gcc-11.5.0
nios2                 randconfig-002-20260228    clang-23
nios2                 randconfig-002-20260228    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260228    gcc-8.5.0
parisc                randconfig-002-20260228    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    clang-23
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    clang-23
powerpc                     mpc5200_defconfig    clang-23
powerpc                  mpc866_ads_defconfig    clang-23
powerpc                     powernv_defconfig    clang-23
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260228    gcc-8.5.0
powerpc               randconfig-002-20260228    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     sequoia_defconfig    clang-23
powerpc                     skiroot_defconfig    clang-23
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260228    gcc-8.5.0
powerpc64             randconfig-002-20260228    gcc-8.5.0
riscv                            alldefconfig    clang-23
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260228    gcc-15.2.0
riscv                 randconfig-002-20260228    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260228    gcc-15.2.0
s390                  randconfig-002-20260228    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    clang-23
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260228    gcc-15.2.0
sh                    randconfig-002-20260228    gcc-15.2.0
sh                           se7722_defconfig    gcc-15.2.0
sh                           se7751_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260228    gcc-9.5.0
sparc                 randconfig-002-20260228    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260228    gcc-9.5.0
sparc64               randconfig-002-20260228    gcc-9.5.0
um                               alldefconfig    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260228    gcc-9.5.0
um                    randconfig-002-20260228    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260228    gcc-14
x86_64      buildonly-randconfig-002-20260228    gcc-14
x86_64      buildonly-randconfig-003-20260228    gcc-14
x86_64      buildonly-randconfig-004-20260228    gcc-14
x86_64      buildonly-randconfig-005-20260228    gcc-14
x86_64      buildonly-randconfig-006-20260228    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260228    gcc-14
x86_64                randconfig-002-20260228    gcc-14
x86_64                randconfig-003-20260228    gcc-14
x86_64                randconfig-004-20260228    gcc-14
x86_64                randconfig-005-20260228    gcc-14
x86_64                randconfig-006-20260228    gcc-14
x86_64                randconfig-011-20260228    gcc-14
x86_64                randconfig-012-20260228    gcc-14
x86_64                randconfig-013-20260228    gcc-14
x86_64                randconfig-014-20260228    gcc-14
x86_64                randconfig-015-20260228    gcc-14
x86_64                randconfig-016-20260228    gcc-14
x86_64                randconfig-071-20260228    gcc-14
x86_64                randconfig-072-20260228    gcc-14
x86_64                randconfig-073-20260228    gcc-14
x86_64                randconfig-074-20260228    gcc-14
x86_64                randconfig-075-20260228    gcc-14
x86_64                randconfig-076-20260228    gcc-14
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
xtensa                  nommu_kc705_defconfig    clang-23
xtensa                randconfig-001-20260228    gcc-9.5.0
xtensa                randconfig-002-20260228    gcc-9.5.0
xtensa                    smp_lx200_defconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
