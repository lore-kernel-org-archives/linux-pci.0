Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7E3D34A4
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995037; cv=none; b=uRuSZUNFgk2LWL+LXVzwtyv8ru+BTrFoKfJJKdJILX6PyEJJTeoyhVxik9/PXeK9/XBU3Zq5rson0ETirjHyvGa3bPF33dz732Y4RfqDF59dETUNBBHoQJViWjny7pnSO2kbg3fy5qOP7kEQh/QYWWNPL9If87zu6LXLPEWbiD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995037; c=relaxed/simple;
	bh=foWTJJmYrnEhHgTrsslFkQnNtvKYLTEbvu1nbmhl8ak=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bzQG0DzZSj+EqpNb/9kWQhN6K6KowhJpufqRdU9cJxOodEy7xMfPWiMLsbGk+XjU45j6x4p8lcfh1Ax+k6Dat29AzDmzcOMLTpRf8q7OvdykRly5fs2OIAnCP0vGgPPyYRj/mD5ugMG1fgI0It9Zf4jOzr9AVdyk52MCw8tq1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUkCCg88; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUkCCg88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768995036; x=1800531036;
  h=date:from:to:cc:subject:message-id;
  bh=foWTJJmYrnEhHgTrsslFkQnNtvKYLTEbvu1nbmhl8ak=;
  b=SUkCCg88yKhGyXCEd52gAZEMXsLRvlYhN545zjgSDosUK6zWJrdN9xSY
   g49De+72zxzuicNRJfAr1pqngVtAQXa0AlTXqLyEXKiIgwF0BdDDfLzxN
   Z8dA11iZJG4a46BYZP+xOs0TFcUO8WYGGv1oNOW8ozW6ukbUmEiC8xtl1
   fnW9DgGy+8ZSebzOBEXQ3aV+Lpx0++FRNjdzE9ZL70JbjB3b6e5N2dChY
   nwZBz6H/Dk3Zebp458Oa9DBFxbrBKTIE5bEJyBpOBez77QMkHihWWOI6L
   2U9Y9kFi0DLTljJhgLSEZrfcbZSEZ662vnd7QxIplO1PD2W4eOepgsgoQ
   Q==;
X-CSE-ConnectionGUID: 6Real+6NST+snxSYegNvHw==
X-CSE-MsgGUID: UzOnym8eTf2UxHJN46s40w==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69236881"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69236881"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 03:30:35 -0800
X-CSE-ConnectionGUID: dfJLw1k2TrqvfxEbWROpmA==
X-CSE-MsgGUID: wtP70tNOTpGUlor3Vu65NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206484779"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Jan 2026 03:30:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viWPu-00000000RC1-1hci;
	Wed, 21 Jan 2026 11:30:30 +0000
Date: Wed, 21 Jan 2026 19:30:25 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 8d8db7dbf2181052dc2e8813737ef31d136e4dbd
Message-ID: <202601211920.Iystrx1t-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 8d8db7dbf2181052dc2e8813737ef31d136e4dbd  PCI: qcom: Rename PERST# assert/deassert helpers for uniformity

elapsed time: 1050m

configs tested: 159
configs skipped: 3

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
arc                   randconfig-001-20260121    gcc-8.5.0
arc                   randconfig-002-20260121    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20260121    clang-20
arm                   randconfig-002-20260121    gcc-15.2.0
arm                   randconfig-003-20260121    clang-18
arm                   randconfig-004-20260121    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260121    gcc-15.2.0
arm64                 randconfig-002-20260121    clang-22
arm64                 randconfig-003-20260121    clang-22
arm64                 randconfig-004-20260121    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260121    gcc-9.5.0
csky                  randconfig-002-20260121    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260121    clang-19
hexagon               randconfig-002-20260121    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260121    clang-20
i386        buildonly-randconfig-002-20260121    gcc-14
i386        buildonly-randconfig-003-20260121    gcc-13
i386        buildonly-randconfig-004-20260121    clang-20
i386        buildonly-randconfig-005-20260121    clang-20
i386        buildonly-randconfig-006-20260121    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260121    gcc-14
i386                  randconfig-002-20260121    clang-20
i386                  randconfig-003-20260121    clang-20
i386                  randconfig-004-20260121    clang-20
i386                  randconfig-011-20260121    gcc-14
i386                  randconfig-012-20260121    gcc-14
i386                  randconfig-013-20260121    clang-20
i386                  randconfig-014-20260121    gcc-12
i386                  randconfig-015-20260121    gcc-14
i386                  randconfig-016-20260121    gcc-14
i386                  randconfig-017-20260121    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260121    gcc-15.2.0
loongarch             randconfig-002-20260121    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260121    gcc-11.5.0
nios2                 randconfig-002-20260121    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260121    gcc-9.5.0
parisc                randconfig-002-20260121    gcc-13.4.0
parisc64                            defconfig    gcc-15.2.0
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20260121    clang-22
powerpc               randconfig-002-20260121    clang-22
powerpc64             randconfig-001-20260121    clang-22
powerpc64             randconfig-002-20260121    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260121    clang-16
riscv                 randconfig-002-20260121    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260121    gcc-9.5.0
s390                  randconfig-002-20260121    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260121    gcc-14.3.0
sh                    randconfig-002-20260121    gcc-9.5.0
sh                           se7343_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260121    gcc-8.5.0
sparc                 randconfig-002-20260121    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260121    gcc-13.4.0
sparc64               randconfig-002-20260121    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260121    gcc-14
um                    randconfig-002-20260121    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260121    clang-20
x86_64      buildonly-randconfig-002-20260121    gcc-14
x86_64      buildonly-randconfig-003-20260121    clang-20
x86_64      buildonly-randconfig-004-20260121    clang-20
x86_64      buildonly-randconfig-005-20260121    gcc-13
x86_64      buildonly-randconfig-006-20260121    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-002-20260121    gcc-14
x86_64                randconfig-003-20260121    gcc-14
x86_64                randconfig-011-20260121    gcc-14
x86_64                randconfig-012-20260121    clang-20
x86_64                randconfig-013-20260121    gcc-14
x86_64                randconfig-014-20260121    gcc-14
x86_64                randconfig-016-20260121    gcc-14
x86_64                randconfig-071-20260121    clang-20
x86_64                randconfig-072-20260121    clang-20
x86_64                randconfig-073-20260121    clang-20
x86_64                randconfig-074-20260121    clang-20
x86_64                randconfig-075-20260121    clang-20
x86_64                randconfig-076-20260121    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260121    gcc-14.3.0
xtensa                randconfig-002-20260121    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
