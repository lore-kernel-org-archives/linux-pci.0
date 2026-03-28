Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019D37472B
	for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774684020; cv=none; b=dDnXGNyVil7aF3LUO4Svs1OeiE5fHdWM7wnxdE+Bl3UoajLWQRCND4hkOurAw1G3WLeqA4yAdN66Mrc7uWQUXRMbOiAB2exP44ZK3rzwogdoyTyDqm6BBZpEFeO7KrH0Vk/DDDUpx+5zGho+oIC7ghNApCOL5BO6LYGC8vJN1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774684020; c=relaxed/simple;
	bh=G+FIx3CcEULEPM04w6kzxKOYYWvFFxyhI9VHEydTHvQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pGQNGR4Pffflu0+9gQkrsOWgCO9IoZUBTTdzwMXUdQnrrvE26gHW1PQqr9wzmqOlW41eJuwLIW0bFKMEj1ydmbyxnBMw0F+kutUICFkIhnnyv7/1L0SVfuBviL+fwAoSu+FpbqPdCQZDaUkoPehBxnaqwjF2iwbI5MnsKV7hWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fy2o3GD4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fy2o3GD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774684019; x=1806220019;
  h=date:from:to:cc:subject:message-id;
  bh=G+FIx3CcEULEPM04w6kzxKOYYWvFFxyhI9VHEydTHvQ=;
  b=Fy2o3GD4rkTWyRePxLPejMvmUtaCcFt5kBnqhu3ut0Lj3Bqc562IXx72
   Pk9Pgj9bpwyFScSM3EPM1PCl2cWN703WikBLO4c01gy0I9MRMrYrq5QYH
   QRQ5iVogEbDsofoKn45tqNLPqNenYkw6xDToB5ponArYFVGptMaKPM6Ie
   V++mIguOrRvTD/op6GhTQK4/bQhBW1iNo0IWsRC6jxQNi0Fbetyrk1MTz
   h6nb3jN6JGBXV1Pd1aPAmhClqMuWzeOFe3pw+aAUDtfrdZ4uO+oy62oqJ
   X+9/hlFqCCpzaaWGkKMteqJtmihW7MzcLHA4Mdjaz6rH7+78NsGoKHmon
   w==;
X-CSE-ConnectionGUID: V39nV+TDSvGtvNCkE3u03Q==
X-CSE-MsgGUID: 774QjeJUQTSidbZ2Ym+NEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="79358042"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="79358042"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 00:46:58 -0700
X-CSE-ConnectionGUID: jEyidcfwRWW6yMNWF/x9pA==
X-CSE-MsgGUID: 6WOAY6AYQ2OxgPzAeqm2Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="248770875"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Mar 2026 00:46:57 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6ONi-00000000BCB-2Yto;
	Sat, 28 Mar 2026 07:46:54 +0000
Date: Sat, 28 Mar 2026 15:46:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 8cb081667377709f4924ab6b3a88a0d7a761fe91
Message-ID: <202603281504.eEZFXtJL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 8cb081667377709f4924ab6b3a88a0d7a761fe91  PCI: Fix alignment calculation for resource size larger than align

elapsed time: 747m

configs tested: 200
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260328    gcc-15.2.0
arc                   randconfig-002-20260328    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260328    gcc-15.2.0
arm                   randconfig-002-20260328    gcc-15.2.0
arm                   randconfig-003-20260328    gcc-15.2.0
arm                   randconfig-004-20260328    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260328    gcc-14.3.0
arm64                 randconfig-002-20260328    gcc-14.3.0
arm64                 randconfig-003-20260328    gcc-14.3.0
arm64                 randconfig-004-20260328    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260328    gcc-14.3.0
csky                  randconfig-002-20260328    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260328    gcc-11.5.0
hexagon               randconfig-002-20260328    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260328    clang-20
i386        buildonly-randconfig-002-20260328    clang-20
i386        buildonly-randconfig-002-20260328    gcc-12
i386        buildonly-randconfig-003-20260328    clang-20
i386        buildonly-randconfig-003-20260328    gcc-14
i386        buildonly-randconfig-004-20260328    clang-20
i386        buildonly-randconfig-005-20260328    clang-20
i386        buildonly-randconfig-006-20260328    clang-20
i386        buildonly-randconfig-006-20260328    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260328    clang-20
i386                  randconfig-002-20260328    clang-20
i386                  randconfig-003-20260328    clang-20
i386                  randconfig-004-20260328    clang-20
i386                  randconfig-005-20260328    clang-20
i386                  randconfig-006-20260328    clang-20
i386                  randconfig-007-20260328    clang-20
i386                  randconfig-011-20260328    gcc-13
i386                  randconfig-012-20260328    gcc-13
i386                  randconfig-013-20260328    gcc-13
i386                  randconfig-014-20260328    gcc-13
i386                  randconfig-015-20260328    gcc-13
i386                  randconfig-016-20260328    gcc-13
i386                  randconfig-017-20260328    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260328    gcc-11.5.0
loongarch             randconfig-002-20260328    gcc-11.5.0
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
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260328    gcc-11.5.0
nios2                 randconfig-002-20260328    gcc-11.5.0
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
parisc                randconfig-001-20260328    gcc-10.5.0
parisc                randconfig-002-20260328    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260328    gcc-10.5.0
powerpc               randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260328    gcc-10.5.0
powerpc64             randconfig-002-20260328    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260328    clang-23
riscv                 randconfig-002-20260328    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260328    clang-23
s390                  randconfig-002-20260328    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260328    clang-23
sh                    randconfig-002-20260328    clang-23
sh                           se7705_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260328    gcc-14
sparc                 randconfig-002-20260328    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260328    gcc-14
sparc64               randconfig-002-20260328    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260328    gcc-14
um                    randconfig-002-20260328    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260328    clang-20
x86_64      buildonly-randconfig-002-20260328    clang-20
x86_64      buildonly-randconfig-003-20260328    clang-20
x86_64      buildonly-randconfig-004-20260328    clang-20
x86_64      buildonly-randconfig-005-20260328    clang-20
x86_64      buildonly-randconfig-006-20260328    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260328    gcc-14
x86_64                randconfig-002-20260328    gcc-14
x86_64                randconfig-003-20260328    gcc-14
x86_64                randconfig-004-20260328    gcc-14
x86_64                randconfig-005-20260328    gcc-14
x86_64                randconfig-006-20260328    gcc-14
x86_64                randconfig-011-20260328    clang-20
x86_64                randconfig-012-20260328    clang-20
x86_64                randconfig-013-20260328    clang-20
x86_64                randconfig-014-20260328    clang-20
x86_64                randconfig-015-20260328    clang-20
x86_64                randconfig-016-20260328    clang-20
x86_64                randconfig-071-20260328    gcc-12
x86_64                randconfig-072-20260328    gcc-12
x86_64                randconfig-073-20260328    gcc-12
x86_64                randconfig-074-20260328    gcc-12
x86_64                randconfig-075-20260328    gcc-12
x86_64                randconfig-076-20260328    gcc-12
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
xtensa                randconfig-001-20260328    gcc-14
xtensa                randconfig-002-20260328    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
