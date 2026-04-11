Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2C308F3E
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895500; cv=none; b=BdZBv+EDKzM44w60+A8m6UZVMraUuK28PSr1f9jikHcJNfRiuiLwZX8VylHRIEJhI8w+nvA7fNIK//iDM0Ede6sunFFW8Ky4dYieHGF+c7JXHDEHX414O/7SydoaXbkvmTIDMfIDRJr0QSLoc4nodKq8U5v5PwWx1C5GSdX3i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895500; c=relaxed/simple;
	bh=hA6xfeGmaAtu+65KzksfjohV1RwWU7y2UaIKbCX5C+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LhItHbkF6F8GolRSflXjp+6nHLkRfRgUWtJodbO7f6VBdpM1wZ69QnYKSlyZnO2hc1hanqQjHZcg+Rh+nw2OxrAogiDKJXBlitdFo6JPjDv1GZ1JhsQzmyvdbtGhK8XJz2MPdSnHRKr+yx+I7F4MTJuCP5qNBDDJxC4TJQiPirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHVAxQhl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHVAxQhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775895498; x=1807431498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hA6xfeGmaAtu+65KzksfjohV1RwWU7y2UaIKbCX5C+g=;
  b=RHVAxQhlB37VLLTT1Yj9lo4SvXplR+1F1AaYRTBww0EFhyREiV4i5Fqa
   +SmT/7JQNV4/OUGfE9RRaGVsdnt8muT8Bd8vR9mtr1kiisBb4SiKimQpS
   amwBChXeFj94xaGDXN+1lCdY4lF/QKrOyxeTcBPxNQHKVL4Q0eafXIocu
   o06rrvy1XbcB73+v7WQ+kH14x8tx/0Ln3UnUB4e8KzoHpeZVJuZnP8ANA
   erftkz4+HFXUpRpq+SMO6lRASACvPup0tTEXOkg6g8jOopWi/xyfgwCv3
   elrA0VNmTwQk/FDq/TNlS7J6BTsbhRzF0wITZPjyhaKc9CWxLXJ3x1X9I
   Q==;
X-CSE-ConnectionGUID: SiVMJ2RGQZ2lm6vrEmr2nQ==
X-CSE-MsgGUID: p7DycQGZQ7K2hEgAGwy4gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="79493514"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="79493514"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 01:18:17 -0700
X-CSE-ConnectionGUID: /YK2xAvQSvO9G9Ss7hH3Yg==
X-CSE-MsgGUID: a1cIZk23RiyLDElDaPIG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="233371110"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Apr 2026 01:18:16 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBTXh-00000000101-1xPk;
	Sat, 11 Apr 2026 08:18:13 +0000
Date: Sat, 11 Apr 2026 16:17:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/static-sysfs-attributes-v4] BUILD SUCCESS
 f357a95be37751a9b37591292dc119f9beb9edc1
Message-ID: <202604111631.lrwAylMM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/static-sysfs-attributes-v4
branch HEAD: f357a95be37751a9b37591292dc119f9beb9edc1  PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()

elapsed time: 892m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260411    gcc-12.5.0
arc                   randconfig-002-20260411    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260411    gcc-14.3.0
arm                   randconfig-002-20260411    clang-23
arm                   randconfig-003-20260411    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260411    clang-23
arm64                 randconfig-002-20260411    clang-23
arm64                 randconfig-003-20260411    clang-16
arm64                 randconfig-004-20260411    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260411    gcc-12.5.0
csky                  randconfig-002-20260411    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260411    clang-23
hexagon               randconfig-002-20260411    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260411    clang-20
i386        buildonly-randconfig-002-20260411    clang-20
i386        buildonly-randconfig-003-20260411    clang-20
i386        buildonly-randconfig-004-20260411    clang-20
i386        buildonly-randconfig-005-20260411    gcc-14
i386        buildonly-randconfig-006-20260411    gcc-14
i386                  randconfig-001-20260411    clang-20
i386                  randconfig-002-20260411    clang-20
i386                  randconfig-003-20260411    clang-20
i386                  randconfig-004-20260411    clang-20
i386                  randconfig-005-20260411    gcc-14
i386                  randconfig-006-20260411    gcc-13
i386                  randconfig-007-20260411    clang-20
i386                  randconfig-011-20260411    clang-20
i386                  randconfig-012-20260411    gcc-14
i386                  randconfig-013-20260411    gcc-14
i386                  randconfig-014-20260411    gcc-14
i386                  randconfig-015-20260411    clang-20
i386                  randconfig-016-20260411    gcc-14
i386                  randconfig-017-20260411    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260411    gcc-14.3.0
loongarch             randconfig-002-20260411    clang-18
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
nios2                 randconfig-001-20260411    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260411    gcc-10.5.0
parisc                randconfig-002-20260411    gcc-11.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260411    clang-17
powerpc               randconfig-002-20260411    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260411    clang-17
riscv                 randconfig-002-20260411    gcc-10.5.0
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260411    gcc-8.5.0
s390                  randconfig-002-20260411    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260411    gcc-12.5.0
sh                    randconfig-002-20260411    gcc-12.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260411    gcc-8.5.0
sparc                 randconfig-002-20260411    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260411    gcc-15.2.0
sparc64               randconfig-002-20260411    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260411    gcc-14
um                    randconfig-002-20260411    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260411    gcc-14
x86_64      buildonly-randconfig-002-20260411    clang-20
x86_64      buildonly-randconfig-003-20260411    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260411    gcc-12
x86_64                randconfig-002-20260411    gcc-14
x86_64                randconfig-003-20260411    gcc-14
x86_64                randconfig-004-20260411    clang-20
x86_64                randconfig-005-20260411    clang-20
x86_64                randconfig-006-20260411    gcc-12
x86_64                randconfig-011-20260411    gcc-14
x86_64                randconfig-012-20260411    clang-20
x86_64                randconfig-013-20260411    gcc-14
x86_64                randconfig-014-20260411    clang-20
x86_64                randconfig-015-20260411    gcc-14
x86_64                randconfig-016-20260411    clang-20
x86_64                randconfig-073-20260411    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260411    gcc-15.2.0
xtensa                randconfig-002-20260411    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
