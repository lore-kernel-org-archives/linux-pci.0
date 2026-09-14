Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1337187F
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408108; cv=none; b=jB2eX79b39VFek5rlaxn8p2pSPyvMNvObv1Qso6HYRCMnWRDe0wZvY6frd0nohRbLV0FCkQibxHKgnSW6CC1AJiiDTYEq1dzFMQYW97PINA70cA3NtNd13jglJVr+81/mJ6Itu+O9FF27RkqQRdgE5QiLl+VRbywPk/+GUFlVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408108; c=relaxed/simple;
	bh=nJJ+dcpl6dnM65ZN+hfJtDg3oWnKMlCyQigzBNSWJOg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=efxrDHiiUz9E9duJrTzcDh4bqBBxRYGSAXVSI1nUPvYTkKAzndbmSioX7OnSqDeApNNAMUDkg4S5h0+tlj8r1cFFG5aXN3wuse6o+ynWtspOotXkK2Mp/uqKi4WzvN75JElrV7jgv8u1zJtYYQwTmC/1Zp8Ele4iBnI6jvXt0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUYnyRoG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUYnyRoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789408107; x=1820944107;
  h=date:from:to:cc:subject:message-id;
  bh=nJJ+dcpl6dnM65ZN+hfJtDg3oWnKMlCyQigzBNSWJOg=;
  b=lUYnyRoGs1rUkYXM1DFerQCuj2PVZNXNee4fOG4gZrwvGiRZFV4fuU16
   eyxMgxObSx1ZAy615eA46vtWPKdO7i8lSVIMZrJejf2AV+RtUGZSFGpGp
   0IoS+n+wzDlfi/8XtQhpFyWvPVgcStTKfschJx9zOMM3/GowAhglUXEsH
   8tQgIkEeP/PhbQfQzApcU5RploFd3S3CITE8ejyQ8MZ9c74JNN5mmQbNq
   vnY/A5cI8AE5qGkNwRBBpjOssbf6CfpkeLu0NB3xXSWMd728KU8VB8Hs6
   fuN7PLYO2HTw2vkewza3PXkzob3zAZm0skTOEsyxc/jmTnTquFQxIVaXR
   Q==;
X-CSE-ConnectionGUID: j+IxsAAlTLeT2VOHi8kZlA==
X-CSE-MsgGUID: efvSwO4jTYG/pVJfbxxWZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89894983"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89894983"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 10:48:26 -0700
X-CSE-ConnectionGUID: mp8DLnXCTXSXd0TnkDptww==
X-CSE-MsgGUID: cBKiuzwoRG6lcWyBYFB9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269024801"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Sep 2026 10:48:25 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6An0-000000003GP-1ycs;
	Mon, 14 Sep 2026 17:48:22 +0000
Date: Tue, 15 Sep 2026 01:47:40 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 2ce4ced05cd7b16f3d3430eac021d6184752175f
Message-ID: <202609150137.Hz4gdbIW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: 2ce4ced05cd7b16f3d3430eac021d6184752175f  PCI/P2PDMA: Gate the host bridge whitelist warning on verbose

elapsed time: 2609m

configs tested: 486
configs skipped: 51

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                randconfig-r121-20260914    gcc-12.5.0 sparse
alpha                randconfig-r123-20260914    gcc-8.5.0 sparse
alpha                randconfig-r132-20260914    gcc-12.5.0 sparse
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                              allyesconfig    clang-24
arc                          axs103_defconfig    clang-17
arc                                 defconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                         haps_hs_defconfig    clang-24
arc                     haps_hs_smp_defconfig    gcc-16.1.0
arc                            hsdk_defconfig    gcc-16.1.0
arc                        nsim_700_defconfig    clang-17
arc                     nsimosci_hs_defconfig    gcc-16.1.0
arc                   randconfig-001-20260913    gcc-10.5.0
arc                   randconfig-001-20260914    gcc-13.4.0
arc                   randconfig-002-20260913    gcc-10.5.0
arc                   randconfig-002-20260914    gcc-13.4.0
arc                  randconfig-r113-20260914    gcc-8.5.0 sparse
arc                  randconfig-r121-20260914    gcc-8.5.0 sparse
arc                  randconfig-r123-20260914    clang-17 sparse
arc                  randconfig-r132-20260914    gcc-14 sparse
arc                  randconfig-r132-20260914    gcc-8.5.0 sparse
arc                           tb10x_defconfig    clang-17
arc                        vdk_hs38_defconfig    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          exynos_defconfig    gcc-16.1.0
arm                      footbridge_defconfig    gcc-16.1.0
arm                          gemini_defconfig    gcc-16.1.0
arm                            hisi_defconfig    gcc-16.1.0
arm                       imx_v6_v7_defconfig    clang-24
arm                           imxrt_defconfig    gcc-16.1.0
arm                        keystone_defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    gcc-16.1.0
arm                        mvebu_v7_defconfig    clang-17
arm                           omap1_defconfig    gcc-16.1.0
arm                       omap2plus_defconfig    clang-17
arm                         orion5x_defconfig    clang-24
arm                             pxa_defconfig    gcc-16.1.0
arm                   randconfig-001-20260913    gcc-10.5.0
arm                   randconfig-001-20260914    gcc-13.4.0
arm                   randconfig-002-20260913    gcc-10.5.0
arm                   randconfig-002-20260914    gcc-13.4.0
arm                   randconfig-003-20260913    gcc-10.5.0
arm                   randconfig-003-20260914    gcc-13.4.0
arm                   randconfig-004-20260913    gcc-10.5.0
arm                   randconfig-004-20260914    gcc-13.4.0
arm                  randconfig-r112-20260914    gcc-8.5.0 sparse
arm                  randconfig-r113-20260914    gcc-11.5.0 sparse
arm                  randconfig-r122-20260914    clang-17 sparse
arm                  randconfig-r133-20260914    gcc-8.5.0 sparse
arm                  randconfig-r134-20260914    clang-22 sparse
arm                  randconfig-r134-20260914    gcc-8.5.0 sparse
arm                         socfpga_defconfig    gcc-16.1.0
arm                         socfpga_defconfig    gcc-16.1.0
arm                    vt8500_v6_v7_defconfig    gcc-14
arm                    vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-24
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260913    gcc-16.1.0
arm64                 randconfig-001-20260914    gcc-9.5.0
arm64                 randconfig-002-20260913    gcc-16.1.0
arm64                 randconfig-002-20260914    gcc-9.5.0
arm64                 randconfig-003-20260913    gcc-16.1.0
arm64                 randconfig-003-20260914    gcc-9.5.0
arm64                 randconfig-004-20260913    gcc-16.1.0
arm64                 randconfig-004-20260914    gcc-9.5.0
arm64                randconfig-r112-20260914    gcc-8.5.0 sparse
arm64                randconfig-r113-20260914    clang-24 sparse
arm64                randconfig-r121-20260914    gcc-11.5.0 sparse
arm64                randconfig-r122-20260914    clang-24 sparse
arm64                randconfig-r122-20260914    gcc-8.5.0 sparse
arm64                randconfig-r131-20260914    gcc-15.2.0 sparse
arm64                randconfig-r131-20260914    gcc-16.1.0 sparse
arm64                randconfig-r132-20260914    gcc-14 sparse
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260913    gcc-16.1.0
csky                  randconfig-001-20260914    gcc-9.5.0
csky                  randconfig-002-20260913    gcc-16.1.0
csky                  randconfig-002-20260914    gcc-9.5.0
csky                 randconfig-r111-20260914    gcc-8.5.0 sparse
csky                 randconfig-r121-20260914    clang-24 sparse
csky                 randconfig-r122-20260914    gcc-12.5.0 sparse
csky                 randconfig-r123-20260914    gcc-8.5.0 sparse
csky                 randconfig-r131-20260914    gcc-13.4.0 sparse
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260913    clang-24
hexagon               randconfig-001-20260914    gcc-13.4.0
hexagon               randconfig-002-20260913    clang-24
hexagon               randconfig-002-20260914    gcc-13.4.0
hexagon              randconfig-r112-20260914    clang-24 sparse
hexagon              randconfig-r131-20260914    gcc-14 sparse
hexagon              randconfig-r133-20260914    gcc-12.5.0 sparse
hexagon              randconfig-r134-20260914    gcc-14 sparse
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260914    gcc-14
i386        buildonly-randconfig-002-20260914    gcc-14
i386        buildonly-randconfig-003-20260914    gcc-14
i386        buildonly-randconfig-004-20260914    gcc-14
i386        buildonly-randconfig-005-20260914    gcc-14
i386        buildonly-randconfig-006-20260914    gcc-14
i386                                defconfig    gcc-16.1.0
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260914    clang-22
i386                  randconfig-002-20260914    clang-22
i386                  randconfig-003-20260914    clang-22
i386                  randconfig-004-20260914    clang-22
i386                  randconfig-005-20260914    clang-22
i386                  randconfig-006-20260914    clang-22
i386                  randconfig-007-20260914    clang-22
i386                  randconfig-011-20260913    gcc-14
i386                  randconfig-011-20260914    clang-22
i386                  randconfig-012-20260913    gcc-14
i386                  randconfig-012-20260914    clang-22
i386                  randconfig-013-20260913    gcc-14
i386                  randconfig-013-20260914    clang-22
i386                  randconfig-014-20260913    gcc-14
i386                  randconfig-014-20260914    clang-22
i386                  randconfig-015-20260913    gcc-14
i386                  randconfig-015-20260914    clang-22
i386                  randconfig-016-20260913    gcc-14
i386                  randconfig-016-20260914    clang-22
i386                  randconfig-017-20260913    gcc-14
i386                  randconfig-017-20260914    clang-22
i386                  randconfig-061-20260914    gcc-14 sparse
i386                  randconfig-062-20260914    gcc-14 sparse
i386                  randconfig-063-20260914    gcc-14 sparse
i386                 randconfig-r111-20260914    clang-17 sparse
i386                 randconfig-r132-20260914    gcc-13.4.0 sparse
i386                 randconfig-r134-20260914    clang-22 sparse
i386                 randconfig-r134-20260914    gcc-14 sparse
loongarch                        allmodconfig    clang-24
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch                           defconfig    clang-24
loongarch                loongson64_defconfig    clang-24
loongarch             randconfig-001-20260913    clang-24
loongarch             randconfig-001-20260914    gcc-13.4.0
loongarch             randconfig-002-20260913    clang-24
loongarch             randconfig-002-20260914    gcc-13.4.0
loongarch            randconfig-r111-20260914    gcc-11.5.0 sparse
loongarch            randconfig-r113-20260914    clang-17 sparse
loongarch            randconfig-r131-20260914    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                             allyesconfig    clang-24
m68k                          amiga_defconfig    gcc-16.1.0
m68k                                defconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5235evb_defconfig    clang-17
m68k                       m5249evb_defconfig    gcc-16.1.0
m68k                       m5282evb_defconfig    gcc-16.1.0
m68k                        m5407c3_defconfig    clang-17
m68k                      m54418evb_defconfig    gcc-16.1.0
m68k                        mvme16x_defconfig    gcc-14
m68k                        mvme16x_defconfig    gcc-16.1.0
m68k                 randconfig-r111-20260914    gcc-12.5.0 sparse
m68k                 randconfig-r113-20260914    gcc-12.5.0 sparse
microblaze                        allnoconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze                          defconfig    clang-24
microblaze           randconfig-r123-20260914    gcc-12.5.0 sparse
mips                             allmodconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        bcm47xx_defconfig    clang-24
mips                         bigsur_defconfig    clang-17
mips                       bmips_be_defconfig    gcc-16.1.0
mips                      bmips_stb_defconfig    clang-17
mips                         cobalt_defconfig    gcc-16.1.0
mips                         db1xxx_defconfig    gcc-16.1.0
mips                  decstation_64_defconfig    gcc-16.1.0
mips                 decstation_r4k_defconfig    gcc-16.1.0
mips                           ip22_defconfig    gcc-16.1.0
mips                           ip32_defconfig    clang-24
mips                           ip32_defconfig    gcc-14
mips                        omega2p_defconfig    gcc-16.1.0
mips                 randconfig-r132-20260914    gcc-16.1.0 sparse
mips                 randconfig-r133-20260914    clang-22 sparse
mips                 randconfig-r134-20260914    gcc-13.4.0 sparse
mips                         rt305x_defconfig    clang-17
mips                         rt305x_defconfig    clang-24
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-16.1.0
nios2                               defconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260913    clang-24
nios2                 randconfig-001-20260914    gcc-13.4.0
nios2                 randconfig-001-20260914    gcc-8.5.0
nios2                 randconfig-002-20260913    clang-24
nios2                 randconfig-002-20260914    gcc-13.4.0
nios2                 randconfig-002-20260914    gcc-8.5.0
nios2                randconfig-r131-20260914    gcc-8.5.0 sparse
nios2                randconfig-r133-20260914    clang-22 sparse
nios2                randconfig-r133-20260914    gcc-14 sparse
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                   de0_nano_defconfig    clang-24
openrisc                   de0_nano_defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r112-20260914    gcc-12.5.0 sparse
openrisc             randconfig-r121-20260914    clang-17 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-001-20260913    gcc-8.5.0
parisc                randconfig-001-20260914    gcc-8.5.0
parisc                randconfig-002-20260913    gcc-8.5.0
parisc                randconfig-002-20260914    gcc-8.5.0
parisc               randconfig-r133-20260914    gcc-13.4.0 sparse
parisc64                            defconfig    clang-24
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      arches_defconfig    gcc-16.1.0
powerpc                     ep8248e_defconfig    clang-24
powerpc                        fsp2_defconfig    gcc-16.1.0
powerpc                    ge_imp3a_defconfig    gcc-14
powerpc                    ge_imp3a_defconfig    gcc-16.1.0
powerpc                     kmeter1_defconfig    gcc-16.1.0
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                   motionpro_defconfig    clang-17
powerpc                     mpc83xx_defconfig    gcc-16.1.0
powerpc                  mpc866_ads_defconfig    clang-17
powerpc                  mpc866_ads_defconfig    clang-24
powerpc                      pasemi_defconfig    clang-24
powerpc                     powernv_defconfig    gcc-16.1.0
powerpc                         ps3_defconfig    clang-17
powerpc                         ps3_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260913    gcc-8.5.0
powerpc               randconfig-001-20260914    gcc-8.5.0
powerpc               randconfig-002-20260913    gcc-8.5.0
powerpc               randconfig-002-20260914    gcc-8.5.0
powerpc              randconfig-r111-20260914    clang-24 sparse
powerpc              randconfig-r122-20260914    gcc-8.5.0 sparse
powerpc              randconfig-r134-20260914    gcc-16.1.0 sparse
powerpc                    socrates_defconfig    clang-24
powerpc                 xes_mpc85xx_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260913    gcc-8.5.0
powerpc64             randconfig-001-20260914    gcc-8.5.0
powerpc64             randconfig-002-20260913    gcc-8.5.0
powerpc64             randconfig-002-20260914    gcc-8.5.0
powerpc64            randconfig-r133-20260914    gcc-8.5.0 sparse
riscv                            allmodconfig    clang-24
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                               defconfig    gcc-16.1.0
riscv                    nommu_virt_defconfig    clang-24
riscv                    nommu_virt_defconfig    gcc-16.1.0
riscv                    nommu_virt_defconfig    gcc-16.1.0
riscv                 randconfig-001-20260913    gcc-14.3.0
riscv                 randconfig-001-20260914    gcc-13.4.0
riscv                 randconfig-002-20260913    gcc-14.3.0
riscv                 randconfig-002-20260914    gcc-13.4.0
riscv                randconfig-r113-20260914    gcc-8.5.0 sparse
riscv                randconfig-r132-20260914    gcc-8.5.0 sparse
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260913    gcc-14.3.0
s390                  randconfig-001-20260914    gcc-13.4.0
s390                  randconfig-002-20260913    gcc-14.3.0
s390                  randconfig-002-20260914    gcc-13.4.0
s390                 randconfig-r122-20260914    gcc-11.5.0 sparse
s390                 randconfig-r131-20260914    gcc-14 sparse
s390                       zfcpdump_defconfig    gcc-16.1.0
sh                               alldefconfig    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                         ap325rxa_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-16.1.0
sh                             espt_defconfig    gcc-16.1.0
sh                               j2_defconfig    gcc-16.1.0
sh                               j2_defconfig    gcc-16.1.0
sh                 kfr2r09-romimage_defconfig    gcc-16.1.0
sh                          kfr2r09_defconfig    clang-17
sh                          r7780mp_defconfig    clang-24
sh                    randconfig-001-20260913    gcc-14.3.0
sh                    randconfig-001-20260914    gcc-13.4.0
sh                    randconfig-002-20260913    gcc-14.3.0
sh                    randconfig-002-20260914    gcc-13.4.0
sh                   randconfig-r123-20260914    clang-24 sparse
sh                          rsk7264_defconfig    gcc-16.1.0
sh                          rsk7269_defconfig    gcc-16.1.0
sh                      rts7751r2d1_defconfig    gcc-16.1.0
sh                           se7705_defconfig    gcc-14
sh                            shmin_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260913    gcc-15.2.0
sparc                 randconfig-001-20260914    gcc-16.1.0
sparc                 randconfig-002-20260913    gcc-15.2.0
sparc                 randconfig-002-20260914    gcc-16.1.0
sparc                randconfig-r112-20260914    clang-17 sparse
sparc                randconfig-r123-20260914    gcc-11.5.0 sparse
sparc                randconfig-r131-20260914    clang-22 sparse
sparc                randconfig-r132-20260914    gcc-14 sparse
sparc                randconfig-r133-20260914    gcc-15.2.0 sparse
sparc64                          alldefconfig    clang-17
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260913    gcc-15.2.0
sparc64               randconfig-001-20260914    gcc-16.1.0
sparc64               randconfig-002-20260913    gcc-15.2.0
sparc64               randconfig-002-20260914    gcc-16.1.0
sparc64              randconfig-r112-20260914    gcc-11.5.0 sparse
sparc64              randconfig-r121-20260914    gcc-8.5.0 sparse
sparc64              randconfig-r131-20260914    clang-22 sparse
sparc64              randconfig-r134-20260914    gcc-12.5.0 sparse
sparc64              randconfig-r134-20260914    gcc-8.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-16.1.0
um                    randconfig-001-20260913    gcc-15.2.0
um                    randconfig-001-20260914    gcc-16.1.0
um                    randconfig-002-20260913    gcc-15.2.0
um                    randconfig-002-20260914    gcc-16.1.0
um                   randconfig-r111-20260914    gcc-8.5.0 sparse
um                   randconfig-r133-20260914    gcc-14 sparse
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-16.1.0
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                            allnoconfig    clang-24
x86_64                            allnoconfig    gcc-16.1.0
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260913    clang-22
x86_64      buildonly-randconfig-001-20260914    gcc-14
x86_64      buildonly-randconfig-002-20260913    clang-22
x86_64      buildonly-randconfig-002-20260914    gcc-14
x86_64      buildonly-randconfig-003-20260913    clang-22
x86_64      buildonly-randconfig-003-20260914    gcc-14
x86_64      buildonly-randconfig-004-20260913    clang-22
x86_64      buildonly-randconfig-004-20260914    gcc-14
x86_64      buildonly-randconfig-005-20260913    clang-22
x86_64      buildonly-randconfig-005-20260914    gcc-14
x86_64      buildonly-randconfig-006-20260913    clang-22
x86_64      buildonly-randconfig-006-20260914    gcc-14
x86_64                              defconfig    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260913    clang-22
x86_64                randconfig-001-20260914    gcc-14
x86_64                randconfig-002-20260913    clang-22
x86_64                randconfig-002-20260914    gcc-14
x86_64                randconfig-003-20260913    clang-22
x86_64                randconfig-003-20260914    gcc-14
x86_64                randconfig-004-20260913    clang-22
x86_64                randconfig-004-20260914    gcc-14
x86_64                randconfig-005-20260913    clang-22
x86_64                randconfig-005-20260914    gcc-14
x86_64                randconfig-006-20260913    clang-22
x86_64                randconfig-006-20260914    gcc-14
x86_64                randconfig-011-20260913    gcc-14
x86_64                randconfig-011-20260914    clang-22
x86_64                randconfig-012-20260913    gcc-14
x86_64                randconfig-012-20260914    clang-22
x86_64                randconfig-013-20260913    gcc-14
x86_64                randconfig-013-20260914    clang-22
x86_64                randconfig-014-20260913    gcc-14
x86_64                randconfig-014-20260914    clang-22
x86_64                randconfig-015-20260913    gcc-14
x86_64                randconfig-015-20260914    clang-22
x86_64                randconfig-016-20260913    gcc-14
x86_64                randconfig-016-20260914    clang-22
x86_64                randconfig-071-20260914    clang-22
x86_64                randconfig-072-20260914    clang-22
x86_64                randconfig-073-20260914    clang-22
x86_64                randconfig-074-20260914    clang-22
x86_64                randconfig-075-20260914    clang-22
x86_64                randconfig-076-20260914    clang-22
x86_64                randconfig-121-20260914    gcc-14 sparse
x86_64                randconfig-122-20260914    gcc-14 sparse
x86_64                randconfig-123-20260914    gcc-14 sparse
x86_64               randconfig-r132-20260914    clang-22 sparse
x86_64               randconfig-r133-20260914    gcc-14 sparse
x86_64               randconfig-r133-20260914    gcc-16.1.0 sparse
x86_64               randconfig-r134-20260914    gcc-15.2.0 sparse
x86_64                               rhel-9.4    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                          rhel-9.4-func    clang-22
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                           alldefconfig    clang-24
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                          iss_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260913    gcc-15.2.0
xtensa                randconfig-001-20260914    gcc-16.1.0
xtensa                randconfig-002-20260913    gcc-15.2.0
xtensa                randconfig-002-20260914    gcc-16.1.0
xtensa               randconfig-r131-20260914    gcc-14 sparse
xtensa               randconfig-r132-20260914    gcc-15.2.0 sparse
xtensa                         virt_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
