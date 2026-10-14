Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617044D7D4D
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017789; cv=none; b=BJQy1MIfYubBmpiPs7N6mxNrM7HMj2khzvKknuh5VF3v0ZiLr7862yeGZeT/3zIPiosjf5O7/AijMB0AfjEiAe+PYiZc72aEBoSxbGvDiZ0BzJ8VNmFQ7JwUOkoHkL50qC/WWcuPra3fMMZN1vUuyTa0/23CDE+qv/nDA9NbatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017789; c=relaxed/simple;
	bh=1llgtmtHLG0FbA4YQW93GJBGykko9xTRe/MuW/m0A0w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DA4LjFvbv1Q41jAZxEimTCmvX5T0q2Xpl4nz7Y3WrtppGHyBihI1DFAQizGs3W8vaoL6tgcehZ21ecXLvyTiXw+iAFfxwr4mxkmBO8pQASawh6ekTIwDviDZe3Fgsrsnyj+6cDPhYeydVofkv39EZej/zgCuxG4d54NYNWvaJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8aP1+AH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8aP1+AH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792017786; x=1823553786;
  h=date:from:to:cc:subject:message-id;
  bh=1llgtmtHLG0FbA4YQW93GJBGykko9xTRe/MuW/m0A0w=;
  b=N8aP1+AHAiskvuWss7UbaB++vZBbkbx80ejs86tkvMO18QnEy9/FrLxq
   zIix6cJfWu0Gaw89vYFcn6efPjBUK7tXELV12GhEEfcwHUawFSUp5qdwj
   KFThFvGpJBS6kpQmNlrRqYn4Kjjnkqjy7PYdpblIDd2FwbLxs5th8tPnW
   aakxiKMezZJA5rtXPl/T9Thgj91A0q9aDaCpi8UTa0HueMd+flcO6Rqs9
   dIX8B+3L+WWzLYBgA2xmxkyiLly9L/D0bFghoPv3EgCt+/igtF5PEEzLo
   M2zg2b5Fe4oy9IdSoQwDMIrz2qzbXgpzJxZNNaYfjz7NDcD0SnRUbTi65
   A==;
X-CSE-ConnectionGUID: XQAGKHAHSZWgCdcULGTAyQ==
X-CSE-MsgGUID: yachQrqeRsepRzHqNhvggQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="786205"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="786205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 15:43:05 -0700
X-CSE-ConnectionGUID: GPnXfz+MRiezjrRX660lwA==
X-CSE-MsgGUID: RDw5QhckRXiQRBOCmE4Y1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="2003649"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2026 15:43:03 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH7ga-00000000FI5-2xRd;
	Wed, 14 Oct 2026 22:43:00 +0000
Date: Thu, 15 Oct 2026 06:42:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:vmd] BUILD SUCCESS
 2c88c2dc18528489b403fe95741f5731e292f7ba
Message-ID: <202610150614.DX89sHWa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 2c88c2dc18528489b403fe95741f5731e292f7ba  PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake

elapsed time: 1784m

configs tested: 552
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261014    gcc-8.5.0  cocci
alpha                randconfig-r2102-20261014    gcc-12.5.0 cocci
alpha                randconfig-r2104-20261013    clang-22   cocci
alpha                randconfig-r2105-20261013    gcc-8.5.0  cocci
alpha                randconfig-r2105-20261014    gcc-10.5.0 cocci
alpha                randconfig-r2106-20261013    clang-22   cocci
alpha                randconfig-r2109-20261014    gcc-13.4.0 cocci
alpha                randconfig-r2308-20261014    gcc-14.3.0 sparse
alpha                randconfig-r2309-20261013    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261014    clang-17
arc                   randconfig-1001-20261014    clang-17
arc                   randconfig-2000-20261013    gcc-8.5.0
arc                   randconfig-2000-20261014    gcc-10.5.0
arc                   randconfig-2001-20261013    gcc-8.5.0
arc                   randconfig-2001-20261014    gcc-10.5.0
arc                  randconfig-r2102-20261014    gcc-8.5.0  cocci
arc                  randconfig-r2107-20261013    clang-22   cocci
arc                  randconfig-r2109-20261013    clang-24   cocci
arc                  randconfig-r2200-20261013    gcc-13.4.0 smatch
arc                  randconfig-r2300-20261013    gcc-8.5.0  sparse
arc                  randconfig-r2301-20261013    gcc-12.5.0 sparse
arc                  randconfig-r2306-20261014    gcc-8.5.0  sparse
arc                  randconfig-r2307-20261014    gcc-8.5.0  sparse
arc                  randconfig-r2308-20261014    gcc-16.1.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      davinci_all_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                       jornada720_defconfig    clang-24
arm                          lpc32xx_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261014    clang-17
arm                   randconfig-1001-20261014    clang-17
arm                   randconfig-1002-20261014    clang-17
arm                   randconfig-1003-20261014    clang-17
arm                   randconfig-2000-20261013    gcc-8.5.0
arm                   randconfig-2000-20261014    gcc-10.5.0
arm                   randconfig-2001-20261013    gcc-8.5.0
arm                   randconfig-2001-20261014    gcc-10.5.0
arm                  randconfig-r2101-20261013    clang-24   cocci
arm                  randconfig-r2104-20261013    gcc-8.5.0  cocci
arm                  randconfig-r2111-20261013    gcc-14.3.0 cocci
arm                  randconfig-r2202-20261013    gcc-8.5.0  smatch
arm                  randconfig-r2307-20261013    clang-19   sparse
arm                  randconfig-r2308-20261013    clang-24   sparse
arm                  randconfig-r2311-20261013    gcc-13.4.0 sparse
arm                          s3c6400_defconfig    clang-24
arm                            u8500_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261014    gcc-16.1.0
arm64                 randconfig-1000-20261015    gcc-8.5.0
arm64                 randconfig-1001-20261014    gcc-16.1.0
arm64                 randconfig-1001-20261015    gcc-8.5.0
arm64                 randconfig-1002-20261014    gcc-16.1.0
arm64                 randconfig-1002-20261015    gcc-8.5.0
arm64                 randconfig-1003-20261014    gcc-16.1.0
arm64                 randconfig-1003-20261015    gcc-8.5.0
arm64                 randconfig-2000-20261013    gcc-9.5.0
arm64                 randconfig-2000-20261014    gcc-16.1.0
arm64                 randconfig-2001-20261013    gcc-9.5.0
arm64                 randconfig-2001-20261014    gcc-16.1.0
arm64                randconfig-r2100-20261014    gcc-13.4.0 cocci
arm64                randconfig-r2101-20261014    gcc-11.5.0 cocci
arm64                randconfig-r2103-20261013    clang-24   cocci
arm64                randconfig-r2104-20261014    gcc-10.5.0 cocci
arm64                randconfig-r2105-20261014    gcc-8.5.0  cocci
arm64                randconfig-r2200-20261013    gcc-8.5.0  smatch
arm64                randconfig-r2201-20261013    gcc-11.5.0 smatch
arm64                randconfig-r2201-20261014    clang-24   smatch
arm64                randconfig-r2305-20261013    gcc-12.5.0 sparse
arm64                randconfig-r2305-20261014    clang-24   sparse
arm64                randconfig-r2306-20261013    gcc-10.5.0 sparse
arm64                randconfig-r2309-20261013    clang-19   sparse
arm64                randconfig-r2311-20261013    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261014    gcc-16.1.0
csky                  randconfig-1000-20261015    gcc-8.5.0
csky                  randconfig-1001-20261014    gcc-16.1.0
csky                  randconfig-1001-20261015    gcc-8.5.0
csky                  randconfig-2000-20261013    gcc-9.5.0
csky                  randconfig-2000-20261014    gcc-16.1.0
csky                  randconfig-2001-20261013    gcc-9.5.0
csky                  randconfig-2001-20261014    gcc-16.1.0
csky                 randconfig-r2100-20261014    gcc-12.5.0 cocci
csky                 randconfig-r2101-20261013    gcc-12.5.0 cocci
csky                 randconfig-r2106-20261014    gcc-10.5.0 cocci
csky                 randconfig-r2108-20261014    gcc-13.4.0 cocci
csky                 randconfig-r2111-20261013    gcc-10.5.0 cocci
csky                 randconfig-r2201-20261014    gcc-14.3.0 smatch
csky                 randconfig-r2300-20261013    gcc-16.1.0 sparse
csky                 randconfig-r2302-20261014    clang-24   sparse
csky                 randconfig-r2303-20261013    gcc-16.1.0 sparse
csky                 randconfig-r2303-20261014    clang-24   sparse
csky                 randconfig-r2304-20261013    gcc-16.1.0 sparse
csky                 randconfig-r2309-20261014    gcc-14.3.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261014    clang-18
hexagon               randconfig-1001-20261014    clang-18
hexagon               randconfig-2000-20261013    gcc-9.5.0
hexagon               randconfig-2000-20261014    gcc-16.1.0
hexagon               randconfig-2001-20261013    gcc-9.5.0
hexagon               randconfig-2001-20261014    gcc-16.1.0
hexagon              randconfig-r2101-20261013    clang-24   cocci
hexagon              randconfig-r2102-20261013    clang-24   cocci
hexagon              randconfig-r2103-20261013    clang-21   cocci
hexagon              randconfig-r2103-20261013    clang-24   cocci
hexagon              randconfig-r2103-20261014    gcc-11.5.0 cocci
hexagon              randconfig-r2104-20261014    gcc-10.5.0 cocci
hexagon              randconfig-r2107-20261013    clang-24   cocci
hexagon              randconfig-r2107-20261014    gcc-10.5.0 cocci
hexagon              randconfig-r2301-20261013    gcc-8.5.0  sparse
hexagon              randconfig-r2304-20261014    clang-24   sparse
hexagon              randconfig-r2305-20261014    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261014    gcc-14
i386        buildonly-randconfig-1001-20261014    gcc-14
i386        buildonly-randconfig-1002-20261014    gcc-14
i386        buildonly-randconfig-1003-20261014    gcc-14
i386        buildonly-randconfig-1004-20261014    gcc-14
i386        buildonly-randconfig-1005-20261014    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261014    clang-22
i386                  randconfig-1001-20261014    clang-22
i386                  randconfig-1002-20261014    clang-22
i386                  randconfig-1003-20261014    clang-22
i386                  randconfig-1004-20261014    clang-22
i386                  randconfig-1005-20261014    clang-22
i386                  randconfig-1006-20261014    clang-22
i386                  randconfig-1007-20261014    gcc-14
i386                  randconfig-1008-20261014    gcc-14
i386                  randconfig-1009-20261014    gcc-14
i386                  randconfig-1010-20261014    gcc-14
i386                  randconfig-1011-20261014    gcc-14
i386                  randconfig-1012-20261014    gcc-14
i386                  randconfig-1013-20261014    gcc-14
i386                  randconfig-2000-20261013    gcc-8.5.0
i386                  randconfig-2000-20261014    gcc-10.5.0
i386                  randconfig-2001-20261013    gcc-8.5.0
i386                  randconfig-2001-20261014    gcc-10.5.0
i386                  randconfig-2100-20261013    gcc-14     cocci
i386                  randconfig-2100-20261014    gcc-13     cocci
i386                  randconfig-2101-20261013    gcc-14     cocci
i386                  randconfig-2101-20261014    gcc-13     cocci
i386                  randconfig-2102-20261013    gcc-14     cocci
i386                  randconfig-2102-20261014    gcc-13     cocci
i386                  randconfig-2103-20261013    gcc-14     cocci
i386                  randconfig-2103-20261014    gcc-13     cocci
i386                  randconfig-2104-20261013    gcc-14     cocci
i386                  randconfig-2104-20261014    gcc-13     cocci
i386                  randconfig-2105-20261013    gcc-14     cocci
i386                  randconfig-2105-20261014    gcc-13     cocci
i386                  randconfig-2200-20261013    gcc-14     smatch
i386                  randconfig-2200-20261014    clang-22   smatch
i386                  randconfig-2300-20261013    gcc-14     sparse
i386                  randconfig-2300-20261014    clang-22   sparse
i386                  randconfig-2301-20261013    gcc-14     sparse
i386                  randconfig-2301-20261014    clang-22   sparse
i386                  randconfig-2302-20261013    gcc-14     sparse
i386                  randconfig-2302-20261014    clang-22   sparse
i386                 randconfig-r2100-20261013    clang-24   cocci
i386                 randconfig-r2102-20261013    clang-24   cocci
i386                 randconfig-r2104-20261013    gcc-10.5.0 cocci
i386                 randconfig-r2110-20261013    clang-24   cocci
i386                 randconfig-r2110-20261014    gcc-10.5.0 cocci
i386                 randconfig-r2111-20261013    clang-22   cocci
i386                 randconfig-r2111-20261014    gcc-8.5.0  cocci
i386                 randconfig-r2300-20261014    clang-24   sparse
i386                 randconfig-r2305-20261013    clang-22   sparse
i386                 randconfig-r2305-20261014    gcc-8.5.0  sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    clang-24
loongarch             randconfig-1000-20261014    clang-18
loongarch             randconfig-1001-20261014    clang-18
loongarch             randconfig-2000-20261013    gcc-11.5.0
loongarch             randconfig-2000-20261014    gcc-8.5.0
loongarch             randconfig-2001-20261013    gcc-11.5.0
loongarch             randconfig-2001-20261014    gcc-8.5.0
loongarch            randconfig-r2100-20261013    gcc-12.5.0 cocci
loongarch            randconfig-r2101-20261013    clang-24   cocci
loongarch            randconfig-r2104-20261014    gcc-8.5.0  cocci
loongarch            randconfig-r2110-20261013    gcc-14.3.0 cocci
loongarch            randconfig-r2111-20261014    gcc-10.5.0 cocci
loongarch            randconfig-r2201-20261013    clang-24   smatch
loongarch            randconfig-r2300-20261013    gcc-12.5.0 sparse
loongarch            randconfig-r2301-20261014    clang-24   sparse
loongarch            randconfig-r2302-20261014    gcc-8.5.0  sparse
loongarch            randconfig-r2305-20261014    clang-24   sparse
loongarch            randconfig-r2306-20261013    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2100-20261013    clang-24   cocci
m68k                 randconfig-r2103-20261013    gcc-12.5.0 cocci
m68k                 randconfig-r2103-20261014    gcc-13.4.0 cocci
m68k                 randconfig-r2107-20261013    gcc-8.5.0  cocci
m68k                 randconfig-r2107-20261014    gcc-10.5.0 cocci
m68k                 randconfig-r2108-20261013    clang-24   cocci
m68k                 randconfig-r2108-20261014    gcc-12.5.0 cocci
m68k                 randconfig-r2109-20261013    gcc-12.5.0 cocci
m68k                 randconfig-r2200-20261014    gcc-9.5.0  smatch
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261014    gcc-8.5.0  cocci
microblaze           randconfig-r2105-20261014    gcc-10.5.0 cocci
microblaze           randconfig-r2202-20261014    gcc-9.5.0  smatch
microblaze           randconfig-r2301-20261013    gcc-16.1.0 sparse
microblaze           randconfig-r2307-20261013    clang-24   sparse
microblaze           randconfig-r2310-20261014    gcc-14.3.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                            ip32_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
mips                 randconfig-r2101-20261014    gcc-13.4.0 cocci
mips                 randconfig-r2103-20261014    gcc-8.5.0  cocci
mips                 randconfig-r2105-20261013    gcc-10.5.0 cocci
mips                 randconfig-r2106-20261013    gcc-10.5.0 cocci
mips                 randconfig-r2110-20261013    gcc-10.5.0 cocci
mips                 randconfig-r2111-20261013    clang-24   cocci
mips                 randconfig-r2201-20261014    clang-24   smatch
mips                 randconfig-r2202-20261013    clang-24   smatch
mips                 randconfig-r2300-20261013    gcc-8.5.0  sparse
mips                 randconfig-r2301-20261013    gcc-8.5.0  sparse
mips                 randconfig-r2302-20261013    gcc-8.5.0  sparse
mips                 randconfig-r2302-20261014    clang-24   sparse
mips                 randconfig-r2303-20261014    gcc-8.5.0  sparse
mips                 randconfig-r2307-20261014    gcc-14     sparse
mips                 randconfig-r2307-20261014    gcc-14.3.0 sparse
mips                 randconfig-r2310-20261013    gcc-10.5.0 sparse
mips                 randconfig-r2311-20261014    gcc-16.1.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261014    clang-18
nios2                 randconfig-1001-20261014    clang-18
nios2                 randconfig-2000-20261013    gcc-11.5.0
nios2                 randconfig-2000-20261014    gcc-8.5.0
nios2                 randconfig-2001-20261013    gcc-11.5.0
nios2                 randconfig-2001-20261014    gcc-8.5.0
nios2                randconfig-r2102-20261014    gcc-11.5.0 cocci
nios2                randconfig-r2106-20261013    gcc-14.3.0 cocci
nios2                randconfig-r2200-20261014    gcc-11.5.0 smatch
nios2                randconfig-r2201-20261013    gcc-8.5.0  smatch
nios2                randconfig-r2202-20261013    gcc-11.5.0 smatch
nios2                randconfig-r2302-20261013    clang-22   sparse
nios2                randconfig-r2304-20261014    clang-24   sparse
nios2                randconfig-r2305-20261013    gcc-8.5.0  sparse
nios2                randconfig-r2308-20261013    gcc-13.4.0 sparse
nios2                randconfig-r2311-20261013    clang-19   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20261013    clang-24   cocci
openrisc             randconfig-r2108-20261014    gcc-11.5.0 cocci
openrisc             randconfig-r2201-20261013    gcc-15.2.0 smatch
openrisc             randconfig-r2310-20261013    gcc-13.4.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261014    clang-22
parisc                randconfig-1000-20261015    gcc-8.5.0
parisc                randconfig-1001-20261014    clang-22
parisc                randconfig-1001-20261015    gcc-8.5.0
parisc                randconfig-2000-20261013    gcc-11.5.0
parisc                randconfig-2000-20261014    gcc-8.5.0
parisc                randconfig-2001-20261013    gcc-11.5.0
parisc                randconfig-2001-20261014    gcc-8.5.0
parisc               randconfig-r2106-20261013    gcc-8.5.0  cocci
parisc               randconfig-r2106-20261014    gcc-10.5.0 cocci
parisc               randconfig-r2108-20261013    clang-24   cocci
parisc               randconfig-r2108-20261014    gcc-8.5.0  cocci
parisc               randconfig-r2202-20261014    gcc-12.5.0 smatch
parisc               randconfig-r2305-20261013    gcc-16.1.0 sparse
parisc               randconfig-r2311-20261013    gcc-10.5.0 sparse
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                         cell_defconfig    clang-24
powerpc                       pasemi_defconfig    gcc-16.1.0
powerpc                       ppc44x_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261014    clang-22
powerpc               randconfig-1000-20261015    gcc-8.5.0
powerpc               randconfig-1001-20261014    clang-22
powerpc               randconfig-1001-20261015    gcc-8.5.0
powerpc               randconfig-2000-20261013    gcc-14
powerpc               randconfig-2000-20261014    clang-22
powerpc               randconfig-2001-20261013    gcc-14
powerpc               randconfig-2001-20261014    clang-22
powerpc              randconfig-r2107-20261013    gcc-10.5.0 cocci
powerpc              randconfig-r2107-20261014    gcc-8.5.0  cocci
powerpc              randconfig-r2110-20261013    clang-22   cocci
powerpc              randconfig-r2110-20261013    gcc-8.5.0  cocci
powerpc              randconfig-r2111-20261014    gcc-10.5.0 cocci
powerpc              randconfig-r2300-20261014    clang-24   sparse
powerpc              randconfig-r2302-20261013    gcc-16.1.0 sparse
powerpc              randconfig-r2305-20261013    gcc-8.5.0  sparse
powerpc              randconfig-r2308-20261014    gcc-8.5.0  sparse
powerpc              randconfig-r2309-20261014    gcc-16.1.0 sparse
powerpc              randconfig-r2310-20261014    gcc-8.5.0  sparse
powerpc                      tqm8540_defconfig    clang-24
powerpc64             randconfig-1000-20261014    clang-22
powerpc64             randconfig-1000-20261015    gcc-8.5.0
powerpc64             randconfig-1001-20261014    clang-22
powerpc64             randconfig-1001-20261015    gcc-8.5.0
powerpc64             randconfig-2000-20261013    gcc-14
powerpc64             randconfig-2000-20261014    clang-22
powerpc64             randconfig-2001-20261013    gcc-14
powerpc64             randconfig-2001-20261014    clang-22
powerpc64            randconfig-r2101-20261014    gcc-12.5.0 cocci
powerpc64            randconfig-r2106-20261013    clang-24   cocci
powerpc64            randconfig-r2109-20261013    clang-21   cocci
powerpc64            randconfig-r2109-20261013    clang-24   cocci
powerpc64            randconfig-r2300-20261013    clang-22   sparse
powerpc64            randconfig-r2301-20261014    clang-24   sparse
powerpc64            randconfig-r2304-20261014    gcc-8.5.0  sparse
powerpc64            randconfig-r2306-20261014    gcc-14.3.0 sparse
powerpc64            randconfig-r2307-20261013    clang-24   sparse
powerpc64            randconfig-r2309-20261013    clang-24   sparse
powerpc64            randconfig-r2310-20261013    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261014    clang-18
riscv                 randconfig-1001-20261014    clang-18
riscv                 randconfig-2000-20261013    gcc-15.2.0
riscv                 randconfig-2000-20261014    gcc-16.1.0
riscv                 randconfig-2001-20261013    gcc-15.2.0
riscv                 randconfig-2001-20261014    gcc-16.1.0
riscv                randconfig-r2111-20261013    gcc-8.5.0  cocci
riscv                randconfig-r2307-20261013    gcc-13.4.0 sparse
riscv                randconfig-r2307-20261014    gcc-16.1.0 sparse
riscv                randconfig-r2308-20261013    gcc-10.5.0 sparse
riscv                randconfig-r2310-20261013    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261014    clang-18
s390                  randconfig-1001-20261014    clang-18
s390                  randconfig-2000-20261013    gcc-15.2.0
s390                  randconfig-2000-20261014    gcc-16.1.0
s390                  randconfig-2001-20261013    gcc-15.2.0
s390                  randconfig-2001-20261014    gcc-16.1.0
s390                 randconfig-r2100-20261013    clang-21   cocci
s390                 randconfig-r2105-20261013    gcc-14.3.0 cocci
s390                 randconfig-r2106-20261014    gcc-8.5.0  cocci
s390                 randconfig-r2108-20261013    gcc-12.5.0 cocci
s390                 randconfig-r2109-20261013    clang-24   cocci
s390                 randconfig-r2109-20261014    gcc-12.5.0 cocci
s390                 randconfig-r2200-20261013    clang-24   smatch
s390                 randconfig-r2200-20261014    gcc-8.5.0  smatch
s390                 randconfig-r2302-20261013    gcc-12.5.0 sparse
s390                 randconfig-r2304-20261013    gcc-8.5.0  sparse
s390                 randconfig-r2307-20261013    gcc-10.5.0 sparse
s390                 randconfig-r2310-20261014    gcc-16.1.0 sparse
s390                 randconfig-r2311-20261013    clang-24   sparse
s390                 randconfig-r2311-20261014    gcc-14.3.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    clang-24
sh                          ap325rxa_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                           kfr2r09_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261014    clang-18
sh                    randconfig-1001-20261014    clang-18
sh                    randconfig-2000-20261013    gcc-15.2.0
sh                    randconfig-2000-20261014    gcc-16.1.0
sh                    randconfig-2001-20261013    gcc-15.2.0
sh                    randconfig-2001-20261014    gcc-16.1.0
sh                   randconfig-r2309-20261014    gcc-8.5.0  sparse
sh                   randconfig-r2311-20261014    gcc-14     sparse
sh                   randconfig-r2311-20261014    gcc-8.5.0  sparse
sh                            se7619_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261014    clang-24
sparc                 randconfig-1001-20261014    clang-24
sparc                 randconfig-2000-20261013    gcc-16.1.0
sparc                 randconfig-2000-20261014    gcc-14.3.0
sparc                 randconfig-2001-20261013    gcc-16.1.0
sparc                 randconfig-2001-20261014    gcc-14.3.0
sparc                randconfig-r2103-20261013    clang-24   cocci
sparc                randconfig-r2103-20261014    gcc-12.5.0 cocci
sparc                randconfig-r2108-20261013    clang-24   cocci
sparc                randconfig-r2110-20261014    gcc-8.5.0  cocci
sparc                randconfig-r2300-20261014    gcc-8.5.0  sparse
sparc                randconfig-r2303-20261013    gcc-8.5.0  sparse
sparc                randconfig-r2303-20261014    clang-24   sparse
sparc                randconfig-r2304-20261013    clang-22   sparse
sparc                randconfig-r2304-20261014    clang-24   sparse
sparc                randconfig-r2306-20261013    clang-19   sparse
sparc                randconfig-r2306-20261013    gcc-13.4.0 sparse
sparc                randconfig-r2306-20261014    gcc-16.1.0 sparse
sparc                randconfig-r2309-20261014    gcc-14     sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261014    clang-24
sparc64               randconfig-1001-20261014    clang-24
sparc64               randconfig-2000-20261013    gcc-16.1.0
sparc64               randconfig-2000-20261014    gcc-14.3.0
sparc64               randconfig-2001-20261013    gcc-16.1.0
sparc64               randconfig-2001-20261014    gcc-14.3.0
sparc64              randconfig-r2102-20261014    gcc-13.4.0 cocci
sparc64              randconfig-r2105-20261013    clang-24   cocci
sparc64              randconfig-r2200-20261013    clang-24   smatch
sparc64              randconfig-r2202-20261014    clang-22   smatch
sparc64              randconfig-r2301-20261014    gcc-8.5.0  sparse
sparc64              randconfig-r2303-20261013    clang-22   sparse
sparc64              randconfig-r2304-20261013    gcc-12.5.0 sparse
sparc64              randconfig-r2310-20261014    gcc-14     sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261014    clang-24
um                    randconfig-1001-20261014    clang-24
um                    randconfig-2000-20261013    gcc-16.1.0
um                    randconfig-2000-20261014    gcc-14.3.0
um                    randconfig-2001-20261013    gcc-16.1.0
um                    randconfig-2001-20261014    gcc-14.3.0
um                   randconfig-r2101-20261013    clang-21   cocci
um                   randconfig-r2102-20261013    clang-24   cocci
um                   randconfig-r2102-20261013    gcc-12.5.0 cocci
um                   randconfig-r2104-20261013    clang-24   cocci
um                   randconfig-r2108-20261013    clang-21   cocci
um                   randconfig-r2109-20261014    gcc-8.5.0  cocci
um                   randconfig-r2200-20261014    clang-17   smatch
um                   randconfig-r2302-20261014    clang-24   sparse
um                   randconfig-r2303-20261013    gcc-12.5.0 sparse
um                   randconfig-r2308-20261013    clang-19   sparse
um                   randconfig-r2308-20261014    gcc-14     sparse
um                   randconfig-r2310-20261013    clang-19   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261014    clang-22
x86_64      buildonly-randconfig-1001-20261014    clang-22
x86_64      buildonly-randconfig-1002-20261014    clang-22
x86_64      buildonly-randconfig-1003-20261014    clang-22
x86_64      buildonly-randconfig-1004-20261014    clang-22
x86_64      buildonly-randconfig-1005-20261014    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261014    gcc-14
x86_64                randconfig-1001-20261014    gcc-14
x86_64                randconfig-1002-20261014    gcc-14
x86_64                randconfig-1003-20261014    gcc-14
x86_64                randconfig-1004-20261014    gcc-14
x86_64                randconfig-1005-20261014    gcc-14
x86_64                randconfig-1006-20261014    gcc-14
x86_64                randconfig-1007-20261014    gcc-14
x86_64                randconfig-1008-20261014    gcc-14
x86_64                randconfig-1009-20261014    gcc-14
x86_64                randconfig-1010-20261014    gcc-14
x86_64                randconfig-1011-20261014    gcc-14
x86_64                randconfig-1012-20261014    gcc-14
x86_64                randconfig-1013-20261014    gcc-14
x86_64                randconfig-1014-20261014    gcc-14
x86_64                randconfig-1015-20261014    gcc-14
x86_64                randconfig-1016-20261014    gcc-14
x86_64                randconfig-1017-20261014    gcc-14
x86_64                randconfig-2000-20261013    gcc-14
x86_64                randconfig-2000-20261014    clang-22
x86_64                randconfig-2001-20261013    gcc-14
x86_64                randconfig-2001-20261014    clang-22
x86_64                randconfig-2100-20261013    clang-22   cocci
x86_64                randconfig-2100-20261014    clang-22   cocci
x86_64                randconfig-2101-20261013    clang-22   cocci
x86_64                randconfig-2101-20261014    clang-22   cocci
x86_64                randconfig-2102-20261013    clang-22   cocci
x86_64                randconfig-2102-20261014    clang-22   cocci
x86_64                randconfig-2103-20261013    clang-22   cocci
x86_64                randconfig-2103-20261014    clang-22   cocci
x86_64                randconfig-2104-20261013    clang-22   cocci
x86_64                randconfig-2104-20261014    clang-22   cocci
x86_64                randconfig-2105-20261013    clang-22   cocci
x86_64                randconfig-2105-20261014    clang-22   cocci
x86_64                randconfig-2200-20261013    gcc-13     smatch
x86_64                randconfig-2200-20261014    clang-22   smatch
x86_64                randconfig-2300-20261013    gcc-14     sparse
x86_64                randconfig-2300-20261014    clang-22   sparse
x86_64                randconfig-2301-20261013    gcc-14     sparse
x86_64                randconfig-2301-20261014    clang-22   sparse
x86_64                randconfig-2302-20261013    gcc-14     sparse
x86_64                randconfig-2302-20261014    clang-22   sparse
x86_64               randconfig-r2102-20261013    clang-21   cocci
x86_64               randconfig-r2109-20261014    gcc-11.5.0 cocci
x86_64               randconfig-r2202-20261013    gcc-14     smatch
x86_64               randconfig-r2202-20261014    clang-22   smatch
x86_64               randconfig-r2301-20261013    clang-22   sparse
x86_64               randconfig-r2302-20261013    gcc-8.5.0  sparse
x86_64               randconfig-r2303-20261013    gcc-8.5.0  sparse
x86_64               randconfig-r2304-20261013    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261013    clang-24   sparse
x86_64               randconfig-r2306-20261014    gcc-14     sparse
x86_64               randconfig-r2308-20261013    clang-24   sparse
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
xtensa                randconfig-1000-20261014    clang-24
xtensa                randconfig-1001-20261014    clang-24
xtensa                randconfig-2000-20261013    gcc-16.1.0
xtensa                randconfig-2000-20261014    gcc-14.3.0
xtensa                randconfig-2001-20261013    gcc-16.1.0
xtensa                randconfig-2001-20261014    gcc-14.3.0
xtensa               randconfig-r2100-20261014    gcc-11.5.0 cocci
xtensa               randconfig-r2104-20261013    gcc-14.3.0 cocci
xtensa               randconfig-r2105-20261013    clang-22   cocci
xtensa               randconfig-r2107-20261013    gcc-14.3.0 cocci
xtensa               randconfig-r2303-20261014    clang-24   sparse
xtensa               randconfig-r2309-20261013    gcc-10.5.0 sparse
xtensa               randconfig-r2309-20261013    gcc-13.4.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
