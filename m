Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1DEEBA
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782153; cv=none; b=spRB0NbvhcTwyhQD1sWJhox7Of/cT0jjzu4yy3Y+bA1rgdAak/EECRF0K8h5NiYkao8i3P//aIsT33MaSBvBGoFANk3BAsj6DT5yvo+wumAY0z/Q6kYmaR1FKuhsUD5r+43FTyh6+zo8ZXd9WCuluWjgVBVumP+yLYYur9KsPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782153; c=relaxed/simple;
	bh=UecMpvw7PJCeftAs7OvQe1ID0GYNMOhLB9C5mHvbkdw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E/LsfNacD4TbevST9oFH1Ts5AA+Icavy30w3exFlbEtWR/Z8G+Nmr/bxJAi+rNLHVnrJPu3dUc1/C/nTPPZMzBI+kN4iH3Zz2X6JxqgsUbM19yIH0j2qmCFDswQDf4T1tCBsaV0/HcJqX7BzyVAgStKChpaitiv8P2WwgC230WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbHWcyKX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbHWcyKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772782151; x=1804318151;
  h=date:from:to:cc:subject:message-id;
  bh=UecMpvw7PJCeftAs7OvQe1ID0GYNMOhLB9C5mHvbkdw=;
  b=GbHWcyKXpx5CRtShp1I2GQQy3t7kqJf1cLI7sF78qVxqck1juCWVNFId
   mYAZnFi7VEW1LGXQTTwNf+nGzRJu656WU5R3j2DA/bDBWjM7dEcgiDkq/
   iw7wNlE4Eb97VsZW9wWPTKRxeESB7kRz1FUdh6E5LjfZ6s5lQyofcyQaZ
   5nqnScRkGcOHy/wMr4ELgHwybECB7QsW2QlZFhuFZM0IaaZX0SoUQuSCm
   mMTG/GFIdHh3E/1QaYS9Xa6DNlc/QurpvhbUtANAvbV1EuD/VGuVzSgAa
   d2pDn6zp8VL29p0tjeVanusCkx9oMYCszlyBDMoiBQj2KT8/yp3Q+dN2e
   A==;
X-CSE-ConnectionGUID: FahQ07zTT9yAQNGXj3UTyQ==
X-CSE-MsgGUID: /1fHeR0hSjaFCVxWnjn8Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="99356452"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="99356452"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 23:29:10 -0800
X-CSE-ConnectionGUID: Nntcty6TQti1tgH1GY5iIw==
X-CSE-MsgGUID: mduGTkeORRG49801FNn1iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="215647524"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Mar 2026 23:29:09 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyPcQ-000000000WB-3203;
	Fri, 06 Mar 2026 07:29:06 +0000
Date: Fri, 06 Mar 2026 15:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-andes-qilai] BUILD SUCCESS
 df5d8fb6fe55754bc2956e501a9e6acaca5af7d9
Message-ID: <202603061521.yHGxgJ5q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-andes-qilai
branch HEAD: df5d8fb6fe55754bc2956e501a9e6acaca5af7d9  PCI: qilai: Add Andes QiLai SoC PCIe host driver support

elapsed time: 1484m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260306    gcc-11.5.0
arc                   randconfig-002-20260306    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260306    gcc-15.2.0
arm                   randconfig-002-20260306    gcc-14.3.0
arm                   randconfig-003-20260306    clang-23
arm                   randconfig-004-20260306    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260306    gcc-12.5.0
arm64                 randconfig-002-20260306    clang-23
arm64                 randconfig-003-20260306    gcc-14.3.0
arm64                 randconfig-004-20260306    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260306    gcc-15.2.0
csky                  randconfig-002-20260306    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260306    clang-23
hexagon               randconfig-002-20260306    clang-16
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260306    gcc-14
i386        buildonly-randconfig-002-20260306    gcc-14
i386        buildonly-randconfig-003-20260306    clang-20
i386        buildonly-randconfig-004-20260306    gcc-14
i386        buildonly-randconfig-005-20260306    gcc-14
i386        buildonly-randconfig-006-20260306    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260306    clang-20
i386                  randconfig-002-20260306    clang-20
i386                  randconfig-003-20260306    clang-20
i386                  randconfig-004-20260306    clang-20
i386                  randconfig-005-20260306    clang-20
i386                  randconfig-006-20260306    clang-20
i386                  randconfig-007-20260306    gcc-14
i386                  randconfig-011-20260306    gcc-14
i386                  randconfig-012-20260306    clang-20
i386                  randconfig-013-20260306    clang-20
i386                  randconfig-014-20260306    gcc-14
i386                  randconfig-015-20260306    gcc-14
i386                  randconfig-016-20260306    gcc-14
i386                  randconfig-017-20260306    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260306    clang-23
loongarch             randconfig-002-20260306    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260306    gcc-8.5.0
nios2                 randconfig-002-20260306    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260306    gcc-14.3.0
parisc                randconfig-002-20260306    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260306    clang-19
powerpc               randconfig-002-20260306    clang-23
powerpc64             randconfig-001-20260306    gcc-13.4.0
powerpc64             randconfig-002-20260306    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260306    gcc-11.5.0
riscv                 randconfig-002-20260306    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260306    clang-19
s390                  randconfig-002-20260306    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                    randconfig-001-20260306    gcc-9.5.0
sh                    randconfig-002-20260306    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260306    gcc-12.5.0
sparc                 randconfig-002-20260306    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260306    gcc-14.3.0
sparc64               randconfig-002-20260306    gcc-8.5.0
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260306    clang-23
um                    randconfig-002-20260306    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260306    clang-20
x86_64      buildonly-randconfig-002-20260306    clang-20
x86_64      buildonly-randconfig-003-20260306    clang-20
x86_64      buildonly-randconfig-004-20260306    clang-20
x86_64      buildonly-randconfig-005-20260306    gcc-14
x86_64      buildonly-randconfig-006-20260306    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20260306    gcc-14
x86_64                randconfig-012-20260306    clang-20
x86_64                randconfig-013-20260306    clang-20
x86_64                randconfig-014-20260306    clang-20
x86_64                randconfig-015-20260306    gcc-13
x86_64                randconfig-016-20260306    clang-20
x86_64                randconfig-071-20260306    clang-20
x86_64                randconfig-072-20260306    clang-20
x86_64                randconfig-073-20260306    clang-20
x86_64                randconfig-074-20260306    clang-20
x86_64                randconfig-075-20260306    gcc-14
x86_64                randconfig-076-20260306    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260306    gcc-8.5.0
xtensa                randconfig-002-20260306    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
