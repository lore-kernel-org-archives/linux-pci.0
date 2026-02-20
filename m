Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA63191CE
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771589235; cv=none; b=bWghHA+od6ABqAYTMYZuHxhtN/mfOVqNKWwFAZaAGujEwFgg00wbMe3djdy+Z/Eap/3y2XmPhlhy8A0ryE1RQLtf+xr8X1d7nQX3ys+po8Ci5kY2tCnkjwD/R5579oPBvnJ3Zfv76Dr8TtJMkGwPeI08qDDbHWQ+mJfsf2JJjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771589235; c=relaxed/simple;
	bh=Ws4DP3M79615tDkGE7qgLYuKYYQjRn0NWUrARrRd9Z0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SDTefZh+3aeLlfhQTMSiCoj0sb2SpdigvzlKb8QG1NiE/mzE694rANmaQtxQIE8v81u6cG9XReq+pGNimT9aHmGsEnjvxFBCNL3k1Br3rC2amKFnmzlMgM2gc/Ba7DeAx8ojBIsg5chYmGhMP9b+nQiTbbGTimDfrmzl7203AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhO9005G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhO9005G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771589234; x=1803125234;
  h=date:from:to:cc:subject:message-id;
  bh=Ws4DP3M79615tDkGE7qgLYuKYYQjRn0NWUrARrRd9Z0=;
  b=BhO9005GQMAf9+3CUHkh1B2eSXF3zPrZMSBH2TlRV8kl0VK7v2pisVHU
   KKwXJ892SOnNkjQFDQ15yA8wMJX0C4lmXheMUMfA90vbkIBhXwtX18of9
   jnIs7a5V2mTVl4rgfEftzLTpYkWD0nQ7NvFFXJKrSCi7h83heklA3ErW6
   ToEMKBrp/zTQN/MsdFQ67FF3960ATKeKKiVXPsfJ4Qdb3HN8eRZCC0U5f
   xNSjjD/1sMgNcW857xOK6AARUuqhvCJSs2UjilIbAFf7i4HTBM8f3sqeZ
   rQRqx2VqGcK8X4CcyDnihZfiJo5UJVGaI1UsJym+YK5FWzwa1yhe/h+Yf
   Q==;
X-CSE-ConnectionGUID: C+L0rk6TT5ev3w6In2NuUQ==
X-CSE-MsgGUID: QnY2CfwGTG+Cc00pklZNqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71886935"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="71886935"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 04:07:13 -0800
X-CSE-ConnectionGUID: BcxJocLNS02u9HU1S0A41A==
X-CSE-MsgGUID: ygOvO/xSQxq6XLBdXb4HIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219334393"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Feb 2026 04:07:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtPHp-0000000144g-0vMV;
	Fri, 20 Feb 2026 12:07:09 +0000
Date: Fri, 20 Feb 2026 20:06:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 79d5cc2cc2fcf1f929f57b2f72fe5cf9f09b28e2
Message-ID: <202602202045.pKaYOaym-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 79d5cc2cc2fcf1f929f57b2f72fe5cf9f09b28e2  PCI: Bail out early for 2.5GT/s devices in PCIe failed link retraining

elapsed time: 852m

configs tested: 248
configs skipped: 5

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
arc                         haps_hs_defconfig    clang-23
arc                   randconfig-001-20260220    gcc-8.5.0
arc                   randconfig-002-20260220    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                        keystone_defconfig    clang-23
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                   randconfig-001-20260220    gcc-8.5.0
arm                   randconfig-002-20260220    gcc-8.5.0
arm                   randconfig-003-20260220    gcc-8.5.0
arm                   randconfig-004-20260220    gcc-8.5.0
arm                        spear3xx_defconfig    clang-17
arm                           sunxi_defconfig    gcc-15.2.0
arm                       versatile_defconfig    clang-17
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260220    gcc-8.5.0
arm64                 randconfig-002-20260220    gcc-8.5.0
arm64                 randconfig-003-20260220    gcc-8.5.0
arm64                 randconfig-004-20260220    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260220    gcc-8.5.0
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
i386                  randconfig-004-20260220    clang-20
i386                  randconfig-005-20260220    clang-20
i386                  randconfig-006-20260220    clang-20
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
m68k                       bvme6000_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    clang-17
m68k                            mac_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                      mmu_defconfig    clang-17
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-15.2.0
mips                           ip30_defconfig    clang-23
mips                           mtx1_defconfig    clang-23
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
powerpc                       holly_defconfig    clang-23
powerpc                     ksi8560_defconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    clang-23
powerpc                      ppc6xx_defconfig    clang-23
powerpc               randconfig-001-20260220    clang-23
powerpc               randconfig-001-20260220    gcc-13.4.0
powerpc               randconfig-002-20260220    clang-23
powerpc                     skiroot_defconfig    clang-23
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     taishan_defconfig    clang-17
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
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260220    gcc-11.5.0
sh                    randconfig-002-20260220    gcc-11.5.0
sh                   secureedge5410_defconfig    clang-17
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260220    clang-20
sparc                 randconfig-002-20260220    clang-20
sparc                       sparc64_defconfig    clang-17
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
x86_64                randconfig-011-20260220    gcc-14
x86_64                randconfig-012-20260220    gcc-14
x86_64                randconfig-013-20260220    gcc-14
x86_64                randconfig-014-20260220    gcc-14
x86_64                randconfig-015-20260220    gcc-14
x86_64                randconfig-016-20260220    gcc-14
x86_64                randconfig-071-20260220    gcc-14
x86_64                randconfig-072-20260220    gcc-14
x86_64                randconfig-073-20260220    gcc-14
x86_64                randconfig-074-20260220    gcc-14
x86_64                randconfig-075-20260220    gcc-14
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
xtensa                  audio_kc705_defconfig    clang-23
xtensa                randconfig-001-20260220    clang-20
xtensa                randconfig-002-20260220    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
