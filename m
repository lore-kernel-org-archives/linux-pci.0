Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C813AF2
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377452; cv=none; b=jk42PeXXlOA63oIy71P+kvM+5YA7HvAuRy+kFPg92A8vJJ7hUReXQavpiJ8yH09nY7lvEoXcZF+llSWisP1Cinjm/be8mvMtYtWzLSchCIulGeU0IKuoRLyJCLA5M0NI0DkdhCqEzG+JzDPxZd/rxdjvX5PEwYiJO0Zw5XTG0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377452; c=relaxed/simple;
	bh=TlsBrTkQ7opmJBB95AERh0ZyTZU2evL10M+WzIUwTic=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pQxBGLIjR/zxLEbr1nGsvLOQBh+uSeWUsffKFF7n1sWk0IPWoyb7C8W93uoYes96u+5de2u2Pr+QsgNr2SfhJj25fOyn652c8SotKPinXgEG6QlijZIAdq2vLX+TrqMNtDqjSfp/vKjzGneUoYBLCtb7dDKlIc6oqcY45kwTNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arz2NMZ5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arz2NMZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781377449; x=1812913449;
  h=date:from:to:cc:subject:message-id;
  bh=TlsBrTkQ7opmJBB95AERh0ZyTZU2evL10M+WzIUwTic=;
  b=arz2NMZ5jYmmTrK40NUiL3oEKr21WomG7e+SgV7Lizh6B3qHSQcDwSKG
   RXlNwbesXb1YzTfmSNDzYKYseR2kRUwB4MVS7zQBBtJk6Uk/bLRaAtZ6R
   pjQCdDR9TZ99TTS9PjT39uw9L+NSdFZA4dxhhb70TupgIOLh5xhs+S3lH
   vSMC4bTvT5OdhvWCn+2UtuVB76FuknydstrcZBsYOzKgOy/Satt7XVttw
   cVF15TAT0T45zMw7RDyrnPkNqZsKlH1qf3WBDFR9ehebGyEyOlR37pdv+
   Lbd30NhiTIJ4EHWhb71qhPdxDJ/VFpOEyltyUPXDObkVTa7LbQ1DdRJ0o
   g==;
X-CSE-ConnectionGUID: yEFN2uBMR8u7yen7X8jB1w==
X-CSE-MsgGUID: 00A2ex4eSU+5KN1KjiVxwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="93567877"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="93567877"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 12:04:09 -0700
X-CSE-ConnectionGUID: PTYP6peaTHmYk3KlA/jONw==
X-CSE-MsgGUID: 9dY+7KvbQf2bCy3pY2LUSw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Jun 2026 12:04:07 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYTeH-00000000QBq-2P2H;
	Sat, 13 Jun 2026 19:04:05 +0000
Date: Sun, 14 Jun 2026 03:04:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 6d8135abc78ea7a0a7ad34008e8f47c2b3e63413
Message-ID: <202606140348.s4K19vFI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 6d8135abc78ea7a0a7ad34008e8f47c2b3e63413  PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

elapsed time: 947m

configs tested: 218
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
arc                   randconfig-001-20260613    gcc-12.5.0
arc                   randconfig-001-20260614    gcc-11.5.0
arc                   randconfig-002-20260613    gcc-12.5.0
arc                   randconfig-002-20260614    gcc-11.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260613    gcc-12.5.0
arm                   randconfig-001-20260614    gcc-11.5.0
arm                   randconfig-002-20260613    gcc-12.5.0
arm                   randconfig-002-20260614    gcc-11.5.0
arm                   randconfig-003-20260613    gcc-12.5.0
arm                   randconfig-003-20260614    gcc-11.5.0
arm                   randconfig-004-20260613    gcc-12.5.0
arm                   randconfig-004-20260614    gcc-11.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-16.1.0
arm64                 randconfig-001-20260613    gcc-16.1.0
arm64                          randconfig-002    gcc-16.1.0
arm64                 randconfig-002-20260613    gcc-16.1.0
arm64                          randconfig-003    gcc-16.1.0
arm64                 randconfig-003-20260613    gcc-16.1.0
arm64                          randconfig-004    gcc-16.1.0
arm64                 randconfig-004-20260613    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-16.1.0
csky                  randconfig-001-20260613    gcc-16.1.0
csky                           randconfig-002    gcc-16.1.0
csky                  randconfig-002-20260613    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260613    clang-23
hexagon               randconfig-001-20260614    clang-17
hexagon               randconfig-002-20260613    clang-23
hexagon               randconfig-002-20260614    clang-17
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260613    gcc-14
i386        buildonly-randconfig-002-20260613    gcc-14
i386        buildonly-randconfig-003-20260613    gcc-14
i386        buildonly-randconfig-004-20260613    gcc-14
i386        buildonly-randconfig-005-20260613    gcc-14
i386        buildonly-randconfig-006-20260613    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260613    clang-22
i386                  randconfig-002-20260613    clang-22
i386                  randconfig-003-20260613    clang-22
i386                  randconfig-004-20260613    clang-22
i386                  randconfig-005-20260613    clang-22
i386                  randconfig-006-20260613    clang-22
i386                  randconfig-007-20260613    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260613    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260613    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260613    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260613    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260613    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260613    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260613    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260613    clang-23
loongarch             randconfig-001-20260614    clang-17
loongarch             randconfig-002-20260613    clang-23
loongarch             randconfig-002-20260614    clang-17
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
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260613    clang-23
nios2                 randconfig-001-20260614    clang-17
nios2                 randconfig-002-20260613    clang-23
nios2                 randconfig-002-20260614    clang-17
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-15.2.0
parisc                randconfig-001-20260613    gcc-15.2.0
parisc                         randconfig-002    gcc-15.2.0
parisc                randconfig-002-20260613    gcc-15.2.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                 canyonlands_defconfig    clang-22
powerpc                        randconfig-001    gcc-15.2.0
powerpc               randconfig-001-20260613    gcc-15.2.0
powerpc                        randconfig-002    gcc-15.2.0
powerpc               randconfig-002-20260613    gcc-15.2.0
powerpc64                      randconfig-001    gcc-15.2.0
powerpc64             randconfig-001-20260613    gcc-15.2.0
powerpc64                      randconfig-002    gcc-15.2.0
powerpc64             randconfig-002-20260613    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260613    gcc-10.5.0
riscv                 randconfig-001-20260614    gcc-9.5.0
riscv                 randconfig-002-20260613    gcc-10.5.0
riscv                 randconfig-002-20260614    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260613    gcc-10.5.0
s390                  randconfig-001-20260614    gcc-9.5.0
s390                  randconfig-002-20260613    gcc-10.5.0
s390                  randconfig-002-20260614    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    gcc-16.1.0
sh                    randconfig-001-20260613    gcc-10.5.0
sh                    randconfig-001-20260614    gcc-9.5.0
sh                    randconfig-002-20260613    gcc-10.5.0
sh                    randconfig-002-20260614    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260613    gcc-13.4.0
sparc                 randconfig-002-20260613    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260613    gcc-13.4.0
sparc64               randconfig-002-20260613    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260613    gcc-13.4.0
um                    randconfig-002-20260613    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260613    clang-22
x86_64      buildonly-randconfig-002-20260613    clang-22
x86_64      buildonly-randconfig-003-20260613    clang-22
x86_64      buildonly-randconfig-004-20260613    clang-22
x86_64      buildonly-randconfig-005-20260613    clang-22
x86_64      buildonly-randconfig-006-20260613    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260613    clang-22
x86_64                randconfig-002-20260613    clang-22
x86_64                randconfig-003-20260613    clang-22
x86_64                randconfig-004-20260613    clang-22
x86_64                randconfig-005-20260613    clang-22
x86_64                randconfig-006-20260613    clang-22
x86_64                randconfig-011-20260613    clang-22
x86_64                randconfig-012-20260613    clang-22
x86_64                randconfig-013-20260613    clang-22
x86_64                randconfig-014-20260613    clang-22
x86_64                randconfig-015-20260613    clang-22
x86_64                randconfig-016-20260613    clang-22
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260613    clang-22
x86_64                randconfig-071-20260613    gcc-13
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260613    clang-22
x86_64                randconfig-072-20260613    gcc-13
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260613    clang-22
x86_64                randconfig-073-20260613    gcc-13
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260613    clang-22
x86_64                randconfig-074-20260613    gcc-13
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260613    clang-22
x86_64                randconfig-075-20260613    gcc-13
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260613    clang-22
x86_64                randconfig-076-20260613    gcc-13
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260613    gcc-13.4.0
xtensa                randconfig-002-20260613    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
