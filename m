Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDC1A5B9D
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783658205; cv=none; b=o2oCk5OTkYUk9ggfjRcqmgJ/zczB54Nb3whc5oDkL5zicRtbwr240IjNRVdoPRpm1urkCD2A6tgdOF8DS3VV9VEMKCnPxkVzUQONVAmoi6P8PhCNQeEgG4d+JygwiJlnqXQcqz8o669wZtVUd7kU9AzrViT1Rhv+sGs8Ca1HDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783658205; c=relaxed/simple;
	bh=D0ycdMJqOvGZxYllY+BzmtzVOvm5RDoXYFDZ/Va6jCI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B6clmCI3ZUQzmow8R5287Qxxx8J0b/+ulIxqsPLhoEOvYFB8qS4E11hEoH8fWuX63m8twKMEAGTL518xnzhLn4ZsVLctTMQ9GXKMuTz6oy+raZA1ZtqtOWbkbMzP92iGQ6qTlNWozNoVaRo1bx4H3xWnOkXV0rdPwi2OCqeSFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdTr5mox; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdTr5mox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783658203; x=1815194203;
  h=date:from:to:cc:subject:message-id;
  bh=D0ycdMJqOvGZxYllY+BzmtzVOvm5RDoXYFDZ/Va6jCI=;
  b=MdTr5moxchmh4DogduhgbI4iRYFQ6kjQj0PNR3NtOQ6kJBDkDgr0QDR5
   uxvbCB5omkK8c8+0o+IKaQl53AslEfQe77Yp/GXZXXIE8J/RWPFHdPPRp
   9h9jnmDg4phuoBoSUOVvLf8+ZLksWe7mL+rowMC49F97c4EoZhjcfLcdO
   VJUBGWbkhjEO2y7otYvxQd9sfq863YDjCOO4bDtlGEKoAXo4e7tPkvvDv
   hV97SCwqmoU6SV878+w85Xo6v0Uw31MQjVNE+/z0njcTI4luxh0qxH+EK
   6zWF6tub/7eqB4UIZkWHu1g3XqByef5I6n43Jggs6jMEKig39PuBKR1jm
   A==;
X-CSE-ConnectionGUID: 9DYvOc78Tw2B/wYUf4LOzQ==
X-CSE-MsgGUID: 1fZja+uZTTOHzNY4DqpIGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86899644"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="86899644"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 21:36:42 -0700
X-CSE-ConnectionGUID: 9Vitie8UR7qynjBGdcB4Rw==
X-CSE-MsgGUID: IH2NUaILSsS2In+nqe/3xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253044838"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2026 21:36:41 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wi2yb-00000000IUN-3pNl;
	Fri, 10 Jul 2026 04:36:37 +0000
Date: Fri, 10 Jul 2026 12:36:34 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 93aac16f1eb9a181f9bdde620b464f6cc5fa8369
Message-ID: <202607101224.3Aqd7jLh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 93aac16f1eb9a181f9bdde620b464f6cc5fa8369  PCI: cadence: Add missing MODULE_DEVICE_TABLE()

elapsed time: 953m

configs tested: 341
configs skipped: 10

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
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260709    gcc-16.1.0
arc                   randconfig-001-20260710    clang-23
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260709    gcc-16.1.0
arc                   randconfig-002-20260710    clang-23
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          ep93xx_defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260709    gcc-16.1.0
arm                   randconfig-001-20260710    clang-23
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260709    gcc-16.1.0
arm                   randconfig-002-20260710    clang-23
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260709    gcc-16.1.0
arm                   randconfig-003-20260710    clang-23
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260709    gcc-16.1.0
arm                   randconfig-004-20260710    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260709    gcc-16.1.0
arm64                 randconfig-001-20260710    gcc-10.5.0
arm64                 randconfig-002-20260709    gcc-16.1.0
arm64                 randconfig-002-20260710    gcc-10.5.0
arm64                 randconfig-003-20260709    gcc-16.1.0
arm64                 randconfig-003-20260710    gcc-10.5.0
arm64                 randconfig-004-20260709    gcc-16.1.0
arm64                 randconfig-004-20260710    gcc-10.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260709    gcc-16.1.0
csky                  randconfig-001-20260710    gcc-10.5.0
csky                  randconfig-002-20260709    gcc-16.1.0
csky                  randconfig-002-20260710    gcc-10.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260709    clang-18
hexagon               randconfig-001-20260710    gcc-12.5.0
hexagon               randconfig-002-20260709    clang-18
hexagon               randconfig-002-20260710    gcc-12.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260709    gcc-14
i386        buildonly-randconfig-001-20260710    clang-22
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260709    gcc-14
i386        buildonly-randconfig-002-20260710    clang-22
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260709    gcc-14
i386        buildonly-randconfig-003-20260710    clang-22
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260709    gcc-14
i386        buildonly-randconfig-004-20260710    clang-22
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260709    gcc-14
i386        buildonly-randconfig-005-20260710    clang-22
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260709    gcc-14
i386        buildonly-randconfig-006-20260710    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260709    gcc-14
i386                  randconfig-001-20260710    clang-22
i386                  randconfig-002-20260709    gcc-14
i386                  randconfig-002-20260710    clang-22
i386                  randconfig-003-20260709    gcc-14
i386                  randconfig-003-20260710    clang-22
i386                  randconfig-004-20260709    gcc-14
i386                  randconfig-004-20260710    clang-22
i386                  randconfig-005-20260709    gcc-14
i386                  randconfig-005-20260710    clang-22
i386                  randconfig-006-20260709    gcc-14
i386                  randconfig-006-20260710    clang-22
i386                  randconfig-007-20260709    gcc-14
i386                  randconfig-007-20260710    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260709    gcc-14
i386                  randconfig-011-20260710    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260709    gcc-14
i386                  randconfig-012-20260710    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260709    gcc-14
i386                  randconfig-013-20260710    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260709    gcc-14
i386                  randconfig-014-20260710    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260709    gcc-14
i386                  randconfig-015-20260710    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260709    gcc-14
i386                  randconfig-016-20260710    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260709    gcc-14
i386                  randconfig-017-20260710    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260709    clang-18
loongarch             randconfig-001-20260710    gcc-12.5.0
loongarch             randconfig-002-20260709    clang-18
loongarch             randconfig-002-20260710    gcc-12.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260709    clang-18
nios2                 randconfig-001-20260710    gcc-12.5.0
nios2                 randconfig-002-20260709    clang-18
nios2                 randconfig-002-20260710    gcc-12.5.0
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
parisc                         randconfig-001    clang-23
parisc                randconfig-001-20260709    clang-23
parisc                randconfig-001-20260710    clang-17
parisc                         randconfig-002    clang-23
parisc                randconfig-002-20260709    clang-23
parisc                randconfig-002-20260710    clang-17
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc                     mpc83xx_defconfig    clang-21
powerpc                       ppc64_defconfig    clang-17
powerpc                     rainier_defconfig    gcc-16.1.0
powerpc                        randconfig-001    clang-23
powerpc               randconfig-001-20260709    clang-23
powerpc               randconfig-001-20260710    clang-17
powerpc                        randconfig-002    clang-23
powerpc               randconfig-002-20260709    clang-23
powerpc               randconfig-002-20260710    clang-17
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260709    clang-23
powerpc64             randconfig-001-20260710    clang-17
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260709    clang-23
powerpc64             randconfig-002-20260710    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-17
riscv                          randconfig-001    clang-22
riscv                 randconfig-001-20260709    clang-22
riscv                 randconfig-001-20260710    clang-17
riscv                          randconfig-002    clang-17
riscv                          randconfig-002    clang-22
riscv                 randconfig-002-20260709    clang-22
riscv                 randconfig-002-20260710    clang-17
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-17
s390                           randconfig-001    clang-22
s390                  randconfig-001-20260709    clang-22
s390                  randconfig-001-20260710    clang-17
s390                           randconfig-002    clang-17
s390                           randconfig-002    clang-22
s390                  randconfig-002-20260709    clang-22
s390                  randconfig-002-20260710    clang-17
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-17
sh                             randconfig-001    clang-22
sh                    randconfig-001-20260709    clang-22
sh                    randconfig-001-20260710    clang-17
sh                             randconfig-002    clang-17
sh                             randconfig-002    clang-22
sh                    randconfig-002-20260709    clang-22
sh                    randconfig-002-20260710    clang-17
sh                   sh7724_generic_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260709    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260709    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260709    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260709    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260709    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260709    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260709    clang-22
x86_64      buildonly-randconfig-001-20260710    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260709    clang-22
x86_64      buildonly-randconfig-002-20260710    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260709    clang-22
x86_64      buildonly-randconfig-003-20260710    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260709    clang-22
x86_64      buildonly-randconfig-004-20260710    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260709    clang-22
x86_64      buildonly-randconfig-005-20260710    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260709    clang-22
x86_64      buildonly-randconfig-006-20260710    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260709    clang-22
x86_64                randconfig-001-20260710    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260709    clang-22
x86_64                randconfig-002-20260710    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260709    clang-22
x86_64                randconfig-003-20260710    gcc-14
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260709    clang-22
x86_64                randconfig-004-20260710    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260709    clang-22
x86_64                randconfig-005-20260710    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260709    clang-22
x86_64                randconfig-006-20260710    gcc-14
x86_64                randconfig-011-20260709    gcc-14
x86_64                randconfig-011-20260710    clang-22
x86_64                randconfig-011-20260710    gcc-14
x86_64                randconfig-012-20260709    gcc-14
x86_64                randconfig-012-20260710    clang-22
x86_64                randconfig-012-20260710    gcc-14
x86_64                randconfig-013-20260709    gcc-14
x86_64                randconfig-013-20260710    clang-22
x86_64                randconfig-014-20260709    gcc-14
x86_64                randconfig-014-20260710    clang-22
x86_64                randconfig-015-20260709    gcc-14
x86_64                randconfig-015-20260710    clang-22
x86_64                randconfig-015-20260710    gcc-14
x86_64                randconfig-016-20260709    gcc-14
x86_64                randconfig-016-20260710    clang-22
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260709    clang-22
x86_64                randconfig-071-20260710    gcc-14
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260709    clang-22
x86_64                randconfig-072-20260710    gcc-14
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260709    clang-22
x86_64                randconfig-073-20260710    gcc-14
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260709    clang-22
x86_64                randconfig-074-20260710    gcc-14
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260709    clang-22
x86_64                randconfig-075-20260710    gcc-14
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260709    clang-22
x86_64                randconfig-076-20260710    gcc-14
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
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260709    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260709    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
