Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C9128816
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492230; cv=none; b=i6a5AmXYs/55XGsMQGs1U3eeGxj2oeGmTPNIrixZihapySNEDb+aUo5QRVa9miokE0Lnf6OyEO6Og/W9cK0sq2w+3rDNiUkIn1aT0f52ME2c1LuOFBTqwWVjUH3Pbw0fjyBdLuML78HDIYCHi/Dmpu/TMPYtXBl0Ufv6k+0kSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492230; c=relaxed/simple;
	bh=7a3ViGo9NC5EaU2iukgscesOrFhUWs1qC1w9ke/SMD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WJc1/mNjTV8ohZXwNEd0v7HrYIopPOP172DjYnuW4tZkslwhhy4CRUOTSaoXdSgrSHI/RCaiqvVUFMCA6vbaZgV1xerkesfPkQvMbNcH8RG4xs1dIOBIQRYObAq0NgifxFJ9jkLMcwDtkh3BbEHVEFDf2Y4VDK70EUmaXZDuVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDT14eWY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDT14eWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781492229; x=1813028229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7a3ViGo9NC5EaU2iukgscesOrFhUWs1qC1w9ke/SMD0=;
  b=QDT14eWYjO2WRQdO9fZRh4WS7fKPKvrlqUEj4dMDc2IgH9ywXhE/90NW
   rPWiiXgw0sQSQWOP4xTi0dlwDcGq89gAGpjVEBgOMrN1pohxKvHMoKuiU
   4z/tzq5w0u/yMXLJH67zMo8Nms5o5efmDubyY/QnQtt8YqZmDTNeewcrU
   N4AwQnrZ4wNwG46B84GWNG0EToCEvGhHxlGDdXsUsiivkGutG29EOqNS6
   0MPlU9/lFk6rjyJ3rLnrD8l2TN1UDPPjxVbqTcos78G2Aldd0kmtc1Hyk
   QnH3LdC2efhV1nx2Q29Rfv/W6H+81QJuxK3Ep3yMBsOqdsZ/Oiz+BNVTz
   g==;
X-CSE-ConnectionGUID: CSKqqs18SpeexEaNy9Gz1g==
X-CSE-MsgGUID: B5EMWyxJQhC2TUgeQDebEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93718592"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="93718592"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:57:09 -0700
X-CSE-ConnectionGUID: p3OXilTxSZKGlYGWYXUTmg==
X-CSE-MsgGUID: pkRODPArTRWeufhWl2R8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="285455916"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2026 19:57:06 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYxVX-00000000RQM-23a8;
	Mon, 15 Jun 2026 02:57:03 +0000
Date: Mon, 15 Jun 2026 10:56:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/sysfs-kstrtobool] BUILD SUCCESS
 c497e360f49414194f031d52cda39206c342be8f
Message-ID: <202606151056.CznnKflg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/sysfs-kstrtobool
branch HEAD: c497e360f49414194f031d52cda39206c342be8f  PCI/sysfs: Replace kstrtoul() with kstrtobool() for boolean attributes

elapsed time: 818m

configs tested: 289
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-10.5.0
arc                   randconfig-001-20260614    gcc-11.5.0
arc                   randconfig-001-20260615    gcc-10.5.0
arc                            randconfig-002    gcc-10.5.0
arc                   randconfig-002-20260614    gcc-11.5.0
arc                   randconfig-002-20260615    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                      footbridge_defconfig    clang-23
arm                         orion5x_defconfig    clang-21
arm                            randconfig-001    gcc-10.5.0
arm                   randconfig-001-20260614    gcc-11.5.0
arm                   randconfig-001-20260615    gcc-10.5.0
arm                            randconfig-002    gcc-10.5.0
arm                   randconfig-002-20260614    gcc-11.5.0
arm                   randconfig-002-20260615    gcc-10.5.0
arm                            randconfig-003    gcc-10.5.0
arm                   randconfig-003-20260614    gcc-11.5.0
arm                   randconfig-003-20260615    gcc-10.5.0
arm                            randconfig-004    gcc-10.5.0
arm                   randconfig-004-20260614    gcc-11.5.0
arm                   randconfig-004-20260615    gcc-10.5.0
arm                        vexpress_defconfig    gcc-16.1.0
arm                    vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260614    gcc-11.5.0
arm64                 randconfig-001-20260615    gcc-10.5.0
arm64                 randconfig-002-20260614    gcc-11.5.0
arm64                 randconfig-002-20260615    gcc-10.5.0
arm64                 randconfig-003-20260614    gcc-11.5.0
arm64                 randconfig-003-20260615    gcc-10.5.0
arm64                 randconfig-004-20260614    gcc-11.5.0
arm64                 randconfig-004-20260615    gcc-10.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260614    gcc-11.5.0
csky                  randconfig-001-20260615    gcc-10.5.0
csky                  randconfig-002-20260614    gcc-11.5.0
csky                  randconfig-002-20260615    gcc-10.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260614    gcc-11.5.0
hexagon               randconfig-001-20260615    clang-18
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260614    gcc-11.5.0
hexagon               randconfig-002-20260615    clang-18
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260614    gcc-14
i386        buildonly-randconfig-001-20260615    clang-22
i386        buildonly-randconfig-002-20260614    gcc-14
i386        buildonly-randconfig-002-20260615    clang-22
i386        buildonly-randconfig-003-20260614    gcc-14
i386        buildonly-randconfig-003-20260615    clang-22
i386        buildonly-randconfig-004-20260614    gcc-14
i386        buildonly-randconfig-004-20260615    clang-22
i386        buildonly-randconfig-005-20260614    gcc-14
i386        buildonly-randconfig-005-20260615    clang-22
i386        buildonly-randconfig-006-20260614    gcc-14
i386        buildonly-randconfig-006-20260615    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260614    clang-22
i386                  randconfig-001-20260615    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260614    clang-22
i386                  randconfig-002-20260615    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260614    clang-22
i386                  randconfig-003-20260615    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260614    clang-22
i386                  randconfig-004-20260615    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260614    clang-22
i386                  randconfig-005-20260615    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260614    clang-22
i386                  randconfig-006-20260615    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260614    clang-22
i386                  randconfig-007-20260615    clang-22
i386                  randconfig-011-20260614    clang-22
i386                  randconfig-011-20260615    gcc-14
i386                  randconfig-012-20260614    clang-22
i386                  randconfig-012-20260615    gcc-14
i386                  randconfig-013-20260614    clang-22
i386                  randconfig-013-20260615    gcc-14
i386                  randconfig-014-20260614    clang-22
i386                  randconfig-014-20260615    gcc-14
i386                  randconfig-015-20260614    clang-22
i386                  randconfig-015-20260615    gcc-14
i386                  randconfig-016-20260614    clang-22
i386                  randconfig-016-20260615    gcc-14
i386                  randconfig-017-20260614    clang-22
i386                  randconfig-017-20260615    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260614    gcc-11.5.0
loongarch             randconfig-001-20260615    clang-18
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260614    gcc-11.5.0
loongarch             randconfig-002-20260615    clang-18
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                malta_qemu_32r6_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260614    gcc-11.5.0
nios2                 randconfig-001-20260615    clang-18
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260614    gcc-11.5.0
nios2                 randconfig-002-20260615    clang-18
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260614    gcc-12.5.0
parisc                randconfig-001-20260615    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260614    gcc-12.5.0
parisc                randconfig-002-20260615    gcc-13.4.0
parisc64                         alldefconfig    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                      ppc44x_defconfig    clang-17
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260614    gcc-12.5.0
powerpc               randconfig-001-20260615    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260614    gcc-12.5.0
powerpc               randconfig-002-20260615    gcc-13.4.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260614    gcc-12.5.0
powerpc64             randconfig-001-20260615    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260614    gcc-12.5.0
powerpc64             randconfig-002-20260615    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-9.5.0
riscv                 randconfig-001-20260614    gcc-9.5.0
riscv                 randconfig-001-20260615    gcc-16.1.0
riscv                          randconfig-002    gcc-9.5.0
riscv                 randconfig-002-20260614    gcc-9.5.0
riscv                 randconfig-002-20260615    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-9.5.0
s390                  randconfig-001-20260614    gcc-9.5.0
s390                  randconfig-001-20260615    gcc-16.1.0
s390                           randconfig-002    gcc-9.5.0
s390                  randconfig-002-20260614    gcc-9.5.0
s390                  randconfig-002-20260615    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-9.5.0
sh                    randconfig-001-20260614    gcc-9.5.0
sh                    randconfig-001-20260615    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260614    gcc-9.5.0
sh                    randconfig-002-20260615    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260615    gcc-15.2.0
sparc                 randconfig-002-20260615    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260615    gcc-15.2.0
sparc64               randconfig-002-20260615    gcc-15.2.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260615    gcc-15.2.0
um                    randconfig-002-20260615    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260615    clang-22
x86_64      buildonly-randconfig-002-20260615    clang-22
x86_64      buildonly-randconfig-003-20260615    clang-22
x86_64      buildonly-randconfig-004-20260615    clang-22
x86_64      buildonly-randconfig-005-20260615    clang-22
x86_64      buildonly-randconfig-006-20260615    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260614    gcc-14
x86_64                randconfig-001-20260615    clang-22
x86_64                randconfig-002-20260614    gcc-14
x86_64                randconfig-002-20260615    clang-22
x86_64                randconfig-003-20260614    gcc-14
x86_64                randconfig-003-20260615    clang-22
x86_64                randconfig-004-20260614    gcc-14
x86_64                randconfig-004-20260615    clang-22
x86_64                randconfig-005-20260614    gcc-14
x86_64                randconfig-005-20260615    clang-22
x86_64                randconfig-006-20260614    gcc-14
x86_64                randconfig-006-20260615    clang-22
x86_64                randconfig-011-20260614    clang-22
x86_64                randconfig-011-20260615    clang-22
x86_64                randconfig-012-20260614    clang-22
x86_64                randconfig-012-20260615    clang-22
x86_64                randconfig-013-20260614    clang-22
x86_64                randconfig-013-20260615    clang-22
x86_64                randconfig-014-20260614    clang-22
x86_64                randconfig-014-20260615    clang-22
x86_64                randconfig-015-20260614    clang-22
x86_64                randconfig-015-20260615    clang-22
x86_64                randconfig-016-20260614    clang-22
x86_64                randconfig-016-20260615    clang-22
x86_64                randconfig-071-20260614    clang-22
x86_64                randconfig-071-20260615    gcc-14
x86_64                randconfig-072-20260614    clang-22
x86_64                randconfig-072-20260615    gcc-14
x86_64                randconfig-073-20260614    clang-22
x86_64                randconfig-073-20260615    gcc-14
x86_64                randconfig-074-20260614    clang-22
x86_64                randconfig-074-20260615    gcc-14
x86_64                randconfig-075-20260614    clang-22
x86_64                randconfig-075-20260615    gcc-14
x86_64                randconfig-076-20260614    clang-22
x86_64                randconfig-076-20260615    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260615    gcc-15.2.0
xtensa                randconfig-002-20260615    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
