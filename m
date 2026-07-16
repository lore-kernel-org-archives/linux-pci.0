Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4B3D9DCC
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195478; cv=none; b=hcFnqs0A1wqfro+q4kS36s2B+alag4T3Ncr8b9n7aQBpUi/5o5XSX0TJq9Q5hzOaRO6YZihiDwsyKMRTDJIeN7Avhw+uJU5FTC9V9TGdrlq9dwSgc7l2ZPqmT1ygtLZlxHHLNMrYCWznP/7a6wzsMtfwFjilwtMeIpiaRjiXCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195478; c=relaxed/simple;
	bh=DIlRlnlrj6oju9yvCbEyI+r+/RGgeaI9HpmcO9REogo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IXGLaB9MVKXN4PIk9Ughp+UD+Cez46iS6bTG9RltBog8/OkkSVoltjH8z5n6BAqdRReKTx1XextB4bXvRZ+EKFy8paWXmwppu5Zzf73lNRBEEabfRHiCyJBMhnLggqjnJJN3chdm16Hjyfd1xy2tV6AINLqFboidvyhBCdNi8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU7Mg0QS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fU7Mg0QS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784195477; x=1815731477;
  h=date:from:to:cc:subject:message-id;
  bh=DIlRlnlrj6oju9yvCbEyI+r+/RGgeaI9HpmcO9REogo=;
  b=fU7Mg0QSQAxJAm5HlnhGOzoW2HVM+MQY2D5CQwJ9UfueW858ymFTvli1
   gf1Pc/W3JTzdTabf9a0HA/jZWtSRrtkiueNnjJze3i7DDbTNJXORc9QV6
   nT6Vet0/qRcWnf1DnajVUqLGbfWcwZERdHKCVmtQh0oIKozmrV8Apb4ZJ
   JFxC4reJ0P8vwZ6Pq6gLwEcBa40Y9SArw9WWxBlFUtg5alR415XbxzgOX
   Zsy1kZ639ba8UNOW9vXhCSZrBoTRk42yFcEoJAsbz80/CdSAAARpKxHS1
   4QI6iodhg505yEJfTMNEfzaag9k1lxBSSltJ792+Cf/y8WVmPRvIlAFGN
   A==;
X-CSE-ConnectionGUID: TBNj8knkQM2dPHicWuzA8A==
X-CSE-MsgGUID: W/fDd4a1SvKM0xypCzyVKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84630454"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84630454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:51:17 -0700
X-CSE-ConnectionGUID: /MINMNn+ToKuUqExXECJiw==
X-CSE-MsgGUID: OoyKqHJBTbiQI0IkciEyEg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2026 02:51:15 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkIkK-00000000OeI-3LXs;
	Thu, 16 Jul 2026 09:51:12 +0000
Date: Thu, 16 Jul 2026 17:50:24 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 2077ccb9baa2cbbbccf5f0d8c2196dd9d5e43399
Message-ID: <202607161713.jmb4ZC8D-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 2077ccb9baa2cbbbccf5f0d8c2196dd9d5e43399  PCI: mediatek: Add support for EcoNet EN7528 SoC

elapsed time: 1116m

configs tested: 106
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arm                              allyesconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-001-20260716    clang-23
arm64                 randconfig-002-20260716    clang-22
arm64                 randconfig-003-20260716    clang-23
arm64                 randconfig-004-20260716    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260716    gcc-12.5.0
csky                  randconfig-002-20260716    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260716    clang-24
hexagon               randconfig-002-20260716    clang-24
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260716    clang-22
i386        buildonly-randconfig-002-20260716    clang-22
i386        buildonly-randconfig-003-20260716    clang-22
i386        buildonly-randconfig-004-20260716    clang-22
i386        buildonly-randconfig-005-20260716    clang-22
i386        buildonly-randconfig-006-20260716    clang-22
i386                  randconfig-011-20260716    clang-22
i386                  randconfig-012-20260716    gcc-12
i386                  randconfig-013-20260716    clang-22
i386                  randconfig-014-20260716    gcc-12
i386                  randconfig-015-20260716    clang-22
i386                  randconfig-016-20260716    gcc-14
i386                  randconfig-017-20260716    clang-22
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260716    clang-20
loongarch             randconfig-002-20260716    clang-24
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260716    gcc-8.5.0
nios2                 randconfig-002-20260716    gcc-8.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260716    gcc-15.2.0
parisc                randconfig-002-20260716    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260716    clang-21
powerpc               randconfig-002-20260716    clang-19
powerpc64             randconfig-001-20260716    clang-22
powerpc64             randconfig-002-20260716    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-24
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260716    gcc-13.4.0
sparc                 randconfig-002-20260716    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64               randconfig-001-20260716    clang-23
sparc64               randconfig-002-20260716    clang-23
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                    randconfig-001-20260716    clang-23
um                    randconfig-002-20260716    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64                randconfig-071-20260716    clang-22
x86_64                randconfig-072-20260716    clang-22
x86_64                randconfig-073-20260716    clang-22
x86_64                randconfig-074-20260716    gcc-14
x86_64                randconfig-075-20260716    clang-22
x86_64                randconfig-076-20260716    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260716    gcc-9.5.0
xtensa                randconfig-002-20260716    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
