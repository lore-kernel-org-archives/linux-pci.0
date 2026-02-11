Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B638944F
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812131; cv=none; b=iHD0MJZKcq1LUth+RqxZA6voHGbacwMuMJODajOtE25L0zN6ybx9Z/XCngkZelo5kpFTezzdE2ck9hxe/JPAFHj9WB/aoa+upFvltDIZLsSCZCOg2bGHENYDFXid1BVjgtggEi5AwmaEdiUkCyYXj4K1a3WW/Vd6i2iFIrSGAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812131; c=relaxed/simple;
	bh=LBpmI6Y5j6Qvc3wLInYvsAovbhw058lnWVtwKdRMjn8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bac/x6ByU+IaduculCBjmfMBm4P6V7h3V7kJ4QLyCWQ1FEw8OG/BDH36d7yvqQIvPGVhHki+hRT5MtDHA4WLPN5Dc9Vag+h+nTvHsVShday2HZujBDkEKvraSG01CwFnTmQ6x0JZESsdFi6fsz0xmiuhO+3GGPeKMWT6CkC2kWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/b0xtJo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/b0xtJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770812130; x=1802348130;
  h=date:from:to:cc:subject:message-id;
  bh=LBpmI6Y5j6Qvc3wLInYvsAovbhw058lnWVtwKdRMjn8=;
  b=F/b0xtJoAo2GZETH8tBOzp+qz0KTxdnKJb9oD3i2KHD4hd3d1jNs7mne
   40SRe48jSAF4Aoa7ipTyIJv4xa3sVTynWL9PhwjRqjO1ELFZH1CmpxbiA
   knYhqGMn1BqB58Y1UK/6vCRLKyVe42yjNbpmCL7ck5Zew7iRt/LaUr1uJ
   hYUeHjTaPrCHPnevYfP7qlAlYA092bXWhzBxb7JpQCCKpgRReRA9RCK3X
   6iqbpMal9cEO6+RU2Y8fDDPSX4Ws3NUV6Xe3Wu0/r34w69pliJMR+k414
   iPTtIUprEdVYZlYv1XuZ/ILEbHja/71nghNKLdqcta20CJAxWguIGPvc0
   A==;
X-CSE-ConnectionGUID: qmgiY0nNR/Cw5UYE8N+v3A==
X-CSE-MsgGUID: NuaMIcIxQfSEE27xoJJ6yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="94598058"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="94598058"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 04:15:29 -0800
X-CSE-ConnectionGUID: zBPw45GkQmCvXseAMGTfSg==
X-CSE-MsgGUID: uWHQWIhVRCWvDy8MnTUzAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211338070"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2026 04:15:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vq97t-00000000pxb-2TXR;
	Wed, 11 Feb 2026 12:15:25 +0000
Date: Wed, 11 Feb 2026 20:15:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:v7.0-merge] BUILD SUCCESS
 d05e2af08bae38ddaa112b21836095665be9abec
Message-ID: <202602112007.lkdZs0Qk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git v7.0-merge
branch HEAD: d05e2af08bae38ddaa112b21836095665be9abec  Merge branch 'next' into v7.0-merge

elapsed time: 858m

configs tested: 211
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs103_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260211    gcc-8.5.0
arc                   randconfig-002-20260211    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260211    gcc-8.5.0
arm                   randconfig-002-20260211    gcc-8.5.0
arm                   randconfig-003-20260211    gcc-8.5.0
arm                   randconfig-004-20260211    gcc-8.5.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260211    gcc-15.2.0
arm64                 randconfig-002-20260211    gcc-15.2.0
arm64                 randconfig-003-20260211    gcc-15.2.0
arm64                 randconfig-004-20260211    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260211    gcc-15.2.0
csky                  randconfig-002-20260211    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260211    clang-22
hexagon               randconfig-002-20260211    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260211    clang-20
i386        buildonly-randconfig-002-20260211    clang-20
i386        buildonly-randconfig-003-20260211    clang-20
i386        buildonly-randconfig-004-20260211    clang-20
i386        buildonly-randconfig-005-20260211    clang-20
i386        buildonly-randconfig-006-20260211    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260211    gcc-14
i386                  randconfig-002-20260211    gcc-14
i386                  randconfig-003-20260211    gcc-14
i386                  randconfig-004-20260211    gcc-14
i386                  randconfig-005-20260211    gcc-14
i386                  randconfig-006-20260211    gcc-14
i386                  randconfig-007-20260211    gcc-14
i386                  randconfig-011-20260211    clang-20
i386                  randconfig-012-20260211    clang-20
i386                  randconfig-013-20260211    clang-20
i386                  randconfig-014-20260211    clang-20
i386                  randconfig-015-20260211    clang-20
i386                  randconfig-016-20260211    clang-20
i386                  randconfig-017-20260211    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260211    clang-22
loongarch             randconfig-002-20260211    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.2.0
m68k                            mac_defconfig    gcc-15.2.0
m68k                            q40_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260211    clang-22
nios2                 randconfig-002-20260211    clang-22
openrisc                         alldefconfig    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260211    clang-22
parisc                randconfig-002-20260211    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260211    clang-22
powerpc               randconfig-002-20260211    clang-22
powerpc                     sequoia_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260211    clang-22
powerpc64             randconfig-002-20260211    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260211    gcc-13.4.0
riscv                 randconfig-002-20260211    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260211    gcc-13.4.0
s390                  randconfig-002-20260211    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260211    gcc-13.4.0
sh                    randconfig-002-20260211    gcc-13.4.0
sh                          rsk7264_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260211    gcc-13.4.0
sparc                 randconfig-002-20260211    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260211    gcc-13.4.0
sparc64               randconfig-002-20260211    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260211    gcc-13.4.0
um                    randconfig-002-20260211    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260211    gcc-12
x86_64      buildonly-randconfig-002-20260211    gcc-12
x86_64      buildonly-randconfig-003-20260211    gcc-12
x86_64      buildonly-randconfig-004-20260211    gcc-12
x86_64      buildonly-randconfig-005-20260211    gcc-12
x86_64      buildonly-randconfig-006-20260211    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260211    clang-20
x86_64                randconfig-002-20260211    clang-20
x86_64                randconfig-003-20260211    clang-20
x86_64                randconfig-004-20260211    clang-20
x86_64                randconfig-005-20260211    clang-20
x86_64                randconfig-006-20260211    clang-20
x86_64                randconfig-011-20260211    gcc-14
x86_64                randconfig-012-20260211    gcc-14
x86_64                randconfig-013-20260211    gcc-14
x86_64                randconfig-014-20260211    gcc-14
x86_64                randconfig-015-20260211    gcc-14
x86_64                randconfig-016-20260211    gcc-14
x86_64                randconfig-071-20260211    clang-20
x86_64                randconfig-072-20260211    clang-20
x86_64                randconfig-073-20260211    clang-20
x86_64                randconfig-074-20260211    clang-20
x86_64                randconfig-075-20260211    clang-20
x86_64                randconfig-076-20260211    clang-20
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
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260211    gcc-13.4.0
xtensa                randconfig-002-20260211    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
