Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53441B34B
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219975; cv=none; b=WE7bawThDDafaApiOcXR5rKM5Il88297VSZkQQhKTA7FmYqFxQYBqTVyCx4dce0CY7qEh6aXri+4q6mEtoPNzGFWbmXIaDZylBycq4ChTFzzzZ82+BcUl6AkBRfBvP76fSH9lAozTtNc8/pLDg+MPCmeRkr8EILoviuAu+uwLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219975; c=relaxed/simple;
	bh=5AUShYJQ1tWB4mjCqUijFqUO2i9hD7mruNDBB+M2GXM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EzlN1UZk1gpMVmbGDPAn3kStkONmzzGYnqdvFrNzA0eyDjM6GIhLzEC3Thh3PqO+e87mzM7G7jvk1Zpu4FjpcE1G5vQz8cu/gJjqRdBawmpV8iTu5BnB3BVFMq1xQXAXdWVshD/4EKqBUodu8Eo1OOpufOl+LbZEBJhHteiXqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTC/CO15; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTC/CO15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219976; x=1801755976;
  h=date:from:to:cc:subject:message-id;
  bh=5AUShYJQ1tWB4mjCqUijFqUO2i9hD7mruNDBB+M2GXM=;
  b=RTC/CO150wlugtZ28wjf2CETmwNjZDLh62hPDcJjmpKsWL7yf4K24kCq
   FsJA3DfOyZZ1MrK3kOj7xx0XwIuTs5BNChqWnGApazl4t/imLpEb1rvu/
   cDRR5/rPynx1fabAzmv1qyVrNyM0sJLTRTBkivlScEzS1IFjl+rYLS+Gr
   VVJ9m+BI6zik/SSVVbZ4DPeAKL/1sJDv1wmDUGkEz4YZc8KgMGO2geEEi
   oolspIc/GgL+2Hi3rBaF3yW08KCKFMaHA64ReCjcIXmh91rDg2WbmYX4Y
   wwQd1qdxygaOk7GvoiDz1Rbj1wJdkcVjeY6glYwMw2JgRwxVkWv1liAmi
   g==;
X-CSE-ConnectionGUID: LZlYSaY2QRediZ55ggO5cw==
X-CSE-MsgGUID: qO/SCF+nTTC7SU2iv8VWRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75030713"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="75030713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:46:16 -0800
X-CSE-ConnectionGUID: qcQpzKDYTvmhN6HaggT8iw==
X-CSE-MsgGUID: XyiQiuKiSNiBIZp3kiwLhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214367352"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Feb 2026 07:46:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnf51-00000000ime-2N8x;
	Wed, 04 Feb 2026 15:46:11 +0000
Date: Wed, 04 Feb 2026 23:45:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 f365bb1bf8702158f87ec50b1ee806f7af1a21a8
Message-ID: <202602042312.H00bRpkv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: f365bb1bf8702158f87ec50b1ee806f7af1a21a8  Merge branch 'pci/misc'

elapsed time: 988m

configs tested: 161
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260204    gcc-9.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20260204    clang-22
arm                   randconfig-002-20260204    gcc-11.5.0
arm                   randconfig-003-20260204    clang-22
arm                   randconfig-004-20260204    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260204    gcc-8.5.0
arm64                 randconfig-002-20260204    clang-22
arm64                 randconfig-003-20260204    clang-22
arm64                 randconfig-004-20260204    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-002-20260204    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260204    clang-19
hexagon               randconfig-002-20260204    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260204    clang-20
i386        buildonly-randconfig-002-20260204    gcc-14
i386        buildonly-randconfig-003-20260204    gcc-14
i386        buildonly-randconfig-004-20260204    gcc-14
i386        buildonly-randconfig-005-20260204    gcc-14
i386        buildonly-randconfig-006-20260204    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-003-20260204    clang-20
i386                  randconfig-004-20260204    gcc-12
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-011-20260204    clang-20
i386                  randconfig-012-20260204    gcc-14
i386                  randconfig-013-20260204    clang-20
i386                  randconfig-014-20260204    clang-20
i386                  randconfig-015-20260204    gcc-13
i386                  randconfig-016-20260204    clang-20
i386                  randconfig-017-20260204    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-002-20260204    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                      pic32mzda_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260204    gcc-11.5.0
nios2                 randconfig-002-20260204    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-002-20260204    gcc-10.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20260204    clang-22
powerpc               randconfig-002-20260204    gcc-14.3.0
powerpc64             randconfig-001-20260204    clang-19
powerpc64             randconfig-002-20260204    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-002-20260204    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                  randconfig-001-20260204    clang-19
s390                  randconfig-002-20260204    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260204    gcc-14.3.0
sh                    randconfig-002-20260204    gcc-12.5.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260204    clang-22
sparc64               randconfig-002-20260204    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260204    gcc-14
um                    randconfig-002-20260204    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260204    gcc-12
x86_64      buildonly-randconfig-002-20260204    gcc-14
x86_64      buildonly-randconfig-003-20260204    clang-20
x86_64      buildonly-randconfig-004-20260204    gcc-14
x86_64      buildonly-randconfig-005-20260204    clang-20
x86_64      buildonly-randconfig-006-20260204    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260204    gcc-13
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-005-20260204    clang-20
x86_64                randconfig-006-20260204    clang-20
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-012-20260204    gcc-14
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-014-20260204    gcc-14
x86_64                randconfig-015-20260204    gcc-14
x86_64                randconfig-016-20260204    gcc-14
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-076-20260204    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260204    gcc-9.5.0
xtensa                randconfig-002-20260204    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
