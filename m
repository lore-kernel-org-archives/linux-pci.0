Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A52DC763
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183049; cv=none; b=V9rfYfmHL+af7voQp16BEU+ahDUAvwpyuSyKasN7aplgLjA57RWkvFBBvtD0TGf/rDLGcWX4yLYD+KPioDWQI72yvwzeH0ErQasx49u4V0Zwi0G8QJ710qtEKGlSTfInrXu/MfYYfxlmgGwIRNxnUAjZ4B3c4JbpF3FLe1NIHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183049; c=relaxed/simple;
	bh=amBfZwb50S2y7gERg3vVqofnVF11Af4TOxOcmODBCvc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u6Kren/MieV9dHkTfPdFFjRjjK4NDU0uQ8N7cJvt0ut+C+27RqAM6Mzedd6dDQbnnRFSsDKaxWaOnH0qPNWM6ZeCLxWVstDn1yx/LvwLy9gLwck86xUNjgqrbX3t/Pi3iF2X/CqMc77j85GyRkaAZk1qN6LHEl2nQfvGAX5g3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3domg5W; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3domg5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769183047; x=1800719047;
  h=date:from:to:cc:subject:message-id;
  bh=amBfZwb50S2y7gERg3vVqofnVF11Af4TOxOcmODBCvc=;
  b=K3domg5WoTQLJ55SxhVpsbIArxJTaIqw8u67ehvInx1/NTZCwH02knYS
   mrUssAo2ht3yR8dMg/u4eF09e43CX/vCKfd7SZ/BsAcJZdrn7AVUHL1Yv
   ESPOjAJAJcPjC+QQ+IPNNO+56kapK3QZrxjVMm2PiJVzCZa6zcqaj5jVp
   BYDbolgy31ukR+dCE+CcWYBrAIPdhSZA+vToQcJ45R1pBMfMcwY3U5OEk
   A9feGekPDUoQIYm8jeJDgqZD49TrZ+m06VGBk3H06xUmurpfUzb+FqNYQ
   go0bV7/IvqxM4IA0n0slLjpERScd3x1MnRniSNgrawLitO550l3LEq+ms
   Q==;
X-CSE-ConnectionGUID: plE9slzATOeSAIFuFjpKOw==
X-CSE-MsgGUID: InC0NWMtR0y99XLywOEexA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="74295892"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="74295892"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 07:44:06 -0800
X-CSE-ConnectionGUID: EgjHZiVJQBugQdBLinp+FQ==
X-CSE-MsgGUID: xVnvD7HMRgefOA2tvXfgQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207473131"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Jan 2026 07:44:05 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjJKM-00000000U94-49o5;
	Fri, 23 Jan 2026 15:44:02 +0000
Date: Fri, 23 Jan 2026 23:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 51c0996dadaea20d73eb0495aeda9cb0422243e8
Message-ID: <202601232351.swv8JpZC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 51c0996dadaea20d73eb0495aeda9cb0422243e8  PCI/PM: Prevent runtime suspend until devices are fully initialized

elapsed time: 1224m

configs tested: 209
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-22
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260123    gcc-10.5.0
arc                   randconfig-002-20260123    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         assabet_defconfig    clang-22
arm                        clps711x_defconfig    gcc-15.2.0
arm                     davinci_all_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                      integrator_defconfig    gcc-15.2.0
arm                          moxart_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260123    gcc-10.5.0
arm                   randconfig-002-20260123    gcc-10.5.0
arm                   randconfig-003-20260123    gcc-10.5.0
arm                   randconfig-004-20260123    gcc-10.5.0
arm                         s5pv210_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260123    gcc-15.2.0
arm64                 randconfig-002-20260123    gcc-15.2.0
arm64                 randconfig-003-20260123    gcc-15.2.0
arm64                 randconfig-004-20260123    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260123    gcc-15.2.0
csky                  randconfig-002-20260123    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260123    gcc-12.5.0
hexagon               randconfig-002-20260123    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260123    clang-20
i386        buildonly-randconfig-002-20260123    clang-20
i386        buildonly-randconfig-003-20260123    clang-20
i386        buildonly-randconfig-004-20260123    clang-20
i386        buildonly-randconfig-005-20260123    clang-20
i386        buildonly-randconfig-006-20260123    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260123    gcc-14
i386                  randconfig-002-20260123    gcc-14
i386                  randconfig-003-20260123    gcc-14
i386                  randconfig-004-20260123    gcc-14
i386                  randconfig-005-20260123    gcc-14
i386                  randconfig-006-20260123    gcc-14
i386                  randconfig-007-20260123    gcc-14
i386                  randconfig-011-20260123    clang-20
i386                  randconfig-012-20260123    clang-20
i386                  randconfig-013-20260123    clang-20
i386                  randconfig-014-20260123    clang-20
i386                  randconfig-015-20260123    clang-20
i386                  randconfig-016-20260123    clang-20
i386                  randconfig-017-20260123    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260123    gcc-12.5.0
loongarch             randconfig-002-20260123    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          multi_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260123    gcc-12.5.0
nios2                 randconfig-002-20260123    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260123    gcc-12.5.0
parisc                randconfig-002-20260123    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc               randconfig-001-20260123    gcc-12.5.0
powerpc               randconfig-002-20260123    gcc-12.5.0
powerpc                     taishan_defconfig    clang-22
powerpc64             randconfig-001-20260123    gcc-12.5.0
powerpc64             randconfig-002-20260123    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260123    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260123    clang-22
s390                  randconfig-002-20260123    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    clang-22
sh                    randconfig-001-20260123    clang-22
sh                    randconfig-002-20260123    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260123    gcc-13.4.0
sparc                 randconfig-002-20260123    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260123    gcc-13.4.0
sparc64               randconfig-002-20260123    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260123    gcc-13.4.0
um                    randconfig-002-20260123    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260123    clang-20
x86_64      buildonly-randconfig-002-20260123    clang-20
x86_64      buildonly-randconfig-003-20260123    clang-20
x86_64      buildonly-randconfig-004-20260123    clang-20
x86_64      buildonly-randconfig-005-20260123    clang-20
x86_64      buildonly-randconfig-006-20260123    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260123    gcc-14
x86_64                randconfig-002-20260123    gcc-14
x86_64                randconfig-003-20260123    gcc-14
x86_64                randconfig-004-20260123    gcc-14
x86_64                randconfig-005-20260123    gcc-14
x86_64                randconfig-006-20260123    gcc-14
x86_64                randconfig-011-20260123    gcc-14
x86_64                randconfig-012-20260123    gcc-14
x86_64                randconfig-013-20260123    gcc-14
x86_64                randconfig-014-20260123    gcc-14
x86_64                randconfig-015-20260123    gcc-14
x86_64                randconfig-016-20260123    gcc-14
x86_64                randconfig-071-20260123    clang-20
x86_64                randconfig-072-20260123    clang-20
x86_64                randconfig-073-20260123    clang-20
x86_64                randconfig-074-20260123    clang-20
x86_64                randconfig-075-20260123    clang-20
x86_64                randconfig-076-20260123    clang-20
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
xtensa                randconfig-001-20260123    gcc-13.4.0
xtensa                randconfig-002-20260123    gcc-13.4.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
