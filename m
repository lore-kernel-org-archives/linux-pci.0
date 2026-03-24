Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A233E3DB5
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349041; cv=none; b=QF9FF23vC6/ebzEwEtpYlBFOXDbRy8LEgJU57y/ItHAzm5hXOMBqhdLb2Cyz7z6OE+QLuLSLr3hR+92TSNvQdP1k21ehjRnuV96aIiT5YZmxjkmhyuUwEd24PjpEVNUfe8hIq0hnuOE0m57d/8uotwIWCMP4wfRe2FziSWMYR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349041; c=relaxed/simple;
	bh=tTSf2c1AgPRghJFkHnVDRwIlMF08DROlvtCd0xisjy8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NneYydaQhIZvI8qeM0676ol6hg+p+MNa5wbCjJSQd/ePiTZ+YgtEQ4Bj4QAyFOGlr1iaK0wV8Lcz7G1R5BA2ae0TbA/1FrOvDsI+epWKFDDpVGR4OE3ZtXLW+4d4obl65lNMy9EkqZGGD3TlSmTTX2wdg6suUfDUF+s9OrxCvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEQm4jCh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEQm4jCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774349039; x=1805885039;
  h=date:from:to:cc:subject:message-id;
  bh=tTSf2c1AgPRghJFkHnVDRwIlMF08DROlvtCd0xisjy8=;
  b=JEQm4jChB0Fh+R6C05OHu0IuIA/sBbq8o0f/QHs8vy2UnUfmhVCXu7QD
   EwJbHZt3nFnwOtN+ZPhnkcxjSHxPGg2CZpIIMp9+CbYD3Nyw7WPfxzOL6
   hXlmHfIMFwKofJZ2vEWDGrBIW/wJ7E9cns746ik/mD6q9D616fArewo4Q
   5GjfO4c0jn4UMpiqpbcoRxuMDGZO0Lp7xTqNXhf18jDW6t4lrStosbPUL
   M1lPZmAa0UKTvEiPr8ZyZcwuRJuQOV+KZ9lcv2DoM+kPtGhFTZU8mzHDY
   mBpkeGi8dI7AL+9ZWbWpz0uKOBFAwiXukDk7RjzzImnDt+DCi9C6SfYfh
   w==;
X-CSE-ConnectionGUID: fyHvtg/FScuKIG8SkcBXEQ==
X-CSE-MsgGUID: KpVp4/UeS6aRFE6iw6wE1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75245440"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75245440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:43:59 -0700
X-CSE-ConnectionGUID: 9O/57IImQfKmoDPBSptZ4g==
X-CSE-MsgGUID: qG41hoSHTpOPDHXemXjVrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228795557"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Mar 2026 03:43:57 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4zEp-000000004PH-04ej;
	Tue, 24 Mar 2026 10:43:55 +0000
Date: Tue, 24 Mar 2026 18:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 05f643d6f7e699198ccc47e634de3879a8ec26a3
Message-ID: <202603241815.AR7g076z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 05f643d6f7e699198ccc47e634de3879a8ec26a3  Documentation: PCI: Document PCIe TLP Header decoder for AER messages

elapsed time: 803m

configs tested: 255
configs skipped: 3

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
arc                   randconfig-001-20260324    gcc-11.5.0
arc                   randconfig-001-20260324    gcc-8.5.0
arc                   randconfig-002-20260324    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260324    gcc-8.5.0
arm                   randconfig-002-20260324    gcc-14.3.0
arm                   randconfig-002-20260324    gcc-8.5.0
arm                   randconfig-003-20260324    gcc-8.5.0
arm                   randconfig-004-20260324    clang-23
arm                   randconfig-004-20260324    gcc-8.5.0
arm                           u8500_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260324    gcc-13.4.0
arm64                 randconfig-002-20260324    gcc-13.4.0
arm64                 randconfig-002-20260324    gcc-8.5.0
arm64                 randconfig-003-20260324    clang-23
arm64                 randconfig-003-20260324    gcc-13.4.0
arm64                 randconfig-004-20260324    clang-23
arm64                 randconfig-004-20260324    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260324    gcc-13.4.0
csky                  randconfig-001-20260324    gcc-15.2.0
csky                  randconfig-002-20260324    gcc-13.4.0
csky                  randconfig-002-20260324    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260324    clang-23
hexagon               randconfig-001-20260324    gcc-11.5.0
hexagon               randconfig-002-20260324    clang-23
hexagon               randconfig-002-20260324    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260324    gcc-12
i386        buildonly-randconfig-002-20260324    clang-20
i386        buildonly-randconfig-002-20260324    gcc-12
i386        buildonly-randconfig-003-20260324    clang-20
i386        buildonly-randconfig-003-20260324    gcc-12
i386        buildonly-randconfig-004-20260324    gcc-12
i386        buildonly-randconfig-004-20260324    gcc-14
i386        buildonly-randconfig-005-20260324    clang-20
i386        buildonly-randconfig-005-20260324    gcc-12
i386        buildonly-randconfig-006-20260324    gcc-12
i386        buildonly-randconfig-006-20260324    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260324    clang-20
i386                  randconfig-001-20260324    gcc-14
i386                  randconfig-002-20260324    clang-20
i386                  randconfig-003-20260324    clang-20
i386                  randconfig-004-20260324    clang-20
i386                  randconfig-005-20260324    clang-20
i386                  randconfig-006-20260324    clang-20
i386                  randconfig-006-20260324    gcc-14
i386                  randconfig-007-20260324    clang-20
i386                  randconfig-007-20260324    gcc-14
i386                  randconfig-011-20260324    clang-20
i386                  randconfig-011-20260324    gcc-13
i386                  randconfig-012-20260324    clang-20
i386                  randconfig-012-20260324    gcc-13
i386                  randconfig-013-20260324    gcc-13
i386                  randconfig-013-20260324    gcc-14
i386                  randconfig-014-20260324    gcc-13
i386                  randconfig-015-20260324    gcc-13
i386                  randconfig-015-20260324    gcc-14
i386                  randconfig-016-20260324    gcc-13
i386                  randconfig-017-20260324    clang-20
i386                  randconfig-017-20260324    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260324    gcc-11.5.0
loongarch             randconfig-001-20260324    gcc-14.3.0
loongarch             randconfig-002-20260324    clang-18
loongarch             randconfig-002-20260324    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260324    gcc-11.5.0
nios2                 randconfig-002-20260324    gcc-11.5.0
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
parisc                randconfig-001-20260324    gcc-12.5.0
parisc                randconfig-001-20260324    gcc-8.5.0
parisc                randconfig-002-20260324    gcc-10.5.0
parisc                randconfig-002-20260324    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260324    gcc-8.5.0
powerpc               randconfig-002-20260324    gcc-8.5.0
powerpc64             randconfig-001-20260324    gcc-14.3.0
powerpc64             randconfig-001-20260324    gcc-8.5.0
powerpc64             randconfig-002-20260324    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260324    clang-23
riscv                 randconfig-002-20260324    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260324    clang-23
s390                  randconfig-001-20260324    gcc-12.5.0
s390                  randconfig-002-20260324    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260324    clang-23
sh                    randconfig-001-20260324    gcc-15.2.0
sh                    randconfig-002-20260324    clang-23
sh                    randconfig-002-20260324    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260324    gcc-14
sparc                 randconfig-001-20260324    gcc-15.2.0
sparc                 randconfig-002-20260324    gcc-14
sparc                 randconfig-002-20260324    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260324    clang-23
sparc64               randconfig-001-20260324    gcc-14
sparc64               randconfig-002-20260324    clang-20
sparc64               randconfig-002-20260324    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260324    gcc-14
um                    randconfig-002-20260324    clang-17
um                    randconfig-002-20260324    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260324    gcc-14
x86_64      buildonly-randconfig-002-20260324    clang-20
x86_64      buildonly-randconfig-002-20260324    gcc-14
x86_64      buildonly-randconfig-003-20260324    clang-20
x86_64      buildonly-randconfig-003-20260324    gcc-14
x86_64      buildonly-randconfig-004-20260324    gcc-14
x86_64      buildonly-randconfig-005-20260324    gcc-12
x86_64      buildonly-randconfig-005-20260324    gcc-14
x86_64      buildonly-randconfig-006-20260324    clang-20
x86_64      buildonly-randconfig-006-20260324    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260324    clang-20
x86_64                randconfig-001-20260324    gcc-14
x86_64                randconfig-002-20260324    clang-20
x86_64                randconfig-003-20260324    clang-20
x86_64                randconfig-003-20260324    gcc-14
x86_64                randconfig-004-20260324    clang-20
x86_64                randconfig-004-20260324    gcc-14
x86_64                randconfig-005-20260324    clang-20
x86_64                randconfig-005-20260324    gcc-14
x86_64                randconfig-006-20260324    clang-20
x86_64                randconfig-011-20260324    clang-20
x86_64                randconfig-011-20260324    gcc-14
x86_64                randconfig-012-20260324    gcc-14
x86_64                randconfig-013-20260324    gcc-14
x86_64                randconfig-014-20260324    clang-20
x86_64                randconfig-014-20260324    gcc-14
x86_64                randconfig-015-20260324    gcc-14
x86_64                randconfig-016-20260324    clang-20
x86_64                randconfig-016-20260324    gcc-14
x86_64                randconfig-071-20260324    gcc-12
x86_64                randconfig-071-20260324    gcc-14
x86_64                randconfig-072-20260324    gcc-12
x86_64                randconfig-072-20260324    gcc-14
x86_64                randconfig-073-20260324    gcc-12
x86_64                randconfig-073-20260324    gcc-14
x86_64                randconfig-074-20260324    gcc-12
x86_64                randconfig-075-20260324    gcc-12
x86_64                randconfig-075-20260324    gcc-14
x86_64                randconfig-076-20260324    gcc-12
x86_64                randconfig-076-20260324    gcc-14
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
xtensa                randconfig-001-20260324    gcc-14
xtensa                randconfig-001-20260324    gcc-8.5.0
xtensa                randconfig-002-20260324    gcc-14
xtensa                randconfig-002-20260324    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
