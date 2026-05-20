Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCF1DA0E1
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255434; cv=none; b=n5pCXIyJ784NPhRHNLtULusfzXDEF/QNAt6leNWjGbmLhZWHYwWhUp3X/qF3aqNDqVGm1Ife1D8HSuvwhtW9VC9oqRGGsLYUc+1fMgPWRGUMeVv1rRmrt6AR2WsGlzDj7x+/38Chc9GAgq/l/ZQF+sTpFSsWHAvRy9bazbgGVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255434; c=relaxed/simple;
	bh=zeQpZO+YGjGKCSQmEaiB/yazXd7TUkR9TDnuxqkQrh8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fcMRXHhPdooHCWoBQ8sFIR0n5aKQYAGCn8EK9kxYD1Fh/HPUOo5pfdCvreX79NOc1roolMI8LrROQ/qlrXEF6j609tUOk28k2D5WvRvBPI20Y30Yoyz6WFxFdQ/hcdvKjyKgCZXXZ0AvgOnWX8rdkk5WavxLW+y1ADdBN1tmJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyUGVgUq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyUGVgUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779255433; x=1810791433;
  h=date:from:to:cc:subject:message-id;
  bh=zeQpZO+YGjGKCSQmEaiB/yazXd7TUkR9TDnuxqkQrh8=;
  b=gyUGVgUqm5bHutuoOjEN1TZ5v2DMOmescYukUUNZoCefDsPwkmT5WGGS
   dROKAUjq4YQTneOlL6yx0aa5PuqIVtRxo831MRwsteXAYGyVOt9BqATCy
   3nVQHPwm2spo9WEzHQhw51NJKVBH3OFOA7fC+NlKdhAZdgwiH1tGl/+BB
   zjZ1ModPsSVSv3TeIKblpSr4cfi/X7m3n+AO039LuHHT6ROUK7xn5OlJt
   slrFSALyZqwZe4YALIv3EzrbxbkZOM/4Vg7+UBm9OFrysQnbE5pKqteSw
   25B+CPbi3MhlTHrpkOpiWkd8yvl+SNg+38Jpw7pHxJmX7CzTcag1u1RUx
   A==;
X-CSE-ConnectionGUID: 5ZX25Gm4QmGYGgLpAK20fQ==
X-CSE-MsgGUID: JB5D8LLqQV2JNVcVDdT0TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91611751"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91611751"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 22:37:12 -0700
X-CSE-ConnectionGUID: 7it8Q+ltT6maULZiC9YXKQ==
X-CSE-MsgGUID: NEydbN+LStq0EwcOZYBKBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263810144"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 May 2026 22:37:11 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPZc9-000000002Xz-1fY4;
	Wed, 20 May 2026 05:37:06 +0000
Date: Wed, 20 May 2026 13:36:24 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek-gen3] BUILD SUCCESS
 8ba433753d9b131c2e43b1ff7ba8c5730cef8231
Message-ID: <202605201315.8z2Ao3WY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek-gen3
branch HEAD: 8ba433753d9b131c2e43b1ff7ba8c5730cef8231  PCI: mediatek-gen3: Fix incorrectly skipped pwrctrl error message

elapsed time: 740m

configs tested: 192
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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260520    gcc-8.5.0
arc                   randconfig-002-20260520    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                   randconfig-001-20260520    gcc-8.5.0
arm                   randconfig-002-20260520    gcc-8.5.0
arm                   randconfig-003-20260520    gcc-8.5.0
arm                   randconfig-004-20260520    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260520    gcc-10.5.0
arm64                 randconfig-002-20260520    gcc-10.5.0
arm64                 randconfig-003-20260520    gcc-10.5.0
arm64                 randconfig-004-20260520    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260520    gcc-10.5.0
csky                  randconfig-002-20260520    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260520    gcc-11.5.0
hexagon               randconfig-002-20260520    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260520    clang-20
i386        buildonly-randconfig-002-20260520    clang-20
i386        buildonly-randconfig-003-20260520    clang-20
i386        buildonly-randconfig-004-20260520    clang-20
i386        buildonly-randconfig-005-20260520    clang-20
i386        buildonly-randconfig-006-20260520    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260520    clang-20
i386                  randconfig-002-20260520    clang-20
i386                  randconfig-003-20260520    clang-20
i386                  randconfig-004-20260520    clang-20
i386                  randconfig-005-20260520    clang-20
i386                  randconfig-006-20260520    clang-20
i386                  randconfig-007-20260520    clang-20
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260520    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260520    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260520    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260520    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260520    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260520    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260520    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260520    gcc-11.5.0
loongarch             randconfig-002-20260520    gcc-11.5.0
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
mips                         rt305x_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260520    gcc-11.5.0
nios2                 randconfig-002-20260520    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260520    clang-23
parisc                randconfig-002-20260520    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260520    clang-23
powerpc               randconfig-002-20260520    clang-23
powerpc64             randconfig-001-20260520    clang-23
powerpc64             randconfig-002-20260520    clang-23
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
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260520    gcc-8.5.0
sparc                 randconfig-002-20260520    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260520    gcc-8.5.0
sparc64               randconfig-002-20260520    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260520    gcc-8.5.0
um                    randconfig-002-20260520    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260520    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260520    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260520    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260520    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260520    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260520    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260520    gcc-14
x86_64                randconfig-002-20260520    gcc-14
x86_64                randconfig-003-20260520    gcc-14
x86_64                randconfig-004-20260520    gcc-14
x86_64                randconfig-005-20260520    gcc-14
x86_64                randconfig-006-20260520    gcc-14
x86_64                randconfig-011-20260520    gcc-14
x86_64                randconfig-012-20260520    gcc-14
x86_64                randconfig-013-20260520    gcc-14
x86_64                randconfig-014-20260520    gcc-14
x86_64                randconfig-015-20260520    gcc-14
x86_64                randconfig-016-20260520    gcc-14
x86_64                randconfig-071-20260520    gcc-14
x86_64                randconfig-072-20260520    gcc-14
x86_64                randconfig-073-20260520    gcc-14
x86_64                randconfig-074-20260520    gcc-14
x86_64                randconfig-075-20260520    gcc-14
x86_64                randconfig-076-20260520    gcc-14
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
xtensa                randconfig-001-20260520    gcc-8.5.0
xtensa                randconfig-002-20260520    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
