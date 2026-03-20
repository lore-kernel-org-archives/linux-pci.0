Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB798282F33
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036552; cv=none; b=P0YhWWG8avWonQv1hVtduAnx+3WdJR6gKiecc31taUX00GajZZYHTll6rxtyXgahEPCxwEvQccIcXMVTHFi90qJUvKCegFOBJ3uIzOJqJnsyAKHLIXqAEubg6xf0sl70+n84HGMyCvtB+r8QT5jTIe0mLRL+pMY/2iwTdLGeIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036552; c=relaxed/simple;
	bh=2a2oMevNS3mRfT9ac6FiBzLROEobcuvPHugcO038vZU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cb3cvfv0wdUdGJiPYYdSFhYZmkIFA2gZjmZJ8LCmdTDv7eblF1R04usc4Dadht+03MVXM7IBh2oZUfvFnehp5df/DKcdDsqmidd6KxX2QPNx4RMr0PrbIXiZVH2spi2GnmZ9csQk5ztKLN1rxKiDeOL7nMk/deV2OdnKlCnZesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf+cY0cg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf+cY0cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774036551; x=1805572551;
  h=date:from:to:cc:subject:message-id;
  bh=2a2oMevNS3mRfT9ac6FiBzLROEobcuvPHugcO038vZU=;
  b=Cf+cY0cgpCvTJq7tcigXcazw404+/vUzQ6q0/YbxQ5XMFDU0MgicDDM+
   rvDdji3NGmNIjnIKLfKpA0P72iYDPpvu9e+8kqB2gCRERLX3PZH0ttjwZ
   9IGZouPtDUh202cz889bbxMV89m3+rAkbI5xQGOWr0vlx7gPh+B+iGvpk
   9TFzyEbgsiiQ/CjJgS9X48IEI6Y/p6V55p/OK+HiP4OHzfMBPEl55bOCS
   Gnfg8ormwIwM71N14hyRmDhjn+cfUSZSwgjsyRf53ecDfoN3rdxwRHb9O
   jDCT4F16akjz+C+C4QiN3+rNGVQUwVBD0swHB/n28Nq4A8uwWdyuLb8fw
   Q==;
X-CSE-ConnectionGUID: w2ubr6BlTz6bzqxaqql/gQ==
X-CSE-MsgGUID: 9AidvJYlRdK3H2qJ617p8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="78731942"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78731942"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:55:51 -0700
X-CSE-ConnectionGUID: VMQ91nAsReCAEsiMPuvjZw==
X-CSE-MsgGUID: u5UTWVruRKmooQiDamaPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227494750"
Received: from lkp-server02.sh.intel.com (HELO ef9b23065726) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 20 Mar 2026 12:55:48 -0700
Received: from kbuild by ef9b23065726 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3fwg-0000000009K-17M6;
	Fri, 20 Mar 2026 19:55:46 +0000
Date: Sat, 21 Mar 2026 03:42:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 13292811c9d461d4b0478ce8fa2d55d3cba5a905
Message-ID: <202603210318.8knXwv9J-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 13292811c9d461d4b0478ce8fa2d55d3cba5a905  Merge branch 'pci/misc'

elapsed time: 1268m

configs tested: 200
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260320    gcc-13.4.0
arc                   randconfig-001-20260321    gcc-8.5.0
arc                   randconfig-002-20260320    gcc-13.4.0
arc                   randconfig-002-20260321    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260320    gcc-13.4.0
arm                   randconfig-001-20260321    gcc-8.5.0
arm                   randconfig-002-20260320    gcc-13.4.0
arm                   randconfig-002-20260321    gcc-8.5.0
arm                   randconfig-003-20260320    gcc-13.4.0
arm                   randconfig-003-20260321    gcc-8.5.0
arm                   randconfig-004-20260320    gcc-13.4.0
arm                   randconfig-004-20260321    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260320    clang-17
arm64                 randconfig-001-20260321    clang-23
arm64                 randconfig-002-20260320    clang-17
arm64                 randconfig-002-20260321    clang-23
arm64                 randconfig-003-20260320    clang-17
arm64                 randconfig-003-20260321    clang-23
arm64                 randconfig-004-20260320    clang-17
arm64                 randconfig-004-20260321    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260320    clang-17
csky                  randconfig-001-20260321    clang-23
csky                  randconfig-002-20260320    clang-17
csky                  randconfig-002-20260321    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260320    gcc-8.5.0
hexagon               randconfig-001-20260321    gcc-11.5.0
hexagon               randconfig-002-20260320    gcc-8.5.0
hexagon               randconfig-002-20260321    gcc-11.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260320    gcc-14
i386        buildonly-randconfig-001-20260321    clang-20
i386        buildonly-randconfig-002-20260320    gcc-14
i386        buildonly-randconfig-002-20260321    clang-20
i386        buildonly-randconfig-003-20260320    gcc-14
i386        buildonly-randconfig-003-20260321    clang-20
i386        buildonly-randconfig-004-20260320    gcc-14
i386        buildonly-randconfig-004-20260321    clang-20
i386        buildonly-randconfig-005-20260320    gcc-14
i386        buildonly-randconfig-005-20260321    clang-20
i386        buildonly-randconfig-006-20260320    gcc-14
i386        buildonly-randconfig-006-20260321    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260320    gcc-8.5.0
loongarch             randconfig-001-20260321    gcc-11.5.0
loongarch             randconfig-002-20260320    gcc-8.5.0
loongarch             randconfig-002-20260321    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260320    gcc-8.5.0
nios2                 randconfig-001-20260321    gcc-11.5.0
nios2                 randconfig-002-20260320    gcc-8.5.0
nios2                 randconfig-002-20260321    gcc-11.5.0
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
parisc                randconfig-001-20260320    gcc-10.5.0
parisc                randconfig-001-20260321    clang-23
parisc                randconfig-002-20260320    gcc-10.5.0
parisc                randconfig-002-20260321    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260320    gcc-10.5.0
powerpc               randconfig-001-20260321    clang-23
powerpc               randconfig-002-20260320    gcc-10.5.0
powerpc               randconfig-002-20260321    clang-23
powerpc64             randconfig-001-20260320    gcc-10.5.0
powerpc64             randconfig-001-20260321    clang-23
powerpc64             randconfig-002-20260320    gcc-10.5.0
powerpc64             randconfig-002-20260321    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260321    clang-23
riscv                 randconfig-002-20260321    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260321    clang-23
s390                  randconfig-002-20260321    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260321    clang-23
sh                    randconfig-002-20260321    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260320    gcc-14
sparc                 randconfig-001-20260321    gcc-14
sparc                 randconfig-002-20260320    gcc-14
sparc                 randconfig-002-20260321    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260320    gcc-14
sparc64               randconfig-001-20260321    gcc-14
sparc64               randconfig-002-20260320    gcc-14
sparc64               randconfig-002-20260321    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260320    gcc-14
um                    randconfig-001-20260321    gcc-14
um                    randconfig-002-20260320    gcc-14
um                    randconfig-002-20260321    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260320    clang-20
x86_64      buildonly-randconfig-002-20260320    clang-20
x86_64      buildonly-randconfig-003-20260320    clang-20
x86_64      buildonly-randconfig-004-20260320    clang-20
x86_64      buildonly-randconfig-005-20260320    clang-20
x86_64      buildonly-randconfig-006-20260320    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260320    gcc-14
x86_64                randconfig-012-20260320    gcc-14
x86_64                randconfig-013-20260320    gcc-14
x86_64                randconfig-014-20260320    gcc-14
x86_64                randconfig-015-20260320    gcc-14
x86_64                randconfig-016-20260320    gcc-14
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
xtensa                randconfig-001-20260320    gcc-14
xtensa                randconfig-001-20260321    gcc-14
xtensa                randconfig-002-20260320    gcc-14
xtensa                randconfig-002-20260321    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
