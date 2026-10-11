Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35629ACCD
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685322; cv=none; b=kKMh0eDqcFELJzUnIDjDrl2MVaErOCcB4GTVUFne6lXyBUPSbBnef3JcjtYDdMyQNreDPzDvy6fhv39+MGkrUMPndJkH2jA+pDFGA5OKtGEAG4aU5neH6NR50oH2aj9HlSCUCcsoBrw7T+oTSaBcA8USaJJnayHJkPyetNWWVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685322; c=relaxed/simple;
	bh=F6CkJBWtUmqttZ+VwQz2/V9pFrZZ838TDyVSaOLI3aA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uF1o34a5gh8dHYlEG47mPDZ5g0D5e+ShaGLX5+Wl58ObHVVnxPyAbPxGHYitXWqWUZMzDkOgpbYMKg2G2G+ImqtVric46k74OPnMOJLFTXjP9rywhy2BuRUvRP3FBc1rBrf2MqBcmasuzmKZNfQgOYSHzC2hxST0yyHu/EFe6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLX5MXGl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLX5MXGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791685321; x=1823221321;
  h=date:from:to:cc:subject:message-id;
  bh=F6CkJBWtUmqttZ+VwQz2/V9pFrZZ838TDyVSaOLI3aA=;
  b=CLX5MXGlafRJZY6IvagaAuSKFQwqC0Nr9Pc+ClwACZfvE/XgLp7nfGce
   0P7nz3cwdPIvPaSz+tQ7sWQEHWmHW0ibgOaivyOYYxMJdCFHNyH8SJUXl
   64GAVI4wnutyOiUw6NwOMn5etdQyxkvbSR9ynQh8GYO+qtenQ4RrICDBx
   VTUWPlaEW5u1NnT7lvxrZyo2WOAqsj8cCFaQIOsdLslSSFQmQ6F+xpPUY
   qtSWM+YPG7ZKR0ymYIsiaOAyLoJ9k/hgzOnBaoVM/JDF5XHq7Xka2qLBy
   zxSnAyQ9sFNJvimvrMSjh+jYezRy8r9jMtLRDA9t2ws3S/AsEWgDnKm3a
   g==;
X-CSE-ConnectionGUID: 6JCRwv/8SICfqS17NnJGUQ==
X-CSE-MsgGUID: Byrxg9+aRF61GbjPxQpNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="462081"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="462081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 19:21:58 -0700
X-CSE-ConnectionGUID: o1Q8dStSSWWZrkzeJ7c0aA==
X-CSE-MsgGUID: uWpG8HjdSHmAfFQoPJV5Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="577106"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2026 19:21:56 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFjCE-00000000AFc-0Efy;
	Sun, 11 Oct 2026 02:21:54 +0000
Date: Sun, 11 Oct 2026 10:21:40 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 05503ec0125c9215d38b4696e39ba36decd1f6ee
Message-ID: <202610111036.xlVgd7rM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 05503ec0125c9215d38b4696e39ba36decd1f6ee  PCI/pwrctrl: Only destroy devices created by pwrctrl core

elapsed time: 1306m

configs tested: 410
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261009    clang-18   cocci
alpha                randconfig-r2103-20261009    gcc-10.5.0 cocci
alpha                randconfig-r2104-20261009    gcc-9.5.0  cocci
alpha                randconfig-r2200-20261009    gcc-8.5.0  smatch
alpha                randconfig-r2300-20261009    gcc-8.5.0  sparse
alpha                randconfig-r2304-20261009    gcc-13.4.0 sparse
alpha                randconfig-r2305-20261009    clang-17   sparse
alpha                randconfig-r2305-20261009    gcc-8.5.0  sparse
alpha                randconfig-r2306-20261009    gcc-12.5.0 sparse
alpha                randconfig-r2308-20261009    gcc-14     sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261010    gcc-8.5.0
arc                   randconfig-1000-20261011    clang-24
arc                   randconfig-1001-20261010    gcc-8.5.0
arc                   randconfig-1001-20261011    clang-24
arc                  randconfig-r2101-20261009    gcc-14.3.0 cocci
arc                  randconfig-r2105-20261009    gcc-13.4.0 cocci
arc                  randconfig-r2107-20261009    gcc-9.5.0  cocci
arc                  randconfig-r2201-20261009    gcc-16.1.0 smatch
arc                  randconfig-r2302-20261009    gcc-8.5.0  sparse
arc                  randconfig-r2303-20261009    gcc-8.5.0  sparse
arc                  randconfig-r2306-20261009    gcc-9.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261010    gcc-8.5.0
arm                   randconfig-1000-20261011    clang-24
arm                   randconfig-1001-20261010    gcc-8.5.0
arm                   randconfig-1001-20261011    clang-24
arm                   randconfig-1002-20261010    gcc-8.5.0
arm                   randconfig-1002-20261011    clang-24
arm                   randconfig-1003-20261010    gcc-8.5.0
arm                   randconfig-1003-20261011    clang-24
arm                  randconfig-r2102-20261009    gcc-14     cocci
arm                  randconfig-r2103-20261009    clang-17   cocci
arm                  randconfig-r2105-20261009    gcc-16.1.0 cocci
arm                  randconfig-r2105-20261009    gcc-9.5.0  cocci
arm                  randconfig-r2200-20261009    clang-24   smatch
arm                  randconfig-r2201-20261009    clang-24   smatch
arm                  randconfig-r2202-20261009    clang-24   smatch
arm                  randconfig-r2301-20261009    gcc-10.5.0 sparse
arm                  randconfig-r2302-20261009    gcc-10.5.0 sparse
arm                  randconfig-r2302-20261009    gcc-12     sparse
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261010    gcc-10.5.0
arm64                 randconfig-1001-20261010    gcc-10.5.0
arm64                 randconfig-1002-20261010    gcc-10.5.0
arm64                 randconfig-1003-20261010    gcc-10.5.0
arm64                randconfig-r2104-20261009    gcc-9.5.0  cocci
arm64                randconfig-r2105-20261009    clang-24   cocci
arm64                randconfig-r2107-20261009    gcc-9.5.0  cocci
arm64                randconfig-r2202-20261009    gcc-10.5.0 smatch
arm64                randconfig-r2303-20261009    gcc-10.5.0 sparse
arm64                randconfig-r2305-20261009    gcc-10.5.0 sparse
arm64                randconfig-r2307-20261009    gcc-11.5.0 sparse
arm64                randconfig-r2309-20261009    gcc-11.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261010    gcc-10.5.0
csky                  randconfig-1001-20261010    gcc-10.5.0
csky                 randconfig-r2102-20261009    clang-18   cocci
csky                 randconfig-r2106-20261009    clang-24   cocci
csky                 randconfig-r2202-20261009    gcc-12.5.0 smatch
csky                 randconfig-r2300-20261009    clang-24   sparse
csky                 randconfig-r2302-20261009    clang-24   sparse
csky                 randconfig-r2302-20261009    gcc-10.5.0 sparse
csky                 randconfig-r2306-20261009    gcc-11.5.0 sparse
csky                 randconfig-r2308-20261009    clang-17   sparse
csky                 randconfig-r2308-20261009    clang-22   sparse
csky                 randconfig-r2308-20261009    gcc-16.1.0 sparse
csky                 randconfig-r2309-20261009    gcc-12.5.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261010    clang-17
hexagon               randconfig-1001-20261010    clang-17
hexagon              randconfig-r2301-20261009    gcc-12     sparse
hexagon              randconfig-r2308-20261009    gcc-12.5.0 sparse
hexagon              randconfig-r2309-20261009    gcc-14     sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
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
i386                  randconfig-2100-20261009    clang-22   cocci
i386                  randconfig-2101-20261009    clang-22   cocci
i386                  randconfig-2101-20261009    gcc-14     cocci
i386                  randconfig-2102-20261009    clang-22   cocci
i386                  randconfig-2102-20261009    gcc-14     cocci
i386                  randconfig-2103-20261009    clang-22   cocci
i386                  randconfig-2200-20261009    gcc-14     smatch
i386                  randconfig-2300-20261009    clang-22   sparse
i386                  randconfig-2301-20261009    clang-22   sparse
i386                  randconfig-2301-20261009    gcc-14     sparse
i386                  randconfig-2302-20261009    clang-22   sparse
i386                  randconfig-2302-20261009    gcc-14     sparse
i386                 randconfig-r2100-20261009    gcc-14     cocci
i386                 randconfig-r2103-20261009    gcc-14     cocci
i386                 randconfig-r2304-20261009    gcc-12     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261010    clang-17
loongarch             randconfig-1001-20261010    clang-17
loongarch            randconfig-r2100-20261009    gcc-13.4.0 cocci
loongarch            randconfig-r2103-20261009    gcc-16.1.0 cocci
loongarch            randconfig-r2200-20261009    gcc-16.1.0 smatch
loongarch            randconfig-r2202-20261009    clang-18   smatch
loongarch            randconfig-r2302-20261009    clang-24   sparse
loongarch            randconfig-r2303-20261009    clang-17   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2100-20261009    gcc-16.1.0 cocci
m68k                 randconfig-r2100-20261009    gcc-8.5.0  cocci
m68k                 randconfig-r2103-20261009    gcc-14.3.0 cocci
m68k                 randconfig-r2201-20261009    gcc-11.5.0 smatch
m68k                 randconfig-r2301-20261009    clang-24   sparse
m68k                 randconfig-r2307-20261009    gcc-12.5.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2107-20261009    gcc-10.5.0 cocci
microblaze           randconfig-r2200-20261009    gcc-9.5.0  smatch
microblaze           randconfig-r2302-20261009    gcc-13.4.0 sparse
microblaze           randconfig-r2309-20261009    gcc-12.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                            ip22_defconfig    gcc-16.1.0
mips                 randconfig-r2102-20261009    gcc-10.5.0 cocci
mips                 randconfig-r2102-20261009    gcc-16.1.0 cocci
mips                 randconfig-r2104-20261009    clang-17   cocci
mips                 randconfig-r2106-20261009    gcc-9.5.0  cocci
mips                 randconfig-r2303-20261009    clang-24   sparse
mips                 randconfig-r2304-20261009    clang-17   sparse
mips                 randconfig-r2304-20261009    gcc-10.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261010    clang-17
nios2                 randconfig-1001-20261010    clang-17
nios2                randconfig-r2101-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2102-20261009    gcc-13.4.0 cocci
nios2                randconfig-r2102-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2106-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2107-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2200-20261009    gcc-8.5.0  smatch
nios2                randconfig-r2300-20261009    gcc-10.5.0 sparse
nios2                randconfig-r2304-20261009    gcc-8.5.0  sparse
nios2                randconfig-r2309-20261009    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261009    gcc-10.5.0 cocci
openrisc             randconfig-r2101-20261009    gcc-13.4.0 cocci
openrisc             randconfig-r2105-20261009    gcc-9.5.0  cocci
openrisc             randconfig-r2107-20261009    clang-24   cocci
openrisc             randconfig-r2300-20261009    gcc-8.5.0  sparse
openrisc             randconfig-r2301-20261009    clang-17   sparse
openrisc             randconfig-r2304-20261009    gcc-9.5.0  sparse
openrisc             randconfig-r2305-20261009    clang-24   sparse
openrisc             randconfig-r2305-20261009    gcc-10.5.0 sparse
openrisc             randconfig-r2306-20261009    gcc-14     sparse
openrisc             randconfig-r2308-20261009    gcc-11.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc               randconfig-r2101-20261009    clang-18   cocci
parisc               randconfig-r2103-20261009    gcc-8.5.0  cocci
parisc               randconfig-r2105-20261009    clang-24   cocci
parisc               randconfig-r2201-20261009    gcc-10.5.0 smatch
parisc               randconfig-r2302-20261009    clang-17   sparse
parisc               randconfig-r2302-20261009    gcc-8.5.0  sparse
parisc               randconfig-r2305-20261009    gcc-8.5.0  sparse
parisc               randconfig-r2309-20261009    gcc-9.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    gcc-16.1.0
powerpc              randconfig-r2103-20261009    clang-18   cocci
powerpc              randconfig-r2105-20261009    gcc-8.5.0  cocci
powerpc              randconfig-r2107-20261009    clang-24   cocci
powerpc              randconfig-r2301-20261009    gcc-8.5.0  sparse
powerpc                       tqm8xx_defconfig    gcc-16.1.0
powerpc64            randconfig-r2100-20261009    gcc-8.5.0  cocci
powerpc64            randconfig-r2101-20261009    gcc-16.1.0 cocci
powerpc64            randconfig-r2101-20261009    gcc-8.5.0  cocci
powerpc64            randconfig-r2104-20261009    clang-24   cocci
powerpc64            randconfig-r2104-20261009    gcc-16.1.0 cocci
powerpc64            randconfig-r2200-20261009    clang-24   smatch
powerpc64            randconfig-r2301-20261009    gcc-8.5.0  sparse
powerpc64            randconfig-r2303-20261009    gcc-13.4.0 sparse
powerpc64            randconfig-r2304-20261009    gcc-10.5.0 sparse
powerpc64            randconfig-r2305-20261009    gcc-12     sparse
powerpc64            randconfig-r2306-20261009    gcc-8.5.0  sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261010    clang-19
riscv                 randconfig-1000-20261011    clang-17
riscv                 randconfig-1001-20261010    clang-19
riscv                 randconfig-1001-20261011    clang-17
riscv                 randconfig-2000-20261009    gcc-16.1.0
riscv                 randconfig-2001-20261009    gcc-16.1.0
riscv                randconfig-r2100-20261009    gcc-8.5.0  cocci
riscv                randconfig-r2102-20261009    gcc-8.5.0  cocci
riscv                randconfig-r2106-20261009    clang-24   cocci
riscv                randconfig-r2300-20261009    gcc-12     sparse
riscv                randconfig-r2306-20261009    clang-17   sparse
riscv                randconfig-r2307-20261009    clang-17   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261010    clang-19
s390                  randconfig-1000-20261011    clang-17
s390                  randconfig-1001-20261010    clang-19
s390                  randconfig-1001-20261011    clang-17
s390                  randconfig-2000-20261009    gcc-16.1.0
s390                  randconfig-2001-20261009    gcc-16.1.0
s390                 randconfig-r2102-20261009    clang-24   cocci
s390                 randconfig-r2104-20261009    clang-24   cocci
s390                 randconfig-r2104-20261009    gcc-8.5.0  cocci
s390                 randconfig-r2106-20261009    gcc-13.4.0 cocci
s390                 randconfig-r2202-20261009    clang-18   smatch
s390                 randconfig-r2306-20261009    gcc-11.5.0 sparse
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
sh                    randconfig-2001-20261009    gcc-16.1.0
sh                   randconfig-r2201-20261009    gcc-16.1.0 smatch
sh                   randconfig-r2300-20261009    gcc-10.5.0 sparse
sh                   randconfig-r2300-20261009    gcc-13.4.0 sparse
sh                   randconfig-r2301-20261009    gcc-10.5.0 sparse
sh                   randconfig-r2305-20261009    gcc-13.4.0 sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261010    gcc-16.1.0
sparc                 randconfig-1001-20261010    gcc-16.1.0
sparc                 randconfig-2000-20261009    clang-17
sparc                 randconfig-2000-20261009    gcc-8.5.0
sparc                 randconfig-2001-20261009    clang-17
sparc                 randconfig-2001-20261009    gcc-14.3.0
sparc                randconfig-r2100-20261009    gcc-14.3.0 cocci
sparc                randconfig-r2103-20261009    gcc-13.4.0 cocci
sparc                randconfig-r2106-20261009    gcc-16.1.0 cocci
sparc                randconfig-r2200-20261009    gcc-16.1.0 smatch
sparc                randconfig-r2303-20261009    gcc-10.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261010    gcc-16.1.0
sparc64               randconfig-1001-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261009    clang-17
sparc64               randconfig-2000-20261009    gcc-9.5.0
sparc64               randconfig-2001-20261009    clang-17
sparc64               randconfig-2001-20261009    clang-24
sparc64              randconfig-r2101-20261009    gcc-13.4.0 cocci
sparc64              randconfig-r2102-20261009    clang-18   cocci
sparc64              randconfig-r2102-20261009    gcc-14.3.0 cocci
sparc64              randconfig-r2103-20261009    gcc-8.5.0  cocci
sparc64              randconfig-r2105-20261009    gcc-8.5.0  cocci
sparc64              randconfig-r2106-20261009    gcc-9.5.0  cocci
sparc64              randconfig-r2107-20261009    gcc-13.4.0 cocci
sparc64              randconfig-r2107-20261009    gcc-16.1.0 cocci
sparc64              randconfig-r2201-20261009    clang-24   smatch
sparc64              randconfig-r2300-20261009    clang-20   sparse
sparc64              randconfig-r2301-20261009    gcc-13.4.0 sparse
sparc64              randconfig-r2303-20261009    gcc-12     sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261010    gcc-16.1.0
um                    randconfig-1001-20261010    gcc-16.1.0
um                    randconfig-2000-20261009    clang-17
um                    randconfig-2000-20261009    clang-21
um                    randconfig-2001-20261009    clang-17
um                   randconfig-r2100-20261009    gcc-10.5.0 cocci
um                   randconfig-r2104-20261009    gcc-13.4.0 cocci
um                   randconfig-r2201-20261009    clang-24   smatch
um                   randconfig-r2202-20261009    gcc-14     smatch
um                   randconfig-r2304-20261009    clang-24   sparse
um                   randconfig-r2304-20261009    gcc-8.5.0  sparse
um                   randconfig-r2305-20261009    clang-24   sparse
um                   randconfig-r2307-20261009    gcc-8.5.0  sparse
um                   randconfig-r2307-20261009    gcc-9.5.0  sparse
um                   randconfig-r2308-20261009    gcc-8.5.0  sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
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
x86_64                randconfig-2101-20261009    clang-22   cocci
x86_64                randconfig-2102-20261009    clang-22   cocci
x86_64                randconfig-2103-20261009    clang-22   cocci
x86_64                randconfig-2200-20261009    gcc-14     smatch
x86_64                randconfig-2300-20261009    clang-22   sparse
x86_64                randconfig-2300-20261009    gcc-14     sparse
x86_64                randconfig-2301-20261009    clang-22   sparse
x86_64                randconfig-2302-20261009    clang-22   sparse
x86_64               randconfig-r2201-20261009    gcc-14     smatch
x86_64               randconfig-r2303-20261009    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261009    clang-22   sparse
x86_64               randconfig-r2307-20261009    gcc-14     sparse
x86_64               randconfig-r2309-20261009    clang-22   sparse
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
xtensa                randconfig-2000-20261009    clang-17
xtensa                randconfig-2000-20261009    gcc-10.5.0
xtensa                randconfig-2001-20261009    clang-17
xtensa                randconfig-2001-20261009    gcc-8.5.0
xtensa               randconfig-r2101-20261009    clang-18   cocci
xtensa               randconfig-r2101-20261009    gcc-14     cocci
xtensa               randconfig-r2201-20261009    gcc-16.1.0 smatch
xtensa               randconfig-r2300-20261009    clang-17   sparse
xtensa               randconfig-r2307-20261009    clang-22   sparse
xtensa               randconfig-r2309-20261009    clang-17   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
