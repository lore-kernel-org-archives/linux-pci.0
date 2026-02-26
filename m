Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964F36AB7B
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130744; cv=none; b=pAtey/lWM3gem7arxa3yBNEzwfusj9LKSA3nuRi8im01sDCDtE2TYRoqyHl8UJbh6qZMynZBHeqcSQJ2Ciy5i05wHxtfCMJGALZlhJAzH7ba1qc/AJCfhdAHxngq2ZQOvlg8gUbL1hLm6MtN0nSxQDcVCNs9O7AYEJdaqM/QcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130744; c=relaxed/simple;
	bh=pmotI5e6YgWJwrEWQOwWE3RisOXT6pv/rpZYy/PmaMo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qyXGgTL3+YYFryuH0n731P1bCqtHwS2r/Tzr7tdHPd1YR/B1Ia6xqF/sF1LtQ+ioKb1Hn8CiEXDpgu8n77L23HN2QBD9NZ5pr6NMvcjqkQWwXSGVVbHZZQkl7zDS0AvIl138CFRw3otHejEjPEJTc5pZh1U/sEq1WuHJOXXzgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=En96WsN5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="En96WsN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772130743; x=1803666743;
  h=date:from:to:cc:subject:message-id;
  bh=pmotI5e6YgWJwrEWQOwWE3RisOXT6pv/rpZYy/PmaMo=;
  b=En96WsN5dKhdaErWIn+rON2LqOpabfTcqSU6s+gRB0rUX+JSx0HNkJTR
   i+1pjZu2XkW3VpJ/j22lZQJ2SKw3retLmAu94vG3B0mTSn1GTJtkyd5Ws
   vWMgXPaaHXDHFtAcwpDxz0y75svx4DmoI4mXBj/2F/B1/A89LoSzVsqkA
   026gS4eJ8x4QjH+Ag54w8rENMvKR7WgBfyYgpZlgrCvoo3WjE5zNXf4/n
   t+x+/efwJbsiD3Z1ydFfSmF+a5vaEbSYXh+K5Xzz31p0qZFZe1Ph1FdLg
   VUlB/NG6rOSYj6QkPfjJ0lYXCM9n2gZceRV1agRDnHAmZMCCjBr6n4Z5w
   g==;
X-CSE-ConnectionGUID: ZwjsR5ntRzWi8T0169MONw==
X-CSE-MsgGUID: 3SVuqe9aQ8C/VSwtBOe+HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="77038774"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="77038774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:32:23 -0800
X-CSE-ConnectionGUID: uGRaO/0BRZGiYqT1QoWd0g==
X-CSE-MsgGUID: ENhAD6MpRlyc4XyUVoi0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="244173833"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 10:32:21 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvg9H-000000009lf-25ZB;
	Thu, 26 Feb 2026 18:32:01 +0000
Date: Fri, 27 Feb 2026 02:31:29 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-amd-mdb] BUILD SUCCESS
 821578559ef68583dc3f1fcaaf9dfa00147348b7
Message-ID: <202602270221.YBJZC665-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-amd-mdb
branch HEAD: 821578559ef68583dc3f1fcaaf9dfa00147348b7  PCI: amd-mdb: fix incorrect IRQ number in INTx error message

elapsed time: 739m

configs tested: 237
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260226    gcc-15.2.0
arc                   randconfig-002-20260226    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    clang-18
arm                           imxrt_defconfig    gcc-15.2.0
arm                   randconfig-001-20260226    gcc-15.2.0
arm                   randconfig-002-20260226    gcc-15.2.0
arm                   randconfig-003-20260226    gcc-15.2.0
arm                   randconfig-004-20260226    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260226    gcc-14.3.0
arm64                 randconfig-002-20260226    gcc-14.3.0
arm64                 randconfig-003-20260226    gcc-14.3.0
arm64                 randconfig-004-20260226    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260226    gcc-14.3.0
csky                  randconfig-002-20260226    gcc-14.3.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260226    clang-23
hexagon               randconfig-002-20260226    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260226    gcc-14
i386        buildonly-randconfig-002-20260226    gcc-14
i386        buildonly-randconfig-003-20260226    gcc-14
i386        buildonly-randconfig-004-20260226    gcc-14
i386        buildonly-randconfig-005-20260226    gcc-14
i386        buildonly-randconfig-006-20260226    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260226    clang-20
i386                  randconfig-001-20260226    gcc-14
i386                  randconfig-002-20260226    clang-20
i386                  randconfig-003-20260226    clang-20
i386                  randconfig-004-20260226    clang-20
i386                  randconfig-005-20260226    clang-20
i386                  randconfig-005-20260226    gcc-13
i386                  randconfig-006-20260226    clang-20
i386                  randconfig-007-20260226    clang-20
i386                  randconfig-011-20260226    gcc-14
i386                  randconfig-012-20260226    gcc-14
i386                  randconfig-013-20260226    gcc-14
i386                  randconfig-014-20260226    gcc-14
i386                  randconfig-015-20260226    gcc-14
i386                  randconfig-016-20260226    gcc-14
i386                  randconfig-017-20260226    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260226    clang-23
loongarch             randconfig-002-20260226    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-18
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260226    clang-23
nios2                 randconfig-002-20260226    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260226    clang-16
parisc                randconfig-002-20260226    clang-16
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-18
powerpc               randconfig-001-20260226    clang-16
powerpc               randconfig-002-20260226    clang-16
powerpc                  storcenter_defconfig    clang-18
powerpc64             randconfig-001-20260226    clang-16
powerpc64             randconfig-002-20260226    clang-16
riscv                            alldefconfig    clang-18
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260226    clang-23
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-002-20260227    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260226    clang-23
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-002-20260226    gcc-8.5.0
s390                  randconfig-002-20260227    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                             espt_defconfig    clang-18
sh                            migor_defconfig    clang-18
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260226    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-002-20260226    gcc-15.2.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260226    gcc-8.5.0
sparc                 randconfig-002-20260226    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260226    clang-23
sparc64               randconfig-001-20260226    gcc-8.5.0
sparc64               randconfig-002-20260226    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260226    clang-23
um                    randconfig-001-20260226    gcc-8.5.0
um                    randconfig-002-20260226    gcc-13
um                    randconfig-002-20260226    gcc-8.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260226    gcc-14
x86_64      buildonly-randconfig-002-20260226    clang-20
x86_64      buildonly-randconfig-002-20260226    gcc-14
x86_64      buildonly-randconfig-003-20260226    gcc-14
x86_64      buildonly-randconfig-004-20260226    clang-20
x86_64      buildonly-randconfig-004-20260226    gcc-14
x86_64      buildonly-randconfig-005-20260226    gcc-14
x86_64      buildonly-randconfig-006-20260226    gcc-13
x86_64      buildonly-randconfig-006-20260226    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260226    gcc-14
x86_64                randconfig-002-20260226    gcc-14
x86_64                randconfig-003-20260226    gcc-14
x86_64                randconfig-004-20260226    gcc-14
x86_64                randconfig-005-20260226    gcc-14
x86_64                randconfig-006-20260226    gcc-14
x86_64                randconfig-011-20260226    gcc-14
x86_64                randconfig-012-20260226    gcc-14
x86_64                randconfig-013-20260226    gcc-14
x86_64                randconfig-014-20260226    gcc-14
x86_64                randconfig-015-20260226    gcc-14
x86_64                randconfig-016-20260226    gcc-14
x86_64                randconfig-071-20260226    clang-20
x86_64                randconfig-071-20260226    gcc-14
x86_64                randconfig-072-20260226    clang-20
x86_64                randconfig-072-20260226    gcc-14
x86_64                randconfig-073-20260226    gcc-14
x86_64                randconfig-074-20260226    clang-20
x86_64                randconfig-074-20260226    gcc-14
x86_64                randconfig-075-20260226    gcc-13
x86_64                randconfig-075-20260226    gcc-14
x86_64                randconfig-076-20260226    clang-20
x86_64                randconfig-076-20260226    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260226    gcc-8.5.0
xtensa                randconfig-001-20260226    gcc-9.5.0
xtensa                randconfig-002-20260226    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
