Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334D43C7C1
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115753; cv=none; b=hMy3HEH1Ng0Od5SQli8AmIDyPiJkRsUvReLcKAZpebiuyN8R4Tg28BP+x/r3pzcIyoSQd/16zKGBkJ/V/Iv0okQvZHtjGuoqGtWh4LVqwa/9K+y6Ap266Hk90LobkksxMSaCw+d3NCTZmXCkbuQI0/57Xb+t2QRy0uo9sGeg9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115753; c=relaxed/simple;
	bh=00L+7NDHSMDBN0O+8h2Vn1RE9tqJowUADMmS7pI5vGs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gwwX5wzB5Jd5WzvevpBXmnbaiXo6nZGuxV/MqtlAe8ESDps9TrQuYNPZgcrdirnTyh5hY+Mz/8zqu58rx6XmbTqec9W/A/Jb+k75FHrShZVrwTx/nIx1tpv/PEPn9bTEIJs68b59RqHQegRV5yKYojPoTGOCTzLRqOglJCJvSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUY88HRu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUY88HRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791115750; x=1822651750;
  h=date:from:to:cc:subject:message-id;
  bh=00L+7NDHSMDBN0O+8h2Vn1RE9tqJowUADMmS7pI5vGs=;
  b=nUY88HRuoC8c8himIYmfqBGweKLLurMoPgAQAomBCmMGT2SduXckAUFC
   0zyt6aS4DvswexvrhTKNekot1eAnfAROBCY499a5+mYO2DMOSG9JRDkaG
   4jqiFZ1RLper4A/FCEyVyj7aRmjWtib6ZoGDyCgcrgOKZS3vTWcXNdSIU
   BkUcHyJk91RM/zia2izwOLBYpRq4b4h67eB6wCbPJUtR6MVJ8aL9apSph
   4qiXxkyBUG2MES8rza273RBdQAQgILrxnbay1/XAHbDGFTNnX98pAciVd
   kUXbj2x/4gb4+3RHhuH/p62/Ob2QRQqID1VQxfUhi6CBwlRZCo3xxAIYv
   w==;
X-CSE-ConnectionGUID: ySl6r3arQwmaagqhVwZohQ==
X-CSE-MsgGUID: ESI5dttTTsKwT15vkUUZWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="109295485"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="109295485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 05:09:09 -0700
X-CSE-ConnectionGUID: /GxsS+K4QuWqCh3NAmHZfg==
X-CSE-MsgGUID: tC6S3rnCTs+BnSQnflgD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="314612999"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Oct 2026 05:09:08 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDL1d-00000000Uj7-1ySr;
	Sun, 04 Oct 2026 12:09:05 +0000
Date: Sun, 04 Oct 2026 20:08:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD REGRESSION
 372b7a0d9c7c0cb724b259db9d39c785ad9dec74
Message-ID: <202610042042.XzZeAHcl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 372b7a0d9c7c0cb724b259db9d39c785ad9dec74  Merge branch 'pci/misc'

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202610041359.Iv8zjxRh-lkp@intel.com

    drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: error: 'PCIE_PORT_LANE_SKEW' undeclared (first use in this function); did you mean 'PORT_LANE_SKEW'?

Error/Warning ids grouped by kconfigs:

recent_errors
`-- arm64-defconfig
    `-- drivers-pci-controller-dwc-pcie-rcar-gen4.c:error:PCIE_PORT_LANE_SKEW-undeclared-(first-use-in-this-function)

elapsed time: 1837m

configs tested: 274
configs skipped: 2

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2202-20261003    gcc-11.5.0 smatch
alpha                randconfig-r2300-20261003    gcc-12.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1001-20261004    clang-22
arc                  randconfig-r2105-20261003    gcc-8.5.0  cocci
arc                  randconfig-r2106-20261003    gcc-8.5.0  cocci
arc                  randconfig-r2200-20261003    gcc-12.5.0 smatch
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    clang-21
arm                                  defconfig    gcc-16.1.0
arm                          orion5x_defconfig    clang-21
arm                             qcom_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1003-20261004    clang-22
arm                          s3c6400_defconfig    clang-21
arm                          s3c6400_defconfig    gcc-16.1.0
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261004    gcc-16.1.0
arm64                 randconfig-1001-20261004    gcc-16.1.0
arm64                 randconfig-1002-20261004    gcc-16.1.0
arm64                 randconfig-1003-20261004    gcc-16.1.0
arm64                randconfig-r2303-20261003    gcc-13.4.0 sparse
arm64                randconfig-r2306-20261003    gcc-15.2.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261004    gcc-16.1.0
csky                  randconfig-1001-20261004    gcc-16.1.0
csky                 randconfig-r2303-20261003    gcc-16.1.0 sparse
hexagon                           alldefconfig    clang-21
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261004    gcc-16.1.0
hexagon               randconfig-1001-20261004    gcc-16.1.0
hexagon              randconfig-r2100-20261003    gcc-8.5.0  cocci
hexagon              randconfig-r2301-20261003    clang-19   sparse
hexagon              randconfig-r2305-20261003    clang-24   sparse
hexagon              randconfig-r2307-20261003    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261004    clang-22
i386        buildonly-randconfig-1001-20261004    clang-22
i386        buildonly-randconfig-1002-20261004    clang-22
i386        buildonly-randconfig-1003-20261004    clang-22
i386        buildonly-randconfig-1004-20261004    clang-22
i386        buildonly-randconfig-1005-20261004    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261004    gcc-14
i386                  randconfig-1001-20261004    gcc-14
i386                  randconfig-1002-20261004    gcc-14
i386                  randconfig-1003-20261004    gcc-14
i386                  randconfig-1004-20261004    gcc-14
i386                  randconfig-1005-20261004    gcc-14
i386                  randconfig-1006-20261004    gcc-14
i386                  randconfig-1007-20261004    clang-22
i386                  randconfig-1008-20261004    clang-22
i386                  randconfig-1009-20261004    clang-22
i386                  randconfig-1010-20261004    clang-22
i386                  randconfig-1011-20261004    clang-22
i386                  randconfig-1012-20261004    clang-22
i386                  randconfig-1013-20261004    clang-22
i386                  randconfig-2100-20261003    gcc-14     cocci
i386                  randconfig-2101-20261003    clang-22   cocci
i386                  randconfig-2101-20261003    gcc-14     cocci
i386                  randconfig-2102-20261003    gcc-14     cocci
i386                  randconfig-2103-20261003    clang-22   cocci
i386                  randconfig-2103-20261003    gcc-14     cocci
i386                  randconfig-2200-20261003    gcc-14     smatch
i386                  randconfig-2300-20261003    clang-22   sparse
i386                  randconfig-2301-20261003    clang-22   sparse
i386                  randconfig-2301-20261003    gcc-14     sparse
i386                  randconfig-2302-20261003    clang-22   sparse
i386                  randconfig-2302-20261003    gcc-14     sparse
i386                 randconfig-r2302-20261003    gcc-16.1.0 sparse
i386                 randconfig-r2308-20261003    gcc-14     sparse
i386                 randconfig-r2309-20261003    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261004    gcc-16.1.0
loongarch             randconfig-1001-20261004    gcc-16.1.0
loongarch            randconfig-r2101-20261003    gcc-16.1.0 cocci
loongarch            randconfig-r2106-20261003    gcc-16.1.0 cocci
loongarch            randconfig-r2300-20261003    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2202-20261003    gcc-11.5.0 smatch
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2201-20261003    gcc-13.4.0 smatch
microblaze           randconfig-r2301-20261003    gcc-16.1.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                 randconfig-r2103-20261003    clang-21   cocci
mips                 randconfig-r2107-20261003    gcc-8.5.0  cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261004    gcc-16.1.0
nios2                 randconfig-1001-20261004    gcc-16.1.0
nios2                randconfig-r2104-20261003    gcc-11.5.0 cocci
nios2                randconfig-r2200-20261003    gcc-8.5.0  smatch
nios2                randconfig-r2304-20261003    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2307-20261003    gcc-14     sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc               randconfig-r2104-20261003    gcc-8.5.0  cocci
parisc               randconfig-r2308-20261003    gcc-14     sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc                      mpc512x_defconfig    clang-21
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261004    gcc-11.5.0
riscv                 randconfig-2000-20261003    clang-17
riscv                 randconfig-2000-20261003    gcc-16.1.0
riscv                 randconfig-2001-20261003    gcc-16.1.0
riscv                 randconfig-2001-20261003    gcc-9.5.0
riscv                randconfig-r2107-20261003    clang-24   cocci
riscv                randconfig-r2201-20261003    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                  randconfig-2000-20261003    clang-24
s390                  randconfig-2000-20261003    gcc-16.1.0
s390                  randconfig-2001-20261003    gcc-13.4.0
s390                  randconfig-2001-20261003    gcc-16.1.0
s390                 randconfig-r2103-20261003    gcc-8.5.0  cocci
s390                 randconfig-r2105-20261003    gcc-13.4.0 cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                                j2_defconfig    clang-21
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                    randconfig-2000-20261003    gcc-16.1.0
sh                    randconfig-2001-20261003    gcc-16.1.0
sh                   randconfig-r2100-20261003    gcc-10.5.0 cocci
sh                   randconfig-r2101-20261003    gcc-8.5.0  cocci
sh                   randconfig-r2102-20261003    gcc-16.1.0 cocci
sh                   randconfig-r2306-20261003    gcc-14     sparse
sh                           sdk7786_defconfig    clang-21
sh                         sh7785lcr_defconfig    gcc-16.1.0
sparc                             alldefconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1001-20261004    gcc-14
sparc                 randconfig-2000-20261003    gcc-14
sparc                 randconfig-2001-20261003    gcc-14
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1001-20261004    gcc-14
sparc64               randconfig-2000-20261003    gcc-14
sparc64               randconfig-2001-20261003    gcc-14
sparc64              randconfig-r2302-20261003    gcc-13.4.0 sparse
sparc64              randconfig-r2304-20261003    gcc-16.1.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1001-20261004    gcc-14
um                    randconfig-2000-20261003    gcc-14
um                    randconfig-2001-20261003    gcc-14
um                   randconfig-r2102-20261003    gcc-8.5.0  cocci
um                   randconfig-r2309-20261003    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261004    gcc-14
x86_64      buildonly-randconfig-1001-20261004    gcc-14
x86_64      buildonly-randconfig-1002-20261004    gcc-14
x86_64      buildonly-randconfig-1003-20261004    gcc-14
x86_64      buildonly-randconfig-1004-20261004    gcc-14
x86_64      buildonly-randconfig-1005-20261004    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1006-20261004    clang-22
x86_64                randconfig-1007-20261004    clang-22
x86_64                randconfig-1008-20261004    clang-22
x86_64                randconfig-1009-20261004    clang-22
x86_64                randconfig-1010-20261004    clang-22
x86_64                randconfig-1011-20261004    clang-22
x86_64                randconfig-1012-20261004    gcc-13
x86_64                randconfig-1013-20261004    gcc-13
x86_64                randconfig-1014-20261004    gcc-13
x86_64                randconfig-1015-20261004    gcc-13
x86_64                randconfig-1016-20261004    gcc-13
x86_64                randconfig-1017-20261004    gcc-13
x86_64                randconfig-2100-20261003    clang-22   cocci
x86_64                randconfig-2101-20261003    clang-22   cocci
x86_64                randconfig-2102-20261003    clang-22   cocci
x86_64                randconfig-2102-20261003    gcc-14     cocci
x86_64                randconfig-2103-20261003    clang-22   cocci
x86_64                randconfig-2103-20261003    gcc-13     cocci
x86_64                randconfig-2200-20261003    gcc-14     smatch
x86_64                randconfig-2300-20261003    clang-22   sparse
x86_64                randconfig-2300-20261003    gcc-14     sparse
x86_64                randconfig-2301-20261003    clang-22   sparse
x86_64                randconfig-2301-20261003    gcc-14     sparse
x86_64                randconfig-2302-20261003    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                        common_defconfig    clang-21
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1001-20261004    gcc-14
xtensa                randconfig-2000-20261003    gcc-14
xtensa                randconfig-2001-20261003    gcc-14
xtensa               randconfig-r2201-20261003    gcc-8.5.0  smatch
xtensa               randconfig-r2202-20261003    gcc-8.5.0  smatch
xtensa               randconfig-r2305-20261003    gcc-16.1.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
