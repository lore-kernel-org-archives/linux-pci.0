Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255C31717C
	for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932778; cv=none; b=HdVVNRVECY+yvLeanz5XhUxbXcvq1buODbLfY8NqOP4GWEdjP/sKSXC2U7NcmoWbTplyGsTNxoKNvofmuAbqzQ39X6eQbWSuJmUw8ltdURKH62NzeHUlC2Jnom5SdH88v6k0/QoDTyTXTY2WbKjhZNXpw3YeJfC8aZKzMUdOSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932778; c=relaxed/simple;
	bh=aUFM9y0tYmjDp6s77IKGL9BRImc2Pr8aBjnvoyycu0w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Gb2HR4HqtmkpSkNo9P6he5KoxVIPS9ZPvTbzfD1jyxTtcA8wcv7jsb7hGYPefSndaGP52lpWyucVeVl7P1W4i+Deu1mThKPJFzfSA43045s4BzyhKFGfpeBCcjwE7a7fTdITH/q7NxRnMBOPuXkaGKgDqqiSR/8c6O07pbhTlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfiCNe4R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfiCNe4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778932778; x=1810468778;
  h=date:from:to:cc:subject:message-id;
  bh=aUFM9y0tYmjDp6s77IKGL9BRImc2Pr8aBjnvoyycu0w=;
  b=YfiCNe4RpABeshmJsp+BJlqFnkV3s7Q3aBoDt9TCETpETDiIKYt7TvOj
   g8B3g3OgpGMQllT5HbNC0xVO4mCbq1CD0laR7NUqOizyHOcELTgD/D5y+
   zuPKhdp1tBGCr5ZjP5hhwiIfmi8ej/gi2YHaGkTEI7YKaCE7UTSghD0NZ
   TwccgBCd3Ej/mMCBOP+9pvOExbtkdqDktJ7hA7lrZrepaqNEuCvyn9iQ2
   P/vD0hkZsvpblLIynqw5H/F65zl6yII+aCeChB1a65+c/uQpoIlBV14LZ
   X2hDnEP0kv2th57uMyzpe6r+up+KKzE/LGzKrQwRSYZRmroDDEgulxHN0
   w==;
X-CSE-ConnectionGUID: VDLzDpzZS5aNSZhtzNBLSg==
X-CSE-MsgGUID: 4pMM/24cTaq07HzqXlE8wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83734548"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="83734548"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 04:59:37 -0700
X-CSE-ConnectionGUID: 36ZBf2ujRGmO5JLyc6Pcwg==
X-CSE-MsgGUID: FrLNB3LPRLeyJMdgHk6HIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="277058751"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 May 2026 04:59:35 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wODg5-000000000nA-0b1w;
	Sat, 16 May 2026 11:59:33 +0000
Date: Sat, 16 May 2026 19:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS WITH UNVERIFIED WARNING
 ed831e7ea1a860bdbab3eadeb95f7f73e9d212df
Message-ID: <202605161948.M6XaueWn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: ed831e7ea1a860bdbab3eadeb95f7f73e9d212df  PCI: brcmstb: Assign pcie->gen from of_pci_get_max_link_speed()

Unverified Warning (likely false positive, kindly check if interested):

    drivers/pci/controller/pcie-brcmstb.c:2190 brcm_pcie_probe() warn: 'pcie->clk' from clk_prepare_enable() not released on lines: 2177.

Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-randconfig-r072-20260516
    `-- drivers-pci-controller-pcie-brcmstb.c-brcm_pcie_probe()-warn:pcie-clk-from-clk_prepare_enable()-not-released-on-lines:.

elapsed time: 1065m

configs tested: 164
configs skipped: 13

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260516    gcc-14.3.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260516    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260516    gcc-13.4.0
arm                            randconfig-002    gcc-11.5.0
arm                   randconfig-002-20260516    gcc-8.5.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20260516    clang-19
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260516    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260516    gcc-13.4.0
arm64                 randconfig-002-20260516    clang-23
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                 randconfig-004-20260516    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260516    gcc-15.2.0
csky                  randconfig-002-20260516    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260516    clang-23
hexagon               randconfig-002-20260516    clang-16
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260516    clang-20
i386        buildonly-randconfig-002-20260516    clang-20
i386        buildonly-randconfig-003-20260516    clang-20
i386        buildonly-randconfig-004-20260516    gcc-14
i386        buildonly-randconfig-005-20260516    clang-20
i386        buildonly-randconfig-006-20260516    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260516    clang-20
i386                  randconfig-002-20260516    clang-20
i386                  randconfig-003-20260516    clang-20
i386                  randconfig-004-20260516    clang-20
i386                  randconfig-005-20260516    clang-20
i386                  randconfig-006-20260516    clang-20
i386                  randconfig-007-20260516    clang-20
i386                  randconfig-011-20260516    gcc-14
i386                  randconfig-012-20260516    clang-20
i386                  randconfig-013-20260516    gcc-14
i386                  randconfig-014-20260516    gcc-14
i386                  randconfig-015-20260516    clang-20
i386                  randconfig-016-20260516    gcc-14
i386                  randconfig-017-20260516    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260516    gcc-15.2.0
loongarch             randconfig-002-20260516    clang-18
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-10.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260516    gcc-10.5.0
parisc                randconfig-002-20260516    gcc-11.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260516    clang-23
powerpc               randconfig-002-20260516    gcc-12.5.0
powerpc64             randconfig-001-20260516    clang-17
powerpc64             randconfig-002-20260516    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260516    gcc-8.5.0
riscv                 randconfig-002-20260516    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260516    clang-23
s390                  randconfig-002-20260516    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-12.5.0
sh                    randconfig-002-20260516    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-002-20260516    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260516    gcc-10.5.0
sparc64               randconfig-002-20260516    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260516    clang-16
um                    randconfig-002-20260516    clang-18
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260516    clang-20
x86_64      buildonly-randconfig-002-20260516    gcc-14
x86_64      buildonly-randconfig-003-20260516    gcc-13
x86_64      buildonly-randconfig-004-20260516    gcc-14
x86_64      buildonly-randconfig-005-20260516    gcc-14
x86_64      buildonly-randconfig-006-20260516    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260516    clang-20
x86_64                randconfig-002-20260516    clang-20
x86_64                randconfig-003-20260516    gcc-14
x86_64                randconfig-004-20260516    gcc-14
x86_64                randconfig-005-20260516    gcc-14
x86_64                randconfig-006-20260516    gcc-14
x86_64                randconfig-011-20260516    gcc-14
x86_64                randconfig-012-20260516    clang-20
x86_64                randconfig-013-20260516    clang-20
x86_64                randconfig-014-20260516    gcc-14
x86_64                randconfig-015-20260516    clang-20
x86_64                randconfig-016-20260516    gcc-14
x86_64                randconfig-071-20260516    gcc-14
x86_64                randconfig-072-20260516    gcc-14
x86_64                randconfig-073-20260516    clang-20
x86_64                randconfig-074-20260516    clang-20
x86_64                randconfig-075-20260516    gcc-14
x86_64                randconfig-076-20260516    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260516    gcc-13.4.0
xtensa                randconfig-002-20260516    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
