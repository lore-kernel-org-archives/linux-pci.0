Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86627057D
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017290; cv=none; b=niNwgt5I5gdNBguJACKLB8YEMZcx4rvB7dTiOsIKVsGnaYfKH0fwOVGAzcRTpdwwITnCFGAcXs3k1psnDGD1/G+99+N2yMyAQHndaRR5QsO48E7lotlZTtgoDlqUQOE9pxcQ1na4gdxzZTxDQt7thYzK/3KmpGb/uS1ThNYLnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017290; c=relaxed/simple;
	bh=5Z5xFhV+J0ae+7wzDw6SmGDfbABj4e3xPRTdWFPB+hM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gvupEhjWMZE6At4ah2vSanU45WhzigZe0WozTjOAzv8Zzd/7fAG0t2POjG5qolUXSEtMid6jv2nKSU6t3uDrE6PSgnhuAHkofKHo7qdK3erl2la9rwVvuBVeSxcDay66HwsPUm7SEnQh7mldvH6DBrFXBTinmxpBZhXDCbWHV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVHsrcq3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVHsrcq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771017288; x=1802553288;
  h=date:from:to:cc:subject:message-id;
  bh=5Z5xFhV+J0ae+7wzDw6SmGDfbABj4e3xPRTdWFPB+hM=;
  b=bVHsrcq3/mUoekE9/wpMGNeZBt10Pe0drnw5JZt/HMb1mT77okjOMnZH
   FV0pYrr4iMhnoGKAsw9V4wkaA0+fq2NG/ZrpLmyp7c5XgcfxZgKSdhLbf
   nVophOTWBgqo1gMvL4Jlp3hmHVBob8KjzWysWH9A/Ra5D5lE5MZLTxhdT
   QvKdvlGgTUPgyIDUmuUhxmyNMe0ImmvT52GiQrEw5mGXmEF/YEwTZgNcy
   r+lBwkDca3X1uiZL8gb7KVv4Jw4ojcO+YCg+DcOwY1qB6+En4wDVRORo8
   yEpy/E8jnDw+zkLbK21BLerKhU2X+QA9lltwAKjasuwsyiazM2u6F/WB/
   g==;
X-CSE-ConnectionGUID: hniilZssRtaBVIsc1V1OIw==
X-CSE-MsgGUID: RXrq5sblRJefNMUL+4xXDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76052330"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="76052330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:14:48 -0800
X-CSE-ConnectionGUID: 9Ny4rff9Sq2aMAlYb6+adQ==
X-CSE-MsgGUID: O+XsCeOwTU6RwYahXXWHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="213130010"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2026 13:14:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vr0Ut-00000000vpk-3CNv;
	Fri, 13 Feb 2026 21:14:43 +0000
Date: Sat, 14 Feb 2026 05:14:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:msi] BUILD SUCCESS
 a648eed65a7b683a1198692bf53c8faa6fdf20cd
Message-ID: <202602140558.IxB8DmFf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git msi
branch HEAD: a648eed65a7b683a1198692bf53c8faa6fdf20cd  PCI/MSI: Add TODO comment about legacy pcim_enable_device() side-effect

elapsed time: 1408m

configs tested: 265
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-22
arc                   randconfig-001-20260213    clang-22
arc                   randconfig-002-20260213    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    clang-22
arm                         axm55xx_defconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                     davinci_all_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                      integrator_defconfig    clang-22
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20260213    clang-22
arm                   randconfig-002-20260213    clang-22
arm                   randconfig-003-20260213    clang-22
arm                   randconfig-004-20260213    clang-22
arm                             rpc_defconfig    clang-22
arm                         s3c6400_defconfig    clang-22
arm                         socfpga_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260213    clang-20
arm64                 randconfig-001-20260214    gcc-8.5.0
arm64                 randconfig-002-20260213    clang-20
arm64                 randconfig-002-20260214    gcc-8.5.0
arm64                 randconfig-003-20260213    clang-20
arm64                 randconfig-003-20260214    gcc-8.5.0
arm64                 randconfig-004-20260213    clang-20
arm64                 randconfig-004-20260214    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260213    clang-20
csky                  randconfig-001-20260214    gcc-8.5.0
csky                  randconfig-002-20260213    clang-20
csky                  randconfig-002-20260214    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260213    clang-22
hexagon               randconfig-002-20260213    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260213    clang-20
i386        buildonly-randconfig-001-20260214    clang-20
i386        buildonly-randconfig-002-20260213    clang-20
i386        buildonly-randconfig-002-20260214    clang-20
i386        buildonly-randconfig-003-20260213    clang-20
i386        buildonly-randconfig-003-20260214    clang-20
i386        buildonly-randconfig-004-20260213    clang-20
i386        buildonly-randconfig-004-20260214    clang-20
i386        buildonly-randconfig-005-20260213    clang-20
i386        buildonly-randconfig-005-20260214    clang-20
i386        buildonly-randconfig-006-20260213    clang-20
i386        buildonly-randconfig-006-20260214    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260213    gcc-14
i386                  randconfig-002-20260213    gcc-14
i386                  randconfig-003-20260213    gcc-14
i386                  randconfig-004-20260213    gcc-14
i386                  randconfig-005-20260213    gcc-14
i386                  randconfig-006-20260213    gcc-14
i386                  randconfig-007-20260213    gcc-14
i386                  randconfig-011-20260213    gcc-14
i386                  randconfig-012-20260213    gcc-14
i386                  randconfig-013-20260213    gcc-14
i386                  randconfig-014-20260213    gcc-14
i386                  randconfig-015-20260213    gcc-14
i386                  randconfig-016-20260213    gcc-14
i386                  randconfig-017-20260213    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260213    clang-22
loongarch             randconfig-002-20260213    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.2.0
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
mips                           ip27_defconfig    clang-22
mips                           ip30_defconfig    clang-22
mips                     loongson2k_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-22
nios2                         3c120_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260213    clang-22
nios2                 randconfig-002-20260213    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260213    clang-20
parisc                randconfig-001-20260214    clang-22
parisc                randconfig-002-20260213    clang-20
parisc                randconfig-002-20260214    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-22
powerpc                      chrp32_defconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                       ebony_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc                     mpc5200_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-22
powerpc                      pcm030_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260213    clang-20
powerpc               randconfig-001-20260214    clang-22
powerpc               randconfig-002-20260213    clang-20
powerpc               randconfig-002-20260214    clang-22
powerpc                     taishan_defconfig    clang-22
powerpc                        warp_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260213    clang-20
powerpc64             randconfig-001-20260214    clang-22
powerpc64             randconfig-002-20260213    clang-20
powerpc64             randconfig-002-20260214    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260213    gcc-11.5.0
riscv                 randconfig-001-20260214    clang-20
riscv                 randconfig-002-20260213    gcc-11.5.0
riscv                 randconfig-002-20260214    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260213    gcc-11.5.0
s390                  randconfig-001-20260214    clang-20
s390                  randconfig-002-20260213    gcc-11.5.0
s390                  randconfig-002-20260214    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                         ap325rxa_defconfig    clang-22
sh                        apsh4ad0a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                               j2_defconfig    clang-22
sh                    randconfig-001-20260213    gcc-11.5.0
sh                    randconfig-001-20260214    clang-20
sh                    randconfig-002-20260213    gcc-11.5.0
sh                    randconfig-002-20260214    clang-20
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7750_defconfig    clang-22
sh                           se7750_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260213    gcc-12.5.0
sparc                 randconfig-002-20260213    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260213    gcc-12.5.0
sparc64               randconfig-002-20260213    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260213    gcc-12.5.0
um                    randconfig-002-20260213    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260213    gcc-14
x86_64      buildonly-randconfig-002-20260213    gcc-14
x86_64      buildonly-randconfig-003-20260213    gcc-14
x86_64      buildonly-randconfig-004-20260213    gcc-14
x86_64      buildonly-randconfig-005-20260213    gcc-14
x86_64      buildonly-randconfig-006-20260213    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260213    gcc-14
x86_64                randconfig-001-20260214    clang-20
x86_64                randconfig-002-20260213    gcc-14
x86_64                randconfig-002-20260214    clang-20
x86_64                randconfig-003-20260213    gcc-14
x86_64                randconfig-003-20260214    clang-20
x86_64                randconfig-004-20260213    gcc-14
x86_64                randconfig-004-20260214    clang-20
x86_64                randconfig-005-20260213    gcc-14
x86_64                randconfig-005-20260214    clang-20
x86_64                randconfig-006-20260213    gcc-14
x86_64                randconfig-006-20260214    clang-20
x86_64                randconfig-011-20260213    gcc-12
x86_64                randconfig-011-20260214    gcc-14
x86_64                randconfig-012-20260213    gcc-12
x86_64                randconfig-012-20260214    gcc-14
x86_64                randconfig-013-20260213    gcc-12
x86_64                randconfig-013-20260214    gcc-14
x86_64                randconfig-014-20260213    gcc-12
x86_64                randconfig-014-20260214    gcc-14
x86_64                randconfig-015-20260213    gcc-12
x86_64                randconfig-015-20260214    gcc-14
x86_64                randconfig-016-20260213    gcc-12
x86_64                randconfig-016-20260214    gcc-14
x86_64                randconfig-071-20260213    clang-20
x86_64                randconfig-072-20260213    clang-20
x86_64                randconfig-073-20260213    clang-20
x86_64                randconfig-074-20260213    clang-20
x86_64                randconfig-075-20260213    clang-20
x86_64                randconfig-076-20260213    clang-20
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
xtensa                  audio_kc705_defconfig    clang-22
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260213    gcc-12.5.0
xtensa                randconfig-002-20260213    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
