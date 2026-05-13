Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC730E83A
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778639624; cv=none; b=Y/XhujR/brEFeGxMWmeiOJSZLkrlTiEMb90XXv5+e479LidN2+txYxBnW6yUdJJtSgG0x1vbFdX0TGRa9ipjaQ1Iooh8eqiMNEUeqWKSh4kzZjbzBi2Jnf2O0o4MXOMAqEqc0ZY3sLnXik6mSOJQydHurcLKYXtZ7Di1G0aIpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778639624; c=relaxed/simple;
	bh=FRM0kOS/Fwp2kbJf1qe1b/zmAEKN0AyJfb81hZErhYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MPf/h2JLNNXCu4D4CBL9IHeMVnIuXshbNbtqfEHYC66XVqi2TN8XhlTPJvfIjWtPE2FEztXPN70veKyaSS4+FuPOb/gFf8F9VfSPNLLfNQWmJKKaHGD679SWc5Pm3TNrx9sccfBkNNNA7VAHbgoz789pfA05+s0p4vzuGZeVmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOGjf65I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOGjf65I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778639623; x=1810175623;
  h=date:from:to:cc:subject:message-id;
  bh=FRM0kOS/Fwp2kbJf1qe1b/zmAEKN0AyJfb81hZErhYM=;
  b=gOGjf65INsuoC2+KGD4gpj2ie5GBeaTxC9uA+U7nLK//WLd+V0WrFW3V
   CtXrwi/gGMykbrCGhWv5LdZafpicLk8Si9XNPLY7O3p91L7UK8Dd8Z/kI
   zXF9ZLGzpd13mHvfB2U6F0HctsHWiKGXFGDroQbnB7cS1oCcVoJ/eR+4V
   bjnIaL8+sYWFlYS91TMVSHMj9vofDzhJMVRR5A+8cP5ApKxvKlVQx4gQI
   t6q1X+cDIDDcq5KZI6uK6VXL7J/gENWDQcJ11Y/4lW9VAZI2cGqoQd0LZ
   X/V/96LKhmxyiM7eDumDcgcvpYTk+hKm9J1f05FKlg429TsnVzkhQUyLp
   g==;
X-CSE-ConnectionGUID: VC7zL4+wSLKGH3lIF5EAJA==
X-CSE-MsgGUID: IhVHAhv7Sn6G+t8kznc2bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="91022118"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="91022118"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 19:33:34 -0700
X-CSE-ConnectionGUID: 1xjX2HndQS+jJSK1Bj/omg==
X-CSE-MsgGUID: gyqIUmhBTKi8Knx03ruKAw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 May 2026 19:33:33 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMzPe-000000003DJ-2Rrj;
	Wed, 13 May 2026 02:33:30 +0000
Date: Wed, 13 May 2026 10:32:47 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-amd-mdb] BUILD SUCCESS
 0492461a0508d88f2b63de4f7f4e71b38078de20
Message-ID: <202605131038.colehbtm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-amd-mdb
branch HEAD: 0492461a0508d88f2b63de4f7f4e71b38078de20  PCI: amd-mdb: Assert PERST# on shutdown

elapsed time: 774m

configs tested: 282
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260513    gcc-14.3.0
arc                   randconfig-001-20260513    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260513    gcc-14.3.0
arc                   randconfig-002-20260513    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    clang-20
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260513    gcc-14.3.0
arm                   randconfig-001-20260513    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260513    gcc-14.3.0
arm                   randconfig-002-20260513    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260513    gcc-14.3.0
arm                   randconfig-003-20260513    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260513    gcc-14.3.0
arm                   randconfig-004-20260513    gcc-8.5.0
arm                           sama7_defconfig    clang-23
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260512    clang-23
arm64                 randconfig-001-20260513    gcc-12.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260512    clang-23
arm64                 randconfig-002-20260513    gcc-12.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260512    clang-23
arm64                 randconfig-003-20260513    gcc-12.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260512    clang-23
arm64                 randconfig-004-20260513    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260512    clang-23
csky                  randconfig-001-20260513    gcc-12.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260512    clang-23
csky                  randconfig-002-20260513    gcc-12.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260512    gcc-11.5.0
hexagon               randconfig-001-20260513    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260512    gcc-11.5.0
hexagon               randconfig-002-20260513    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260512    gcc-14
i386        buildonly-randconfig-001-20260513    clang-20
i386        buildonly-randconfig-002-20260512    gcc-14
i386        buildonly-randconfig-002-20260513    clang-20
i386        buildonly-randconfig-003-20260512    gcc-14
i386        buildonly-randconfig-003-20260513    clang-20
i386        buildonly-randconfig-004-20260512    gcc-14
i386        buildonly-randconfig-004-20260513    clang-20
i386        buildonly-randconfig-005-20260512    gcc-14
i386        buildonly-randconfig-005-20260513    clang-20
i386        buildonly-randconfig-006-20260512    gcc-14
i386        buildonly-randconfig-006-20260513    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260512    gcc-14
i386                  randconfig-001-20260513    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260512    gcc-14
i386                  randconfig-002-20260513    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260512    gcc-14
i386                  randconfig-003-20260513    clang-20
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260512    gcc-14
i386                  randconfig-004-20260513    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260512    gcc-14
i386                  randconfig-005-20260513    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260512    gcc-14
i386                  randconfig-006-20260513    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260512    gcc-14
i386                  randconfig-007-20260513    clang-20
i386                  randconfig-011-20260512    clang-20
i386                  randconfig-011-20260513    clang-20
i386                  randconfig-012-20260512    clang-20
i386                  randconfig-012-20260513    clang-20
i386                  randconfig-013-20260512    clang-20
i386                  randconfig-013-20260513    clang-20
i386                  randconfig-014-20260512    clang-20
i386                  randconfig-014-20260513    clang-20
i386                  randconfig-015-20260512    clang-20
i386                  randconfig-015-20260513    clang-20
i386                  randconfig-016-20260512    clang-20
i386                  randconfig-016-20260513    clang-20
i386                  randconfig-017-20260512    clang-20
i386                  randconfig-017-20260513    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260512    gcc-11.5.0
loongarch             randconfig-001-20260513    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260512    gcc-11.5.0
loongarch             randconfig-002-20260513    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260512    gcc-11.5.0
nios2                 randconfig-001-20260513    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260512    gcc-11.5.0
nios2                 randconfig-002-20260513    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260513    gcc-8.5.0
parisc                randconfig-002-20260513    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                     rainier_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260513    gcc-8.5.0
powerpc               randconfig-002-20260513    gcc-8.5.0
powerpc64             randconfig-001-20260513    gcc-8.5.0
powerpc64             randconfig-002-20260513    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260513    gcc-15.2.0
riscv                 randconfig-002-20260513    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260513    gcc-15.2.0
s390                  randconfig-002-20260513    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260513    gcc-15.2.0
sh                    randconfig-002-20260513    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-11.5.0
sparc                          randconfig-001    gcc-13.4.0
sparc                 randconfig-001-20260512    gcc-13.4.0
sparc                 randconfig-001-20260513    gcc-11.5.0
sparc                          randconfig-002    gcc-11.5.0
sparc                          randconfig-002    gcc-13.4.0
sparc                 randconfig-002-20260512    gcc-13.4.0
sparc                 randconfig-002-20260513    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-11.5.0
sparc64                        randconfig-001    gcc-13.4.0
sparc64               randconfig-001-20260512    gcc-13.4.0
sparc64               randconfig-001-20260513    gcc-11.5.0
sparc64                        randconfig-002    gcc-11.5.0
sparc64                        randconfig-002    gcc-13.4.0
sparc64               randconfig-002-20260512    gcc-13.4.0
sparc64               randconfig-002-20260513    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-11.5.0
um                             randconfig-001    gcc-13.4.0
um                    randconfig-001-20260512    gcc-13.4.0
um                    randconfig-001-20260513    gcc-11.5.0
um                             randconfig-002    gcc-11.5.0
um                             randconfig-002    gcc-13.4.0
um                    randconfig-002-20260512    gcc-13.4.0
um                    randconfig-002-20260513    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260512    gcc-14
x86_64      buildonly-randconfig-001-20260513    gcc-12
x86_64      buildonly-randconfig-002-20260512    gcc-14
x86_64      buildonly-randconfig-002-20260513    gcc-12
x86_64      buildonly-randconfig-003-20260512    gcc-14
x86_64      buildonly-randconfig-003-20260513    gcc-12
x86_64      buildonly-randconfig-004-20260512    gcc-14
x86_64      buildonly-randconfig-004-20260513    gcc-12
x86_64      buildonly-randconfig-005-20260512    gcc-14
x86_64      buildonly-randconfig-005-20260513    gcc-12
x86_64      buildonly-randconfig-006-20260512    gcc-14
x86_64      buildonly-randconfig-006-20260513    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260513    clang-20
x86_64                randconfig-002-20260513    clang-20
x86_64                randconfig-003-20260513    clang-20
x86_64                randconfig-004-20260513    clang-20
x86_64                randconfig-005-20260513    clang-20
x86_64                randconfig-006-20260513    clang-20
x86_64                randconfig-011-20260512    clang-20
x86_64                randconfig-011-20260513    gcc-14
x86_64                randconfig-012-20260512    clang-20
x86_64                randconfig-012-20260513    gcc-14
x86_64                randconfig-013-20260512    clang-20
x86_64                randconfig-013-20260513    gcc-14
x86_64                randconfig-014-20260512    clang-20
x86_64                randconfig-014-20260513    gcc-14
x86_64                randconfig-015-20260512    clang-20
x86_64                randconfig-015-20260513    gcc-14
x86_64                randconfig-016-20260512    clang-20
x86_64                randconfig-016-20260513    gcc-14
x86_64                randconfig-071-20260512    gcc-14
x86_64                randconfig-071-20260513    gcc-14
x86_64                randconfig-072-20260513    gcc-14
x86_64                randconfig-073-20260513    gcc-14
x86_64                randconfig-074-20260512    gcc-14
x86_64                randconfig-074-20260513    gcc-14
x86_64                randconfig-075-20260513    gcc-14
x86_64                randconfig-076-20260513    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                         randconfig-001    gcc-11.5.0
xtensa                         randconfig-001    gcc-13.4.0
xtensa                randconfig-001-20260512    gcc-13.4.0
xtensa                randconfig-001-20260513    gcc-11.5.0
xtensa                         randconfig-002    gcc-11.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260512    gcc-13.4.0
xtensa                randconfig-002-20260513    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
