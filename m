Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79D2DC357
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038289; cv=none; b=Twem2IhEe0WnHSobejre39Ok/jz3KHfcMMBXYkWi6cgLAgpkU+i1Y8klessM3cNf0+ACgRw3qeCrPu1gkOImkaYSvnemUrmTnM407RrbTgddZXELBUkgSHMIegOPcE/nLNNjGqy+ykJQttWZRmSMto9UK3BSSjaCFs0R6AzG3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038289; c=relaxed/simple;
	bh=85NFEhEc2RDpbQLSz1+EQbdkMSFRBgpOk3QyQAFxtpo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kALXt31Wuav91+w+O/5OCmn8z7190kifFgORDRftv7N6KpwriSNlQuXMS/bEvbDlKQu1llSCOox4t6J5nR8GTc7TXJ3jUmW8L+e3BcBtTWZn1MrUzx5tCYDogZEb221R9cCqVIRZMwIyOnd3f3oqYXYw67GZNPMMyOQmQTqpcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/wF7kcp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/wF7kcp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790038288; x=1821574288;
  h=date:from:to:cc:subject:message-id;
  bh=85NFEhEc2RDpbQLSz1+EQbdkMSFRBgpOk3QyQAFxtpo=;
  b=e/wF7kcpOi7t4f0CboLsuC2qmAOv0ip9eQZAd5pCFP7VitJacalXApIE
   sFjbhNR3uhnEUJIToDg0R5YhkzHi7JPf1y4PxGzZIsYrdXV1tG4yLbKo8
   D6kMV80NPhjF+a+wguVQ34Ztq6SJxkNJE42Zhf5bhhqrywWm7dOSPLNiC
   IfpbBYL7EuApffG0cTlA6YPGyjRxCG/Rw0NTL5zfgHRruxLujEemJYNlf
   cpRjI5W+VoGSJM7BKOi7DfV6BCo92egQoafqgk/dU7GTc0KB2qWeyu0GK
   I2JAWDDxTz4TZJnnow4dJkYhaTgWQrdhdh5wagfpP5L+seMgEgiprzLul
   A==;
X-CSE-ConnectionGUID: r2la8wAsSqGaMY00P96oVA==
X-CSE-MsgGUID: DZFTwPNISKy4D9OfRQ7BHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101261849"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101261849"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:51:15 -0700
X-CSE-ConnectionGUID: SDZtdVV/SeWhU4VbQUhvUA==
X-CSE-MsgGUID: DVjSdGb9Ry2X3JYRCveulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269426957"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2026 17:51:14 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x8oj1-00000000EfR-2OWr;
	Tue, 22 Sep 2026 00:51:11 +0000
Date: Tue, 22 Sep 2026 08:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-imx6] BUILD SUCCESS
 861f5f161689620daa50940bd0c1fceb425094d6
Message-ID: <202609220847.d72L53fQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: 861f5f161689620daa50940bd0c1fceb425094d6  PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability

elapsed time: 3465m

configs tested: 160
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
arc                   randconfig-1000-20260922    gcc-8.5.0
arc                  randconfig-r1307-20260921    gcc-10.5.0 sparse
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                   randconfig-1002-20260922    clang-24
arm                   randconfig-1003-20260922    gcc-8.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260922    clang-24
arm64                 randconfig-1001-20260922    gcc-11.5.0
arm64                 randconfig-1002-20260922    gcc-9.5.0
arm64                 randconfig-1003-20260922    gcc-11.5.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260922    gcc-16.1.0
csky                  randconfig-1001-20260922    gcc-12.5.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260922    clang-17
hexagon               randconfig-1001-20260922    clang-17
hexagon              randconfig-r1308-20260921    clang-17   sparse
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
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
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260922    gcc-16.1.0
loongarch             randconfig-1001-20260922    clang-18
loongarch            randconfig-r1302-20260922    gcc-13.4.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                       m54418evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
microblaze                       mmu_defconfig    gcc-16.1.0
microblaze           randconfig-r1305-20260922    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      decstation_defconfig    gcc-16.1.0
mips                             gpr_defconfig    clang-24
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260922    gcc-10.5.0
nios2                 randconfig-1001-20260922    gcc-11.5.0
nios2                randconfig-r1309-20260921    gcc-11.5.0 sparse
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1304-20260922    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc               randconfig-r1306-20260921    gcc-14.3.0 sparse
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc                      mpc5200_defconfig    clang-24
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1001-20260921    clang-24
powerpc64                         alldefconfig    clang-17
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1001-20260921    gcc-8.5.0
powerpc64            randconfig-r1300-20260922    clang-18   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260921    gcc-12.5.0
riscv                 randconfig-1001-20260921    gcc-8.5.0
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260921    clang-24
s390                  randconfig-1001-20260921    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260921    gcc-9.5.0
sh                    randconfig-1001-20260921    gcc-16.1.0
sh                   randconfig-r1301-20260922    gcc-14.3.0 sparse
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260921    gcc-8.5.0
sparc                 randconfig-1001-20260921    gcc-11.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260921    clang-21
sparc64               randconfig-1001-20260921    clang-22
sparc64              randconfig-r1303-20260922    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260921    gcc-14
um                    randconfig-1001-20260921    gcc-14
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260921    clang-22
x86_64      buildonly-randconfig-1001-20260921    gcc-13
x86_64      buildonly-randconfig-1002-20260921    clang-22
x86_64      buildonly-randconfig-1003-20260921    clang-22
x86_64      buildonly-randconfig-1004-20260921    clang-22
x86_64      buildonly-randconfig-1005-20260921    clang-22
x86_64                               defconfig    gcc-14
x86_64                randconfig-1000-20260921    gcc-13
x86_64                randconfig-1001-20260921    clang-22
x86_64                randconfig-1002-20260921    gcc-14
x86_64                randconfig-1003-20260921    gcc-14
x86_64                randconfig-1004-20260921    clang-22
x86_64                randconfig-1005-20260921    clang-22
x86_64                randconfig-1006-20260921    gcc-14
x86_64                randconfig-1007-20260921    clang-22
x86_64                randconfig-1008-20260921    clang-22
x86_64                randconfig-1009-20260921    clang-22
x86_64                randconfig-1010-20260921    gcc-14
x86_64                randconfig-1011-20260921    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260921    gcc-11.5.0
xtensa                randconfig-1001-20260921    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
