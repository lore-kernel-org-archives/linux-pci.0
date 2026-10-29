Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294647;
	b=mKyPpvkHYaxQJFvQ4aXZBpgp7YhxXoBpWgDrS6SDGz+bdgFgo/7PY5/5KsyDMli6BMs+
	 STDbRIRbTUU2OJ7HBh1vuZJ5rSvLuitH5vUFWLb75Y3J0KmEg9kGO3osKD7dktHC19ka6
	 5IAUNIzq1dl7YKihtjixBUoAYlaMcO9U1NsN0GkxjGlVQgfmzG/IASPrG2ypVoOc0oRZw
	 LUjtkA+z36seadbJY1cjYC02HeG95qbsZ4sCENQZ3lNWSGurgy1QmqZsfWOeL9dDk//yo
	 Czzy2Z9KLN6xILYJ85sTRyUce8YyW5dE0X6NyME9AFyzbgFip8RC2vT58ZXLR/7rnQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294647;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=juUoIwCKBYiM3kV48/iHOyPGIBr5U7vg/2PiOZITCP4=;
	b=Tq1+JaJ44sfEvk77CkPjoyBqh1O15HUZ4p4S3yGlqEdSh7oj8s4+hNeeZel0oFtQoddx
	 ZNt2xsucc8sU5GYzAReDaGuXQCW+dth+Pqd3PB+hvA6agCUiPp2dDzn3dWt9BnOtir36Q
	 PilLiOVFvQ8DtMzeh16+Uy+X3kCM2S/gpKmnGCVKbpols2scN8KNdOZnNpNyryfhAkKJ4
	 5fRpuAa7gG1vSAdimdNzCzfP3q+M9GIcr5LCVYzwiogqbjBy9/5YTwzWZy4Bv1I2I0Jti
	 A059v3NOdoft+riMu7xCaz83Ii/NF7GlIoIXaBj98HNPxcMi8OqUnsu3T7TdlVzzdrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iXL0QoMq;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95447606A323
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95447606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iXL0QoMq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793294646; x=1824830646;
  h=date:from:to:cc:subject:message-id;
  bh=KJ1pvR6r8CEJiKcaZL5WaRTSUHrqJYuq+ztpUqU1yHY=;
  b=iXL0QoMqdGi2QfmL14kA4PfJuCxX9ZP2WvZuqCppNWpk6fWXhSvc9uIR
   aKg9SMnymWIMDTgOJ4on9S3Zr/EvV+AJ2JPp1QdbYTLRV/Rcfc5Ak4yD8
   lRMadJNQe90iLpdUegE/D2rXGCgmgna0FwXHSgxkwqjUhzPsnFcr7KhIi
   UO3muECokDjo274BwxwpUNdP9K2r303Hau5QhgPnhjb1iACUu9DBbpy+q
   sQ54174+HJEAZfnh8cIFvXE9Jdr2AzpoDeCiUfxZWpJsarDvwY+YVS+OC
   2tzlMzEcAGmWhcL7reeTWjgw9V4KJnRSZRk2J5dr71fiBpsWV/m8NNMVx
   w==;
X-CSE-ConnectionGUID: pLq36N0eQmK+NxUfWNXZ2A==
X-CSE-MsgGUID: Dr8RWCMpSgCFCUs/JcLWZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2063682"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2063682"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 10:24:05 -0700
X-CSE-ConnectionGUID: jlwFX3e2TCu8K7bQohLs6w==
X-CSE-MsgGUID: ZASt0evhQPCjLRgQrTYRgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="7039811"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 29 Oct 2026 10:24:03 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMTr6-00000000aZa-35U6;
	Thu, 29 Oct 2026 17:24:00 +0000
Date: Fri, 30 Oct 2026 01:23:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-layerscape] BUILD SUCCESS
 89d2ac4da7df75921130caa82a52c31c755cdf29
Message-ID: <202610300101.CK9MXhpI-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-layerscape
branch HEAD: 89d2ac4da7df75921130caa82a52c31c755cdf29  Revert "PCI: layerscape: Change default error response behavior"

elapsed time: 2556m

configs tested: 326
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-19
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1000-20261029    clang-24
arc                   randconfig-1001-20261028    gcc-8.5.0
arc                   randconfig-1001-20261029    clang-24
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    clang-24
arm                          axm55xx_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                            h3600_defconfig    clang-24
arm                        imx_v4_v5_defconfig    gcc-16.2.0
arm                            imxrt_defconfig    gcc-16.2.0
arm                    milbeaut_m10v_defconfig    gcc-16.2.0
arm                             mps2_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1000-20261029    clang-24
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1001-20261029    clang-24
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1002-20261029    clang-24
arm                   randconfig-1003-20261028    gcc-8.5.0
arm                   randconfig-1003-20261029    clang-24
arm                          s3c6400_defconfig    gcc-16.2.0
arm                        spear13xx_defconfig    clang-24
arm                         spear3xx_defconfig    gcc-16.2.0
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261028    clang-22
arm64                 randconfig-1000-20261029    gcc-8.5.0
arm64                 randconfig-1001-20261028    clang-22
arm64                 randconfig-1001-20261029    gcc-8.5.0
arm64                 randconfig-1002-20261028    clang-22
arm64                 randconfig-1002-20261029    gcc-8.5.0
arm64                 randconfig-1003-20261028    clang-22
arm64                 randconfig-1003-20261029    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261028    clang-22
csky                  randconfig-1000-20261029    gcc-8.5.0
csky                  randconfig-1001-20261028    clang-22
csky                  randconfig-1001-20261029    gcc-8.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261028    clang-17
hexagon               randconfig-1000-20261029    clang-24
hexagon               randconfig-1001-20261028    clang-17
hexagon               randconfig-1001-20261029    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261028    clang-22
i386        buildonly-randconfig-1000-20261029    gcc-14
i386        buildonly-randconfig-1001-20261028    clang-22
i386        buildonly-randconfig-1001-20261029    gcc-14
i386        buildonly-randconfig-1002-20261028    clang-22
i386        buildonly-randconfig-1002-20261029    gcc-14
i386        buildonly-randconfig-1003-20261028    clang-22
i386        buildonly-randconfig-1003-20261029    gcc-14
i386        buildonly-randconfig-1004-20261028    clang-22
i386        buildonly-randconfig-1004-20261029    gcc-14
i386        buildonly-randconfig-1005-20261028    clang-22
i386        buildonly-randconfig-1005-20261029    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261028    gcc-14
i386                  randconfig-1000-20261029    clang-22
i386                  randconfig-1001-20261028    gcc-14
i386                  randconfig-1001-20261029    clang-22
i386                  randconfig-1002-20261028    gcc-14
i386                  randconfig-1002-20261029    clang-22
i386                  randconfig-1003-20261028    gcc-14
i386                  randconfig-1003-20261029    clang-22
i386                  randconfig-1004-20261028    gcc-14
i386                  randconfig-1004-20261029    clang-22
i386                  randconfig-1005-20261028    gcc-14
i386                  randconfig-1005-20261029    clang-22
i386                  randconfig-1006-20261028    gcc-14
i386                  randconfig-1006-20261029    clang-22
i386                  randconfig-1007-20261028    clang-22
i386                  randconfig-1007-20261029    clang-22
i386                  randconfig-1008-20261028    clang-22
i386                  randconfig-1008-20261029    clang-22
i386                  randconfig-1009-20261028    clang-22
i386                  randconfig-1009-20261029    clang-22
i386                  randconfig-1010-20261028    clang-22
i386                  randconfig-1010-20261029    clang-22
i386                  randconfig-1011-20261028    clang-22
i386                  randconfig-1011-20261029    clang-22
i386                  randconfig-1012-20261028    clang-22
i386                  randconfig-1012-20261029    clang-22
i386                  randconfig-1013-20261028    clang-22
i386                  randconfig-1013-20261029    clang-22
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261028    clang-17
loongarch             randconfig-1000-20261029    clang-24
loongarch             randconfig-1001-20261028    clang-17
loongarch             randconfig-1001-20261029    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    clang-22
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    clang-24
m68k                        m5275evb_defconfig    clang-22
m68k                        m5282evb_defconfig    clang-24
m68k                         stmark2_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            ip32_defconfig    gcc-16.2.0
mips                        lemote2f_defconfig    clang-22
mips                            mtx1_defconfig    gcc-16.2.0
mips                           rm200_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261028    clang-17
nios2                 randconfig-1000-20261029    clang-24
nios2                 randconfig-1001-20261028    clang-17
nios2                 randconfig-1001-20261029    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc          de0_nano_multicore_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    clang-24
openrisc                        virt_defconfig    clang-24
parisc                            alldefconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1000-20261029    clang-17
parisc                randconfig-1001-20261028    clang-19
parisc                randconfig-1001-20261029    clang-17
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                       bamboo_defconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                  canyonlands_defconfig    clang-22
powerpc                       cm5200_defconfig    clang-24
powerpc                      ep8248e_defconfig    clang-22
powerpc                           g5_defconfig    clang-24
powerpc                     ge_imp3a_defconfig    clang-24
powerpc                         icon_defconfig    gcc-16.2.0
powerpc                   iss476-smp_defconfig    gcc-16.2.0
powerpc                    motionpro_defconfig    clang-24
powerpc                  mpc8315_rdb_defconfig    gcc-16.2.0
powerpc                  mpc834x_itx_defconfig    clang-24
powerpc                       pasemi_defconfig    clang-24
powerpc                       ppc44x_defconfig    clang-24
powerpc                       ppc64e_defconfig    clang-24
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1000-20261029    clang-17
powerpc               randconfig-1001-20261028    clang-19
powerpc               randconfig-1001-20261029    clang-17
powerpc                     sam440ep_defconfig    clang-22
powerpc                     sam440ep_defconfig    clang-24
powerpc                     socrates_defconfig    gcc-16.2.0
powerpc                   storcenter_defconfig    clang-24
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc                         warp_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1000-20261029    clang-17
powerpc64             randconfig-1001-20261028    clang-19
powerpc64             randconfig-1001-20261029    clang-17
riscv                             alldefconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261028    gcc-11.5.0
riscv                 randconfig-1000-20261029    gcc-10.5.0
riscv                 randconfig-1001-20261028    gcc-11.5.0
riscv                 randconfig-1001-20261029    gcc-10.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261028    gcc-11.5.0
s390                  randconfig-1000-20261029    gcc-10.5.0
s390                  randconfig-1001-20261028    gcc-11.5.0
s390                  randconfig-1001-20261029    gcc-10.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                          ap325rxa_defconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    clang-22
sh                             hp6xx_defconfig    clang-24
sh                                j2_defconfig    clang-24
sh                  kfr2r09-romimage_defconfig    clang-24
sh                           polaris_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261028    gcc-11.5.0
sh                    randconfig-1000-20261029    gcc-10.5.0
sh                    randconfig-1001-20261028    gcc-11.5.0
sh                    randconfig-1001-20261029    gcc-10.5.0
sh                           rsk7201_defconfig    clang-22
sh                            se7206_defconfig    gcc-16.2.0
sh                            se7619_defconfig    clang-24
sh                            se7721_defconfig    gcc-16.2.0
sh                            se7751_defconfig    gcc-16.2.0
sh                    sh7724_generic_defconfig    gcc-16.2.0
sh                         sh7785lcr_defconfig    gcc-16.2.0
sh                             titan_defconfig    clang-24
sparc                             alldefconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1000-20261029    clang-24
sparc                 randconfig-1001-20261028    gcc-12
sparc                 randconfig-1001-20261029    clang-24
sparc                        sparc64_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1000-20261029    clang-24
sparc64               randconfig-1001-20261028    gcc-12
sparc64               randconfig-1001-20261029    clang-24
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1000-20261029    clang-24
um                    randconfig-1001-20261028    gcc-12
um                    randconfig-1001-20261029    clang-24
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1000-20261029    gcc-14
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261029    gcc-14
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261029    gcc-14
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261029    gcc-14
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261029    gcc-14
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261029    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1000-20261029    clang-22
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1001-20261029    clang-22
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1002-20261029    clang-22
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1003-20261029    clang-22
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1004-20261029    clang-22
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1005-20261029    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1006-20261029    gcc-14
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1007-20261029    gcc-14
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1008-20261029    gcc-14
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1009-20261029    gcc-14
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1010-20261029    gcc-14
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1011-20261029    gcc-14
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1012-20261029    clang-22
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1013-20261029    clang-22
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1014-20261029    clang-22
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1015-20261029    clang-22
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1016-20261029    clang-22
x86_64                randconfig-1017-20261028    gcc-12
x86_64                randconfig-1017-20261029    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   cadence_csp_defconfig    clang-24
xtensa                        common_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1000-20261029    clang-24
xtensa                randconfig-1001-20261028    gcc-12
xtensa                randconfig-1001-20261029    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
