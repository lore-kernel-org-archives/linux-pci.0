Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988642737E3
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769290120; cv=none; b=TXAVt4kbDlXYkJCHC14DJKbtQn5K59ujNlTHeU6h81A+nucE4GcnjbpOk4dpfzbZb6dpWhLy3O6oiUqRXx5uA5rn5HUUDdehwdRmM9QQUMwfAtA9ovoBNPpd2vz9xUVRdoPCMsbE4/nB5STjSfqoksqI5tkg5mq+3zII8cMlQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769290120; c=relaxed/simple;
	bh=a80oaU1QDvbeERBKlmrgr9/EJM+oLCEEqpuBbx5sgoA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SsCrJA5+FWA5m52W4rSm2gSLDPvD7HI/cM3FbamwsleG8iq4ePqs4fr5Rzk5BiMiByBFH3Dk6/gHUIth2H58v1Mn/cwOtCPRRJDBunuqiYzKHPAH1sOs6VKgsuhgYDpN68/IXD3HCIT681bUVwYc7nNc1sF0Tr74jiyN7Y1MpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X86dooPM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X86dooPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769290119; x=1800826119;
  h=date:from:to:cc:subject:message-id;
  bh=a80oaU1QDvbeERBKlmrgr9/EJM+oLCEEqpuBbx5sgoA=;
  b=X86dooPMXUIvCAuGJ5ElrHJUS5q3UUTeQAxucxpWrZVDHyzLWQjvRgto
   hc3yeuIhyR5iwuE653UuyZcF5dz8ntpMZ5u0esj3cYZ/iTDJjt5xUreEI
   GxnVv1nOmdq1FcKE1pIyVMZ5Kv/vBLceFLGDKNJkJ98V3U1Ynme8WoZ3k
   BSmv/CnLCmsNQxVVgJtS556rJfZVcr42qJNYMZF76/KOh4/yhZbAWAPSv
   qHTI0lIp+zfFNCkMdpr7e25ahYzAsfQTX8WEk1vJc87Pk6pmZXIrtrETW
   QVEuO8wN4qjR/awIKgc+XUiSmth6VyQ1WeFgdqbhNzcSJ1PZ0tcwg7S3i
   A==;
X-CSE-ConnectionGUID: zYpru2k2TNmC4DiaJBnceQ==
X-CSE-MsgGUID: E0pDvLA6SwOw3DgFNraUvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="70670465"
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="70670465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 13:28:38 -0800
X-CSE-ConnectionGUID: +nGjYXmzSoOGclhCSb2fxw==
X-CSE-MsgGUID: X1q59+6MQXWKJqL9gduBEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="207135000"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Jan 2026 13:28:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjlBK-00000000VYE-0iD8;
	Sat, 24 Jan 2026 21:28:34 +0000
Date: Sun, 25 Jan 2026 05:28:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 8754dd7639ab0fd68c3ab9d91c7bdecc3e5740a8
Message-ID: <202601250503.L9RWBk7G-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 8754dd7639ab0fd68c3ab9d91c7bdecc3e5740a8  PCI: endpoint: Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink() functions

elapsed time: 1256m

configs tested: 266
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-22
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260124    clang-18
arc                   randconfig-001-20260124    gcc-14.3.0
arc                   randconfig-002-20260124    clang-18
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                        keystone_defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                          pxa168_defconfig    clang-22
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260124    clang-18
arm                   randconfig-002-20260124    clang-18
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    clang-18
arm                         s3c6400_defconfig    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm                        vexpress_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    clang-22
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260124    gcc-15.2.0
hexagon               randconfig-002-20260124    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-001-20260125    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-002-20260125    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-003-20260125    gcc-14
i386        buildonly-randconfig-004-20260124    gcc-14
i386        buildonly-randconfig-004-20260125    gcc-14
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-005-20260125    gcc-14
i386        buildonly-randconfig-006-20260124    gcc-14
i386        buildonly-randconfig-006-20260125    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-12
i386                  randconfig-004-20260124    gcc-14
i386                  randconfig-005-20260124    clang-20
i386                  randconfig-005-20260124    gcc-14
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-011-20260125    gcc-14
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-012-20260125    gcc-14
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-013-20260125    gcc-14
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-014-20260125    gcc-14
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-015-20260125    gcc-14
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-016-20260125    gcc-14
i386                  randconfig-017-20260124    clang-20
i386                  randconfig-017-20260125    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                           ci20_defconfig    clang-22
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-22
mips                       rbtx49xx_defconfig    clang-22
mips                           rs90_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260124    gcc-15.2.0
nios2                 randconfig-002-20260124    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-001-20260125    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-8.5.0
parisc                randconfig-002-20260125    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        cell_defconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    clang-22
powerpc                 mpc8313_rdb_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20260124    gcc-8.5.0
powerpc               randconfig-001-20260125    gcc-8.5.0
powerpc               randconfig-002-20260124    gcc-8.5.0
powerpc               randconfig-002-20260125    gcc-8.5.0
powerpc                     skiroot_defconfig    gcc-15.2.0
powerpc                     taishan_defconfig    clang-22
powerpc64             randconfig-001-20260124    gcc-8.5.0
powerpc64             randconfig-001-20260125    gcc-8.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
powerpc64             randconfig-002-20260125    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-001-20260125    clang-22
riscv                 randconfig-002-20260124    gcc-8.5.0
riscv                 randconfig-002-20260125    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-001-20260125    clang-22
s390                  randconfig-002-20260124    gcc-8.5.0
s390                  randconfig-002-20260125    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-001-20260125    clang-22
sh                    randconfig-002-20260124    gcc-8.5.0
sh                    randconfig-002-20260125    clang-22
sh                           se7751_defconfig    clang-22
sh                   sh7724_generic_defconfig    clang-22
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-002-20260124    clang-20
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-006-20260124    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-076-20260124    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
