Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC815370AE5
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097733; cv=none; b=H0RXCyoEuwOSL/P2KqcHVIZxD0pS+55biGCb9Pb84frpwPM8ej3W+hQThfz83jrtRZZVceTubxixVxq4jq/3lyR7pdHuh/c/EL1bJzuaVLleIep4vJ7fwkKDgfk5kGDX72UvPo7VD3ie8oVGtlQ6QbFVsGHVJaDEhX5ASDVgiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097733; c=relaxed/simple;
	bh=UME3vsv62zS2Aw6jamiXyppOUXI5TO64yoqYkipvOP4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gRpgtMtwvRIrRGm4xfDAT8a7dKCTAVsh+HH87wTMXIdfU5Y1sKkare9ubtEMGbahcnDfSIsM2XORagST0xpd5llc/gNz7vjj0KlG5F9lzVzR9wYCnHFzpkqA1udw1rhGoPH6zVI42JsD3Mikdlk8dcboWa+64eSx1UWEgr3FOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT+Kobtb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT+Kobtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789097731; x=1820633731;
  h=date:from:to:cc:subject:message-id;
  bh=UME3vsv62zS2Aw6jamiXyppOUXI5TO64yoqYkipvOP4=;
  b=UT+KobtbMl8EuuOrVbryzMe7mhWnI15m8NFhUu1AvIKkTjUTnaGSUo//
   sLpSbL8gHHvnYC06/a5C9juvsKjy7tyCUnj0Y6xfqQ2YXg9D8qwQ7Vw24
   2S+Vq0yV6XUvbOVcYY5+f4PvxRUdHflDTS+9vLPrjzlP2/3InNgcwRtkA
   33tMrQ7ymWTOp8l07WdlafCzfySfhHC8QeqY7FGW9k+6Vyak1Ws0LgBVC
   r6/8jxufQx2wuCQOnvx8Ep4xmaF8oTNaRYtxc3d8CCRYa8rIkgVoudq1g
   dPeW+FBq5FT7JeDywX2iSC5LwsJ+KhMWoRP1W333nf3RLMJjnSZbY1mvo
   g==;
X-CSE-ConnectionGUID: lCV7ONHtQ/Oa66PaIfPkTw==
X-CSE-MsgGUID: Yh6JFq2oT16F0Y0Ltuu5lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89491719"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89491719"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 20:35:30 -0700
X-CSE-ConnectionGUID: U1jqw149RNWPrvza7jy0bw==
X-CSE-MsgGUID: zEAgP/o5S/WZaPwDJcNo1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="271784220"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2026 20:35:29 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4s2v-000000000wg-0M47;
	Fri, 11 Sep 2026 03:35:25 +0000
Date: Fri, 11 Sep 2026 11:35:13 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:xgene] BUILD SUCCESS
 b9022584ebbae81f7bbe4a61bd1df0d0a95e1a99
Message-ID: <202609111110.GlJVDfr0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xgene
branch HEAD: b9022584ebbae81f7bbe4a61bd1df0d0a95e1a99  PCI: xgene: Use managed clock for PCIe controller

elapsed time: 922m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
alpha                     defconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                     allnoconfig    gcc-16.1.0
arc                    allyesconfig    clang-24
arc                    allyesconfig    gcc-16.1.0
arc                       defconfig    gcc-16.1.0
arc         randconfig-001-20260911    clang-24
arc         randconfig-002-20260911    clang-24
arm                     allnoconfig    clang-17
arm                     allnoconfig    gcc-16.1.0
arm                    allyesconfig    gcc-16.1.0
arm             aspeed_g5_defconfig    clang-20
arm               assabet_defconfig    clang-20
arm                       defconfig    gcc-16.1.0
arm                exynos_defconfig    clang-20
arm         randconfig-001-20260911    clang-24
arm         randconfig-002-20260911    clang-24
arm         randconfig-003-20260911    clang-24
arm         randconfig-004-20260911    clang-24
arm64                  allmodconfig    clang-24
arm64                   allnoconfig    gcc-16.1.0
arm64                     defconfig    gcc-16.1.0
arm64       randconfig-001-20260911    gcc-16.1.0
arm64       randconfig-002-20260911    gcc-16.1.0
arm64       randconfig-003-20260911    gcc-16.1.0
arm64       randconfig-004-20260911    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
csky                    allnoconfig    gcc-16.1.0
csky                      defconfig    gcc-16.1.0
csky        randconfig-001-20260911    gcc-16.1.0
csky        randconfig-002-20260911    gcc-16.1.0
hexagon                allmodconfig    clang-24
hexagon                 allnoconfig    clang-24
hexagon                 allnoconfig    gcc-16.1.0
hexagon                   defconfig    gcc-16.1.0
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-16.1.0
i386                   allyesconfig    gcc-14
i386                      defconfig    gcc-16.1.0
loongarch              allmodconfig    clang-19
loongarch              allmodconfig    clang-24
loongarch               allnoconfig    clang-20
loongarch               allnoconfig    gcc-16.1.0
loongarch                 defconfig    clang-24
m68k                   allmodconfig    gcc-16.1.0
m68k                    allnoconfig    gcc-16.1.0
m68k                   allyesconfig    gcc-16.1.0
m68k                      defconfig    clang-24
microblaze              allnoconfig    gcc-16.1.0
microblaze             allyesconfig    gcc-16.1.0
microblaze                defconfig    clang-24
mips                   allmodconfig    gcc-16.1.0
mips                    allnoconfig    gcc-16.1.0
mips                   allyesconfig    gcc-16.1.0
mips              vocore2_defconfig    clang-20
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    clang-24
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    clang-24
openrisc               allmodconfig    gcc-16.1.0
openrisc                allnoconfig    clang-24
openrisc                allnoconfig    gcc-16.1.0
openrisc                  defconfig    gcc-16.1.0
parisc                 alldefconfig    clang-20
parisc                 allmodconfig    gcc-16.1.0
parisc                  allnoconfig    clang-24
parisc                  allnoconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
parisc      randconfig-001-20260911    gcc-8.5.0
parisc      randconfig-002-20260911    gcc-8.5.0
parisc64                  defconfig    clang-24
powerpc                allmodconfig    gcc-16.1.0
powerpc                 allnoconfig    clang-24
powerpc                 allnoconfig    gcc-16.1.0
powerpc       mpc836x_rdk_defconfig    clang-20
powerpc     randconfig-001-20260911    gcc-8.5.0
powerpc     randconfig-002-20260911    gcc-8.5.0
powerpc64   randconfig-001-20260911    gcc-8.5.0
powerpc64   randconfig-002-20260911    gcc-8.5.0
riscv                  allmodconfig    clang-24
riscv                   allnoconfig    clang-24
riscv                   allnoconfig    gcc-16.1.0
riscv                  allyesconfig    clang-24
riscv                     defconfig    gcc-16.1.0
riscv       randconfig-001-20260911    gcc-16.1.0
riscv       randconfig-002-20260911    gcc-16.1.0
s390                   allmodconfig    clang-24
s390                    allnoconfig    clang-24
s390                   allyesconfig    gcc-16.1.0
s390                      defconfig    gcc-16.1.0
s390        randconfig-001-20260911    gcc-16.1.0
s390        randconfig-002-20260911    gcc-16.1.0
sh                     allmodconfig    gcc-16.1.0
sh                      allnoconfig    clang-24
sh                      allnoconfig    gcc-16.1.0
sh                     allyesconfig    gcc-16.1.0
sh                        defconfig    gcc-14
sh          randconfig-001-20260911    gcc-16.1.0
sh          randconfig-002-20260911    gcc-16.1.0
sh                  shmin_defconfig    clang-20
sh                urquell_defconfig    clang-20
sparc                   allnoconfig    clang-24
sparc                   allnoconfig    gcc-16.1.0
sparc                     defconfig    gcc-16.1.0
sparc64                allmodconfig    clang-20
sparc64                   defconfig    gcc-14
um                     allmodconfig    clang-17
um                      allnoconfig    clang-17
um                      allnoconfig    clang-24
um                     allyesconfig    gcc-14
um                        defconfig    gcc-14
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    gcc-14
x86_64                 allmodconfig    clang-22
x86_64                  allnoconfig    clang-22
x86_64                  allnoconfig    clang-24
x86_64                 allyesconfig    clang-22
x86_64                    defconfig    gcc-14
x86_64                 rhel-9.4-bpf    gcc-14
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-22
xtensa                  allnoconfig    clang-24
xtensa                  allnoconfig    gcc-16.1.0
xtensa                 allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
