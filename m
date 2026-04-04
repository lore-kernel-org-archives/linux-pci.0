Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA92D661C
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775304445; cv=none; b=Gn+4ly59ZJ4z1ceSu14+xrFwbCqbOj00JuQ1508CJ3U1Mqd2xwKkKSXC2Yx5kjmrmPwJOvqeER2t7q+CRek1AQIZGRZ382yMYWBT1FZmMAtSdKEdU6mshCIu1qw6Ua4v2ccCSLWzfCupsn78kM7G9zgMSE+0+waZePIHxBwNjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775304445; c=relaxed/simple;
	bh=Gsppcp7LCX3dlySkMvH/tNc2XPMVKRvXmSbVMg2Y1DI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RJe+Ic2xe5lWbq+j8gRR7KmhSWIrlLl7SH9G5ZduKPihhlzYN2QpPYCQLrUfz8M+7jhk8s0A4frgCNTXuPdxohSrmMcpLbBc6X3j6BbC4xZYO4zzy2FG5xWu1Ohb1CfTZhoV5gK1N2zmBp+TeFqxm5+Yu8HaXF3x6HvNHCmOwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvKLijvX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvKLijvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775304443; x=1806840443;
  h=date:from:to:cc:subject:message-id;
  bh=Gsppcp7LCX3dlySkMvH/tNc2XPMVKRvXmSbVMg2Y1DI=;
  b=bvKLijvXpwaJtR93A+8LIViVeO3kgcotDD1xz9iXyH8fLu3ISyiPW3rB
   66Dv8fEUjShksYq0Qda5uGI6WAQwxJjhJTKN8faD8VbFw0rRMIKkOTFAr
   yB9t03wMdr07QkJDuZrnMNDIWH47At47LmhJgJCx27685791Iv9F9unN3
   kLx4VtGBDLr0oCW+VLPb8PnarvkaGJ2Lpzs9gJKJU2TaBjTiPvKCydL+8
   Xi1thoSKEHMR1VGK3Ub+0E5rBfUdoPnCfSZqWBhQ2FCFxhPGJENycWZWX
   5SQqOuwmEvm/1ttHDJxp3IskNsMsEDWtZDsL+4HXwy618ym6V4fe6bpXN
   w==;
X-CSE-ConnectionGUID: T6cnGJoNRrG1tPG0tW5FEA==
X-CSE-MsgGUID: Y+7gGkezRF6AqjUMcQzwqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76357358"
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="76357358"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 05:07:23 -0700
X-CSE-ConnectionGUID: yVCwwwldRG2B7KD5ZZBmdA==
X-CSE-MsgGUID: MSgMaeKNTuiHNqCKKTvQfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="227343055"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Apr 2026 05:07:21 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8zmY-000000000g5-2sL7;
	Sat, 04 Apr 2026 12:07:18 +0000
Date: Sat, 04 Apr 2026 20:06:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 20e47e925678cd68ac0a749cf5f9bc280d6c2a66
Message-ID: <202604042024.is7TSKHH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 20e47e925678cd68ac0a749cf5f9bc280d6c2a66  PCI: Remove MPS/MRRS Kconfig settings

elapsed time: 825m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260404    gcc-15.2.0
arc                   randconfig-002-20260404    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260404    gcc-15.2.0
arm                   randconfig-002-20260404    gcc-15.2.0
arm                   randconfig-003-20260404    gcc-15.2.0
arm                   randconfig-004-20260404    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260404    gcc-15.2.0
arm64                 randconfig-002-20260404    gcc-15.2.0
arm64                 randconfig-003-20260404    gcc-15.2.0
arm64                 randconfig-004-20260404    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260404    gcc-15.2.0
csky                  randconfig-002-20260404    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260404    gcc-15.2.0
hexagon               randconfig-002-20260404    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260404    clang-20
i386        buildonly-randconfig-002-20260404    clang-20
i386        buildonly-randconfig-003-20260404    clang-20
i386        buildonly-randconfig-004-20260404    clang-20
i386        buildonly-randconfig-005-20260404    clang-20
i386        buildonly-randconfig-006-20260404    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260404    clang-20
i386                  randconfig-002-20260404    clang-20
i386                  randconfig-003-20260404    clang-20
i386                  randconfig-004-20260404    clang-20
i386                  randconfig-005-20260404    clang-20
i386                  randconfig-006-20260404    clang-20
i386                  randconfig-007-20260404    clang-20
i386                  randconfig-011-20260404    clang-20
i386                  randconfig-012-20260404    clang-20
i386                  randconfig-013-20260404    clang-20
i386                  randconfig-014-20260404    clang-20
i386                  randconfig-015-20260404    clang-20
i386                  randconfig-016-20260404    clang-20
i386                  randconfig-017-20260404    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260404    gcc-15.2.0
loongarch             randconfig-002-20260404    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260404    gcc-15.2.0
nios2                 randconfig-002-20260404    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260404    gcc-10.5.0
parisc                randconfig-002-20260404    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260404    gcc-10.5.0
powerpc               randconfig-002-20260404    gcc-10.5.0
powerpc64             randconfig-001-20260404    gcc-10.5.0
powerpc64             randconfig-002-20260404    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260404    clang-20
riscv                 randconfig-002-20260404    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260404    clang-20
s390                  randconfig-002-20260404    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260404    clang-20
sh                    randconfig-002-20260404    clang-20
sh                           se7751_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260404    clang-20
sparc                 randconfig-002-20260404    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260404    clang-20
sparc64               randconfig-002-20260404    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260404    clang-20
um                    randconfig-002-20260404    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260404    gcc-13
x86_64      buildonly-randconfig-002-20260404    gcc-13
x86_64      buildonly-randconfig-003-20260404    gcc-13
x86_64      buildonly-randconfig-004-20260404    gcc-13
x86_64      buildonly-randconfig-005-20260404    gcc-13
x86_64      buildonly-randconfig-006-20260404    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260404    gcc-14
x86_64                randconfig-002-20260404    gcc-14
x86_64                randconfig-003-20260404    gcc-14
x86_64                randconfig-004-20260404    gcc-14
x86_64                randconfig-005-20260404    gcc-14
x86_64                randconfig-006-20260404    gcc-14
x86_64                randconfig-011-20260404    gcc-14
x86_64                randconfig-012-20260404    gcc-14
x86_64                randconfig-013-20260404    gcc-14
x86_64                randconfig-014-20260404    gcc-14
x86_64                randconfig-015-20260404    gcc-14
x86_64                randconfig-016-20260404    gcc-14
x86_64                randconfig-071-20260404    gcc-14
x86_64                randconfig-072-20260404    gcc-14
x86_64                randconfig-073-20260404    gcc-14
x86_64                randconfig-074-20260404    gcc-14
x86_64                randconfig-075-20260404    gcc-14
x86_64                randconfig-076-20260404    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260404    clang-20
xtensa                randconfig-002-20260404    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
