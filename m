Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BA34B1AD
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637037; cv=none; b=prtKNP9yrhVeJo8eTyvlO0qwfrpxJWNQe1O0ROyjDO9rGJ1kQomGJn07cOQUy6Goz/+5+iI4NwwjcljRaS2vB+qKh0JsIDT85ttcBzGApd8Klc/0exL346Hf32LETpt7jwOGWyXQKc2Hai92yCNo5t0MFZ2CAao4lNURKBsVQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637037; c=relaxed/simple;
	bh=kboIuvY54zMkF/nn9jr+7M+YZE3UyxhgRWoklK68pOU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HGgvl6XVD1GzNY+ICdAbp99Hr0y9sfM0BZqynyvQzccef6XsQub7wNfCpOquqVLwKPbRmF5KnWzV1g0OL2qI+ETyeNVJcQpCPvk/ohFyemF7MIUmmyDW/ryXj/aDAVXcWIn+9KvS5wqj/KvBHJ4iokrcieTIDjuR4J+iYFPNuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFdo02fe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFdo02fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778637033; x=1810173033;
  h=date:from:to:cc:subject:message-id;
  bh=kboIuvY54zMkF/nn9jr+7M+YZE3UyxhgRWoklK68pOU=;
  b=oFdo02feCuF6AFcflartyvoE6r+Ojl3BD41tUMckVFRhHQ8VVlWDxfrz
   aE/UvMf7xBggNtSxwDqxFycfe1GEUQB15xmjt9lgh90w/N/BI65nPBHMF
   H7uMkGnt+MJMYrk/rLSmPK02iTSooC9o1q47vt+GriscP4IGJUihPc41b
   V5ROl6BUA8zC2XxDLydNz25/hcLk5hos3qkoQCDTnjwypbgLUtAlCa/6a
   BfF3jQIxzFDQHaghxY8hLRihvsvc0GO/zxKcW57aPjtdd5DfE3Bf7l3/g
   BJUVwqIxNdqCdWdAuGKTg3IOJNN0paRxfdt+qf5HxBu3n5IrymEQrsQkj
   A==;
X-CSE-ConnectionGUID: 5SJUq9K4RJa1Ybe/EP3CBg==
X-CSE-MsgGUID: DzyaZQsbSsWflL+5sYKtIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78700565"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="78700565"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 18:50:32 -0700
X-CSE-ConnectionGUID: Vu5fBXoIRvSB+CxxbZGjDQ==
X-CSE-MsgGUID: 1KnEpk0CT3yVXGpk4EfpHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261431873"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 May 2026 18:50:30 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMyk0-0000000039J-12mY;
	Wed, 13 May 2026 01:50:28 +0000
Date: Wed, 13 May 2026 09:50:24 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-imx6] BUILD SUCCESS
 40b7f61a1a4d7fd18188f3f87e15ff5a90ce1d31
Message-ID: <202605130915.t8X0fzU3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: 40b7f61a1a4d7fd18188f3f87e15ff5a90ce1d31  PCI: imx6: Add support for parsing the reset property in new Root Port binding

elapsed time: 761m

configs tested: 288
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260513    gcc-14.3.0
arc                   randconfig-001-20260513    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260513    gcc-14.3.0
arc                   randconfig-002-20260513    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    clang-20
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260513    gcc-14.3.0
arm                   randconfig-001-20260513    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260513    gcc-14.3.0
arm                   randconfig-002-20260513    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260513    gcc-14.3.0
arm                   randconfig-003-20260513    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260513    gcc-14.3.0
arm                   randconfig-004-20260513    gcc-8.5.0
arm                           sama7_defconfig    clang-23
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260512    clang-23
arm64                 randconfig-001-20260513    gcc-12.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260512    clang-23
arm64                 randconfig-002-20260513    gcc-12.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260512    clang-23
arm64                 randconfig-003-20260513    gcc-12.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260512    clang-23
arm64                 randconfig-004-20260513    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260512    clang-23
csky                  randconfig-001-20260513    gcc-12.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260512    clang-23
csky                  randconfig-002-20260513    gcc-12.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260512    gcc-11.5.0
hexagon               randconfig-001-20260513    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260512    gcc-11.5.0
hexagon               randconfig-002-20260513    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260512    gcc-14
i386        buildonly-randconfig-001-20260513    clang-20
i386        buildonly-randconfig-002-20260512    gcc-14
i386        buildonly-randconfig-002-20260513    clang-20
i386        buildonly-randconfig-003-20260512    gcc-14
i386        buildonly-randconfig-003-20260513    clang-20
i386        buildonly-randconfig-004-20260512    gcc-14
i386        buildonly-randconfig-004-20260513    clang-20
i386        buildonly-randconfig-005-20260512    gcc-14
i386        buildonly-randconfig-005-20260513    clang-20
i386        buildonly-randconfig-006-20260512    gcc-14
i386        buildonly-randconfig-006-20260513    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260512    gcc-14
i386                  randconfig-001-20260513    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260512    gcc-14
i386                  randconfig-002-20260513    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260512    gcc-14
i386                  randconfig-003-20260513    clang-20
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260512    gcc-14
i386                  randconfig-004-20260513    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260512    gcc-14
i386                  randconfig-005-20260513    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260512    gcc-14
i386                  randconfig-006-20260513    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260512    gcc-14
i386                  randconfig-007-20260513    clang-20
i386                  randconfig-011-20260512    clang-20
i386                  randconfig-011-20260513    clang-20
i386                  randconfig-012-20260512    clang-20
i386                  randconfig-012-20260513    clang-20
i386                  randconfig-013-20260512    clang-20
i386                  randconfig-013-20260513    clang-20
i386                  randconfig-014-20260512    clang-20
i386                  randconfig-014-20260513    clang-20
i386                  randconfig-015-20260512    clang-20
i386                  randconfig-015-20260513    clang-20
i386                  randconfig-016-20260512    clang-20
i386                  randconfig-016-20260513    clang-20
i386                  randconfig-017-20260512    clang-20
i386                  randconfig-017-20260513    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260512    gcc-11.5.0
loongarch             randconfig-001-20260513    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260512    gcc-11.5.0
loongarch             randconfig-002-20260513    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260512    gcc-11.5.0
nios2                 randconfig-001-20260513    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260512    gcc-11.5.0
nios2                 randconfig-002-20260513    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260513    gcc-8.5.0
parisc                randconfig-002-20260513    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                     rainier_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260513    gcc-8.5.0
powerpc               randconfig-002-20260513    gcc-8.5.0
powerpc64             randconfig-001-20260513    gcc-8.5.0
powerpc64             randconfig-002-20260513    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260513    gcc-15.2.0
riscv                 randconfig-002-20260513    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260513    gcc-15.2.0
s390                  randconfig-002-20260513    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260513    gcc-15.2.0
sh                    randconfig-002-20260513    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-11.5.0
sparc                          randconfig-001    gcc-13.4.0
sparc                 randconfig-001-20260512    gcc-13.4.0
sparc                 randconfig-001-20260513    gcc-11.5.0
sparc                          randconfig-002    gcc-11.5.0
sparc                          randconfig-002    gcc-13.4.0
sparc                 randconfig-002-20260512    gcc-13.4.0
sparc                 randconfig-002-20260513    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-11.5.0
sparc64                        randconfig-001    gcc-13.4.0
sparc64               randconfig-001-20260512    gcc-13.4.0
sparc64               randconfig-001-20260513    gcc-11.5.0
sparc64                        randconfig-002    gcc-11.5.0
sparc64                        randconfig-002    gcc-13.4.0
sparc64               randconfig-002-20260512    gcc-13.4.0
sparc64               randconfig-002-20260513    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-11.5.0
um                             randconfig-001    gcc-13.4.0
um                    randconfig-001-20260512    gcc-13.4.0
um                    randconfig-001-20260513    gcc-11.5.0
um                             randconfig-002    gcc-11.5.0
um                             randconfig-002    gcc-13.4.0
um                    randconfig-002-20260512    gcc-13.4.0
um                    randconfig-002-20260513    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260512    gcc-14
x86_64      buildonly-randconfig-001-20260513    gcc-12
x86_64      buildonly-randconfig-002-20260512    gcc-14
x86_64      buildonly-randconfig-002-20260513    gcc-12
x86_64      buildonly-randconfig-003-20260512    gcc-14
x86_64      buildonly-randconfig-003-20260513    gcc-12
x86_64      buildonly-randconfig-004-20260512    gcc-14
x86_64      buildonly-randconfig-004-20260513    gcc-12
x86_64      buildonly-randconfig-005-20260512    gcc-14
x86_64      buildonly-randconfig-005-20260513    gcc-12
x86_64      buildonly-randconfig-006-20260512    gcc-14
x86_64      buildonly-randconfig-006-20260513    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260513    clang-20
x86_64                randconfig-002-20260513    clang-20
x86_64                randconfig-003-20260513    clang-20
x86_64                randconfig-004-20260513    clang-20
x86_64                randconfig-005-20260513    clang-20
x86_64                randconfig-006-20260513    clang-20
x86_64                randconfig-011-20260512    clang-20
x86_64                randconfig-011-20260513    gcc-14
x86_64                randconfig-012-20260512    clang-20
x86_64                randconfig-012-20260513    gcc-14
x86_64                randconfig-013-20260512    clang-20
x86_64                randconfig-013-20260513    gcc-14
x86_64                randconfig-014-20260512    clang-20
x86_64                randconfig-014-20260513    gcc-14
x86_64                randconfig-015-20260512    clang-20
x86_64                randconfig-015-20260513    gcc-14
x86_64                randconfig-016-20260512    clang-20
x86_64                randconfig-016-20260513    gcc-14
x86_64                randconfig-071-20260512    gcc-14
x86_64                randconfig-071-20260513    gcc-14
x86_64                randconfig-072-20260513    gcc-14
x86_64                randconfig-073-20260513    gcc-14
x86_64                randconfig-074-20260512    gcc-14
x86_64                randconfig-074-20260513    gcc-14
x86_64                randconfig-075-20260513    gcc-14
x86_64                randconfig-076-20260513    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-11.5.0
xtensa                         randconfig-001    gcc-13.4.0
xtensa                randconfig-001-20260512    gcc-13.4.0
xtensa                randconfig-001-20260513    gcc-11.5.0
xtensa                         randconfig-002    gcc-11.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260512    gcc-13.4.0
xtensa                randconfig-002-20260513    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
