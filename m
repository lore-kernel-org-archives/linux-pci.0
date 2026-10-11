Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED723BCF7
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685320; cv=none; b=kCkjxnRZ8i6cqg2YB8/dV78JLGNQIeIuzZX1spvY5f489UZgU4w9bj30Q+2CgUk6fBBY3kK2kNNmHkfl2K4AknI3eVIcYWWEueGM607CjlB7PdYvIYstiFljNODhJ4eccMR2ZpVuoZbvIwcfxlDYiNytVKGyhH6Tvit8EsKVsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685320; c=relaxed/simple;
	bh=pBcbIZLUOl4Wfj37XHYKi/vnqOx9bQGiXtN+wLGMgpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cvt27RaWW/vDXE7vpmi7moOu37OHtXhlu8dZJCLJVz/J7fUjsyOnKFP9sT1+amAuo3yT2cNuAxR/7gXY4dj5zwaKVDIHFWU8HwbERlMn/FO0weHiQQ8ggrM3WbllBqzsS00wj19cc8xnDV2dHFeBQtkEEa/9Bvkwn01d8sbKglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaEsMXUs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaEsMXUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791685318; x=1823221318;
  h=date:from:to:cc:subject:message-id;
  bh=pBcbIZLUOl4Wfj37XHYKi/vnqOx9bQGiXtN+wLGMgpM=;
  b=ZaEsMXUs5gdK8w8OiEqrrSETdsoPDVJYSx3Wd5NhL4DTg2fApjiX/TSB
   yV5WRfdLnwfmYaIFop+9qa0jCCxDiKV1fX/hX41CDiCrpk3z3rL5bUKX7
   IW/OH800NIR1wO5ScmUpeOHfKn7PIGz5Ymj40lsXiTA0KANJBHWmfIucc
   6NTHZ1Z94UUHTQ9xhUGRbE/MSeasjf7uF9nBf5RxA5xaH7gS2/Wxfxmgr
   ovg6Prwojmn2A4MXe0vCpf3XFWC0RWT8XGd+cnJr2EA5k1nf99ntiVBui
   RjAUtjuNoKVVNDncMppNJlNOkGLkOfMEvGDqog08F6jJ6AYUMRgmbJu0u
   A==;
X-CSE-ConnectionGUID: n1Kuvdc2QcymSS46BAIBTQ==
X-CSE-MsgGUID: q51sdVrdSpiPMEQRTAp+Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="462079"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="462079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 19:21:58 -0700
X-CSE-ConnectionGUID: Q7Mf4OdIS1eTdtwuS8zKng==
X-CSE-MsgGUID: gy90ai2GQ1yRXtFot5OWBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="577104"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2026 19:21:56 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFjCD-00000000AFY-3yws;
	Sun, 11 Oct 2026 02:21:53 +0000
Date: Sun, 11 Oct 2026 10:21:09 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 79c168e2aa957ed0054c93db17caba653b95e377
Message-ID: <202610111005.qwE34mmn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 79c168e2aa957ed0054c93db17caba653b95e377  PCI/AER: Skip error recovery on false alarms

elapsed time: 1306m

configs tested: 444
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261009    clang-18   cocci
alpha                randconfig-r2103-20261009    gcc-10.5.0 cocci
alpha                randconfig-r2105-20261008    gcc-8.5.0  cocci
alpha                randconfig-r2200-20261009    gcc-8.5.0  smatch
alpha                randconfig-r2202-20261010    gcc-8.5.0  smatch
alpha                randconfig-r2305-20261009    clang-17   sparse
alpha                randconfig-r2306-20261009    gcc-12.5.0 sparse
alpha                randconfig-r2309-20261009    gcc-16.1.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261010    gcc-8.5.0
arc                   randconfig-1000-20261011    clang-24
arc                   randconfig-1001-20261010    gcc-8.5.0
arc                   randconfig-1001-20261011    clang-24
arc                  randconfig-r2101-20261008    gcc-12.5.0 cocci
arc                  randconfig-r2101-20261009    gcc-14.3.0 cocci
arc                  randconfig-r2200-20261009    gcc-14.3.0 smatch
arc                  randconfig-r2306-20261009    gcc-8.5.0  sparse
arc                  randconfig-r2306-20261009    gcc-9.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           moxart_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261010    gcc-8.5.0
arm                   randconfig-1000-20261011    clang-24
arm                   randconfig-1001-20261010    gcc-8.5.0
arm                   randconfig-1001-20261011    clang-24
arm                   randconfig-1002-20261010    gcc-8.5.0
arm                   randconfig-1002-20261011    clang-24
arm                   randconfig-1003-20261010    gcc-8.5.0
arm                   randconfig-1003-20261011    clang-24
arm                  randconfig-r2101-20261008    gcc-11.5.0 cocci
arm                  randconfig-r2102-20261009    gcc-13.4.0 cocci
arm                  randconfig-r2105-20261008    gcc-16.1.0 cocci
arm                  randconfig-r2105-20261009    gcc-16.1.0 cocci
arm                  randconfig-r2201-20261009    clang-24   smatch
arm                  randconfig-r2202-20261009    clang-24   smatch
arm                  randconfig-r2300-20261009    gcc-8.5.0  sparse
arm                  randconfig-r2301-20261009    gcc-10.5.0 sparse
arm                  randconfig-r2302-20261009    gcc-8.5.0  sparse
arm                  randconfig-r2305-20261009    gcc-8.5.0  sparse
arm                  randconfig-r2306-20261010    gcc-14     sparse
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261010    gcc-10.5.0
arm64                 randconfig-1001-20261010    gcc-10.5.0
arm64                 randconfig-1002-20261010    gcc-10.5.0
arm64                 randconfig-1003-20261010    gcc-10.5.0
arm64                randconfig-r2102-20261008    gcc-11.5.0 cocci
arm64                randconfig-r2104-20261010    gcc-14     cocci
arm64                randconfig-r2202-20261009    gcc-10.5.0 smatch
arm64                randconfig-r2303-20261009    clang-21   sparse
arm64                randconfig-r2304-20261010    gcc-16.1.0 sparse
arm64                randconfig-r2306-20261008    gcc-10.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261010    gcc-10.5.0
csky                  randconfig-1001-20261010    gcc-10.5.0
csky                 randconfig-r2103-20261010    clang-24   cocci
csky                 randconfig-r2104-20261008    gcc-16.1.0 cocci
csky                 randconfig-r2106-20261009    gcc-14.3.0 cocci
csky                 randconfig-r2201-20261009    gcc-14.3.0 smatch
csky                 randconfig-r2300-20261009    clang-24   sparse
csky                 randconfig-r2300-20261010    gcc-16.1.0 sparse
csky                 randconfig-r2301-20261009    clang-21   sparse
csky                 randconfig-r2302-20261009    clang-24   sparse
csky                 randconfig-r2302-20261009    gcc-10.5.0 sparse
csky                 randconfig-r2308-20261009    clang-22   sparse
csky                 randconfig-r2308-20261009    gcc-16.1.0 sparse
csky                 randconfig-r2309-20261009    gcc-12.5.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261010    clang-17
hexagon               randconfig-1001-20261010    clang-17
hexagon              randconfig-r2100-20261010    clang-24   cocci
hexagon              randconfig-r2303-20261008    clang-24   sparse
hexagon              randconfig-r2304-20261009    gcc-14     sparse
hexagon              randconfig-r2308-20261009    gcc-12.5.0 sparse
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20261010    gcc-14
i386        buildonly-randconfig-1001-20261010    gcc-14
i386        buildonly-randconfig-1002-20261010    gcc-14
i386        buildonly-randconfig-1003-20261010    gcc-14
i386        buildonly-randconfig-1004-20261010    gcc-14
i386        buildonly-randconfig-1005-20261010    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261010    clang-22
i386                  randconfig-1001-20261010    clang-22
i386                  randconfig-1002-20261010    clang-22
i386                  randconfig-1003-20261010    clang-22
i386                  randconfig-1004-20261010    clang-22
i386                  randconfig-1005-20261010    clang-22
i386                  randconfig-1006-20261010    clang-22
i386                  randconfig-1007-20261010    gcc-14
i386                  randconfig-1008-20261010    gcc-14
i386                  randconfig-1009-20261010    gcc-14
i386                  randconfig-1010-20261010    gcc-14
i386                  randconfig-1011-20261010    gcc-14
i386                  randconfig-1012-20261010    gcc-14
i386                  randconfig-1013-20261010    gcc-14
i386                  randconfig-2100-20261008    clang-22   cocci
i386                  randconfig-2100-20261009    clang-22   cocci
i386                  randconfig-2100-20261010    clang-22   cocci
i386                  randconfig-2101-20261008    clang-22   cocci
i386                  randconfig-2101-20261009    clang-22   cocci
i386                  randconfig-2101-20261010    clang-22   cocci
i386                  randconfig-2102-20261008    clang-22   cocci
i386                  randconfig-2102-20261009    clang-22   cocci
i386                  randconfig-2102-20261010    clang-22   cocci
i386                  randconfig-2103-20261008    clang-22   cocci
i386                  randconfig-2103-20261009    clang-22   cocci
i386                  randconfig-2103-20261010    clang-22   cocci
i386                  randconfig-2200-20261008    clang-22   smatch
i386                  randconfig-2200-20261009    gcc-14     smatch
i386                  randconfig-2200-20261010    gcc-12     smatch
i386                  randconfig-2300-20261008    clang-22   sparse
i386                  randconfig-2300-20261009    clang-22   sparse
i386                  randconfig-2300-20261010    gcc-14     sparse
i386                  randconfig-2301-20261008    clang-22   sparse
i386                  randconfig-2301-20261009    clang-22   sparse
i386                  randconfig-2301-20261010    gcc-14     sparse
i386                  randconfig-2302-20261008    clang-22   sparse
i386                  randconfig-2302-20261009    clang-22   sparse
i386                  randconfig-2302-20261010    gcc-14     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    clang-24
loongarch             randconfig-1000-20261010    clang-17
loongarch             randconfig-1001-20261010    clang-17
loongarch            randconfig-r2100-20261009    gcc-13.4.0 cocci
loongarch            randconfig-r2107-20261010    gcc-14     cocci
loongarch            randconfig-r2200-20261009    gcc-16.1.0 smatch
loongarch            randconfig-r2202-20261009    clang-18   smatch
loongarch            randconfig-r2303-20261009    clang-17   sparse
loongarch            randconfig-r2304-20261009    clang-21   sparse
loongarch            randconfig-r2307-20261008    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         m5307c3_defconfig    clang-24
m68k                 randconfig-r2103-20261008    gcc-11.5.0 cocci
m68k                 randconfig-r2103-20261009    gcc-14.3.0 cocci
m68k                 randconfig-r2201-20261009    gcc-11.5.0 smatch
m68k                 randconfig-r2202-20261009    gcc-8.5.0  smatch
m68k                 randconfig-r2301-20261009    clang-24   sparse
m68k                 randconfig-r2305-20261009    clang-21   sparse
m68k                 randconfig-r2307-20261009    gcc-12.5.0 sparse
m68k                 randconfig-r2307-20261010    gcc-14     sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2106-20261008    gcc-16.1.0 cocci
microblaze           randconfig-r2201-20261009    gcc-8.5.0  smatch
microblaze           randconfig-r2307-20261008    gcc-10.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                  decstation_r4k_defconfig    clang-24
mips                     maltaup_xpa_defconfig    clang-24
mips                 randconfig-r2102-20261009    gcc-10.5.0 cocci
mips                 randconfig-r2103-20261009    gcc-12     cocci
mips                 randconfig-r2107-20261009    gcc-14.3.0 cocci
mips                 randconfig-r2303-20261009    clang-24   sparse
mips                 randconfig-r2304-20261009    clang-17   sparse
mips                 randconfig-r2304-20261009    gcc-10.5.0 sparse
mips                 randconfig-r2306-20261008    clang-24   sparse
mips                 randconfig-r2307-20261009    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261010    clang-17
nios2                 randconfig-1001-20261010    clang-17
nios2                randconfig-r2101-20261009    gcc-12     cocci
nios2                randconfig-r2102-20261009    gcc-13.4.0 cocci
nios2                randconfig-r2106-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2107-20261008    gcc-8.5.0  cocci
nios2                randconfig-r2107-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2300-20261008    clang-24   sparse
nios2                randconfig-r2308-20261009    gcc-8.5.0  sparse
nios2                randconfig-r2309-20261009    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20261009    gcc-12     cocci
openrisc             randconfig-r2101-20261009    gcc-10.5.0 cocci
openrisc             randconfig-r2200-20261009    gcc-10.5.0 smatch
openrisc             randconfig-r2301-20261009    clang-17   sparse
openrisc             randconfig-r2301-20261010    gcc-16.1.0 sparse
openrisc             randconfig-r2302-20261009    clang-21   sparse
openrisc             randconfig-r2305-20261009    clang-24   sparse
openrisc             randconfig-r2305-20261009    gcc-10.5.0 sparse
openrisc             randconfig-r2309-20261008    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    clang-24
parisc                randconfig-1000-20261010    clang-24
parisc                randconfig-1001-20261010    clang-24
parisc               randconfig-r2100-20261009    gcc-13.4.0 cocci
parisc               randconfig-r2101-20261009    clang-18   cocci
parisc               randconfig-r2101-20261010    clang-24   cocci
parisc               randconfig-r2104-20261008    gcc-8.5.0  cocci
parisc               randconfig-r2301-20261009    gcc-8.5.0  sparse
parisc               randconfig-r2302-20261009    clang-17   sparse
parisc               randconfig-r2302-20261009    gcc-14     sparse
parisc               randconfig-r2303-20261009    gcc-14     sparse
parisc               randconfig-r2305-20261009    gcc-14     sparse
parisc               randconfig-r2305-20261010    gcc-16.1.0 sparse
parisc               randconfig-r2309-20261009    gcc-9.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc               randconfig-1000-20261010    clang-24
powerpc               randconfig-1001-20261010    clang-24
powerpc              randconfig-r2103-20261009    clang-18   cocci
powerpc              randconfig-r2106-20261008    gcc-8.5.0  cocci
powerpc              randconfig-r2308-20261010    gcc-14     sparse
powerpc64             randconfig-1000-20261010    clang-24
powerpc64             randconfig-1001-20261010    clang-24
powerpc64            randconfig-r2104-20261009    clang-17   cocci
powerpc64            randconfig-r2104-20261009    gcc-14.3.0 cocci
powerpc64            randconfig-r2104-20261009    gcc-16.1.0 cocci
powerpc64            randconfig-r2107-20261008    gcc-16.1.0 cocci
powerpc64            randconfig-r2107-20261009    clang-17   cocci
powerpc64            randconfig-r2306-20261009    gcc-8.5.0  sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261010    clang-19
riscv                 randconfig-1000-20261011    clang-17
riscv                 randconfig-1001-20261010    clang-19
riscv                 randconfig-1001-20261011    clang-17
riscv                 randconfig-2000-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261010    gcc-16.1.0
riscv                 randconfig-2001-20261009    gcc-16.1.0
riscv                 randconfig-2001-20261010    gcc-16.1.0
riscv                randconfig-r2105-20261009    clang-17   cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261010    clang-19
s390                  randconfig-1000-20261011    clang-17
s390                  randconfig-1001-20261010    clang-19
s390                  randconfig-1001-20261011    clang-17
s390                  randconfig-2000-20261009    gcc-16.1.0
s390                  randconfig-2000-20261010    gcc-16.1.0
s390                  randconfig-2001-20261009    gcc-16.1.0
s390                  randconfig-2001-20261010    gcc-16.1.0
s390                 randconfig-r2102-20261008    gcc-12.5.0 cocci
s390                 randconfig-r2104-20261009    gcc-8.5.0  cocci
s390                 randconfig-r2301-20261009    gcc-14     sparse
s390                 randconfig-r2306-20261009    gcc-16.1.0 sparse
s390                 randconfig-r2308-20261009    gcc-9.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261010    clang-19
sh                    randconfig-1000-20261011    clang-17
sh                    randconfig-1001-20261010    clang-19
sh                    randconfig-1001-20261011    clang-17
sh                    randconfig-2000-20261009    gcc-16.1.0
sh                    randconfig-2000-20261010    gcc-16.1.0
sh                    randconfig-2001-20261009    gcc-16.1.0
sh                    randconfig-2001-20261010    gcc-16.1.0
sh                   randconfig-r2100-20261008    gcc-12.5.0 cocci
sh                   randconfig-r2101-20261009    gcc-13.4.0 cocci
sh                   randconfig-r2105-20261009    gcc-14.3.0 cocci
sh                   randconfig-r2106-20261009    clang-17   cocci
sh                   randconfig-r2201-20261008    gcc-16.1.0 smatch
sh                   randconfig-r2201-20261009    gcc-16.1.0 smatch
sh                   randconfig-r2202-20261009    gcc-13.4.0 smatch
sh                   randconfig-r2300-20261009    gcc-10.5.0 sparse
sh                   randconfig-r2302-20261008    clang-24   sparse
sh                   randconfig-r2302-20261010    gcc-16.1.0 sparse
sh                   randconfig-r2305-20261008    clang-24   sparse
sh                   randconfig-r2308-20261008    clang-24   sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261010    gcc-16.1.0
sparc                 randconfig-1001-20261010    gcc-16.1.0
sparc                 randconfig-2000-20261008    gcc-14
sparc                 randconfig-2000-20261009    clang-17
sparc                 randconfig-2000-20261010    gcc-16.1.0
sparc                 randconfig-2001-20261008    gcc-14
sparc                 randconfig-2001-20261009    clang-17
sparc                 randconfig-2001-20261010    gcc-16.1.0
sparc                randconfig-r2100-20261008    gcc-11.5.0 cocci
sparc                randconfig-r2100-20261009    gcc-14.3.0 cocci
sparc                randconfig-r2103-20261009    gcc-13.4.0 cocci
sparc                randconfig-r2106-20261009    gcc-16.1.0 cocci
sparc                randconfig-r2200-20261008    gcc-16.1.0 smatch
sparc                randconfig-r2201-20261009    gcc-11.5.0 smatch
sparc                randconfig-r2303-20261009    gcc-10.5.0 sparse
sparc                randconfig-r2303-20261010    gcc-16.1.0 sparse
sparc                randconfig-r2304-20261008    clang-24   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261010    gcc-16.1.0
sparc64               randconfig-1001-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261008    gcc-14
sparc64               randconfig-2000-20261009    clang-17
sparc64               randconfig-2000-20261010    gcc-16.1.0
sparc64               randconfig-2001-20261008    gcc-14
sparc64               randconfig-2001-20261009    clang-17
sparc64               randconfig-2001-20261010    gcc-16.1.0
sparc64              randconfig-r2101-20261009    gcc-13.4.0 cocci
sparc64              randconfig-r2102-20261009    clang-18   cocci
sparc64              randconfig-r2102-20261009    gcc-14.3.0 cocci
sparc64              randconfig-r2102-20261010    clang-24   cocci
sparc64              randconfig-r2103-20261008    gcc-12.5.0 cocci
sparc64              randconfig-r2105-20261009    gcc-8.5.0  cocci
sparc64              randconfig-r2105-20261010    gcc-14     cocci
sparc64              randconfig-r2107-20261009    gcc-16.1.0 cocci
sparc64              randconfig-r2301-20261008    clang-24   sparse
sparc64              randconfig-r2309-20261009    gcc-8.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261010    gcc-16.1.0
um                    randconfig-1001-20261010    gcc-16.1.0
um                    randconfig-2000-20261008    gcc-14
um                    randconfig-2000-20261009    clang-17
um                    randconfig-2000-20261010    gcc-16.1.0
um                    randconfig-2001-20261008    gcc-14
um                    randconfig-2001-20261009    clang-17
um                    randconfig-2001-20261010    gcc-16.1.0
um                   randconfig-r2100-20261009    gcc-10.5.0 cocci
um                   randconfig-r2102-20261009    gcc-12     cocci
um                   randconfig-r2201-20261010    clang-17   smatch
um                   randconfig-r2300-20261009    gcc-14     sparse
um                   randconfig-r2303-20261009    gcc-8.5.0  sparse
um                   randconfig-r2304-20261009    clang-24   sparse
um                   randconfig-r2304-20261009    gcc-8.5.0  sparse
um                   randconfig-r2307-20261009    gcc-8.5.0  sparse
um                   randconfig-r2307-20261009    gcc-9.5.0  sparse
um                   randconfig-r2308-20261008    gcc-10.5.0 sparse
um                   randconfig-r2308-20261009    gcc-8.5.0  sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261010    clang-22
x86_64      buildonly-randconfig-1000-20261011    gcc-14
x86_64      buildonly-randconfig-1001-20261010    clang-22
x86_64      buildonly-randconfig-1001-20261011    gcc-14
x86_64      buildonly-randconfig-1002-20261010    clang-22
x86_64      buildonly-randconfig-1002-20261011    gcc-14
x86_64      buildonly-randconfig-1003-20261010    clang-22
x86_64      buildonly-randconfig-1003-20261011    gcc-14
x86_64      buildonly-randconfig-1004-20261010    clang-22
x86_64      buildonly-randconfig-1004-20261011    gcc-14
x86_64      buildonly-randconfig-1005-20261010    clang-22
x86_64      buildonly-randconfig-1005-20261011    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261010    gcc-14
x86_64                randconfig-1000-20261011    gcc-14
x86_64                randconfig-1001-20261010    gcc-14
x86_64                randconfig-1001-20261011    gcc-14
x86_64                randconfig-1002-20261010    gcc-14
x86_64                randconfig-1002-20261011    gcc-14
x86_64                randconfig-1003-20261010    gcc-14
x86_64                randconfig-1003-20261011    gcc-14
x86_64                randconfig-1004-20261010    gcc-14
x86_64                randconfig-1004-20261011    gcc-14
x86_64                randconfig-1005-20261010    gcc-14
x86_64                randconfig-1005-20261011    gcc-14
x86_64                randconfig-1006-20261010    clang-22
x86_64                randconfig-1007-20261010    clang-22
x86_64                randconfig-1008-20261010    clang-22
x86_64                randconfig-1009-20261010    clang-22
x86_64                randconfig-1010-20261010    clang-22
x86_64                randconfig-1011-20261010    clang-22
x86_64                randconfig-1012-20261010    clang-22
x86_64                randconfig-1013-20261010    clang-22
x86_64                randconfig-1014-20261010    clang-22
x86_64                randconfig-1015-20261010    clang-22
x86_64                randconfig-1016-20261010    clang-22
x86_64                randconfig-1017-20261010    clang-22
x86_64                randconfig-2100-20261009    clang-22   cocci
x86_64                randconfig-2100-20261010    clang-22   cocci
x86_64                randconfig-2101-20261009    clang-22   cocci
x86_64                randconfig-2101-20261010    clang-22   cocci
x86_64                randconfig-2102-20261009    clang-22   cocci
x86_64                randconfig-2102-20261010    clang-22   cocci
x86_64                randconfig-2103-20261009    clang-22   cocci
x86_64                randconfig-2103-20261010    clang-22   cocci
x86_64                randconfig-2200-20261008    gcc-14     smatch
x86_64                randconfig-2200-20261009    gcc-14     smatch
x86_64                randconfig-2300-20261008    clang-22   sparse
x86_64                randconfig-2300-20261009    clang-22   sparse
x86_64                randconfig-2300-20261010    gcc-14     sparse
x86_64                randconfig-2301-20261008    clang-22   sparse
x86_64                randconfig-2301-20261009    clang-22   sparse
x86_64                randconfig-2301-20261010    gcc-14     sparse
x86_64                randconfig-2302-20261008    clang-22   sparse
x86_64                randconfig-2302-20261009    clang-22   sparse
x86_64                randconfig-2302-20261010    gcc-14     sparse
x86_64               randconfig-r2103-20261009    gcc-13.4.0 cocci
x86_64               randconfig-r2106-20261010    gcc-14     cocci
x86_64               randconfig-r2202-20261009    clang-22   smatch
x86_64               randconfig-r2300-20261009    clang-21   sparse
x86_64               randconfig-r2306-20261009    clang-22   sparse
x86_64               randconfig-r2307-20261009    gcc-16.1.0 sparse
x86_64               randconfig-r2309-20261009    clang-22   sparse
x86_64               randconfig-r2309-20261010    gcc-14     sparse
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
xtensa                randconfig-1000-20261010    gcc-16.1.0
xtensa                randconfig-1001-20261010    gcc-16.1.0
xtensa                randconfig-2000-20261008    gcc-14
xtensa                randconfig-2000-20261009    clang-17
xtensa                randconfig-2000-20261010    gcc-16.1.0
xtensa                randconfig-2001-20261008    gcc-14
xtensa                randconfig-2001-20261009    clang-17
xtensa                randconfig-2001-20261010    gcc-16.1.0
xtensa               randconfig-r2200-20261010    gcc-8.5.0  smatch
xtensa               randconfig-r2300-20261009    clang-17   sparse
xtensa               randconfig-r2307-20261009    clang-22   sparse
xtensa               randconfig-r2309-20261008    clang-24   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
