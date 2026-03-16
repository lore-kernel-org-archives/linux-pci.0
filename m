Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9D40DFAD
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688409; cv=none; b=ffLTUZFwKlPuxvrdlEJCysaA/ShD/QD/kA+kDtx+SE3pY3OKg2p8cemcDlkj2uEwjRgQJuh6U09bm7EWVLeaagUHPq+IRk7W/3kupeZ4wRZIG/ChgOaVt3d0hAB3uGsAPykg1rV2H2hKAgUwX8McYxcgo8W07DnTwV6SPEQfD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688409; c=relaxed/simple;
	bh=EO3ax+jNjA8R5oC4tDyDT2DpCG/jun6aqiaQ6yB+XzM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TH7HesBUlaxNu1q0AV15doaeXJ2ekvJiiNUCNp/aZbZYlRxczri2qPtxKd0F1T64Y3Jqt6y6F+RAIbFs3SknfA/ChO8TkXGruo9H9prbwZ8lLIIloniB+jdX3bqf0XmimxwKJJos3Z6RFbeGozchiHxasoqlx6cPsjJkBrxo9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrS/bh9C; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrS/bh9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773688409; x=1805224409;
  h=date:from:to:cc:subject:message-id;
  bh=EO3ax+jNjA8R5oC4tDyDT2DpCG/jun6aqiaQ6yB+XzM=;
  b=mrS/bh9Ck/hqUtdcHX5gB1PBdp+qxNlK62uturisnivXxaUciKD8CPrQ
   DMw/GMyBM9vXolBikJB/QBAG/xvMR3xB77A+j+fucHTcRnsG7rwDveYMS
   PoGYYICfpBW/sHUFEJ2HlDHJ0XII4zPZ0EAvjnjnni7uKexrItciAJGNZ
   sRo5NuFhmrUOAgbt50SZ2qiC/yCx97fE45a6VnwKFJrBngp4k9HtK6ZZD
   +/xVPyiXzLD09BtzeMpgjn5q6gqOlTUMN7agNZQxA8YkfaxeBGcVnQcGe
   WuVSh+LUCJ2LZmPI2ry+R5JUQu2XknerUkNNIEk+Ma6qb57acU0q1KOPS
   A==;
X-CSE-ConnectionGUID: AM6KYOx1SNSVHZUDE9LgWA==
X-CSE-MsgGUID: Jp3SlsrFRbK71y/673E5oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74629992"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74629992"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:13:28 -0700
X-CSE-ConnectionGUID: +yzabPpBTsS7rosOtTNitQ==
X-CSE-MsgGUID: rC9lHaLlRzCu4ZW6cAbvAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221959332"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 12:13:26 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2DNT-000000001AQ-2Nh2;
	Mon, 16 Mar 2026 19:13:23 +0000
Date: Tue, 17 Mar 2026 03:12:29 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rzg3s-host] BUILD SUCCESS
 8197ec49a2062185f6bd432a19969ce0b3752e94
Message-ID: <202603170323.hY8TMDXi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rzg3s-host
branch HEAD: 8197ec49a2062185f6bd432a19969ce0b3752e94  PCI: rzg3s-host: Add support for RZ/G3E PCIe controller

elapsed time: 1436m

configs tested: 131
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
arc                   randconfig-001-20260316    gcc-10.5.0
arc                   randconfig-002-20260316    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260316    clang-23
arm                   randconfig-002-20260316    clang-23
arm                   randconfig-003-20260316    clang-23
arm                   randconfig-004-20260316    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260316    gcc-11.5.0
arm64                 randconfig-002-20260316    clang-23
arm64                 randconfig-003-20260316    clang-23
arm64                 randconfig-004-20260316    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260316    gcc-15.2.0
csky                  randconfig-002-20260316    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260317    clang-23
hexagon               randconfig-002-20260317    clang-23
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    clang-20
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    clang-20
i386                  randconfig-006-20260316    gcc-12
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260316    clang-20
i386                  randconfig-012-20260316    gcc-14
i386                  randconfig-013-20260316    clang-20
i386                  randconfig-014-20260316    gcc-13
i386                  randconfig-015-20260316    clang-20
i386                  randconfig-016-20260316    gcc-14
i386                  randconfig-017-20260316    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260317    clang-23
loongarch             randconfig-002-20260317    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20260317    gcc-8.5.0
nios2                 randconfig-002-20260317    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-8.5.0
parisc                randconfig-002-20260316    gcc-12.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260316    clang-23
powerpc               randconfig-002-20260316    clang-23
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260317    clang-23
riscv                 randconfig-002-20260317    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260317    gcc-15.2.0
s390                  randconfig-002-20260317    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260317    gcc-15.2.0
sh                    randconfig-002-20260317    gcc-10.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-8.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260316    gcc-8.5.0
sparc64               randconfig-002-20260316    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260316    gcc-14
um                    randconfig-002-20260316    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260316    gcc-14
x86_64      buildonly-randconfig-002-20260316    clang-20
x86_64      buildonly-randconfig-003-20260316    clang-20
x86_64      buildonly-randconfig-004-20260316    gcc-14
x86_64      buildonly-randconfig-005-20260316    gcc-14
x86_64      buildonly-randconfig-006-20260316    clang-20
x86_64                randconfig-011-20260316    gcc-14
x86_64                randconfig-012-20260316    gcc-14
x86_64                randconfig-013-20260316    gcc-14
x86_64                randconfig-014-20260316    gcc-14
x86_64                randconfig-015-20260316    clang-20
x86_64                randconfig-016-20260316    gcc-14
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-14
x86_64                randconfig-073-20260316    gcc-14
x86_64                randconfig-074-20260316    gcc-14
x86_64                randconfig-075-20260316    clang-20
x86_64                randconfig-076-20260316    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260316    gcc-15.2.0
xtensa                randconfig-002-20260316    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
