Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B4349CF3
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157251; cv=none; b=biVIerDYS4LLwlsWzNivsOBI7qsEVMZzK7nmT4nwo5+5RnPZFfZSO6wdDCkrmCLl5U2JQZlpxg8pZsUUz/Vc7enQdpiRBPzONZqp1d2YF/uXuBvjvWT6eg66fe1nHPaMH+dGz1FX5OifogJ8PbyIyFgJBvmnWhGBdlllvCIfTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157251; c=relaxed/simple;
	bh=Hm6tW6PdA+h89LfsBYOahCbk7l/RhzDjIf/hqHkC4Ew=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bu7vSvPfUNIBdNqcHqJZwVxyU24eCCQEd9FNhwepQE5i0ieT/j+oeiZdSRSXtOUo4w4f/FVDphERnb3Pxwhv06wM/hDrb5tQFkt11zLhvLTTvreKuLaXWRTSe29n15vvwZw5GnvXsD1SOFzDh33Zfr+lzpPAj8uQ7d15Gr0r71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBWwcOWn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBWwcOWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782157250; x=1813693250;
  h=date:from:to:cc:subject:message-id;
  bh=Hm6tW6PdA+h89LfsBYOahCbk7l/RhzDjIf/hqHkC4Ew=;
  b=OBWwcOWnlny4Uyc1U0bswYetahCk81ZGXwKqFUu/MnUh914yYCCERvYz
   zuPsLpxtknZVixAg5/fmjJG13InshdQqw4NV9VXHRjZw646d9648SGkLn
   a0gC6U3Ucmy4Jg6VK8C6TLrry4rek9gyXpq1AC0Qnfi+ubUrZzXF7qyzE
   RmPtucnQF4p17d13/br/twCoGlP+6CROoFXpBd43fTn2E22szuXFnmeIx
   Z2MwD+cEttL0KdlezBBqEYOe3eN3y5MUT42yuuiidLwH+qG+1CzszYAZz
   y7VSuvOv6C1v9A0CFGHdUOIC+L0U9AyvXmXrvznREgPepdvtTd+u1h5ge
   g==;
X-CSE-ConnectionGUID: lPRqmn5dSNaguIz82nmDUQ==
X-CSE-MsgGUID: z95fz1SUR0e7Jn8Va4Engg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86584766"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="86584766"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 12:40:50 -0700
X-CSE-ConnectionGUID: 74bMxO+0TlWZdUxjNEEu+g==
X-CSE-MsgGUID: 2ph7hqy/RtOAhgH/RFEr1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="253651564"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Jun 2026 12:40:49 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbkVX-000000001n5-0rds;
	Mon, 22 Jun 2026 19:40:37 +0000
Date: Tue, 23 Jun 2026 03:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/host-common] BUILD SUCCESS
 fda8749ba73638f5bbca3ffb39bc6861eb3b23fa
Message-ID: <202606230345.m9Asi6B4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/host-common
branch HEAD: fda8749ba73638f5bbca3ffb39bc6861eb3b23fa  PCI: host-common: Request bus reassignment when not probe-only

elapsed time: 1007m

configs tested: 220
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260622    gcc-8.5.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260622    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260622    gcc-8.5.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260622    gcc-8.5.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260622    gcc-8.5.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260622    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260622    gcc-8.5.0
arm64                 randconfig-002-20260622    gcc-8.5.0
arm64                 randconfig-003-20260622    gcc-8.5.0
arm64                 randconfig-004-20260622    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260622    gcc-8.5.0
csky                  randconfig-002-20260622    gcc-8.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260622    gcc-14
i386        buildonly-randconfig-002-20260622    gcc-14
i386        buildonly-randconfig-003-20260622    gcc-14
i386        buildonly-randconfig-004-20260622    gcc-14
i386        buildonly-randconfig-005-20260622    gcc-14
i386        buildonly-randconfig-006-20260622    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260622    clang-22
i386                  randconfig-001-20260623    clang-22
i386                  randconfig-002-20260622    clang-22
i386                  randconfig-002-20260623    clang-22
i386                  randconfig-003-20260622    clang-22
i386                  randconfig-003-20260623    clang-22
i386                  randconfig-004-20260622    clang-22
i386                  randconfig-004-20260623    clang-22
i386                  randconfig-005-20260622    clang-22
i386                  randconfig-005-20260623    clang-22
i386                  randconfig-006-20260622    clang-22
i386                  randconfig-006-20260623    clang-22
i386                  randconfig-007-20260622    clang-22
i386                  randconfig-007-20260623    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260622    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260622    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260622    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260622    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260622    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260622    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260622    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-8.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        qi_lb60_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260622    gcc-14.3.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260622    gcc-14.3.0
parisc64                            defconfig    clang-23
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260622    gcc-14.3.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260622    gcc-14.3.0
powerpc64                        alldefconfig    clang-17
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260622    gcc-14.3.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260622    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260622    gcc-16.1.0
sparc                          randconfig-002    gcc-16.1.0
sparc                 randconfig-002-20260622    gcc-16.1.0
sparc                       sparc32_defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-16.1.0
sparc64               randconfig-001-20260622    gcc-16.1.0
sparc64                        randconfig-002    gcc-16.1.0
sparc64               randconfig-002-20260622    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-16.1.0
um                    randconfig-001-20260622    gcc-16.1.0
um                             randconfig-002    gcc-16.1.0
um                    randconfig-002-20260622    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260622    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260622    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260622    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260622    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260622    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260622    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260622    clang-22
x86_64                randconfig-002-20260622    clang-22
x86_64                randconfig-003-20260622    clang-22
x86_64                randconfig-004-20260622    clang-22
x86_64                randconfig-005-20260622    clang-22
x86_64                randconfig-006-20260622    clang-22
x86_64                randconfig-011-20260622    clang-22
x86_64                randconfig-012-20260622    clang-22
x86_64                randconfig-013-20260622    clang-22
x86_64                randconfig-014-20260622    clang-22
x86_64                randconfig-015-20260622    clang-22
x86_64                randconfig-016-20260622    clang-22
x86_64                randconfig-071-20260622    gcc-14
x86_64                randconfig-072-20260622    gcc-14
x86_64                randconfig-073-20260622    gcc-14
x86_64                randconfig-074-20260622    gcc-14
x86_64                randconfig-075-20260622    gcc-14
x86_64                randconfig-076-20260622    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260622    gcc-16.1.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260622    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
