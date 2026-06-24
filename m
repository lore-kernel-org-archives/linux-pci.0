Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCB2E717B
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279335; cv=none; b=goNPJHzVOcwWeZyxYXwETYgbQjKvTAb5k3dsKYfTDyWL4dfojLJ6CMnd1QOG379t5YAoaydOvr1b6+rn3ehr6122/1vQ4iBQhU0XWGazwFcmwoVkBORmz7qhRsqfMBC8NIn9mzMjV1hQJCzAErAUm3gCdmhJ1zQ9xKwagbZNy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279335; c=relaxed/simple;
	bh=CrRxphtDih+rL6vf4pCCv/TZ00kp9xwnwbdfpqKu0CY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hTmofKx9uL60DPzewuW743IyGmM0jVwkpDktK9Wfh1qvzhbd2PobRb+J6QCnwHLvcs5/1Eyqlr6S+ZbEn1Gl0R6b9NL9g1hID4NKdJ3S7BFiYEytrj4ricG8Db9k6n5TthpwZVC7JceFkaLByGSOv4Mr20Lmy+5y7skGHYQ8/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOljxwlB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOljxwlB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782279334; x=1813815334;
  h=date:from:to:cc:subject:message-id;
  bh=CrRxphtDih+rL6vf4pCCv/TZ00kp9xwnwbdfpqKu0CY=;
  b=WOljxwlBCVrCSj8ejYTmkbjzJZzUDjxrbDXspmzB70S72RxpErI7IOs6
   BS1uJI61k37AKKZmY3b31N5PFaF3wgdpeZzt0rsgWjgfFRWk39LCpJPAc
   w/Hr+Q7sNm/mA8nD/KqJ6LADpwTtU01y9q028hYC6siampgJ4CLPFJLKu
   2Wb8dQKuD6UqMpk7kwcSb1MrViEnvCUI5BFFgA5TjLdzp3VrUpT+LS5yc
   TeDnO0yDUpYaGwm7JkX+FAZ1xfAX1Fgc7US/KgxcIfKoxDY1v7GJd7xnb
   fQyAm3cmRNvcytIGM/AmUqkuKd3YuUsY9k1FaTFonDo0A6jYTc8ysC88D
   w==;
X-CSE-ConnectionGUID: 60NXp6OSRkuo0oJhAVZadg==
X-CSE-MsgGUID: MHS9aNsxSAOI5y+22RRqNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86871202"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="86871202"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 22:35:32 -0700
X-CSE-ConnectionGUID: Nnd8OfqiTF6Yco70hcjr0g==
X-CSE-MsgGUID: 0NdlmKwKSr626whRnheGjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249752368"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2026 22:35:26 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcGGd-0000000038l-0BOo;
	Wed, 24 Jun 2026 05:35:20 +0000
Date: Wed, 24 Jun 2026 13:34:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 1fda82e37e00eb679d762756867b2e7508dd73f9
Message-ID: <202606241335.eNL33qzw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 1fda82e37e00eb679d762756867b2e7508dd73f9  NTB: epf: Implement .db_vector_count()/mask() for doorbells

elapsed time: 759m

configs tested: 269
configs skipped: 5

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
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260624    gcc-15.2.0
arc                   randconfig-001-20260624    gcc-9.5.0
arc                   randconfig-002-20260624    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260624    clang-19
arm                   randconfig-001-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-8.5.0
arm                   randconfig-003-20260624    gcc-15.2.0
arm                   randconfig-004-20260624    clang-16
arm                   randconfig-004-20260624    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260624    clang-21
arm64                 randconfig-002-20260624    clang-21
arm64                 randconfig-003-20260624    clang-21
arm64                 randconfig-004-20260624    clang-21
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260624    clang-21
csky                  randconfig-002-20260624    clang-21
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260624    clang-20
hexagon               randconfig-001-20260624    gcc-11.5.0
hexagon               randconfig-001-20260624    gcc-9.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260624    clang-23
hexagon               randconfig-002-20260624    gcc-11.5.0
hexagon               randconfig-002-20260624    gcc-9.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-14
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-14
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20260624    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-14
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-14
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260624    clang-22
i386                  randconfig-002-20260624    clang-22
i386                  randconfig-003-20260624    clang-22
i386                  randconfig-004-20260624    clang-22
i386                  randconfig-005-20260624    clang-22
i386                  randconfig-006-20260624    clang-22
i386                  randconfig-007-20260624    clang-22
i386                  randconfig-011-20260624    clang-22
i386                  randconfig-012-20260624    clang-22
i386                  randconfig-013-20260624    clang-22
i386                  randconfig-014-20260624    clang-22
i386                  randconfig-015-20260624    clang-22
i386                  randconfig-016-20260624    clang-22
i386                  randconfig-017-20260624    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-16.1.0
loongarch             randconfig-001-20260624    gcc-9.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-15.2.0
loongarch             randconfig-002-20260624    gcc-9.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                         apollo_defconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
m68k                        stmark2_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-9.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-9.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260624    gcc-16.1.0
parisc                randconfig-002-20260624    gcc-14.3.0
parisc                randconfig-002-20260624    gcc-16.1.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260624    clang-23
powerpc               randconfig-001-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-8.5.0
powerpc64             randconfig-001-20260624    gcc-16.1.0
powerpc64             randconfig-001-20260624    gcc-8.5.0
powerpc64             randconfig-002-20260624    gcc-11.5.0
powerpc64             randconfig-002-20260624    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-18
riscv                 randconfig-001-20260624    clang-18
riscv                          randconfig-002    clang-18
riscv                 randconfig-002-20260624    clang-18
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-18
s390                  randconfig-001-20260624    clang-18
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260624    clang-18
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-18
sh                    randconfig-001-20260624    clang-18
sh                             randconfig-002    clang-18
sh                    randconfig-002-20260624    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260624    gcc-14.3.0
sparc                 randconfig-001-20260624    gcc-8.5.0
sparc                 randconfig-002-20260624    gcc-14.3.0
sparc                 randconfig-002-20260624    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260624    clang-20
sparc64               randconfig-001-20260624    gcc-14.3.0
sparc64               randconfig-002-20260624    clang-20
sparc64               randconfig-002-20260624    gcc-14.3.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260624    clang-23
um                    randconfig-001-20260624    gcc-14.3.0
um                    randconfig-002-20260624    clang-16
um                    randconfig-002-20260624    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260624    clang-22
x86_64      buildonly-randconfig-002-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    clang-22
x86_64      buildonly-randconfig-004-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    clang-22
x86_64      buildonly-randconfig-006-20260624    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260624    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260624    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260624    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260624    clang-22
x86_64                randconfig-004-20260624    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260624    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260624    clang-22
x86_64                randconfig-006-20260624    gcc-14
x86_64                randconfig-011-20260624    gcc-14
x86_64                randconfig-012-20260624    gcc-14
x86_64                randconfig-013-20260624    gcc-12
x86_64                randconfig-013-20260624    gcc-14
x86_64                randconfig-014-20260624    gcc-14
x86_64                randconfig-015-20260624    gcc-14
x86_64                randconfig-016-20260624    gcc-14
x86_64                randconfig-071-20260624    gcc-14
x86_64                randconfig-072-20260624    clang-22
x86_64                randconfig-072-20260624    gcc-14
x86_64                randconfig-073-20260624    gcc-14
x86_64                randconfig-074-20260624    clang-22
x86_64                randconfig-074-20260624    gcc-14
x86_64                randconfig-075-20260624    gcc-14
x86_64                randconfig-076-20260624    clang-22
x86_64                randconfig-076-20260624    gcc-14
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
xtensa                randconfig-001-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
