Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8718BC3D
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769276494; cv=none; b=tm5W8/h8g/rBrgeMAZ7lv5cFPS5ey/DqCpFJyhYczNrcIHjwInXTPkQCpz0X6Ru6tFJ/Bd1jGAUW0CvVb/aTT9zikowqagbgNBhm+KPsa+Y6khEyOYopRMC44PFbH0Py+DYPB0K4EOvyATs2XIHqGuLOfQoY+9daR/T15T72WGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769276494; c=relaxed/simple;
	bh=WWkfHjHPIQoVEGqEccLdH1ypnY9xlRlOwH7UDzJBXXQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MYHB5Uo2YD/1G3dHCOCx6GA5Zed/5Txe+zHx6cbPaiBoJvR3SotlXNsw9YDYs4yTcbpHaGd7Hrt1KevT+1Bcxh0JjurghSBgIF0SwyVXsdyORcsAAaadwBXv6snRIXKhtnrbDB1E3Dx12ppSZVh1/jMIzRM2Gvp+sYPg/RiNeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UO7562IF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UO7562IF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769276492; x=1800812492;
  h=date:from:to:cc:subject:message-id;
  bh=WWkfHjHPIQoVEGqEccLdH1ypnY9xlRlOwH7UDzJBXXQ=;
  b=UO7562IF1s13GU0QbmszzMisf5i3Up5yrfi1CrUXWz7eiX0JmbXe5daU
   76Jt6Rj0/rnhPGXFZ1Frxn3cv9vpVDifgbkVeK7tATdHqWRcUBPN3BAai
   qj08v16nnB2m3FDlHUxOb2PL5gprQvrXamjCHpbMdN08aa5MAVwgi/spq
   kJ7DjfDyijo/y6x+Aqd6TKsNvQ4wxgCs5mr1TA1lXXoo6YihRgLxdidoK
   FkA12MFkOnyyUeP3EKtl9FKMnEvYhxsgaIkV+QjWgqF8ufBMxubQSsF1T
   2juCK7azO1f8CeOBFGMXQBjd7Lk14plfmZt+Ze55p1lW7TJk6EdDfZ9QM
   Q==;
X-CSE-ConnectionGUID: xt+Z7oahQkueXDITLC/XOQ==
X-CSE-MsgGUID: 8wWnJqS1QtWz3fn/ABf1hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="70412202"
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="70412202"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 09:41:32 -0800
X-CSE-ConnectionGUID: LTYKJZ9tSd2LexoXd0yLCA==
X-CSE-MsgGUID: 80nvUD2tTWWIn5c1+TQrpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="238551966"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Jan 2026 09:41:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjhdX-00000000VQE-2sHr;
	Sat, 24 Jan 2026 17:41:27 +0000
Date: Sun, 25 Jan 2026 01:40:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 1dae0026c011c6dac2472712f3d33f3c4200cdfb
Message-ID: <202601250148.NviUoiy3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 1dae0026c011c6dac2472712f3d33f3c4200cdfb  Merge branch 'pci/misc'

elapsed time: 1029m

configs tested: 163
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
arc                   randconfig-001-20260124    gcc-14.3.0
arc                   randconfig-002-20260124    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20260124    gcc-8.5.0
arm                   randconfig-002-20260124    clang-22
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    gcc-15.2.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260124    clang-22
arm64                 randconfig-002-20260124    clang-22
arm64                 randconfig-003-20260124    clang-22
arm64                 randconfig-004-20260124    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-13.4.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260124    clang-22
hexagon               randconfig-002-20260124    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-004-20260124    clang-20
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-006-20260124    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-12
i386                  randconfig-005-20260124    clang-20
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-014-20260124    gcc-14
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-016-20260124    gcc-14
i386                  randconfig-017-20260124    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-14.3.0
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
mips                  decstation_64_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260124    gcc-8.5.0
nios2                 randconfig-002-20260124    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-14.3.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc               randconfig-001-20260124    clang-22
powerpc               randconfig-002-20260124    clang-22
powerpc64             randconfig-001-20260124    gcc-10.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-002-20260124    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260124    gcc-15.2.0
s390                  randconfig-002-20260124    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                            hp6xx_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260124    gcc-15.2.0
sh                    randconfig-002-20260124    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-14.3.0
sparc                 randconfig-002-20260124    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260124    clang-22
sparc64               randconfig-002-20260124    clang-22
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-14
um                    randconfig-002-20260124    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-002-20260124    gcc-14
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-006-20260124    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-003-20260124    clang-20
x86_64                randconfig-011-20260124    gcc-14
x86_64                randconfig-012-20260124    gcc-14
x86_64                randconfig-013-20260124    clang-20
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-14
x86_64                randconfig-016-20260124    gcc-14
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260124    clang-20
x86_64                randconfig-073-20260124    clang-20
x86_64                randconfig-074-20260124    gcc-12
x86_64                randconfig-075-20260124    clang-20
x86_64                randconfig-076-20260124    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260124    gcc-8.5.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
