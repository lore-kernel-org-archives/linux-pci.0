Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A437DE98
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018697; cv=none; b=BqVqIq9q8RH34fafBNgeW6cuT42+YUrUADqMqayT+YOV0rZQF70ns4BhoXExOzx4hvNUc5iiv9jvnSQg6bEtwReNXTfIBXflsxJyCFbeR+MihZG9HQb102C46JzCnN3sesN4TeyYtEP95IC40xUgmvxikr3k3/+r+GKFN49jEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018697; c=relaxed/simple;
	bh=sagfO6ku0cSyf2t5vMM0+jLRoNsjoQMSo4TLDSL4ArU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cvouOsOQ4j43pxDomMiz78n7nH5Pyv3f0EvkRK/5xKYCnVWzwUHGFBqFOxdFrjSuU/iRCUhowFVDf6EQGSgMV7JliZEChsD/J0826Tz6rVPfhJm0TgYhFD54ywUBTPeZaH72X1l8cUd5LS/YchizJJlSYOY/NVA2tcese6MJs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsTZgIAi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsTZgIAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790018695; x=1821554695;
  h=date:from:to:cc:subject:message-id;
  bh=sagfO6ku0cSyf2t5vMM0+jLRoNsjoQMSo4TLDSL4ArU=;
  b=IsTZgIAiANhRfmHNmVEOPocxVBR8Zmtr/cy7dMW1PNePNsvAlyNevpPV
   9VuCVrWP0SrFZI31AtWBZxSFxi8BGU/wck8WqfTdziahy9Gvli4R61RHn
   3vjRn6NbU6Mau5ocqkj+dx84FVtqnZpmw/hcQ2Ow5XDU5EWxAf4Vo7dKz
   smnFSs10gVN0om9DCTSNH+dIANi7nULG/hYoWsFH+rhxXz30gBAeESKCR
   sUE7zdszRo8RB8N2aPRxQ+K8tISZcKleG3au8gqhUlJigXtVnEm+F6tOq
   AzUq3XXic0gdq8kO74wcv3r4D8jZa3q7pwk0rezRDyoaCdVetQ66phMy6
   w==;
X-CSE-ConnectionGUID: cfOkMB/RQUChfiWXKLtHeA==
X-CSE-MsgGUID: 6I0FccIhSrWbyYBXpf3/mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90683661"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90683661"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:24:55 -0700
X-CSE-ConnectionGUID: PS+GC6/sTeSP/4kva62huA==
X-CSE-MsgGUID: o4MSYhFbQ+CPwkIR4WhPDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="299031484"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Sep 2026 12:24:53 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x8jdD-00000000EHZ-0jPz;
	Mon, 21 Sep 2026 19:24:51 +0000
Date: Tue, 22 Sep 2026 03:24:48 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:tegra] BUILD SUCCESS
 94976a87cfc164fdddda54f4baa61ea7f0bde323
Message-ID: <202609220344.274HMHpp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra
branch HEAD: 94976a87cfc164fdddda54f4baa61ea7f0bde323  dt-bindings: pci: tegra: Convert to json-schema

elapsed time: 3140m

configs tested: 206
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260921    gcc-9.5.0
arc                   randconfig-1001-20260921    gcc-15.2.0
arc                  randconfig-r2202-20260918    gcc-8.5.0
arm                                allnoconfig    clang-17
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    clang-24
arm                   randconfig-1000-20260921    clang-24
arm                   randconfig-1001-20260921    gcc-13.4.0
arm                   randconfig-1002-20260921    gcc-15.2.0
arm                   randconfig-1003-20260921    clang-24
arm                  randconfig-r1309-20260921    gcc-8.5.0  sparse
arm                  randconfig-r2104-20260918    clang-18
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260921    clang-24
arm64                 randconfig-1001-20260921    clang-24
arm64                 randconfig-1002-20260921    clang-24
arm64                 randconfig-1003-20260921    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260921    gcc-9.5.0
csky                  randconfig-1001-20260921    gcc-11.5.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260921    clang-18
hexagon               randconfig-1001-20260921    clang-17
hexagon              randconfig-r1301-20260921    clang-24   sparse
hexagon              randconfig-r2100-20260918    clang-24
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
i386                  randconfig-1302-20260921    gcc-14     sparse
i386                  randconfig-2100-20260918    clang-22
i386                  randconfig-2101-20260918    gcc-14
i386                  randconfig-2102-20260918    clang-22
i386                  randconfig-2103-20260918    clang-22
i386                  randconfig-2200-20260918    clang-22
i386                 randconfig-r2103-20260918    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260921    clang-18
loongarch             randconfig-1001-20260921    gcc-16.1.0
loongarch            randconfig-r2101-20260918    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                 randconfig-r1304-20260921    gcc-15.2.0 sparse
m68k                 randconfig-r1309-20260921    gcc-13.4.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                       maltaaprp_defconfig    clang-17
mips                       pic32mzda_defconfig    gcc-16.1.0
mips                 randconfig-r1306-20260921    clang-24   sparse
mips                 randconfig-r1308-20260921    clang-24   sparse
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260921    gcc-8.5.0
nios2                 randconfig-1001-20260921    gcc-11.5.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2106-20260918    gcc-10.5.0
openrisc             randconfig-r2200-20260918    gcc-15.2.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc                       katmai_defconfig    clang-24
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1001-20260921    clang-24
powerpc              randconfig-r2105-20260918    clang-24
powerpc              randconfig-r2107-20260918    clang-18
powerpc                  xes_mpc85xx_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1001-20260921    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    clang-24
riscv                     nommu_k210_defconfig    clang-24
riscv                 randconfig-1000-20260921    gcc-12.5.0
riscv                 randconfig-1001-20260921    gcc-8.5.0
riscv                 randconfig-2000-20260918    gcc-12.5.0
riscv                 randconfig-2001-20260918    clang-24
riscv                randconfig-r1307-20260921    gcc-8.5.0  sparse
riscv                randconfig-r2201-20260918    gcc-9.5.0
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260921    clang-24
s390                  randconfig-1001-20260921    clang-24
s390                  randconfig-2000-20260918    gcc-8.5.0
s390                  randconfig-2001-20260918    clang-17
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260921    gcc-9.5.0
sh                    randconfig-1001-20260921    gcc-16.1.0
sh                    randconfig-2000-20260918    gcc-13.4.0
sh                    randconfig-2001-20260918    gcc-11.5.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260921    gcc-8.5.0
sparc                 randconfig-1001-20260921    gcc-11.5.0
sparc                 randconfig-2000-20260918    gcc-8.5.0
sparc                 randconfig-2001-20260918    gcc-11.5.0
sparc                randconfig-r1305-20260921    gcc-13.4.0 sparse
sparc                        sparc32_defconfig    gcc-16.1.0
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260921    clang-21
sparc64               randconfig-1001-20260921    clang-22
sparc64               randconfig-2000-20260918    gcc-8.5.0
sparc64               randconfig-2001-20260918    clang-20
sparc64              randconfig-r1307-20260921    clang-20   sparse
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260921    gcc-14
um                    randconfig-1001-20260921    gcc-14
um                    randconfig-2000-20260918    gcc-14
um                    randconfig-2001-20260918    gcc-14
um                   randconfig-r1300-20260921    clang-17   sparse
um                   randconfig-r2102-20260918    clang-17
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
x86_64                randconfig-1012-20260921    clang-22
x86_64                randconfig-1013-20260921    clang-22
x86_64                randconfig-1014-20260921    clang-22
x86_64                randconfig-1015-20260921    clang-22
x86_64                randconfig-1016-20260921    clang-22
x86_64                randconfig-1017-20260921    gcc-12
x86_64                randconfig-1300-20260921    gcc-14     sparse
x86_64                randconfig-2100-20260918    clang-22
x86_64                randconfig-2101-20260918    clang-22
x86_64                randconfig-2102-20260918    gcc-14
x86_64                randconfig-2103-20260918    clang-22
x86_64                randconfig-2200-20260918    gcc-14
x86_64               randconfig-r1303-20260921    clang-22   sparse
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                randconfig-1000-20260921    gcc-11.5.0
xtensa                randconfig-1001-20260921    gcc-9.5.0
xtensa                randconfig-2000-20260918    gcc-8.5.0
xtensa                randconfig-2001-20260918    gcc-13.4.0
xtensa               randconfig-r1302-20260921    gcc-8.5.0  sparse
xtensa               randconfig-r1306-20260921    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
