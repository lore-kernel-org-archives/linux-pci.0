Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C534CDD
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851069; cv=none; b=clAyCuhSe/yXF235zaKxOdsXjAsmMILdY7xejaB3aslYPIrP5TBtx3ZoyjGbuxwDsRqc6/xL8vIes7MTCYIKbBtIxaF8GZ3GYEfW+YZWDraKjz2nALil57MKjZMxkk0Vht1uLcyIsKScIJwOij+aOLLjY1rsgeAVigmhoz/8u/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851069; c=relaxed/simple;
	bh=FXbFURaFFeSgqH5uBLdcjfxWVUB7zfr7ywuoPqw6UPQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O0MdODfEIMfE2DcrvswFOCxDu5h8POKRI3TltQNQorijOTm57UFgrbMoc9BXmGhEC1QlrknrthMLm9nWRtVL9OgnjAdAUx1n3qd2GSmlLvy6ptiBKCGqN8SiXu9O6ez4MHkKi4wZ4UPL7eGTB0WjMGKyEylhliE4UrMwMwsgSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rx6rwPtr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rx6rwPtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782851065; x=1814387065;
  h=date:from:to:cc:subject:message-id;
  bh=FXbFURaFFeSgqH5uBLdcjfxWVUB7zfr7ywuoPqw6UPQ=;
  b=Rx6rwPtrknCt+ay8vp+RA5qNYllsqXPwSl8Uk3ops4Lk+CeW6isUS2CR
   yebqIC6F+w4q5BPhDpgJICvklWcLIXqvGzjLjjhPUca2G6yT5Rn5T4bva
   hJ5yw+ZBcAdbsNpIGQ83+K5Af+CILDvEGiYg2i1iqC3KiK5i+kDDpFiKD
   g3ayt7+FjiFXY8USYDEPZAOCv23zW2mZYugzzpqCM2X/mXw60E5YpQK+N
   3C5Nd3FRqLW6a2GrFOe3eqGIG49G8GCOYfVz2++epJgqqTFOucE5X3YoL
   WjjhfC4bdehsQZXoG7Ku9f5o+aN1FKd0zBCOCdY0RlxrniHfNANJVXuz3
   g==;
X-CSE-ConnectionGUID: LJZO856aRVC7GYP5WbeA5A==
X-CSE-MsgGUID: L1bzG8F2Rh2cMQXxP2nVEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87487393"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="87487393"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 13:24:25 -0700
X-CSE-ConnectionGUID: pOBWpZS/T52ec/6+2vTzDQ==
X-CSE-MsgGUID: uDwxVTqXRiq5EDADVUmQUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="248999179"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jun 2026 13:24:23 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wef0G-000000008dR-44jT;
	Tue, 30 Jun 2026 20:24:20 +0000
Date: Wed, 01 Jul 2026 04:23:27 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-imx6] BUILD SUCCESS
 4b523544008aa70cda4b34c0589bbe47172c2637
Message-ID: <202607010416.CiGlCS8g-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: 4b523544008aa70cda4b34c0589bbe47172c2637  PCI: host-generic: Move legacy DT binding fallback decision to caller of pci_host_common_parse_ports()

elapsed time: 757m

configs tested: 334
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                         haps_hs_defconfig    gcc-16.1.0
arc                            randconfig-001    clang-23
arc                   randconfig-001-20260630    clang-23
arc                   randconfig-001-20260701    gcc-12.5.0
arc                            randconfig-002    clang-23
arc                   randconfig-002-20260630    clang-23
arc                   randconfig-002-20260701    gcc-12.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    clang-23
arm                   randconfig-001-20260630    clang-23
arm                   randconfig-001-20260701    gcc-12.5.0
arm                            randconfig-002    clang-23
arm                   randconfig-002-20260630    clang-23
arm                   randconfig-002-20260701    gcc-12.5.0
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260630    clang-23
arm                   randconfig-003-20260701    gcc-12.5.0
arm                            randconfig-004    clang-23
arm                   randconfig-004-20260630    clang-23
arm                   randconfig-004-20260701    gcc-12.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260630    clang-23
arm64                 randconfig-001-20260701    gcc-12.5.0
arm64                 randconfig-002-20260630    clang-23
arm64                 randconfig-002-20260701    gcc-12.5.0
arm64                 randconfig-003-20260630    clang-23
arm64                 randconfig-003-20260701    gcc-12.5.0
arm64                 randconfig-004-20260630    clang-23
arm64                 randconfig-004-20260701    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260630    clang-23
csky                  randconfig-001-20260701    gcc-12.5.0
csky                  randconfig-002-20260630    clang-23
csky                  randconfig-002-20260701    gcc-12.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260630    clang-18
hexagon               randconfig-001-20260701    clang-23
hexagon               randconfig-002-20260630    clang-18
hexagon               randconfig-002-20260701    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260630    clang-22
i386        buildonly-randconfig-001-20260701    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260630    clang-22
i386        buildonly-randconfig-002-20260701    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260630    clang-22
i386        buildonly-randconfig-003-20260701    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260630    clang-22
i386        buildonly-randconfig-004-20260701    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260630    clang-22
i386        buildonly-randconfig-005-20260701    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260630    clang-22
i386        buildonly-randconfig-006-20260701    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260630    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260630    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260630    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260630    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260630    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260630    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260630    clang-22
i386                           randconfig-011    gcc-12
i386                  randconfig-011-20260630    gcc-12
i386                  randconfig-011-20260701    gcc-14
i386                           randconfig-012    gcc-12
i386                  randconfig-012-20260630    gcc-12
i386                  randconfig-012-20260701    gcc-14
i386                           randconfig-013    gcc-12
i386                  randconfig-013-20260630    gcc-12
i386                  randconfig-013-20260701    gcc-14
i386                           randconfig-014    gcc-12
i386                  randconfig-014-20260630    gcc-12
i386                  randconfig-014-20260701    gcc-14
i386                           randconfig-015    gcc-12
i386                  randconfig-015-20260630    gcc-12
i386                  randconfig-015-20260701    gcc-14
i386                           randconfig-016    gcc-12
i386                  randconfig-016-20260630    gcc-12
i386                  randconfig-016-20260701    gcc-14
i386                           randconfig-017    gcc-12
i386                  randconfig-017-20260630    gcc-12
i386                  randconfig-017-20260701    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260630    clang-18
loongarch             randconfig-001-20260701    clang-23
loongarch             randconfig-002-20260630    clang-18
loongarch             randconfig-002-20260701    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260630    clang-18
nios2                 randconfig-001-20260701    clang-23
nios2                 randconfig-002-20260630    clang-18
nios2                 randconfig-002-20260701    clang-23
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260630    clang-22
parisc                randconfig-001-20260701    clang-17
parisc                randconfig-002-20260630    clang-22
parisc                randconfig-002-20260701    clang-17
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260630    clang-22
powerpc               randconfig-001-20260701    clang-17
powerpc               randconfig-002-20260630    clang-22
powerpc               randconfig-002-20260701    clang-17
powerpc64             randconfig-001-20260630    clang-22
powerpc64             randconfig-001-20260701    clang-17
powerpc64             randconfig-002-20260630    clang-22
powerpc64             randconfig-002-20260701    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-9.5.0
riscv                 randconfig-001-20260630    gcc-9.5.0
riscv                          randconfig-002    gcc-9.5.0
riscv                 randconfig-002-20260630    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-9.5.0
s390                  randconfig-001-20260630    gcc-9.5.0
s390                           randconfig-002    gcc-9.5.0
s390                  randconfig-002-20260630    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-9.5.0
sh                    randconfig-001-20260630    gcc-9.5.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260630    gcc-9.5.0
sh                           se7750_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    clang-17
sparc                 randconfig-001-20260630    clang-17
sparc                 randconfig-001-20260701    gcc-13.4.0
sparc                          randconfig-002    clang-17
sparc                 randconfig-002-20260630    clang-17
sparc                 randconfig-002-20260701    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    clang-17
sparc64               randconfig-001-20260630    clang-17
sparc64               randconfig-001-20260701    gcc-13.4.0
sparc64                        randconfig-002    clang-17
sparc64               randconfig-002-20260630    clang-17
sparc64               randconfig-002-20260701    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-17
um                    randconfig-001-20260630    clang-17
um                    randconfig-001-20260701    gcc-13.4.0
um                             randconfig-002    clang-17
um                    randconfig-002-20260630    clang-17
um                    randconfig-002-20260701    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260630    clang-22
x86_64      buildonly-randconfig-001-20260701    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260630    clang-22
x86_64      buildonly-randconfig-002-20260630    gcc-14
x86_64      buildonly-randconfig-002-20260701    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260630    clang-22
x86_64      buildonly-randconfig-003-20260701    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260630    clang-22
x86_64      buildonly-randconfig-004-20260701    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260630    clang-22
x86_64      buildonly-randconfig-005-20260701    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260630    clang-22
x86_64      buildonly-randconfig-006-20260701    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260630    gcc-14
x86_64                randconfig-001-20260701    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260630    gcc-14
x86_64                randconfig-002-20260701    gcc-14
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260630    gcc-14
x86_64                randconfig-003-20260701    gcc-14
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260630    gcc-14
x86_64                randconfig-004-20260701    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260630    gcc-14
x86_64                randconfig-005-20260701    gcc-14
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260630    gcc-14
x86_64                randconfig-006-20260701    gcc-14
x86_64                randconfig-011-20260630    gcc-14
x86_64                randconfig-011-20260701    gcc-14
x86_64                randconfig-012-20260630    gcc-14
x86_64                randconfig-012-20260701    gcc-14
x86_64                randconfig-013-20260630    gcc-14
x86_64                randconfig-013-20260701    gcc-14
x86_64                randconfig-014-20260630    gcc-14
x86_64                randconfig-014-20260701    gcc-14
x86_64                randconfig-015-20260630    gcc-14
x86_64                randconfig-015-20260701    gcc-14
x86_64                randconfig-016-20260630    gcc-14
x86_64                randconfig-016-20260701    gcc-14
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260630    clang-22
x86_64                randconfig-071-20260630    gcc-13
x86_64                randconfig-071-20260630    gcc-14
x86_64                randconfig-071-20260701    gcc-14
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260630    clang-22
x86_64                randconfig-072-20260630    gcc-13
x86_64                randconfig-072-20260630    gcc-14
x86_64                randconfig-072-20260701    gcc-14
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260630    clang-22
x86_64                randconfig-073-20260630    gcc-13
x86_64                randconfig-073-20260701    gcc-14
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260630    clang-22
x86_64                randconfig-074-20260630    gcc-13
x86_64                randconfig-074-20260701    gcc-14
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260630    clang-22
x86_64                randconfig-075-20260630    gcc-13
x86_64                randconfig-075-20260630    gcc-14
x86_64                randconfig-075-20260701    gcc-14
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260630    clang-22
x86_64                randconfig-076-20260630    gcc-13
x86_64                randconfig-076-20260701    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    clang-17
xtensa                randconfig-001-20260630    clang-17
xtensa                randconfig-001-20260701    gcc-13.4.0
xtensa                         randconfig-002    clang-17
xtensa                randconfig-002-20260630    clang-17
xtensa                randconfig-002-20260701    gcc-13.4.0
xtensa                    smp_lx200_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
