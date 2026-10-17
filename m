Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E382E5B2A
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266483; cv=none; b=ZDafn4NRTnY0jE8wqSIvF6Nuq3wX8zwv8fupRowxYhA8lDPR3zsWKlztYZ+nGZJuev8cOvPuA12kQNCVZ2DHn2MFfeXaGlxarYCzh8eiUhdRTYhA1Md6mCh+wDop5Nv0gzPSA5UlKFWG8Ly3D6SuEFbqHDBVzPde/zGRfTbhLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266483; c=relaxed/simple;
	bh=jkEwTm7yewrXxJPfk1r6nhUvyYIaIkja+Yhfx6pmsb4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hdKZSmmWLDWh3fUEjplSSnPpg9JywJoZzVFwhzZQrWUoJZ2VSY/Sp0IXv1FojQdLqf9BRTVvOYUQoUqqVoU3631Ji0unOK7BNZH+VcBz0vs8+p32SZ6OCvZrvlYR46tOi14I7FMXwzQuvghSsY34HL8AzGP0uFMfL/jgocEYMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRqUatkB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRqUatkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792266481; x=1823802481;
  h=date:from:to:cc:subject:message-id;
  bh=jkEwTm7yewrXxJPfk1r6nhUvyYIaIkja+Yhfx6pmsb4=;
  b=GRqUatkBEL4nfN0PdQtLD3GhRT9xMsTvv0mpp/XB9LgEt/x13CAszALp
   icVTiAZ8Gw/8q+ZmunWG9mNPwLFH2DVEGlgA8S48SdjWc1+LH8aaa6Mcw
   vZEXpRQgeY6AvVfKB+hkeGadclAZSRLGDABEnLoRQYWIF2kikN7PuLecy
   vXZYis1wbh/3O/eir/4SCC0eiVxmiNnTIUB/1paeH4r/7ipDQE8xMmzix
   PeYybvmIOBKBY/cBDzS3GjhvADhTvlfs/MW+bvIqOxSxlkycW0E/40g/5
   i53fVDylgtxwuvvt1rc7/Rr9KsY0ZUKBJA5/hcNs8OZfDQIXgusNv5y7s
   w==;
X-CSE-ConnectionGUID: CZW16B3EQxyLo5KzIY2ekw==
X-CSE-MsgGUID: dM4J3ExcS8+Ezx0fTtkoag==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1012387"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1012387"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:47:58 -0700
X-CSE-ConnectionGUID: TAfpqVMKQku9R7PtElMESg==
X-CSE-MsgGUID: 7/tTBLvVRkimuKlQjY+DLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2547035"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Oct 2026 12:47:57 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIANm-00000000JgV-0p4s;
	Sat, 17 Oct 2026 19:47:54 +0000
Date: Sun, 18 Oct 2026 03:47:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc] BUILD SUCCESS
 efadda401c5c8e2390ba66508eba154dbd0db5a9
Message-ID: <202610180320.PixdMXlL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: efadda401c5c8e2390ba66508eba154dbd0db5a9  PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

elapsed time: 1814m

configs tested: 440
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261015    gcc-9.5.0  cocci
alpha                randconfig-r2103-20261015    gcc-9.5.0  cocci
alpha                randconfig-r2104-20261015    gcc-16.1.0 cocci
alpha                randconfig-r2308-20261015    clang-22   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-2000-20261015    gcc-15.2.0
arc                   randconfig-2000-20261015    gcc-9.5.0
arc                   randconfig-2001-20261015    gcc-15.2.0
arc                  randconfig-r2101-20261015    clang-18   cocci
arc                  randconfig-r2107-20261015    gcc-12.5.0 cocci
arc                  randconfig-r2107-20261015    gcc-16.1.0 cocci
arc                  randconfig-r2109-20261015    clang-24   cocci
arc                  randconfig-r2306-20261015    gcc-16.1.0 sparse
arc                  randconfig-r2307-20261015    clang-24   sparse
arc                  randconfig-r2308-20261015    gcc-16.1.0 sparse
arc                  randconfig-r2310-20261015    clang-24   sparse
arc                         vdk_hs38_defconfig    gcc-16.1.0
arm                               alldefconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                        netwinder_defconfig    gcc-16.1.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-2000-20261015    gcc-11.5.0
arm                   randconfig-2000-20261015    gcc-15.2.0
arm                   randconfig-2001-20261015    gcc-15.2.0
arm                   randconfig-2001-20261015    gcc-8.5.0
arm                  randconfig-r2108-20261015    clang-24   cocci
arm                  randconfig-r2200-20261015    clang-18   smatch
arm                  randconfig-r2309-20261015    clang-22   sparse
arm                          socfpga_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1000-20261018    gcc-14.3.0
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1001-20261018    gcc-14.3.0
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1002-20261018    gcc-14.3.0
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-1003-20261018    gcc-14.3.0
arm64                 randconfig-2000-20261015    clang-17
arm64                 randconfig-2000-20261015    gcc-16.1.0
arm64                 randconfig-2001-20261015    clang-17
arm64                 randconfig-2001-20261015    gcc-16.1.0
arm64                randconfig-r2107-20261015    clang-17   cocci
arm64                randconfig-r2303-20261015    clang-17   sparse
arm64                randconfig-r2311-20261015    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1000-20261018    gcc-14.3.0
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-1001-20261018    gcc-14.3.0
csky                  randconfig-2000-20261015    gcc-13.4.0
csky                  randconfig-2000-20261015    gcc-16.1.0
csky                  randconfig-2001-20261015    gcc-16.1.0
csky                 randconfig-r2109-20261015    gcc-10.5.0 cocci
csky                 randconfig-r2109-20261015    gcc-9.5.0  cocci
csky                 randconfig-r2110-20261015    gcc-16.1.0 cocci
csky                 randconfig-r2300-20261015    clang-17   sparse
csky                 randconfig-r2303-20261015    clang-24   sparse
csky                 randconfig-r2306-20261015    gcc-14.3.0 sparse
csky                 randconfig-r2307-20261015    gcc-16.1.0 sparse
csky                 randconfig-r2308-20261015    gcc-16.1.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1000-20261018    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-1001-20261018    clang-21
hexagon               randconfig-2000-20261015    clang-19
hexagon               randconfig-2000-20261015    gcc-16.1.0
hexagon               randconfig-2001-20261015    clang-24
hexagon               randconfig-2001-20261015    gcc-16.1.0
hexagon              randconfig-r2200-20261015    clang-24   smatch
hexagon              randconfig-r2202-20261015    clang-24   smatch
hexagon              randconfig-r2302-20261015    clang-24   sparse
hexagon              randconfig-r2305-20261015    clang-17   sparse
hexagon              randconfig-r2305-20261015    gcc-16.1.0 sparse
hexagon              randconfig-r2306-20261015    clang-24   sparse
hexagon              randconfig-r2308-20261015    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1005-20261017    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261017    clang-22
i386                  randconfig-1001-20261017    clang-22
i386                  randconfig-1002-20261017    clang-22
i386                  randconfig-1003-20261017    clang-22
i386                  randconfig-1004-20261017    clang-22
i386                  randconfig-1005-20261017    clang-22
i386                  randconfig-1006-20261017    clang-22
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-2000-20261015    clang-22
i386                  randconfig-2000-20261015    gcc-15.2.0
i386                  randconfig-2001-20261015    clang-22
i386                  randconfig-2001-20261015    gcc-15.2.0
i386                  randconfig-2100-20261015    gcc-14     cocci
i386                  randconfig-2101-20261015    gcc-14     cocci
i386                  randconfig-2102-20261015    gcc-14     cocci
i386                  randconfig-2103-20261015    gcc-12     cocci
i386                  randconfig-2103-20261015    gcc-14     cocci
i386                  randconfig-2104-20261015    gcc-14     cocci
i386                  randconfig-2105-20261015    gcc-14     cocci
i386                  randconfig-2200-20261015    clang-22   smatch
i386                  randconfig-2300-20261015    clang-22   sparse
i386                  randconfig-2300-20261015    gcc-14     sparse
i386                  randconfig-2301-20261015    gcc-14     sparse
i386                  randconfig-2302-20261015    gcc-14     sparse
i386                 randconfig-r2200-20261015    gcc-14     smatch
i386                 randconfig-r2308-20261015    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1000-20261018    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-1001-20261018    clang-21
loongarch             randconfig-2000-20261015    clang-24
loongarch             randconfig-2000-20261015    gcc-8.5.0
loongarch             randconfig-2001-20261015    gcc-16.1.0
loongarch             randconfig-2001-20261015    gcc-8.5.0
loongarch            randconfig-r2102-20261015    clang-18   cocci
loongarch            randconfig-r2105-20261015    gcc-16.1.0 cocci
loongarch            randconfig-r2111-20261015    gcc-13.4.0 cocci
loongarch            randconfig-r2300-20261015    gcc-16.1.0 sparse
loongarch            randconfig-r2305-20261015    clang-17   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2103-20261015    clang-24   cocci
m68k                 randconfig-r2108-20261015    gcc-8.5.0  cocci
m68k                 randconfig-r2201-20261015    gcc-8.5.0  smatch
m68k                 randconfig-r2302-20261015    clang-17   sparse
m68k                 randconfig-r2306-20261015    clang-24   sparse
m68k                 randconfig-r2307-20261015    clang-22   sparse
m68k                 randconfig-r2310-20261015    gcc-12.5.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2100-20261015    clang-18   cocci
microblaze           randconfig-r2301-20261015    clang-17   sparse
microblaze           randconfig-r2306-20261015    clang-22   sparse
microblaze           randconfig-r2309-20261015    clang-24   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    clang-24
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                            ip30_defconfig    clang-24
mips                      loongson2k_defconfig    clang-24
mips                 randconfig-r2100-20261015    clang-24   cocci
mips                 randconfig-r2101-20261015    clang-24   cocci
mips                 randconfig-r2309-20261015    clang-24   sparse
mips                    sb1250_swarm_defconfig    clang-24
mips                    sb1250_swarm_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1000-20261018    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-1001-20261018    clang-21
nios2                 randconfig-2000-20261015    gcc-8.5.0
nios2                 randconfig-2001-20261015    gcc-8.5.0
nios2                randconfig-r2311-20261015    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2105-20261015    gcc-12.5.0 cocci
openrisc             randconfig-r2300-20261015    clang-24   sparse
openrisc             randconfig-r2301-20261015    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-1001-20261018    clang-24
parisc                randconfig-2000-20261015    gcc-11.5.0
parisc                randconfig-2000-20261015    gcc-8.5.0
parisc                randconfig-2001-20261015    gcc-8.5.0
parisc               randconfig-r2201-20261015    gcc-11.5.0 smatch
parisc               randconfig-r2303-20261015    clang-17   sparse
parisc               randconfig-r2303-20261015    gcc-16.1.0 sparse
parisc               randconfig-r2304-20261015    clang-24   sparse
parisc               randconfig-r2311-20261015    clang-22   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261018    clang-24
powerpc               randconfig-2000-20261015    clang-22
powerpc               randconfig-2000-20261015    clang-24
powerpc               randconfig-2001-20261015    clang-22
powerpc               randconfig-2001-20261015    gcc-10.5.0
powerpc              randconfig-r2106-20261015    clang-24   cocci
powerpc              randconfig-r2106-20261015    gcc-14.3.0 cocci
powerpc              randconfig-r2108-20261015    clang-18   cocci
powerpc              randconfig-r2111-20261015    gcc-12.5.0 cocci
powerpc              randconfig-r2200-20261015    clang-24   smatch
powerpc              randconfig-r2311-20261015    clang-24   sparse
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261018    clang-24
powerpc64             randconfig-2000-20261015    clang-19
powerpc64             randconfig-2000-20261015    clang-22
powerpc64             randconfig-2001-20261015    clang-22
powerpc64             randconfig-2001-20261015    gcc-8.5.0
powerpc64            randconfig-r2103-20261015    clang-18   cocci
powerpc64            randconfig-r2103-20261015    clang-24   cocci
powerpc64            randconfig-r2104-20261015    gcc-12.5.0 cocci
powerpc64            randconfig-r2105-20261015    gcc-10.5.0 cocci
powerpc64            randconfig-r2110-20261015    gcc-12.5.0 cocci
powerpc64            randconfig-r2304-20261015    clang-17   sparse
powerpc64            randconfig-r2305-20261015    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-1001-20261018    clang-17
riscv                 randconfig-2000-20261015    gcc-8.5.0
riscv                 randconfig-2000-20261015    gcc-9.5.0
riscv                 randconfig-2001-20261015    clang-24
riscv                 randconfig-2001-20261015    gcc-9.5.0
riscv                randconfig-r2107-20261015    clang-24   cocci
riscv                randconfig-r2110-20261015    clang-18   cocci
riscv                randconfig-r2110-20261015    clang-24   cocci
riscv                randconfig-r2301-20261015    clang-24   sparse
riscv                randconfig-r2302-20261015    clang-17   sparse
riscv                randconfig-r2310-20261015    clang-22   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-1001-20261018    clang-17
s390                  randconfig-2000-20261015    clang-24
s390                  randconfig-2000-20261015    gcc-9.5.0
s390                  randconfig-2001-20261015    gcc-14.3.0
s390                  randconfig-2001-20261015    gcc-9.5.0
s390                 randconfig-r2102-20261015    gcc-9.5.0  cocci
s390                 randconfig-r2105-20261015    clang-24   cocci
s390                 randconfig-r2201-20261015    gcc-8.5.0  smatch
s390                 randconfig-r2301-20261015    clang-17   sparse
s390                 randconfig-r2304-20261015    clang-17   sparse
s390                 randconfig-r2310-20261015    gcc-16.1.0 sparse
s390                        zfcpdump_defconfig    gcc-16.1.0
sh                                alldefconfig    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                           lboxre2_defconfig    gcc-16.1.0
sh                             migor_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-1001-20261018    clang-17
sh                    randconfig-2000-20261015    gcc-9.5.0
sh                    randconfig-2001-20261015    gcc-15.2.0
sh                    randconfig-2001-20261015    gcc-9.5.0
sh                   randconfig-r2101-20261015    gcc-11.5.0 cocci
sh                   randconfig-r2106-20261015    gcc-12.5.0 cocci
sh                   randconfig-r2106-20261015    gcc-16.1.0 cocci
sh                   randconfig-r2108-20261015    gcc-9.5.0  cocci
sh                   randconfig-r2201-20261015    gcc-10.5.0 smatch
sh                   randconfig-r2309-20261015    clang-24   sparse
sh                           rsk7264_defconfig    gcc-16.1.0
sh                           rsk7269_defconfig    clang-24
sh                            sh2007_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1000-20261018    clang-24
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261018    clang-24
sparc                 randconfig-2000-20261015    gcc-13.4.0
sparc                 randconfig-2000-20261015    gcc-15.2.0
sparc                 randconfig-2001-20261015    gcc-15.2.0
sparc                randconfig-r2100-20261015    gcc-8.5.0  cocci
sparc                randconfig-r2104-20261015    clang-24   cocci
sparc                randconfig-r2104-20261015    gcc-8.5.0  cocci
sparc                randconfig-r2202-20261015    gcc-16.1.0 smatch
sparc                randconfig-r2310-20261015    clang-24   sparse
sparc                        sparc32_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1000-20261018    clang-24
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261018    clang-24
sparc64               randconfig-2000-20261015    clang-20
sparc64               randconfig-2000-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261015    gcc-8.5.0
sparc64              randconfig-r2101-20261015    gcc-9.5.0  cocci
sparc64              randconfig-r2102-20261015    clang-24   cocci
sparc64              randconfig-r2102-20261015    gcc-16.1.0 cocci
sparc64              randconfig-r2111-20261015    clang-24   cocci
sparc64              randconfig-r2202-20261015    gcc-9.5.0  smatch
sparc64              randconfig-r2302-20261015    gcc-16.1.0 sparse
sparc64              randconfig-r2307-20261015    clang-24   sparse
sparc64              randconfig-r2311-20261015    gcc-16.1.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1000-20261018    clang-24
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-1001-20261018    clang-24
um                    randconfig-2000-20261015    clang-24
um                    randconfig-2000-20261015    gcc-15.2.0
um                    randconfig-2001-20261015    gcc-14
um                    randconfig-2001-20261015    gcc-15.2.0
um                   randconfig-r2109-20261015    clang-18   cocci
um                   randconfig-r2300-20261015    clang-17   sparse
um                   randconfig-r2304-20261015    gcc-16.1.0 sparse
um                   randconfig-r2309-20261015    gcc-16.1.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261017    gcc-14
x86_64      buildonly-randconfig-1001-20261017    gcc-14
x86_64      buildonly-randconfig-1002-20261017    gcc-14
x86_64      buildonly-randconfig-1003-20261017    gcc-14
x86_64      buildonly-randconfig-1004-20261017    gcc-14
x86_64      buildonly-randconfig-1005-20261017    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261017    gcc-14
x86_64                randconfig-1001-20261017    gcc-14
x86_64                randconfig-1002-20261017    gcc-14
x86_64                randconfig-1003-20261017    gcc-14
x86_64                randconfig-1004-20261017    gcc-14
x86_64                randconfig-1005-20261017    gcc-14
x86_64                randconfig-1006-20261017    clang-22
x86_64                randconfig-1007-20261017    clang-22
x86_64                randconfig-1008-20261017    clang-22
x86_64                randconfig-1009-20261017    clang-22
x86_64                randconfig-1010-20261017    clang-22
x86_64                randconfig-1011-20261017    clang-22
x86_64                randconfig-1012-20261017    clang-22
x86_64                randconfig-1013-20261017    clang-22
x86_64                randconfig-1014-20261017    clang-22
x86_64                randconfig-1015-20261017    clang-22
x86_64                randconfig-1016-20261017    clang-22
x86_64                randconfig-1017-20261017    clang-22
x86_64                randconfig-2000-20261015    clang-22
x86_64                randconfig-2000-20261015    gcc-14
x86_64                randconfig-2001-20261015    clang-22
x86_64                randconfig-2100-20261015    clang-22   cocci
x86_64                randconfig-2101-20261015    clang-22   cocci
x86_64                randconfig-2102-20261015    clang-22   cocci
x86_64                randconfig-2103-20261015    clang-22   cocci
x86_64                randconfig-2104-20261015    clang-22   cocci
x86_64                randconfig-2105-20261015    clang-22   cocci
x86_64                randconfig-2200-20261015    clang-22   smatch
x86_64                randconfig-2300-20261015    clang-22   sparse
x86_64                randconfig-2300-20261015    gcc-14     sparse
x86_64                randconfig-2301-20261015    clang-22   sparse
x86_64                randconfig-2301-20261015    gcc-14     sparse
x86_64                randconfig-2302-20261015    gcc-12     sparse
x86_64                randconfig-2302-20261015    gcc-14     sparse
x86_64               randconfig-r2200-20261015    clang-22   smatch
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1000-20261018    clang-24
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261018    clang-24
xtensa                randconfig-2000-20261015    gcc-11.5.0
xtensa                randconfig-2000-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261015    gcc-8.5.0
xtensa               randconfig-r2111-20261015    gcc-16.1.0 cocci
xtensa               randconfig-r2202-20261015    gcc-11.5.0 smatch
xtensa               randconfig-r2307-20261015    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
