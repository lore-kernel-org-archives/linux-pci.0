Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86E2D6400
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664251; cv=none; b=uVZM95ERdvXdDbZGEuxUo3QQoW4VRC0yrzAR4u6dfWGII8NMmazobObj72/XTA13bjGHISyIr9kb3UTBvE1xcA+OF0OT/eKttToOzm5mrvOTQYf8iqlV00hln3jgj6zb9GwCWJJ8aAp9BaxE+h1ItaGJkwvi0IDyEAghykPUgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664251; c=relaxed/simple;
	bh=G5n2JTNb8GJRUn3ZUcRLf30n+wm9B2MPg8JNtbnfv48=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cpo73FTYDff0bdtpeigtjTHPEExgEvkMzEOwLeoaL7rGO7wsSZsKhXarYA3ap5dnw/fS2wstqI4wLmdyR9AaVJJljemfSQyFziFqSztf08p/P8JojYuuDztQWlwqCLXGe+kOmA7vMBghAcYRi8bDNmjqmaJzX2XQYc4pyg3Nn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE1a7A+G; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE1a7A+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769664249; x=1801200249;
  h=date:from:to:cc:subject:message-id;
  bh=G5n2JTNb8GJRUn3ZUcRLf30n+wm9B2MPg8JNtbnfv48=;
  b=aE1a7A+Gg5mF+2vLKDAisqm/kOaiL5TE5leAxNsS0vJC2tGFxymEizm+
   HF9WpCZgAeUN9+Aqr5OeYPyTfzULd3JYsR9PgeaHY6xieSPSRLnQqOyAG
   QtmKVsEcgRnsoCnHv1gDV9FJ5U4qKQMvjT2q8laVsbzs2eovmYXe9sqz8
   3LPwbjTCwEfOeipTo0z5+bAzMkyBVdCgN0tVPnJYHXFySUF3MwddZOkxm
   UkhDjEEd0+iaifLriIl+BOYVRyx3qhZs50LBI8Sk6PsgrdogExr6UybAT
   1sFZoSNJtvV+nJGvAsKRZwiopFS8SwOZX7/kwFc8xiR5uWJZ5/UihWoGo
   A==;
X-CSE-ConnectionGUID: kbNFyni7TAiBZ8w2KFSzqQ==
X-CSE-MsgGUID: 3tRKjVTASGCLfNoiIzotRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="96355460"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="96355460"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 21:24:09 -0800
X-CSE-ConnectionGUID: MHJ10AbwSbWV6l5hHeVNlw==
X-CSE-MsgGUID: 3yxvk27iQQ+MsrNrihYvBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="207706717"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Jan 2026 21:24:07 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlKVg-00000000b7o-2LZZ;
	Thu, 29 Jan 2026 05:24:04 +0000
Date: Thu, 29 Jan 2026 13:23:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 0a1b453be99fbeb594c951bd1211dcfd6685a991
Message-ID: <202601291338.SpQLPnES-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 0a1b453be99fbeb594c951bd1211dcfd6685a991  PCI/pwrctrl: Create pwrctrl device if graph port is found

elapsed time: 726m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260129    clang-18
arc                   randconfig-002-20260129    clang-18
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260129    clang-18
arm                   randconfig-002-20260129    clang-18
arm                   randconfig-003-20260129    clang-18
arm                   randconfig-004-20260129    clang-18
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260129    gcc-11.5.0
arm64                 randconfig-002-20260129    gcc-11.5.0
arm64                 randconfig-003-20260129    gcc-11.5.0
arm64                 randconfig-004-20260129    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260129    gcc-11.5.0
csky                  randconfig-002-20260129    gcc-11.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260129    clang-22
hexagon               randconfig-002-20260129    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260129    clang-20
i386        buildonly-randconfig-002-20260129    clang-20
i386        buildonly-randconfig-003-20260129    clang-20
i386        buildonly-randconfig-004-20260129    clang-20
i386        buildonly-randconfig-005-20260129    clang-20
i386        buildonly-randconfig-006-20260129    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260129    clang-20
i386                  randconfig-002-20260129    clang-20
i386                  randconfig-003-20260129    clang-20
i386                  randconfig-004-20260129    clang-20
i386                  randconfig-005-20260129    clang-20
i386                  randconfig-006-20260129    clang-20
i386                  randconfig-007-20260129    clang-20
i386                  randconfig-011-20260129    clang-20
i386                  randconfig-012-20260129    clang-20
i386                  randconfig-013-20260129    clang-20
i386                  randconfig-014-20260129    clang-20
i386                  randconfig-015-20260129    clang-20
i386                  randconfig-016-20260129    clang-20
i386                  randconfig-017-20260129    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260129    clang-22
loongarch             randconfig-002-20260129    clang-22
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
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260129    clang-22
nios2                 randconfig-002-20260129    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260129    gcc-8.5.0
parisc                randconfig-002-20260129    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260129    gcc-8.5.0
powerpc               randconfig-002-20260129    gcc-8.5.0
powerpc64             randconfig-001-20260129    gcc-8.5.0
powerpc64             randconfig-002-20260129    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260129    gcc-15.2.0
riscv                 randconfig-002-20260129    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260129    gcc-15.2.0
s390                  randconfig-002-20260129    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260129    gcc-15.2.0
sh                    randconfig-002-20260129    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260129    gcc-13
x86_64      buildonly-randconfig-002-20260129    gcc-13
x86_64      buildonly-randconfig-003-20260129    gcc-13
x86_64      buildonly-randconfig-004-20260129    gcc-13
x86_64      buildonly-randconfig-005-20260129    gcc-13
x86_64      buildonly-randconfig-006-20260129    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260129    clang-20
x86_64                randconfig-002-20260129    clang-20
x86_64                randconfig-003-20260129    clang-20
x86_64                randconfig-004-20260129    clang-20
x86_64                randconfig-005-20260129    clang-20
x86_64                randconfig-006-20260129    clang-20
x86_64                randconfig-011-20260129    clang-20
x86_64                randconfig-012-20260129    clang-20
x86_64                randconfig-013-20260129    clang-20
x86_64                randconfig-014-20260129    clang-20
x86_64                randconfig-016-20260129    clang-20
x86_64                randconfig-071-20260129    gcc-14
x86_64                randconfig-072-20260129    gcc-14
x86_64                randconfig-073-20260129    gcc-14
x86_64                randconfig-074-20260129    gcc-14
x86_64                randconfig-075-20260129    gcc-14
x86_64                randconfig-076-20260129    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
