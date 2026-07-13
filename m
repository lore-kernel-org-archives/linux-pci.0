Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A726F29C
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921429; cv=none; b=dN0LXXFXZq7t5iodDWt2OcgJ1qIKK8FELPPHnGvzMK3QcN91ijwcLSQLMHL5M6maHDx7TriYSOcKxMzG312QNWLqkF/fqueCBPOLReh6oPs+L2+8P/TGMOp98TghU47e9ngph1nSSlsCiM6C0ky+6GIQzPS5UtskgEPaBZNJ32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921429; c=relaxed/simple;
	bh=aiqI/3qS896qcFKqJyjmrPyJY6BbAzq5I8vbSgpsdfI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IBeiSqOy3uWl/rTMfuY4OI7p9Ln3qLEBXc7tjMpQugXajwlDWlmfop1uWu/tPW+VIrggDw9xAg9XbqGiigHh45S94iOotjNBR4/7epAMBDQsZO+PoBrALcp/aMe26+bJgs6vCF5NIz/YsPR5i9lJ9JGKbgdXM3zKpAv5LwlOZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIts0u+K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIts0u+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783921428; x=1815457428;
  h=date:from:to:cc:subject:message-id;
  bh=aiqI/3qS896qcFKqJyjmrPyJY6BbAzq5I8vbSgpsdfI=;
  b=WIts0u+KkMeHnLAQeQ+2UY2Qt8bZnXgt4FZHXVyI4zA9vlZezkm8Qxjf
   LscshmPBvONf4yMmbpnFZCL3td5Mtx2AHGiH3oKWn2OSvLKY3v25lStTo
   7EGei3P+SRltNwOyG7bJehYm3q9xwT3ihn20vKXbVCFPqL03Roh6F9zrs
   7euaYeGJBREOaQPSr63BgaXsVj3jKtwUF5R4wNxiFfPCTHVp+JEBJxTZE
   qAHjHLhUDCZ3zx6bxJtV5x9VwmzbO+9x/fSOoskthOpXLwuLbs0bWHjhx
   J6DVoJGZHIKH0k/cIk8HBXLogqeTR2O8jEP52hVIu2D3Dz4xyPHbw5+nV
   g==;
X-CSE-ConnectionGUID: OPPbaPHMQD2KCleQHOxDiw==
X-CSE-MsgGUID: Sj/POUZtQHm1HllYDzkQEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84639708"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84639708"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 22:43:47 -0700
X-CSE-ConnectionGUID: ml2oznVHRXGEPMe5kLfeEA==
X-CSE-MsgGUID: MF98HeXhQKKsYigr0chbMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278714354"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jul 2026 22:43:45 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wj9S4-00000000LPh-2fp9;
	Mon, 13 Jul 2026 05:43:37 +0000
Date: Mon, 13 Jul 2026 13:43:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dpc] BUILD SUCCESS
 97ca178c899d0049210d325b123ed024eb5ac000
Message-ID: <202607131304.30zplTIR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dpc
branch HEAD: 97ca178c899d0049210d325b123ed024eb5ac000  PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER

elapsed time: 728m

configs tested: 221
configs skipped: 9

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
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260713    gcc-8.5.0
arc                   randconfig-002-20260713    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260713    gcc-8.5.0
arm                   randconfig-002-20260713    gcc-8.5.0
arm                   randconfig-003-20260713    gcc-8.5.0
arm                   randconfig-004-20260713    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260713    clang-23
arm64                 randconfig-001-20260713    gcc-13.4.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260713    clang-23
arm64                 randconfig-002-20260713    gcc-13.4.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260713    clang-23
arm64                 randconfig-003-20260713    gcc-13.4.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260713    clang-23
arm64                 randconfig-004-20260713    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260713    clang-23
csky                  randconfig-001-20260713    gcc-13.4.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260713    clang-23
csky                  randconfig-002-20260713    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260713    clang-23
hexagon               randconfig-002-20260713    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260713    gcc-14
i386        buildonly-randconfig-002-20260713    clang-22
i386        buildonly-randconfig-002-20260713    gcc-14
i386        buildonly-randconfig-003-20260713    gcc-14
i386        buildonly-randconfig-004-20260713    clang-22
i386        buildonly-randconfig-004-20260713    gcc-14
i386        buildonly-randconfig-005-20260713    gcc-14
i386        buildonly-randconfig-006-20260713    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260713    clang-22
i386                  randconfig-002-20260713    clang-22
i386                  randconfig-003-20260713    clang-22
i386                  randconfig-004-20260713    clang-22
i386                  randconfig-005-20260713    clang-22
i386                  randconfig-006-20260713    clang-22
i386                  randconfig-007-20260713    clang-22
i386                  randconfig-011-20260713    clang-22
i386                  randconfig-012-20260713    clang-22
i386                  randconfig-013-20260713    clang-22
i386                  randconfig-014-20260713    clang-22
i386                  randconfig-015-20260713    clang-22
i386                  randconfig-016-20260713    clang-22
i386                  randconfig-017-20260713    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260713    clang-23
loongarch             randconfig-002-20260713    clang-23
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
mips                  maltasmvp_eva_defconfig    gcc-16.1.0
mips                        omega2p_defconfig    clang-17
mips                          rm200_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260713    clang-23
nios2                 randconfig-002-20260713    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260713    clang-23
parisc                randconfig-002-20260713    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     mpc512x_defconfig    clang-23
powerpc               randconfig-001-20260713    clang-23
powerpc               randconfig-002-20260713    clang-23
powerpc64             randconfig-001-20260713    clang-23
powerpc64             randconfig-002-20260713    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-19
riscv                 randconfig-001-20260713    clang-19
riscv                          randconfig-002    clang-19
riscv                 randconfig-002-20260713    clang-19
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-19
s390                  randconfig-001-20260713    clang-19
s390                           randconfig-002    clang-19
s390                  randconfig-002-20260713    clang-19
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-19
sh                    randconfig-001-20260713    clang-19
sh                             randconfig-002    clang-19
sh                    randconfig-002-20260713    clang-19
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-12.5.0
sparc                 randconfig-001-20260713    gcc-12.5.0
sparc                          randconfig-002    gcc-12.5.0
sparc                 randconfig-002-20260713    gcc-12.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260713    gcc-12.5.0
sparc64                        randconfig-002    gcc-12.5.0
sparc64               randconfig-002-20260713    gcc-12.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-12.5.0
um                    randconfig-001-20260713    gcc-12.5.0
um                             randconfig-002    gcc-12.5.0
um                    randconfig-002-20260713    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260713    clang-22
x86_64      buildonly-randconfig-001-20260713    gcc-14
x86_64      buildonly-randconfig-002-20260713    clang-22
x86_64      buildonly-randconfig-002-20260713    gcc-14
x86_64      buildonly-randconfig-003-20260713    clang-22
x86_64      buildonly-randconfig-004-20260713    clang-22
x86_64      buildonly-randconfig-005-20260713    clang-22
x86_64      buildonly-randconfig-006-20260713    clang-22
x86_64      buildonly-randconfig-006-20260713    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260713    gcc-13
x86_64                randconfig-002-20260713    gcc-13
x86_64                randconfig-003-20260713    gcc-13
x86_64                randconfig-004-20260713    gcc-13
x86_64                randconfig-005-20260713    gcc-13
x86_64                randconfig-006-20260713    gcc-13
x86_64                randconfig-011-20260713    gcc-14
x86_64                randconfig-012-20260713    gcc-14
x86_64                randconfig-013-20260713    gcc-14
x86_64                randconfig-014-20260713    gcc-14
x86_64                randconfig-015-20260713    gcc-14
x86_64                randconfig-016-20260713    gcc-14
x86_64                randconfig-071-20260713    gcc-14
x86_64                randconfig-072-20260713    gcc-14
x86_64                randconfig-073-20260713    gcc-14
x86_64                randconfig-074-20260713    gcc-14
x86_64                randconfig-075-20260713    gcc-14
x86_64                randconfig-076-20260713    gcc-14
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
xtensa                         randconfig-001    gcc-12.5.0
xtensa                randconfig-001-20260713    gcc-12.5.0
xtensa                         randconfig-002    gcc-12.5.0
xtensa                randconfig-002-20260713    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
