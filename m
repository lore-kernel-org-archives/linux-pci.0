Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9B53D9FE
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080867; cv=none; b=n8vUDR7f3oqbydy2BGxyKy/Vkx8ZCNtXHle6Uy8z1LihaSBuAg//D16rxxQVG2+fXTVjQJS7+Og3IZEbTy939CPFXVsN4Gq/woROa8yy2Sxb8vhoYQXGafCZRKHJfiLfgHWEAznE2MqcoUzIX61uaILWNnorM1ba3Ex+qlRnaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080867; c=relaxed/simple;
	bh=yWOC3eXEvp9++3nCyIsc/5of/CQ0/PbBfETcc/ZIU1s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vC9BSU7OeFokAKGThq9mChxUK1YlMM0u3ONa0Xfx7WZaMHuQZUxY8RESZ17A8ZF15Z76hZSKpOxrxL09AqDRVRo7I4foLoU0yve5X7EIYU8I+BACG094tWiIC6jN18M5JDoY/Lg4Yu3KDoIlYJgql7D1N2/waIhOiEylpVK6trA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mI3EOiCL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI3EOiCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792080845; x=1823616845;
  h=date:from:to:cc:subject:message-id;
  bh=yWOC3eXEvp9++3nCyIsc/5of/CQ0/PbBfETcc/ZIU1s=;
  b=mI3EOiCLfn3VydHxlPTMG4MQiX8dMa/xViYX8JjsZij1AaA8N7W+nsSo
   A1W6M01sEg0y0ZVqipNkCcd7+wNAWWNdg9Oj265o1V8an4j8YEbA3aPS+
   J9Ez6yVC6YdQuV7+4mDYR0Zl+3geDzUhQJTMSiI1BHFK0ZOdy869ozWcj
   M05xjmR1ptXcbkEB+U5DAVlmXuSX7j6pezqTZ8bwAjCGzC0QK1oNsbQnT
   A7bHMbl6GGylUrDZnpJY9Q30pHsaR+uN1q+CRDP6wKS8F3jdZlZBLovnj
   I5VGLFHd3KYUKLXzg/xji2YNAJbg5JxIZwuUnbJKav2PavXb/M6+l4giM
   g==;
X-CSE-ConnectionGUID: VXqwJoYhQImW/9G1tZ8mYg==
X-CSE-MsgGUID: iKaieci3TMOoIyvPLzX41g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="961376"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="961376"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 09:14:01 -0700
X-CSE-ConnectionGUID: BDVrYME3R9+Xr2D4OWEhSA==
X-CSE-MsgGUID: 8MpwszzGThmYOnFd28x2BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2046570"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Oct 2026 09:14:00 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHO5d-00000000Glc-1DaC;
	Thu, 15 Oct 2026 16:13:57 +0000
Date: Fri, 16 Oct 2026 00:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 573bbee68354c1a3566b6451d5477416c3be9462
Message-ID: <202610160017.Yl3WT1GC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 573bbee68354c1a3566b6451d5477416c3be9462  Merge branch 'pci/misc'

elapsed time: 2834m

configs tested: 235
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.1.0
alpha                    allyesconfig    gcc-16.1.0
alpha                       defconfig    gcc-16.1.0
arc                      allmodconfig    gcc-16.1.0
arc                       allnoconfig    gcc-16.1.0
arc                      allyesconfig    gcc-16.1.0
arc                         defconfig    gcc-16.1.0
arc          randconfig-2000-20261013    gcc-15.2.0
arc          randconfig-2000-20261013    gcc-8.5.0
arc          randconfig-2000-20261014    gcc-10.5.0
arc          randconfig-2001-20261013    gcc-8.5.0
arc          randconfig-2001-20261014    gcc-10.5.0
arc         randconfig-r2103-20261013    clang-17   cocci
arc         randconfig-r2107-20261013    gcc-11.5.0 cocci
arc         randconfig-r2108-20261013    clang-17   cocci
arc         randconfig-r2109-20261013    clang-24   cocci
arm                       allnoconfig    clang-17
arm                      allyesconfig    gcc-16.1.0
arm                         defconfig    clang-24
arm          randconfig-2000-20261013    gcc-13.4.0
arm          randconfig-2000-20261013    gcc-8.5.0
arm          randconfig-2000-20261014    gcc-10.5.0
arm          randconfig-2001-20261013    gcc-8.5.0
arm          randconfig-2001-20261014    gcc-10.5.0
arm         randconfig-r2311-20261013    gcc-13.4.0 sparse
arm                  sp7021_defconfig    gcc-16.1.0
arm64                    allmodconfig    clang-24
arm64                     allnoconfig    gcc-16.1.0
arm64                       defconfig    gcc-16.1.0
arm64        randconfig-2000-20261013    gcc-9.5.0
arm64        randconfig-2001-20261013    gcc-9.5.0
arm64       randconfig-r2200-20261013    gcc-8.5.0  smatch
arm64       randconfig-r2201-20261013    gcc-11.5.0 smatch
arm64       randconfig-r2311-20261013    clang-24   sparse
csky                     allmodconfig    gcc-16.1.0
csky                      allnoconfig    gcc-16.1.0
csky                        defconfig    gcc-16.1.0
csky         randconfig-2000-20261013    gcc-9.5.0
csky         randconfig-2001-20261013    gcc-9.5.0
csky        randconfig-r2202-20261013    gcc-16.1.0 smatch
csky        randconfig-r2300-20261013    gcc-16.1.0 sparse
csky        randconfig-r2303-20261013    gcc-16.1.0 sparse
csky        randconfig-r2304-20261013    gcc-16.1.0 sparse
hexagon                  allmodconfig    clang-24
hexagon                   allnoconfig    clang-24
hexagon                     defconfig    clang-24
hexagon      randconfig-2000-20261013    gcc-9.5.0
hexagon      randconfig-2001-20261013    gcc-9.5.0
hexagon     randconfig-r2107-20261013    clang-24   cocci
hexagon     randconfig-r2300-20261013    clang-17   sparse
i386                     allmodconfig    gcc-14
i386                      allnoconfig    gcc-14
i386                     allyesconfig    gcc-14
i386                        defconfig    clang-22
i386         randconfig-2000-20261013    clang-22
i386         randconfig-2000-20261013    gcc-8.5.0
i386         randconfig-2000-20261014    gcc-10.5.0
i386         randconfig-2001-20261013    clang-22
i386         randconfig-2001-20261013    gcc-8.5.0
i386         randconfig-2001-20261014    gcc-10.5.0
i386         randconfig-2100-20261013    gcc-14     cocci
i386         randconfig-2101-20261013    gcc-14     cocci
i386         randconfig-2102-20261013    gcc-14     cocci
i386         randconfig-2103-20261013    gcc-14     cocci
i386         randconfig-2104-20261013    gcc-14     cocci
i386         randconfig-2105-20261013    gcc-14     cocci
i386         randconfig-2200-20261013    gcc-14     smatch
i386         randconfig-2300-20261013    gcc-14     sparse
i386         randconfig-2301-20261013    gcc-14     sparse
i386         randconfig-2302-20261013    gcc-14     sparse
i386        randconfig-r2104-20261013    gcc-11.5.0 cocci
i386        randconfig-r2110-20261013    clang-24   cocci
i386        randconfig-r2301-20261013    clang-17   sparse
i386        randconfig-r2304-20261013    gcc-14     sparse
loongarch                allmodconfig    clang-19
loongarch                 allnoconfig    clang-20
loongarch    randconfig-2000-20261013    gcc-11.5.0
loongarch    randconfig-2001-20261013    gcc-11.5.0
loongarch   randconfig-r2101-20261013    clang-24   cocci
loongarch   randconfig-r2110-20261013    gcc-11.5.0 cocci
loongarch   randconfig-r2303-20261013    gcc-16.1.0 sparse
m68k                     allmodconfig    gcc-16.1.0
m68k                      allnoconfig    gcc-16.1.0
m68k                     allyesconfig    gcc-16.1.0
m68k               m5235evb_defconfig    gcc-16.1.0
m68k        randconfig-r2100-20261013    clang-24   cocci
m68k        randconfig-r2101-20261013    clang-17   cocci
m68k        randconfig-r2108-20261013    clang-24   cocci
m68k        randconfig-r2202-20261013    gcc-14.3.0 smatch
microblaze                allnoconfig    gcc-16.1.0
microblaze               allyesconfig    gcc-16.1.0
microblaze  randconfig-r2301-20261013    gcc-16.1.0 sparse
microblaze  randconfig-r2310-20261013    clang-24   sparse
mips                     allmodconfig    gcc-16.1.0
mips                      allnoconfig    gcc-16.1.0
mips                     allyesconfig    gcc-16.1.0
mips        randconfig-r2111-20261013    clang-24   cocci
nios2                    allmodconfig    gcc-11.5.0
nios2                     allnoconfig    gcc-11.5.0
nios2        randconfig-2000-20261013    gcc-11.5.0
nios2        randconfig-2001-20261013    gcc-11.5.0
nios2       randconfig-r2301-20261013    gcc-8.5.0  sparse
nios2       randconfig-r2308-20261013    clang-24   sparse
nios2       randconfig-r2308-20261013    gcc-13.4.0 sparse
nios2       randconfig-r2309-20261013    clang-24   sparse
openrisc                 allmodconfig    gcc-16.1.0
openrisc                  allnoconfig    gcc-16.1.0
openrisc           de0_nano_defconfig    gcc-16.1.0
openrisc    randconfig-r2102-20261013    clang-17   cocci
openrisc    randconfig-r2305-20261013    gcc-12.5.0 sparse
openrisc    randconfig-r2310-20261013    gcc-13.4.0 sparse
parisc                   allmodconfig    gcc-16.1.0
parisc                    allnoconfig    gcc-16.1.0
parisc                   allyesconfig    gcc-16.1.0
parisc       randconfig-1000-20261015    gcc-12.5.0
parisc       randconfig-1001-20261015    gcc-10.5.0
parisc       randconfig-2000-20261013    gcc-11.5.0
parisc       randconfig-2001-20261013    gcc-11.5.0
parisc      randconfig-r2305-20261013    gcc-16.1.0 sparse
parisc      randconfig-r2307-20261013    clang-24   sparse
powerpc                  allmodconfig    gcc-16.1.0
powerpc                   allnoconfig    gcc-16.1.0
powerpc         mpc832x_rdb_defconfig    gcc-16.1.0
powerpc             ppa8548_defconfig    gcc-16.1.0
powerpc      randconfig-1000-20261015    gcc-11.5.0
powerpc      randconfig-1001-20261015    gcc-8.5.0
powerpc      randconfig-2000-20261013    gcc-14
powerpc      randconfig-2001-20261013    gcc-14
powerpc     randconfig-r2302-20261013    gcc-16.1.0 sparse
powerpc     randconfig-r2303-20261013    clang-17   sparse
powerpc     randconfig-r2306-20261013    clang-24   sparse
powerpc64    randconfig-1000-20261015    gcc-10.5.0
powerpc64    randconfig-1001-20261015    gcc-15.2.0
powerpc64    randconfig-2000-20261013    gcc-14
powerpc64    randconfig-2001-20261013    gcc-14
powerpc64   randconfig-r2105-20261013    gcc-11.5.0 cocci
powerpc64   randconfig-r2106-20261013    clang-24   cocci
riscv                    allmodconfig    clang-24
riscv                     allnoconfig    gcc-16.1.0
riscv                    allyesconfig    clang-24
riscv        randconfig-2000-20261013    gcc-15.2.0
riscv        randconfig-2000-20261014    gcc-16.1.0
riscv        randconfig-2001-20261013    gcc-15.2.0
riscv        randconfig-2001-20261014    gcc-16.1.0
riscv       randconfig-r2304-20261013    clang-17   sparse
riscv       randconfig-r2307-20261013    gcc-13.4.0 sparse
s390                     allmodconfig    clang-24
s390                      allnoconfig    clang-24
s390                     allyesconfig    gcc-16.1.0
s390         randconfig-2000-20261013    gcc-15.2.0
s390         randconfig-2000-20261014    gcc-16.1.0
s390         randconfig-2001-20261013    gcc-15.2.0
s390         randconfig-2001-20261014    gcc-16.1.0
s390        randconfig-r2109-20261013    clang-17   cocci
sh                       allmodconfig    gcc-16.1.0
sh                        allnoconfig    gcc-16.1.0
sh                       allyesconfig    gcc-16.1.0
sh                 ap325rxa_defconfig    gcc-16.1.0
sh                dreamcast_defconfig    gcc-16.1.0
sh                  kfr2r09_defconfig    gcc-16.1.0
sh           randconfig-2000-20261013    gcc-15.2.0
sh           randconfig-2000-20261014    gcc-16.1.0
sh           randconfig-2001-20261013    gcc-15.2.0
sh           randconfig-2001-20261014    gcc-16.1.0
sh          randconfig-r2106-20261013    gcc-11.5.0 cocci
sh          randconfig-r2111-20261013    gcc-11.5.0 cocci
sh          randconfig-r2300-20261013    gcc-9.5.0  sparse
sparc                     allnoconfig    gcc-16.1.0
sparc        randconfig-1000-20261015    gcc-14.3.0
sparc        randconfig-1001-20261015    gcc-16.1.0
sparc        randconfig-2000-20261013    gcc-11.5.0
sparc        randconfig-2000-20261013    gcc-16.1.0
sparc        randconfig-2001-20261013    gcc-16.1.0
sparc       randconfig-r2103-20261013    clang-24   cocci
sparc       randconfig-r2306-20261013    gcc-13.4.0 sparse
sparc64                  allmodconfig    clang-20
sparc64      randconfig-1000-20261015    gcc-8.5.0
sparc64      randconfig-1001-20261015    gcc-8.5.0
sparc64      randconfig-2000-20261013    clang-24
sparc64      randconfig-2000-20261013    gcc-16.1.0
sparc64      randconfig-2001-20261013    clang-24
sparc64      randconfig-2001-20261013    gcc-16.1.0
sparc64     randconfig-r2105-20261013    clang-24   cocci
sparc64     randconfig-r2201-20261013    gcc-8.5.0  smatch
sparc64     randconfig-r2302-20261013    gcc-12.5.0 sparse
um                       allmodconfig    clang-17
um                        allnoconfig    clang-17
um                       allyesconfig    gcc-14
um           randconfig-1000-20261015    clang-17
um           randconfig-1001-20261015    clang-24
um           randconfig-2000-20261013    gcc-14
um           randconfig-2000-20261013    gcc-16.1.0
um           randconfig-2001-20261013    gcc-14
um           randconfig-2001-20261013    gcc-16.1.0
um          randconfig-r2102-20261013    clang-24   cocci
um          randconfig-r2104-20261013    clang-24   cocci
um          randconfig-r2200-20261013    clang-17   smatch
um          randconfig-r2302-20261013    clang-17   sparse
x86_64                   allmodconfig    clang-22
x86_64                    allnoconfig    clang-22
x86_64                   allyesconfig    clang-22
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261013    gcc-14
x86_64       randconfig-2001-20261013    gcc-14
x86_64       randconfig-2100-20261013    clang-22   cocci
x86_64       randconfig-2101-20261013    clang-22   cocci
x86_64       randconfig-2102-20261013    clang-22   cocci
x86_64       randconfig-2103-20261013    clang-22   cocci
x86_64       randconfig-2104-20261013    clang-22   cocci
x86_64       randconfig-2105-20261013    clang-22   cocci
x86_64       randconfig-2200-20261013    gcc-13     smatch
x86_64       randconfig-2300-20261013    gcc-14     sparse
x86_64       randconfig-2301-20261013    gcc-14     sparse
x86_64       randconfig-2302-20261013    gcc-14     sparse
x86_64      randconfig-r2100-20261013    clang-17   cocci
x86_64      randconfig-r2202-20261013    gcc-14     smatch
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    gcc-16.1.0
xtensa                   allyesconfig    gcc-16.1.0
xtensa       randconfig-1000-20261015    gcc-16.1.0
xtensa       randconfig-1001-20261015    gcc-10.5.0
xtensa       randconfig-2000-20261013    gcc-16.1.0
xtensa       randconfig-2000-20261013    gcc-8.5.0
xtensa       randconfig-2001-20261013    gcc-11.5.0
xtensa       randconfig-2001-20261013    gcc-16.1.0
xtensa      randconfig-r2201-20261013    gcc-8.5.0  smatch
xtensa      randconfig-r2305-20261013    clang-17   sparse
xtensa      randconfig-r2309-20261013    gcc-13.4.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
