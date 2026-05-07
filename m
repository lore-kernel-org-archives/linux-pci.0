Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98344B666
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167637; cv=none; b=PgBTQLU1WLL0ZPyxwLcuKYxxpJoz5MhJk6ODCCY6IRzPly2S+LUl8NkmwIlT4NV8GPj1NUbhN6/ZoHj7WSiHfBv8Lo7T4RutOUBHBCYk8dy5zqo69QImhc9lHQKHPqTrO0FuzuOCfD316SOnoFVrBmjjdqXNtX4MVGD5EUD6Oyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167637; c=relaxed/simple;
	bh=bDI38IKrjIHw1vpR1RaVGLIQe9XdZXzWq7Z/ILfdC+I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p67amnO6RJUfa3ic0v4F0DiHmxpr2JRbwX0lD8n0hIDz9vTUV/8aqD+/nUdYmTdBdviSeQXb6qrCL0y33oYbynCBzq+ivGlCMDbWMQf04sGRflUzLHhAetzaequWRuXFM4VdGO83T12iVRMKGgL5S4ym8acU9Jxbop9TmpE1Qa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKOq7rfQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKOq7rfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778167635; x=1809703635;
  h=date:from:to:cc:subject:message-id;
  bh=bDI38IKrjIHw1vpR1RaVGLIQe9XdZXzWq7Z/ILfdC+I=;
  b=IKOq7rfQVKt3yDx8wXyvc8ym0Uki0C9wH2sZWodEXmHZLXgU/6he3X+C
   gxu4Vm+0OeuYc9KehAoTV2AAo1JtE7fkraLMeS39VbvrXpF6VcUZr/Io9
   M8HDMbs1lC5zOiwbRCeDdlnYqYvwrjKWRtcsm7OGKBMSjhJNkRqCkJ/Cs
   ERmNSwSF8S7nycByvtZ3X5bBBEk6HWs10L3/wr8Wt6S0iJPAvwQEgFZ78
   Lwqk56mi6FlmzWeXi0ICIfPw5duqWdFNKPZfhyTc/kTeyPwrUV+oOz0CU
   8PdUMJR+l7aREjEj2TDFrRN+zn83cK5+O3Sv/ReuiV3u59unhacUneBIY
   Q==;
X-CSE-ConnectionGUID: apV4Hed3RzyMiqPr+n6Bug==
X-CSE-MsgGUID: rgTkQ+bEQfuCU0hwp9nAVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="66649459"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="66649459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 08:27:14 -0700
X-CSE-ConnectionGUID: uCRJcNucT8CvOBeDR2ubUA==
X-CSE-MsgGUID: AV5szq/1RHqi/ifL9tLjHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="238291976"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2026 08:27:13 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL0d4-000000000DV-3vQy;
	Thu, 07 May 2026 15:27:10 +0000
Date: Thu, 07 May 2026 23:26:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 64d63fd28177abd1bbc3133610771aa15c22c223
Message-ID: <202605072311.MyZj1TRU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 64d63fd28177abd1bbc3133610771aa15c22c223  PCI: Bail out early for 2.5GT/s devices in PCIe failed link retraining

elapsed time: 824m

configs tested: 231
configs skipped: 7

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260507    gcc-14.3.0
arc                   randconfig-001-20260507    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260507    gcc-14.3.0
arc                   randconfig-002-20260507    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260507    gcc-14.3.0
arm                   randconfig-001-20260507    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260507    gcc-14.3.0
arm                   randconfig-002-20260507    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260507    gcc-14.3.0
arm                   randconfig-003-20260507    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260507    gcc-14.3.0
arm                   randconfig-004-20260507    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-15.2.0
arm64                 randconfig-001-20260507    gcc-15.2.0
arm64                          randconfig-002    gcc-15.2.0
arm64                 randconfig-002-20260507    gcc-15.2.0
arm64                          randconfig-003    gcc-15.2.0
arm64                 randconfig-003-20260507    gcc-15.2.0
arm64                          randconfig-004    gcc-15.2.0
arm64                 randconfig-004-20260507    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-15.2.0
csky                  randconfig-001-20260507    gcc-15.2.0
csky                           randconfig-002    gcc-15.2.0
csky                  randconfig-002-20260507    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260507    clang-23
hexagon               randconfig-002-20260507    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260507    clang-20
i386        buildonly-randconfig-001-20260507    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260507    clang-20
i386        buildonly-randconfig-002-20260507    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260507    clang-20
i386        buildonly-randconfig-003-20260507    gcc-14
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260507    clang-20
i386        buildonly-randconfig-004-20260507    gcc-14
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260507    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260507    clang-20
i386        buildonly-randconfig-006-20260507    gcc-14
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260507    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260507    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260507    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260507    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260507    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260507    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260507    gcc-14
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260507    clang-20
i386                  randconfig-011-20260507    gcc-14
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260507    clang-20
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260507    clang-20
i386                  randconfig-013-20260507    gcc-14
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260507    clang-20
i386                  randconfig-014-20260507    gcc-14
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260507    clang-20
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260507    clang-20
i386                  randconfig-016-20260507    gcc-14
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260507    clang-20
i386                  randconfig-017-20260507    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260507    clang-23
loongarch             randconfig-002-20260507    clang-23
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
mips                    maltaup_xpa_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260507    clang-23
nios2                 randconfig-002-20260507    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260507    gcc-8.5.0
parisc                randconfig-002-20260507    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    clang-23
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260507    gcc-8.5.0
powerpc               randconfig-002-20260507    gcc-8.5.0
powerpc                     redwood_defconfig    clang-23
powerpc64             randconfig-001-20260507    gcc-8.5.0
powerpc64             randconfig-002-20260507    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260507    gcc-12.5.0
sparc                 randconfig-002-20260507    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260507    gcc-12.5.0
sparc64               randconfig-002-20260507    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260507    gcc-12.5.0
um                    randconfig-002-20260507    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260507    clang-20
x86_64      buildonly-randconfig-002-20260507    clang-20
x86_64      buildonly-randconfig-003-20260507    clang-20
x86_64      buildonly-randconfig-004-20260507    clang-20
x86_64      buildonly-randconfig-005-20260507    clang-20
x86_64      buildonly-randconfig-006-20260507    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260507    gcc-14
x86_64                randconfig-002-20260507    gcc-14
x86_64                randconfig-003-20260507    gcc-14
x86_64                randconfig-004-20260507    gcc-14
x86_64                randconfig-005-20260507    gcc-14
x86_64                randconfig-006-20260507    gcc-14
x86_64                randconfig-011-20260507    gcc-14
x86_64                randconfig-012-20260507    gcc-14
x86_64                randconfig-013-20260507    gcc-14
x86_64                randconfig-014-20260507    gcc-14
x86_64                randconfig-015-20260507    gcc-14
x86_64                randconfig-016-20260507    gcc-14
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260507    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260507    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260507    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260507    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260507    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260507    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260507    gcc-12.5.0
xtensa                randconfig-002-20260507    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
