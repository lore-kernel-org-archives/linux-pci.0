Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCC245012
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779540; cv=none; b=Ms3Sjb8rjZInGZlS9IR2w7XlaEyKnTKnZ6fhni8SZ4JXFdwSvEQuCLJ8VHZONVv5ep55eexOvB521Ei5smOBJC/aq3/AJgpX3P9O+xModhME2fxlvmDJkKvgzG7iDav9d0Jd35z71ubToVB7F4GyovBkoy+7BZ0JkAv3CAmTSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779540; c=relaxed/simple;
	bh=dnUiHeFNp2iYazuFSHDTGrvyflOAoZMNIQoDYcIF28M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oBOadM6BYAOC3TH6PSZHmqEJzQ/a5lpojMvuROurPgt1xL6B0cGxX/w7iKXOQAZY5MunzhsscCpFajTbC3VJOd5pcFgLzSEtAy9s61Pg/OZC075QL+yZuQlyjUP/+bhXKgQwR1UU2dQvnkNdPFMAWkTi/7OigB/gfhQAQgrW4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj8YzCtr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj8YzCtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777779539; x=1809315539;
  h=date:from:to:cc:subject:message-id;
  bh=dnUiHeFNp2iYazuFSHDTGrvyflOAoZMNIQoDYcIF28M=;
  b=aj8YzCtrKJnv+0x5QkLP+hAX0cZ7n5YwyLbc4lRcQWQ30c4AEdnzkImM
   gNuCAvlDVCnSt9qVzPsSr3Vp5korXvQUPBuw38bHXbOnJwBSWGFMKdT/1
   xm4om2ncrYvQpQ4P7QWPgNQRnbZ3E1wys92iQI24rVhQPb/pfTsU4flBu
   0N44ro91JpJPY4Ulhl/e3JlSCxlQX0SkK8ItG3p6T7EGIW7e0phztVhYW
   +yqlhs1eE0Dxm8Mune6PwaOpct4O1C4KpZxeaTYS3fBwNZtqyRZkek4wF
   hhQBC09f9q+CTj1Z1W8o6ZB5RC/6qx5KiXNKWZObGznh75WyOtDd/1dNF
   Q==;
X-CSE-ConnectionGUID: AxG1UgiZSo2vgEqnqKdfzA==
X-CSE-MsgGUID: 8z6p3krLRbCONtE1bIl3iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="82294398"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="82294398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 20:38:59 -0700
X-CSE-ConnectionGUID: iqUJn5OySYqvPmD0JEuv4Q==
X-CSE-MsgGUID: e5wWM8WUSqCmubrat5iOmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="239529315"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 May 2026 20:38:58 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJNfS-0000000026D-3T0d;
	Sun, 03 May 2026 03:38:54 +0000
Date: Sun, 03 May 2026 11:38:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 20f87c0f367dd3207f2c172be1eccf14d250cf4f
Message-ID: <202605031112.O8HeLMwe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 20f87c0f367dd3207f2c172be1eccf14d250cf4f  PCI: Return valid alignment for assigned resources

elapsed time: 1895m

configs tested: 227
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260503    gcc-10.5.0
arc                   randconfig-002-20260503    gcc-10.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260503    gcc-10.5.0
arm                   randconfig-002-20260503    gcc-10.5.0
arm                   randconfig-003-20260503    gcc-10.5.0
arm                   randconfig-004-20260503    gcc-10.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260502    gcc-10.5.0
arm64                 randconfig-001-20260503    gcc-15.2.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260502    gcc-10.5.0
arm64                 randconfig-002-20260503    gcc-15.2.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260502    gcc-10.5.0
arm64                 randconfig-003-20260503    gcc-15.2.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260502    gcc-10.5.0
arm64                 randconfig-004-20260503    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260502    gcc-10.5.0
csky                  randconfig-001-20260503    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260502    gcc-10.5.0
csky                  randconfig-002-20260503    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260502    clang-23
hexagon               randconfig-001-20260503    clang-23
hexagon               randconfig-002-20260502    clang-23
hexagon               randconfig-002-20260503    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260502    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260502    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260502    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260502    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260502    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260502    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260502    clang-20
i386                  randconfig-002-20260502    clang-20
i386                  randconfig-003-20260502    clang-20
i386                  randconfig-004-20260502    clang-20
i386                  randconfig-005-20260502    clang-20
i386                  randconfig-006-20260502    clang-20
i386                  randconfig-007-20260502    clang-20
i386                  randconfig-011-20260502    clang-20
i386                  randconfig-012-20260502    clang-20
i386                  randconfig-013-20260502    clang-20
i386                  randconfig-014-20260502    clang-20
i386                  randconfig-015-20260502    clang-20
i386                  randconfig-016-20260502    clang-20
i386                  randconfig-017-20260502    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260502    clang-23
loongarch             randconfig-001-20260503    clang-23
loongarch             randconfig-002-20260502    clang-23
loongarch             randconfig-002-20260503    clang-23
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
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260502    clang-23
nios2                 randconfig-001-20260503    clang-23
nios2                 randconfig-002-20260502    clang-23
nios2                 randconfig-002-20260503    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260502    gcc-12.5.0
parisc                randconfig-001-20260503    gcc-15.2.0
parisc                randconfig-002-20260502    gcc-12.5.0
parisc                randconfig-002-20260503    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260502    gcc-12.5.0
powerpc               randconfig-001-20260503    gcc-15.2.0
powerpc               randconfig-002-20260502    gcc-12.5.0
powerpc               randconfig-002-20260503    gcc-15.2.0
powerpc64             randconfig-001-20260502    gcc-12.5.0
powerpc64             randconfig-001-20260503    gcc-15.2.0
powerpc64             randconfig-002-20260502    gcc-12.5.0
powerpc64             randconfig-002-20260503    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260502    gcc-14.3.0
riscv                 randconfig-001-20260503    clang-23
riscv                 randconfig-002-20260502    gcc-14.3.0
riscv                 randconfig-002-20260503    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260502    gcc-14.3.0
s390                  randconfig-001-20260503    clang-23
s390                  randconfig-002-20260502    gcc-14.3.0
s390                  randconfig-002-20260503    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260502    gcc-14.3.0
sh                    randconfig-001-20260503    clang-23
sh                    randconfig-002-20260502    gcc-14.3.0
sh                    randconfig-002-20260503    clang-23
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260502    gcc-8.5.0
sparc                 randconfig-001-20260503    gcc-15.2.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260502    gcc-8.5.0
sparc                 randconfig-002-20260503    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260502    gcc-8.5.0
sparc64               randconfig-001-20260503    gcc-15.2.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260502    gcc-8.5.0
sparc64               randconfig-002-20260503    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260502    gcc-8.5.0
um                    randconfig-001-20260503    gcc-15.2.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260502    gcc-8.5.0
um                    randconfig-002-20260503    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260502    clang-20
x86_64      buildonly-randconfig-002-20260502    clang-20
x86_64      buildonly-randconfig-003-20260502    clang-20
x86_64      buildonly-randconfig-004-20260502    clang-20
x86_64      buildonly-randconfig-005-20260502    clang-20
x86_64      buildonly-randconfig-006-20260502    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260502    clang-20
x86_64                randconfig-001-20260503    clang-20
x86_64                randconfig-002-20260502    clang-20
x86_64                randconfig-002-20260503    clang-20
x86_64                randconfig-003-20260502    clang-20
x86_64                randconfig-003-20260503    clang-20
x86_64                randconfig-004-20260502    clang-20
x86_64                randconfig-004-20260503    clang-20
x86_64                randconfig-005-20260502    clang-20
x86_64                randconfig-005-20260503    clang-20
x86_64                randconfig-006-20260502    clang-20
x86_64                randconfig-006-20260503    clang-20
x86_64                randconfig-011-20260503    clang-20
x86_64                randconfig-012-20260503    clang-20
x86_64                randconfig-013-20260503    clang-20
x86_64                randconfig-014-20260503    clang-20
x86_64                randconfig-015-20260503    clang-20
x86_64                randconfig-016-20260503    clang-20
x86_64                randconfig-071-20260502    gcc-14
x86_64                randconfig-072-20260502    gcc-14
x86_64                randconfig-073-20260502    gcc-14
x86_64                randconfig-074-20260502    gcc-14
x86_64                randconfig-075-20260502    gcc-14
x86_64                randconfig-076-20260502    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260502    gcc-8.5.0
xtensa                randconfig-001-20260503    gcc-15.2.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260502    gcc-8.5.0
xtensa                randconfig-002-20260503    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
