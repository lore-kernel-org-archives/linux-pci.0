Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794139367;
	b=AButAF+H63+/YzUearBxUetvCB4UMIR+bN8JLsifzQDrJVwDtRGtIJCQpc6vfn5XmJV5
	 k3hjyF1ZgaPPLChDntFxIdZvQU3qYfzKVZ/SV4VrFpIJjGspz8em2u3Zp+/dTE5e5GNzV
	 jbJ6ZWSecPZs/VcSI33HRG33YUlYouoaH6Soun+byER/D1/qVdtBRJUjusvVNI2sofYRm
	 V+mcfUyqDV3+b8i7i1ravrhadeAfWcairlG+eEHiveVFlLDc4wAx22STJNnvdYawSzQxP
	 u0iEvwk4b74OwMWHxG1ZkT08qWOhq2OrDlPDUMVV3S2n7abfArwtgldzF4E8jQFlb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139367;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=BgSdnmK4E8mmw/sBGyRk3uvszVV4s74Faip3HBMHCpE=;
	b=pcuMr9vpg4yWRkm2W+w1nurR+Ibp6ydIHFGHN/bRx9Cad250V4xy4ycngxMNIWMvXDaL
	 zKSN7xxI0mM1WdNkhhwfiX48JgoQCtlpuOrmJLS+6lGezxuTvMm4mNNonhvKcuLr6Bel4
	 MFIw7mpr4T9xrO6EnOfrjXBSh1HnR1j1ewR5/B4qqdADT2gjuLudT0SsZ2n7n/e/Zy03T
	 0a5TfhEJkIJHBfTh9hAYbfxNKcU7gcAOaDEDIW7W1ZJg3IgBLSaMOd5goqAU+Dnntzb/g
	 WxNmJWc8mNieuTuYppEQN2sMAj4d8sf9CVywjPvqZ23oWdi2FfJlEf4uAAA3qBgKuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QdHo90hg;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DC606A321
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 12:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 812DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QdHo90hg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794139365; x=1825675365;
  h=date:from:to:cc:subject:message-id;
  bh=1BOyST3jdk2Nm4UL7BTrru+Khuxq6a/c6O5A4WH7mc4=;
  b=QdHo90hg4nm/gLAp3dIZM5l4u3+nOPMV6jLL0zwd3binPIVse70+ugW0
   iwkGPrt6h7lo8lhrYwC661ZOz1sBv+gD9Bcs4/Hs2f2V0cfD6KFJuXZtA
   pWln5uHy14w3/IzL0ymDLarkVENQjdLrKTEeEi78uOtUlT+zxkT6FYDl8
   OXCMpuTwmhLXumwsr2ihH/P6QEckDxrK+n8Y8qoLTDlge3F8XmaBXZHMV
   +DLviOK1JuQENNjypmXts+9N//bOZ3HdWlIJ0csDT1gcshM72eIS6j2wj
   qwSHYtClT0Qm8Z8GTVgXPwXES7mAWsvNzzd+CosOX/lm2rBXXE8/qWvLn
   w==;
X-CSE-ConnectionGUID: MtFgjyDXSiaouuRtcHKJnw==
X-CSE-MsgGUID: Zz/huyHfQwSaFKc1rxLxiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2902736"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2902736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 04:02:43 -0800
X-CSE-ConnectionGUID: LqK9MUuhQC61XFywS7COgw==
X-CSE-MsgGUID: LU/4LsJ2S9GIx45XvkrGSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7792554"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2026 04:02:43 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQ1bb-00000000stl-4B2J;
	Sun, 08 Nov 2026 12:02:39 +0000
Date: Sun, 08 Nov 2026 20:01:50 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:iproc] BUILD SUCCESS
 a15ebdfe1d4dc698dc5854fc6a8cd359848b7285
Message-ID: <20261108200150.Io3LwT8m-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/iproc
branch HEAD: a15ebdfe1d4dc698dc5854fc6a8cd359848b7285  PCI: iproc-msi: Rework the MSI handler to not hog the CPU

elapsed time: 838m

configs tested: 192
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261108    gcc-11.5.0
arc                   randconfig-1001-20261108    gcc-11.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    gcc-16.2.0
arm                           ep93xx_defconfig    clang-24
arm                         multi_v7_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261108    gcc-11.5.0
arm                   randconfig-1001-20261108    gcc-11.5.0
arm                   randconfig-1002-20261108    gcc-11.5.0
arm                   randconfig-1003-20261108    gcc-11.5.0
arm                         realview_defconfig    clang-19
arm                            stm32_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                       quartz64_defconfig    clang-24
arm64                       quartz64_defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261108    clang-24
arm64                 randconfig-1001-20261108    clang-24
arm64                 randconfig-1002-20261108    clang-24
arm64                 randconfig-1003-20261108    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261108    clang-24
csky                  randconfig-1001-20261108    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261108    gcc-16.2.0
hexagon               randconfig-1001-20261108    gcc-16.2.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261108    clang-22
i386        buildonly-randconfig-1001-20261108    clang-22
i386        buildonly-randconfig-1002-20261108    clang-22
i386        buildonly-randconfig-1003-20261108    clang-22
i386        buildonly-randconfig-1004-20261108    clang-22
i386        buildonly-randconfig-1005-20261108    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261108    gcc-14
i386                  randconfig-1001-20261108    gcc-14
i386                  randconfig-1002-20261108    gcc-14
i386                  randconfig-1003-20261108    gcc-14
i386                  randconfig-1004-20261108    gcc-14
i386                  randconfig-1005-20261108    gcc-14
i386                  randconfig-1006-20261108    gcc-14
i386                  randconfig-1007-20261108    clang-22
i386                  randconfig-1008-20261108    clang-22
i386                  randconfig-1009-20261108    clang-22
i386                  randconfig-1010-20261108    clang-22
i386                  randconfig-1011-20261108    clang-22
i386                  randconfig-1012-20261108    clang-22
i386                  randconfig-1013-20261108    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261108    gcc-16.2.0
loongarch             randconfig-1001-20261108    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           sun3x_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            gcw0_defconfig    clang-19
mips                         qi_lb60_defconfig    gcc-16.2.0
mips                            xway_defconfig    clang-19
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261108    gcc-16.2.0
nios2                 randconfig-1001-20261108    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-32bit_defconfig    clang-24
parisc                randconfig-1000-20261108    clang-24
parisc                randconfig-1001-20261108    clang-24
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.2.0
powerpc                      akebono_defconfig    clang-19
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261108    clang-24
powerpc               randconfig-1001-20261108    clang-24
powerpc                      taishan_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    gcc-16.2.0
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261108    clang-24
powerpc64             randconfig-1001-20261108    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                         apsh4ad0a_defconfig    clang-19
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                           r7785rp_defconfig    clang-19
sh                           rsk7269_defconfig    clang-24
sh                            se7750_defconfig    clang-24
sh                         sh7763rdp_defconfig    clang-19
sh                             shmin_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261108    gcc-8.5.0
sparc                 randconfig-1001-20261108    gcc-8.5.0
sparc                        sparc32_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261108    gcc-8.5.0
sparc64               randconfig-1001-20261108    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261108    gcc-8.5.0
um                    randconfig-1001-20261108    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261108    gcc-14
x86_64      buildonly-randconfig-1001-20261108    gcc-14
x86_64      buildonly-randconfig-1002-20261108    gcc-14
x86_64      buildonly-randconfig-1003-20261108    gcc-14
x86_64      buildonly-randconfig-1004-20261108    gcc-14
x86_64      buildonly-randconfig-1005-20261108    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261108    gcc-14
x86_64                randconfig-1001-20261108    gcc-14
x86_64                randconfig-1002-20261108    gcc-14
x86_64                randconfig-1003-20261108    gcc-14
x86_64                randconfig-1004-20261108    gcc-14
x86_64                randconfig-1005-20261108    gcc-14
x86_64                randconfig-1006-20261108    clang-22
x86_64                randconfig-1007-20261108    clang-22
x86_64                randconfig-1008-20261108    clang-22
x86_64                randconfig-1009-20261108    clang-22
x86_64                randconfig-1010-20261108    clang-22
x86_64                randconfig-1011-20261108    clang-22
x86_64                randconfig-1012-20261108    clang-22
x86_64                randconfig-1013-20261108    clang-22
x86_64                randconfig-1014-20261108    clang-22
x86_64                randconfig-1015-20261108    clang-22
x86_64                randconfig-1016-20261108    clang-22
x86_64                randconfig-1017-20261108    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261108    gcc-8.5.0
xtensa                randconfig-1001-20261108    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
