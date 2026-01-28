Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F763164B6
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620233; cv=none; b=FW8SrWHZzmOo8wyU3z9FIixsKBaplC/zl3oD2TfjPprqhm2+UPL/jAApAlDQqI0voybi16xtuEYMGlNg/AdLp01hNHUuGgruemjJAIkiuTY4nTRqJBg5SXEqclW4MfssMxD0ciLTYVCj649EGe3s8Z1r6BLlscLJDt+CtW4Kz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620233; c=relaxed/simple;
	bh=QoL6w4QerqdccAj3iCCpGTqrAgsBP0Xb93N+LVfhez8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jM2oHrCC8FEzOhLSS3ghVZ83SIRmm9Xzo63a9CslU4B8FcngxppbPBjZQHBR8+rj/GY/oE5F/visl1IuELWqJnZUAaJi1DWvVYNSEEgUuwofjaRHatm3G62gfxcnqa6HTP2a5EcHGt/HpWXWkRAd0GjuJQjF4ZVg3gkfCWePftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQydzdIo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQydzdIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769620231; x=1801156231;
  h=date:from:to:cc:subject:message-id;
  bh=QoL6w4QerqdccAj3iCCpGTqrAgsBP0Xb93N+LVfhez8=;
  b=DQydzdIoY+DQXJPajx7LE8kPJLGXTK+t3YoJmpPc/3acFy24/9TLMWgL
   pRnb5vbhQ9jD4lKoTvZgxu6yuQN85qGd0ZWFDO4P9DvZuStiHGQpREpwh
   3lwhsQcpCdWimETKjp9FjBaClrYsRY91bDKAcb9ac2hZ+dR+fQIjVpJuM
   hBeAXrUh07K//b+RmMwMYqlFSfTfgRohnBMrN0yhTnCMIlw6wsbLpSVgA
   S4dZ4NEEVrSe8ZPgMTcn/biyuWl+gyNVu7RqqwVlGo6AtIDb2KeF+CzVK
   y6D6lA5JC8KwyAWWwTu5/Kvl/DRBzM26q/14WMunlw7+3FFXJXp7qgm74
   w==;
X-CSE-ConnectionGUID: JV4ndAuqTZClzDFov533CA==
X-CSE-MsgGUID: Nn5bs1nfTMCUjfNJBLN2Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81953091"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81953091"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:10:31 -0800
X-CSE-ConnectionGUID: jyQhZI28Sx2Qa2S+LuFZDQ==
X-CSE-MsgGUID: pgdv97gbSWSWAqU+hOIeuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213191884"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jan 2026 09:10:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vl93j-00000000acb-2I33;
	Wed, 28 Jan 2026 17:10:27 +0000
Date: Thu, 29 Jan 2026 01:09:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 97f308dcfed586d61b0265e793aaf086d4acbafe
Message-ID: <202601290122.oB8yf0l2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 97f308dcfed586d61b0265e793aaf086d4acbafe  Merge branch 'pci/misc'

elapsed time: 1109m

configs tested: 157
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260128    gcc-9.5.0
arc                   randconfig-002-20260128    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-22
arm                        neponset_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260128    gcc-15.2.0
arm                   randconfig-002-20260128    gcc-15.2.0
arm                   randconfig-003-20260128    gcc-8.5.0
arm                   randconfig-004-20260128    gcc-8.5.0
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260128    clang-22
arm64                 randconfig-002-20260128    gcc-12.5.0
arm64                 randconfig-003-20260128    gcc-14.3.0
arm64                 randconfig-004-20260128    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260128    gcc-15.2.0
csky                  randconfig-002-20260128    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20260128    clang-20
hexagon               randconfig-002-20260128    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260128    gcc-14
i386        buildonly-randconfig-002-20260128    clang-20
i386        buildonly-randconfig-003-20260128    gcc-14
i386        buildonly-randconfig-004-20260128    clang-20
i386        buildonly-randconfig-005-20260128    gcc-14
i386        buildonly-randconfig-006-20260128    clang-20
i386                  randconfig-001-20260128    gcc-14
i386                  randconfig-002-20260128    gcc-14
i386                  randconfig-003-20260128    gcc-14
i386                  randconfig-004-20260128    gcc-14
i386                  randconfig-005-20260128    gcc-14
i386                  randconfig-006-20260128    gcc-14
i386                  randconfig-007-20260128    gcc-14
i386                  randconfig-011-20260128    clang-20
i386                  randconfig-012-20260128    gcc-14
i386                  randconfig-013-20260128    gcc-14
i386                  randconfig-014-20260128    clang-20
i386                  randconfig-015-20260128    clang-20
i386                  randconfig-016-20260128    gcc-14
i386                  randconfig-017-20260128    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260128    clang-22
loongarch             randconfig-002-20260128    clang-20
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260128    gcc-8.5.0
nios2                 randconfig-002-20260128    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260128    gcc-11.5.0
parisc                randconfig-002-20260128    gcc-12.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20260128    clang-22
powerpc               randconfig-002-20260128    gcc-8.5.0
powerpc64             randconfig-001-20260128    clang-22
powerpc64             randconfig-002-20260128    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260128    gcc-13.4.0
riscv                 randconfig-002-20260128    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260128    gcc-13.4.0
s390                  randconfig-002-20260128    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260128    gcc-15.2.0
sh                    randconfig-002-20260128    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260128    gcc-8.5.0
sparc                 randconfig-002-20260128    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260128    gcc-12.5.0
sparc64               randconfig-002-20260128    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260128    gcc-12
um                    randconfig-002-20260128    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260128    gcc-14
x86_64      buildonly-randconfig-002-20260128    gcc-14
x86_64      buildonly-randconfig-003-20260128    gcc-14
x86_64      buildonly-randconfig-004-20260128    gcc-12
x86_64      buildonly-randconfig-005-20260128    clang-20
x86_64      buildonly-randconfig-006-20260128    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260128    clang-20
x86_64                randconfig-002-20260128    clang-20
x86_64                randconfig-003-20260128    clang-20
x86_64                randconfig-004-20260128    gcc-14
x86_64                randconfig-005-20260128    gcc-13
x86_64                randconfig-006-20260128    gcc-14
x86_64                randconfig-011-20260128    clang-20
x86_64                randconfig-012-20260128    gcc-14
x86_64                randconfig-013-20260128    clang-20
x86_64                randconfig-014-20260128    clang-20
x86_64                randconfig-015-20260128    gcc-14
x86_64                randconfig-016-20260128    clang-20
x86_64                randconfig-071-20260128    clang-20
x86_64                randconfig-072-20260128    clang-20
x86_64                randconfig-073-20260128    gcc-12
x86_64                randconfig-074-20260128    gcc-14
x86_64                randconfig-075-20260128    gcc-14
x86_64                randconfig-076-20260128    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260128    gcc-8.5.0
xtensa                randconfig-002-20260128    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
