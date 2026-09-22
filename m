Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDE53358B
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077195; cv=none; b=fzikmSBz9L6YALUzyug5ClrkAtNhQd92PLuwReXb0mB7t8nzq0LdTD117OjgpwC+XxWN1S7FqoS3qAno8rg5pDUuMeqZwsfocrN1xJPdZhOuremzPXrgX7SMHferrQW/4+CkQChZ0XqAXyq4vIy3UBmzzbaWZ4ywzsdmjB06wuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077195; c=relaxed/simple;
	bh=SpgTCWK9vFzC6rgWEn2SJx0jtnl8izFI+JkOdmZ4Lhk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fv35V4lhhi5OUbYXy0Upbs4RZtQ82Dnl/6AGyrKrzUgn4gsgyCelzxBGrAwu7ziC2hSj3VEql+MiNqEXGGGPCWXUgzeck5UERWF0RIcpdMmNe7KbbYq6NmXnPA9vFClMvQvYS1ujjEZZsZpdKKim5KJ+DMIXZRVMJuD3OIr7DrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1+83tGr; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1+83tGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790077192; x=1821613192;
  h=date:from:to:cc:subject:message-id;
  bh=SpgTCWK9vFzC6rgWEn2SJx0jtnl8izFI+JkOdmZ4Lhk=;
  b=n1+83tGrvPTGEEyuKywdNyrDJ5svBldoquaGxzRqOTZ98zt7JOp7mN/F
   83ph6QjGGkzkpPkbIF4sNv7Af0ukEzPNr8ykEDt0Z8RhhAnQ5ciUYypgV
   AYBYs2FOb7daLsxCtEh17xqXoEMTf1P611OZRGXnaHLOX2ik6ituULYxU
   wBpwNjXgR45H9+9h3ryDpPOHMGjf5/VYLa9LqWGLKjRjbDHPfZpjiv3JL
   kBqLgWVGDh7baSR+/ym0F76PrhNs2eud9xkAxIFCZoK35pHp45GZU7vhf
   nYz1wBY3mrsRyqX67CgIKziTpUrd1ZiQw1aSGWzkxzj8AUYG4iWp2EQ+G
   g==;
X-CSE-ConnectionGUID: 0S+DPmcXRUi3z8W8/3EWNw==
X-CSE-MsgGUID: oJmFQPe/SBey6jMFx7mFKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1173361"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1173361"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:39:49 -0700
X-CSE-ConnectionGUID: c/diHfOtQkeeEUWLYhWnog==
X-CSE-MsgGUID: us6ul16KTx+gvOnfzl6y3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="299339619"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Sep 2026 04:39:48 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x8yqb-00000000FQk-1Aze;
	Tue, 22 Sep 2026 11:39:41 +0000
Date: Tue, 22 Sep 2026 19:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-qcom] BUILD SUCCESS
 626acf6efc69c666ffee50bf18e7b95e68670c6a
Message-ID: <202609221926.i707MLqs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 626acf6efc69c666ffee50bf18e7b95e68670c6a  PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()

elapsed time: 4114m

configs tested: 202
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260921    gcc-9.5.0
arc                   randconfig-1001-20260921    gcc-15.2.0
arc                  randconfig-r1301-20260921    gcc-14.3.0 sparse
arc                  randconfig-r2106-20260917    gcc-8.5.0  cocci
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                      am200epdkit_defconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                   randconfig-1000-20260921    clang-24
arm                   randconfig-1001-20260921    gcc-13.4.0
arm                   randconfig-1002-20260921    gcc-15.2.0
arm                   randconfig-1003-20260921    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260922    clang-24
arm64                 randconfig-1001-20260922    gcc-11.5.0
arm64                 randconfig-1002-20260922    gcc-9.5.0
arm64                 randconfig-1003-20260922    gcc-11.5.0
arm64                randconfig-r2202-20260917    gcc-16.1.0 smatch
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260922    gcc-16.1.0
csky                  randconfig-1001-20260922    gcc-12.5.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260921    clang-18
hexagon               randconfig-1001-20260921    clang-17
hexagon              randconfig-r1304-20260921    clang-17   sparse
hexagon              randconfig-r1309-20260922    clang-24   sparse
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386        buildonly-randconfig-1000-20260921    clang-22
i386        buildonly-randconfig-1001-20260921    clang-22
i386        buildonly-randconfig-1002-20260921    clang-22
i386        buildonly-randconfig-1003-20260921    clang-22
i386        buildonly-randconfig-1004-20260921    gcc-14
i386        buildonly-randconfig-1005-20260921    clang-22
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260921    clang-22
i386                  randconfig-1001-20260921    clang-22
i386                  randconfig-1002-20260921    clang-22
i386                  randconfig-1003-20260921    gcc-14
i386                  randconfig-1004-20260921    gcc-13
i386                  randconfig-1005-20260921    clang-22
i386                  randconfig-1006-20260921    clang-22
i386                  randconfig-1007-20260921    gcc-14
i386                  randconfig-1008-20260921    clang-22
i386                  randconfig-1009-20260921    gcc-14
i386                  randconfig-1010-20260921    gcc-14
i386                  randconfig-1011-20260921    clang-22
i386                  randconfig-1012-20260921    clang-22
i386                  randconfig-1013-20260921    clang-22
i386                  randconfig-1300-20260922    clang-22   sparse
i386                  randconfig-1301-20260922    clang-22   sparse
i386                  randconfig-1302-20260922    gcc-14     sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260921    clang-18
loongarch             randconfig-1001-20260921    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                 randconfig-r1305-20260921    gcc-8.5.0  sparse
m68k                 randconfig-r2200-20260917    gcc-8.5.0  smatch
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r1306-20260922    gcc-12.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260921    gcc-8.5.0
nios2                 randconfig-1001-20260921    gcc-11.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc               randconfig-r1302-20260921    gcc-14.3.0 sparse
parisc               randconfig-r2104-20260917    gcc-11.5.0 cocci
parisc               randconfig-r2107-20260917    gcc-8.5.0  cocci
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc                  mpc8315_rdb_defconfig    clang-24
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1001-20260921    clang-24
powerpc              randconfig-r2105-20260917    gcc-15.2.0 cocci
powerpc                       tqm8xx_defconfig    clang-20
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1001-20260921    gcc-8.5.0
powerpc64            randconfig-r1300-20260921    clang-24   sparse
powerpc64            randconfig-r1308-20260922    gcc-10.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260921    gcc-12.5.0
riscv                 randconfig-1001-20260921    gcc-8.5.0
riscv                 randconfig-2000-20260917    clang-24
riscv                 randconfig-2001-20260917    clang-17
riscv                randconfig-r1307-20260922    clang-17   sparse
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260921    clang-24
s390                  randconfig-1001-20260921    clang-24
s390                  randconfig-2000-20260917    clang-17
s390                  randconfig-2001-20260917    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                             migor_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260921    gcc-9.5.0
sh                    randconfig-1001-20260921    gcc-16.1.0
sh                    randconfig-2000-20260917    gcc-14.3.0
sh                    randconfig-2001-20260917    gcc-16.1.0
sh                   randconfig-r1303-20260921    gcc-9.5.0  sparse
sh                           rsk7269_defconfig    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260921    gcc-8.5.0
sparc                 randconfig-1001-20260921    gcc-11.5.0
sparc                 randconfig-2000-20260917    gcc-16.1.0
sparc                 randconfig-2000-20260918    gcc-8.5.0
sparc                 randconfig-2001-20260917    gcc-12.5.0
sparc                 randconfig-2001-20260918    gcc-11.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260921    clang-21
sparc64               randconfig-1001-20260921    clang-22
sparc64               randconfig-2000-20260917    clang-20
sparc64               randconfig-2000-20260918    gcc-8.5.0
sparc64               randconfig-2001-20260917    clang-20
sparc64               randconfig-2001-20260918    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260921    gcc-14
um                    randconfig-1001-20260921    gcc-14
um                    randconfig-2000-20260917    clang-20
um                    randconfig-2000-20260918    gcc-14
um                    randconfig-2001-20260917    clang-17
um                    randconfig-2001-20260918    gcc-14
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260921    clang-22
x86_64      buildonly-randconfig-1001-20260921    gcc-13
x86_64      buildonly-randconfig-1002-20260921    clang-22
x86_64      buildonly-randconfig-1003-20260921    clang-22
x86_64      buildonly-randconfig-1004-20260921    clang-22
x86_64      buildonly-randconfig-1005-20260921    clang-22
x86_64                               defconfig    gcc-14
x86_64                randconfig-1006-20260921    gcc-14
x86_64                randconfig-1007-20260921    clang-22
x86_64                randconfig-1008-20260921    clang-22
x86_64                randconfig-1009-20260921    clang-22
x86_64                randconfig-1010-20260921    gcc-14
x86_64                randconfig-1011-20260921    clang-22
x86_64                randconfig-1012-20260921    clang-22
x86_64                randconfig-1013-20260921    clang-22
x86_64                randconfig-1014-20260921    clang-22
x86_64                randconfig-1015-20260921    clang-22
x86_64                randconfig-1016-20260921    clang-22
x86_64                randconfig-1017-20260921    gcc-12
x86_64                randconfig-1300-20260922    gcc-13     sparse
x86_64                randconfig-1301-20260922    gcc-13     sparse
x86_64                randconfig-1302-20260922    clang-22   sparse
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260921    gcc-11.5.0
xtensa                randconfig-1001-20260921    gcc-9.5.0
xtensa                randconfig-2000-20260917    gcc-8.5.0
xtensa                randconfig-2000-20260918    gcc-8.5.0
xtensa                randconfig-2001-20260918    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
