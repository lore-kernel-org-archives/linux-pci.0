Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C719D092
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155118; cv=none; b=MMOWgEJeGZsseI23s9i6wTbDnuU65hElZCtfzb2Y3rRDKceAJufBmoEgOouV4fj5Ydi2xnn5dGUTspiH/MUY4+WfPJS20G4E7UdCgTeJXVsEpkj4YNca9Ri8b+utGoOdlRT2AQWCqYTBckxppuqxJgvbHnc+foavDH5Ko9vELRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155118; c=relaxed/simple;
	bh=2A0xD+MhJMWT+FqW3zKKVE22W+Os1YDpIsycrblVW2I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ObpwjGmoOEOgJS8gzwrGSaPwBs1ThObHboG4Nz6al68J+KJmjdmqxgohFDupJVxKH4WTGIkHO3OKFc3Fl34TWBIRHV+vksdg9ArbpP1B+GVVVhmn6C/bNS7EayZiUUJM3apcgYnzo4PexIiQikA1EroaWZJmUQAi6dtAbBp7PaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td8bSIme; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td8bSIme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782155117; x=1813691117;
  h=date:from:to:cc:subject:message-id;
  bh=2A0xD+MhJMWT+FqW3zKKVE22W+Os1YDpIsycrblVW2I=;
  b=Td8bSImeaag8AlL1LGJL3nETvFMx0F0fBK+dHW68Jv0SJZQtP9asuPda
   6b0q5lqK4FtZ7o7/u9DrCiKQt1RcAiczVsYdMiMQXJ22j1/fqe/blVKmm
   jEGq71tqJf+aFOsr3Mu3v+s4L0KGlgO4IWBET7+V3c3J01l0eroPDLxFJ
   0gX4ER0Y8LXJl0aoL/mZwnwdcustFQoVh6rR9Nyb0Q5V6JkAvB3blyHtL
   ztGJ4jGNI5Rv2ja9Hfq1rwIaGH8z8SEbMuuYkq1k0A+TlMLGRVvWl0Rih
   IZ+xZ2eGnY/NvmnG2uLcxNrsKQtUKZPaiXsCqDw1korypye17gml0vGJh
   g==;
X-CSE-ConnectionGUID: rpkkT1TKSV2D0+dicM9bcw==
X-CSE-MsgGUID: 3O4AkuS3SNKAh2ir+9csVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82985711"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82985711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 12:05:17 -0700
X-CSE-ConnectionGUID: 7eBJr1neQgWL61mrI1ADhA==
X-CSE-MsgGUID: qsdt82N2QtGMWQX/GtMDDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="249346336"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 22 Jun 2026 12:05:12 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbjx1-000000001kv-241c;
	Mon, 22 Jun 2026 19:04:58 +0000
Date: Tue, 23 Jun 2026 03:04:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 40e92a5476e7aa3af966d37a58b5d40a929e55c6
Message-ID: <202606230322.Yi3eoErF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 40e92a5476e7aa3af966d37a58b5d40a929e55c6  Merge branch 'pci/misc'

elapsed time: 971m

configs tested: 214
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260622    gcc-8.5.0
arc                   randconfig-002-20260622    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260622    gcc-8.5.0
arm                   randconfig-002-20260622    gcc-8.5.0
arm                   randconfig-003-20260622    gcc-8.5.0
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
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260622    gcc-14
i386        buildonly-randconfig-002-20260622    gcc-14
i386        buildonly-randconfig-003-20260622    gcc-14
i386        buildonly-randconfig-004-20260622    gcc-14
i386        buildonly-randconfig-005-20260622    gcc-14
i386        buildonly-randconfig-006-20260622    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260622    clang-22
i386                  randconfig-002-20260622    clang-22
i386                  randconfig-003-20260622    clang-22
i386                  randconfig-004-20260622    clang-22
i386                  randconfig-005-20260622    clang-22
i386                  randconfig-006-20260622    clang-22
i386                  randconfig-007-20260622    clang-22
i386                  randconfig-011-20260622    gcc-14
i386                  randconfig-012-20260622    gcc-14
i386                  randconfig-013-20260622    gcc-14
i386                  randconfig-014-20260622    gcc-14
i386                  randconfig-015-20260622    gcc-14
i386                  randconfig-016-20260622    gcc-14
i386                  randconfig-017-20260622    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260622    gcc-14.3.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260622    gcc-14.3.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260622    gcc-14.3.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260622    gcc-14.3.0
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260622    gcc-14.3.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260622    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
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
um                                allnoconfig    clang-16
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
x86_64                            allnoconfig    clang-22
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
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260622    gcc-16.1.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260622    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
