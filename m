Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5539D6F4
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777506671; cv=none; b=J34CiG7TpXAqACCbYhaHNz9TUC51mQwJcO7Unu4E0qCSb46zRBxEZV5Srmv9y/Zj7StkMYBjgNQZ6gg2YnzO/9vYdSem+Jw2j+3GFSgVhsQbLuvvboYgZlY+Oyey5XOhmi+8mSvlnONsDuqIigoFW4LMeQX9k4VCAh7uhD+Wjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777506671; c=relaxed/simple;
	bh=gPewlzRqZCVPrUPzMeTsCbWTOPETdd7fs9Qyk0RSLCo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pYEM+S+cNKlpgXP8+SNRlfsAOCtB09iqRMmhuQjRzlrSsPYkj0a7WGopvOe15PRCplEE6eEel9n6LFRyepcql/U1itV9kBKo/6JxElILEi2plkG+s7AhEdPaX+RyshScP0ZErE2+t/Q53aSndTwhESUj3id9pVqzVkWi3wKcpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUl2t138; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUl2t138"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777506670; x=1809042670;
  h=date:from:to:cc:subject:message-id;
  bh=gPewlzRqZCVPrUPzMeTsCbWTOPETdd7fs9Qyk0RSLCo=;
  b=RUl2t138DwjlTPdF9IsPJXDEomn7TAVhlMHiaH/+TdqRFjMS5CGCUPm/
   JIq5m6wxKq7/qbY9F/yulJY1UV6obY7MtzNUFkVapEWyVfa5SzhyVYoxV
   0qvFMADHB02BA2BksQ+lOR+VaQ9d0wvJ0QSXFi2aMiIoi1nxeLKCf4Nn+
   /V9BLR4fj8LeRy/JN3hr/Iqmeqm1Rym/nNZ6crMnofeRBkplwgQBMR5BD
   7cDOSAXQk9PsOtt23qiYYt7qvkRZHjnz/lZ3jwC+d1FIWpqX6pHeB4MGK
   7jZCERiS9GsAKv6E08kx1Q73H/7e3cCPAoKYKg/PBPHUn0IQLYGbVBzIA
   A==;
X-CSE-ConnectionGUID: D3i+SvwbRMKtgniCbUsrGQ==
X-CSE-MsgGUID: CnSgPGdeRWeYjfng21N8NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89046589"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89046589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 16:51:09 -0700
X-CSE-ConnectionGUID: 6i2p8f9LS46ykm0RQrc2Kg==
X-CSE-MsgGUID: gCWr7cv8RjuLB+1GjiQjew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238388896"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2026 16:51:07 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIEgL-00000000Bf6-0QSu;
	Wed, 29 Apr 2026 23:51:05 +0000
Date: Thu, 30 Apr 2026 07:50:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 842c96e80e883e8b2a70e9e6196d636804576cb0
Message-ID: <202604300749.3j8p5FL5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 842c96e80e883e8b2a70e9e6196d636804576cb0  PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap

elapsed time: 2999m

configs tested: 149
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
arc                   randconfig-001-20260430    gcc-8.5.0
arc                   randconfig-002-20260430    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260430    gcc-8.5.0
arm                   randconfig-002-20260430    gcc-8.5.0
arm                   randconfig-003-20260430    gcc-8.5.0
arm                   randconfig-004-20260430    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260430    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260430    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260430    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260430    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260430    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260430    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260430    gcc-14.3.0
hexagon               randconfig-002-20260430    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260430    gcc-14
i386        buildonly-randconfig-002-20260430    gcc-14
i386        buildonly-randconfig-003-20260430    gcc-14
i386        buildonly-randconfig-004-20260430    gcc-14
i386        buildonly-randconfig-005-20260430    gcc-14
i386        buildonly-randconfig-006-20260430    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260430    clang-20
i386                  randconfig-002-20260430    clang-20
i386                  randconfig-003-20260430    clang-20
i386                  randconfig-004-20260430    clang-20
i386                  randconfig-005-20260430    clang-20
i386                  randconfig-006-20260430    clang-20
i386                  randconfig-007-20260430    clang-20
i386                  randconfig-011-20260430    clang-20
i386                  randconfig-012-20260430    clang-20
i386                  randconfig-013-20260430    clang-20
i386                  randconfig-014-20260430    clang-20
i386                  randconfig-015-20260430    clang-20
i386                  randconfig-016-20260430    clang-20
i386                  randconfig-017-20260430    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260430    gcc-14.3.0
loongarch             randconfig-002-20260430    gcc-14.3.0
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
mips                           xway_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260430    gcc-14.3.0
nios2                 randconfig-002-20260430    gcc-14.3.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260430    gcc-13.4.0
parisc                randconfig-002-20260430    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260430    gcc-13.4.0
powerpc               randconfig-002-20260430    gcc-13.4.0
powerpc64             randconfig-001-20260430    gcc-13.4.0
powerpc64             randconfig-002-20260430    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260430    gcc-14
x86_64      buildonly-randconfig-002-20260430    gcc-14
x86_64      buildonly-randconfig-003-20260430    gcc-14
x86_64      buildonly-randconfig-004-20260430    gcc-14
x86_64      buildonly-randconfig-005-20260430    gcc-14
x86_64      buildonly-randconfig-006-20260430    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260430    clang-20
x86_64                randconfig-012-20260430    clang-20
x86_64                randconfig-013-20260430    clang-20
x86_64                randconfig-014-20260430    clang-20
x86_64                randconfig-015-20260430    clang-20
x86_64                randconfig-016-20260430    clang-20
x86_64                randconfig-071-20260430    gcc-14
x86_64                randconfig-072-20260430    gcc-14
x86_64                randconfig-073-20260430    gcc-14
x86_64                randconfig-074-20260430    gcc-14
x86_64                randconfig-075-20260430    gcc-14
x86_64                randconfig-076-20260430    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
