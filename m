Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DB3B9D86
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488384; cv=none; b=iDUqTedvOU7TmFnckrg+3+Ct+evIeSBk3TPK/dpWNL/l8qwoB+GnVTsgjjrc4NwWfDHBTfxN+Joib+IwimQ1bJ5DipjI2zk8xjV5avGRHGRi+0jOBUj3D1WWiWEyQ1B08QjG7VthdqXF4XSkciocFZwHARnL1i0KnkH3gToN5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488384; c=relaxed/simple;
	bh=ZRMQSRG9qp9L1hI9EZw6OxFbfidLWr72Fak1+spFXOg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T59WsTiNVyApMmhQOjanM4RYOOHDVh9l7s5oY78YRGW/Id4q5fnhmDTVcF4RkP5WHcAp4Ke+m57fE0g1WCaaxR/KHdd728LWwSTDWXZysv0FbhhM7Pts9i/BDQUQyM8Bf1VHPQssPnorC8DdWlXbri9h9zATL/DQOBOR/CT3F3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2Carpqb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2Carpqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783488383; x=1815024383;
  h=date:from:to:cc:subject:message-id;
  bh=ZRMQSRG9qp9L1hI9EZw6OxFbfidLWr72Fak1+spFXOg=;
  b=D2CarpqbKpFrec52izIvphoeYdfwvtntJstK6tIOm7ZxY2LO8tZETvTe
   uD58/dIEHmgec151mcZRP93TqiiW+c2QzmTWA24zvcCTQrk6kx6ZGOsdw
   qQ94QoQalUof+ofRSAsfIjDbJu/Uy5mKoJgYRgCQdpNrAJmDkgIBAm1+e
   4Pg1ubc1nh5QfIlkRgQkXO/HmpfzZ3gQQAEB5TpinaVVQqKefJMkDrymw
   jofw28D7lE8bb7uUT4NrhF0WFKFRjto+XCcKLNnNG/EJAX1iTR1ph0v2B
   WOTWsK/V88W3Flc/RXCdBK/dzXPOpEfYwIV+xYM5OkK3gkti0WenbMjq2
   w==;
X-CSE-ConnectionGUID: fQH/AV9ERx2wtkASHiUVJg==
X-CSE-MsgGUID: mYXKvkL6RseyeNXNFMgwxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95520713"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95520713"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 22:26:22 -0700
X-CSE-ConnectionGUID: E1oWCoEDTzGVqJNt14SA7g==
X-CSE-MsgGUID: d8dX8bOTShmMiAZC/cd2Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247815230"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 07 Jul 2026 22:26:21 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whKna-00000000G3v-2ven;
	Wed, 08 Jul 2026 05:26:18 +0000
Date: Wed, 08 Jul 2026 13:25:26 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 3edb3a038d423480efeb204dbc6ddc9a292f8ecb
Message-ID: <202607081315.YB1a9Nj9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 3edb3a038d423480efeb204dbc6ddc9a292f8ecb  PCI: qcom: Skip PERST# GPIOs provided by downstream PCIe devices

elapsed time: 1417m

configs tested: 143
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-002-20260708    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260708    gcc-11.5.0
arm                   randconfig-002-20260708    gcc-10.5.0
arm                   randconfig-003-20260708    gcc-8.5.0
arm                   randconfig-004-20260708    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-002-20260708    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260708    gcc-11.5.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260708    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260708    clang-21
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260708    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386        buildonly-randconfig-004-20260708    gcc-12
i386        buildonly-randconfig-005-20260708    gcc-14
i386        buildonly-randconfig-006-20260708    gcc-14
i386                                defconfig    clang-22
i386                  randconfig-001-20260708    gcc-14
i386                  randconfig-002-20260708    gcc-14
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260708    gcc-14
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260708    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260708    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260708    gcc-9.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260708    gcc-8.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260708    gcc-12.5.0
parisc                randconfig-002-20260708    gcc-10.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260708    gcc-11.5.0
powerpc               randconfig-002-20260708    gcc-13.4.0
powerpc                     tqm8540_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260708    clang-23
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260708    gcc-8.5.0
riscv                 randconfig-002-20260708    gcc-8.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260708    clang-20
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260708    gcc-16.1.0
sh                    randconfig-002-20260708    gcc-9.5.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260708    gcc-16.1.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260708    clang-22
sparc64               randconfig-002-20260708    clang-20
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260708    gcc-14
um                    randconfig-002-20260708    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260708    clang-22
x86_64      buildonly-randconfig-002-20260708    gcc-14
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64      buildonly-randconfig-004-20260708    clang-22
x86_64      buildonly-randconfig-005-20260708    gcc-14
x86_64      buildonly-randconfig-006-20260708    clang-22
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20260708    gcc-14
x86_64                randconfig-012-20260708    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                randconfig-014-20260708    gcc-14
x86_64                randconfig-015-20260708    gcc-14
x86_64                randconfig-016-20260708    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-002-20260708    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
