Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D413612DC
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031312; cv=none; b=SsXXvGPEu86B2uekwJbwncEkcmbs8/6tp1YcJCwiMGPCXfvS/sf5PmyiV9/AETjBT/MOr15uUVvf0icXaUf52o+h1LXSKuVafYzUqiGBvLY0mH72lf1nVU1KwdYXAuNr6pTAbFFAO/6s5cIGDsCGRtIsH33yglbmjXSc/knZhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031312; c=relaxed/simple;
	bh=kZ9qfPSbdxhdxJd1jEgNR8KcEW+dydPdZg2jpta0mZ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qSgkRtY7+sVMdi6PoBIFe4KPWFa7tkv1WKqPDvVMaJpbh7zGS0E15VWba80kouBoyc6CjkzWIJHuU8a7YsHPQyMUt8Cw5N2e3WEOdzcV2iU6Px27+22Vq0fgfL7WkgLCj/Cq42Cd130eAoFxdNJ2C+MeKRFsBNopJM9JGYAVTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egGBFYQs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egGBFYQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770031309; x=1801567309;
  h=date:from:to:cc:subject:message-id;
  bh=kZ9qfPSbdxhdxJd1jEgNR8KcEW+dydPdZg2jpta0mZ0=;
  b=egGBFYQsU3+P8CimdD6xbn4Bs+oK/aylRLxF69j87xEK3eohl9KnkWWl
   njqOY4hPUoRcgpaaJXiDIOM5zt7wBYYAM1Y9ZyJfY81LYVlGBygr3qKEz
   8OmjmcOqxRxPL3ChWOO7v5j+1jnqVlyJLzMcRbpKp5BiVRkQuR20MqIom
   ELhhC0CuF2sCIzYHKjmbqNOmg6/of/L/6HDGemSiLZs5mFSOQggjZV14L
   xNA6+kcnlQ1pJ/ST2Ox0M8MJNRyj0iJKF05lwG0qp6UcvwCAom2Ql27VC
   T3kmFIH0UjrVbu5iOq4rItHX6HqL1VrMd4oc1jF5cNwsEZtigUGdf6zMB
   A==;
X-CSE-ConnectionGUID: ngM4SqwKTTuRUUAuzwXSyg==
X-CSE-MsgGUID: WCB85q61TwqcrcJLK3vIqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71097260"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="71097260"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 03:21:48 -0800
X-CSE-ConnectionGUID: yZ6sum6MQuK/gkREvTYoZg==
X-CSE-MsgGUID: dVvFdl7CQ6mJE7MOr63ucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209343642"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Feb 2026 03:21:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vms00-00000000fVc-3tjr;
	Mon, 02 Feb 2026 11:21:44 +0000
Date: Mon, 02 Feb 2026 19:21:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:iov] BUILD SUCCESS
 a5338e365c4559d7b4d7356116b0eb95b12e08d5
Message-ID: <202602021935.aRNf7uXk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git iov
branch HEAD: a5338e365c4559d7b4d7356116b0eb95b12e08d5  PCI/IOV: Fix race between SR-IOV enable/disable and hotplug

elapsed time: 775m

configs tested: 272
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260202    gcc-10.5.0
arc                   randconfig-001-20260202    gcc-14.3.0
arc                   randconfig-002-20260202    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         assabet_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-22
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                          pxa168_defconfig    gcc-15.2.0
arm                             pxa_defconfig    clang-22
arm                   randconfig-001-20260202    gcc-13.4.0
arm                   randconfig-001-20260202    gcc-14.3.0
arm                   randconfig-002-20260202    gcc-12.5.0
arm                   randconfig-002-20260202    gcc-14.3.0
arm                   randconfig-003-20260202    clang-22
arm                   randconfig-003-20260202    gcc-14.3.0
arm                   randconfig-004-20260202    gcc-11.5.0
arm                   randconfig-004-20260202    gcc-14.3.0
arm                          sp7021_defconfig    gcc-15.2.0
arm                           spitz_defconfig    clang-22
arm                         vf610m4_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260202    gcc-9.5.0
arm64                 randconfig-002-20260202    gcc-9.5.0
arm64                 randconfig-003-20260202    gcc-9.5.0
arm64                 randconfig-004-20260202    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260202    gcc-9.5.0
csky                  randconfig-002-20260202    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260202    clang-19
hexagon               randconfig-001-20260202    clang-22
hexagon               randconfig-002-20260202    clang-19
hexagon               randconfig-002-20260202    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260202    clang-20
i386        buildonly-randconfig-001-20260202    gcc-14
i386        buildonly-randconfig-002-20260202    gcc-14
i386        buildonly-randconfig-003-20260202    clang-20
i386        buildonly-randconfig-003-20260202    gcc-14
i386        buildonly-randconfig-004-20260202    clang-20
i386        buildonly-randconfig-004-20260202    gcc-14
i386        buildonly-randconfig-005-20260202    gcc-12
i386        buildonly-randconfig-005-20260202    gcc-14
i386        buildonly-randconfig-006-20260202    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260202    clang-20
i386                  randconfig-001-20260202    gcc-14
i386                  randconfig-002-20260202    gcc-14
i386                  randconfig-003-20260202    clang-20
i386                  randconfig-003-20260202    gcc-14
i386                  randconfig-004-20260202    clang-20
i386                  randconfig-004-20260202    gcc-14
i386                  randconfig-005-20260202    gcc-14
i386                  randconfig-006-20260202    gcc-14
i386                  randconfig-007-20260202    clang-20
i386                  randconfig-007-20260202    gcc-14
i386                  randconfig-011-20260202    clang-20
i386                  randconfig-012-20260202    clang-20
i386                  randconfig-013-20260202    clang-20
i386                  randconfig-014-20260202    clang-20
i386                  randconfig-014-20260202    gcc-14
i386                  randconfig-015-20260202    clang-20
i386                  randconfig-016-20260202    clang-20
i386                  randconfig-017-20260202    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260202    clang-19
loongarch             randconfig-001-20260202    gcc-12.5.0
loongarch             randconfig-002-20260202    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    clang-22
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                       alldefconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    clang-22
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                           ip27_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.2.0
nios2                 randconfig-001-20260202    clang-19
nios2                 randconfig-001-20260202    gcc-9.5.0
nios2                 randconfig-002-20260202    clang-19
nios2                 randconfig-002-20260202    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    clang-22
parisc                randconfig-001-20260202    gcc-8.5.0
parisc                randconfig-002-20260202    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-22
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    gcc-15.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260202    gcc-8.5.0
powerpc               randconfig-002-20260202    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260202    gcc-8.5.0
powerpc64             randconfig-002-20260202    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                          rsk7269_defconfig    gcc-15.2.0
sh                   rts7751r2dplus_defconfig    gcc-15.2.0
sh                           se7206_defconfig    clang-22
sh                           se7751_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260202    gcc-12.5.0
sparc                 randconfig-002-20260202    gcc-12.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260202    gcc-12.5.0
sparc64               randconfig-002-20260202    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260202    gcc-12.5.0
um                    randconfig-002-20260202    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260202    gcc-14
x86_64      buildonly-randconfig-002-20260202    clang-20
x86_64      buildonly-randconfig-002-20260202    gcc-14
x86_64      buildonly-randconfig-003-20260202    gcc-14
x86_64      buildonly-randconfig-004-20260202    gcc-14
x86_64      buildonly-randconfig-005-20260202    clang-20
x86_64      buildonly-randconfig-005-20260202    gcc-14
x86_64      buildonly-randconfig-006-20260202    clang-20
x86_64      buildonly-randconfig-006-20260202    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260202    gcc-14
x86_64                randconfig-002-20260202    gcc-14
x86_64                randconfig-003-20260202    gcc-14
x86_64                randconfig-004-20260202    gcc-14
x86_64                randconfig-005-20260202    gcc-14
x86_64                randconfig-006-20260202    gcc-14
x86_64                randconfig-011-20260202    gcc-14
x86_64                randconfig-012-20260202    clang-20
x86_64                randconfig-012-20260202    gcc-14
x86_64                randconfig-013-20260202    clang-20
x86_64                randconfig-013-20260202    gcc-14
x86_64                randconfig-014-20260202    gcc-12
x86_64                randconfig-014-20260202    gcc-14
x86_64                randconfig-015-20260202    gcc-14
x86_64                randconfig-016-20260202    gcc-14
x86_64                randconfig-071-20260202    clang-20
x86_64                randconfig-071-20260202    gcc-14
x86_64                randconfig-072-20260202    clang-20
x86_64                randconfig-072-20260202    gcc-14
x86_64                randconfig-073-20260202    clang-20
x86_64                randconfig-074-20260202    clang-20
x86_64                randconfig-075-20260202    clang-20
x86_64                randconfig-075-20260202    gcc-12
x86_64                randconfig-076-20260202    clang-20
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
xtensa                           allyesconfig    gcc-11.5.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260202    gcc-12.5.0
xtensa                randconfig-002-20260202    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
