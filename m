Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E472472A6
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685320; cv=none; b=J0/94GQ6Tm+dOAZSQkhiuH2qGw11RvB46kW78OJ2PzuVvjCdyihV5X39JDP9GwZcrHUhz3SfaeUJ414EJm24iwnVsh0R3Sc3nNnLNx3/lymXzqpXRk5mc5D98hhfk6pSrYzSaUPBv+cpqHNOBFvbrO1cIyT4XGtwRhwrUoqS+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685320; c=relaxed/simple;
	bh=nmWeLLwoMHSH0C5bE2ShItyuHF7HKTU4jqoLWJu0eBQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ncuPInigMQELQvoXlF0pNdDCNXenGBAHLAWb7pStUXaW7fh33bHNcMROemHBf5EbaGoOe8kV+ypAJwsst6ZK6pRT8td8mRic435qpidi98uMXNnynaGIkSklg/I9v2jgAx+c2laPuMfiIt2AkWaLPzJRF/U83nIEGe5VIOh2ADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFTSzbew; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFTSzbew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791685319; x=1823221319;
  h=date:from:to:cc:subject:message-id;
  bh=nmWeLLwoMHSH0C5bE2ShItyuHF7HKTU4jqoLWJu0eBQ=;
  b=TFTSzbewXe2L3aIkoFhxp8XJvJDy4nPKbatvIxYkaP9bdQfd2qYksx30
   T2j+44S/9ihAD9Bt5mvM6s73xjbJdWTw0DS7pn3HngSqo3G91ESwslUnB
   1G7Igt4Y56oYXGoHBe7uNyC34doYQgu/QNIRf1KDJu1eOpO7BAPOyKl9t
   0Q93JbRS7buFvQKFYU62lMU6Z50TeXJtDzHaIivd01pmkf1V3WN+FDECB
   e720hUkiGuG5hwesDc37RwKVO+LcFTktqkqA0OWZr7qgBqG2jLGABaxxs
   MzGoTKufnB5bJNf+FyyhHouLxaPYTjfQU4sFD8RMVKf4HRmhiGpYo/qMg
   Q==;
X-CSE-ConnectionGUID: xhWEVberSpGIg3CG4IqZqA==
X-CSE-MsgGUID: YlJSOLdJTbuN4WzQMNwmPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="317032"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="317032"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 19:21:58 -0700
X-CSE-ConnectionGUID: ylqoWp6uQ0mVQdrHgWH1Iw==
X-CSE-MsgGUID: TiB2YIr0ROqUzqsbnMNG6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="705369"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Oct 2026 19:21:56 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFjCE-00000000AFa-02ph;
	Sun, 11 Oct 2026 02:21:54 +0000
Date: Sun, 11 Oct 2026 10:21:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 36038f0e8377ef316b723d0d85b1510bc64069ab
Message-ID: <202610111018.uYdnSqor-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: 36038f0e8377ef316b723d0d85b1510bc64069ab  PCI/P2PDMA: Gate the host bridge whitelist warning on verbose

elapsed time: 1306m

configs tested: 346
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20261010    gcc-12.5.0 cocci
alpha                randconfig-r2107-20261010    gcc-8.5.0  cocci
alpha                randconfig-r2305-20261010    gcc-8.5.0  sparse
alpha                randconfig-r2307-20261009    gcc-11.5.0 sparse
alpha                randconfig-r2308-20261009    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261010    gcc-8.5.0
arc                   randconfig-1001-20261010    gcc-8.5.0
arc                  randconfig-r2200-20261010    gcc-14.3.0 smatch
arc                  randconfig-r2300-20261009    clang-22   sparse
arc                  randconfig-r2305-20261010    clang-17   sparse
arc                  randconfig-r2307-20261010    clang-22   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261010    gcc-8.5.0
arm                   randconfig-1001-20261010    gcc-8.5.0
arm                   randconfig-1002-20261010    gcc-8.5.0
arm                   randconfig-1003-20261010    gcc-8.5.0
arm                  randconfig-r2105-20261010    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261009    clang-17   cocci
arm                  randconfig-r2202-20261009    clang-24   smatch
arm                  randconfig-r2303-20261010    gcc-8.5.0  sparse
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261010    gcc-10.5.0
arm64                 randconfig-1001-20261010    gcc-10.5.0
arm64                 randconfig-1002-20261010    gcc-10.5.0
arm64                 randconfig-1003-20261010    gcc-10.5.0
arm64                randconfig-r2101-20261010    gcc-10.5.0 cocci
arm64                randconfig-r2301-20261010    gcc-15.2.0 sparse
arm64                randconfig-r2306-20261009    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261010    gcc-10.5.0
csky                  randconfig-1001-20261010    gcc-10.5.0
csky                 randconfig-r2103-20261010    gcc-16.1.0 cocci
csky                 randconfig-r2104-20261009    gcc-16.1.0 cocci
csky                 randconfig-r2304-20261010    gcc-15.2.0 sparse
csky                 randconfig-r2309-20261009    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261010    clang-17
hexagon               randconfig-1001-20261010    clang-17
hexagon              randconfig-r2103-20261010    gcc-12.5.0 cocci
hexagon              randconfig-r2104-20261009    gcc-16.1.0 cocci
hexagon              randconfig-r2106-20261009    gcc-16.1.0 cocci
hexagon              randconfig-r2106-20261010    gcc-8.5.0  cocci
hexagon              randconfig-r2200-20261010    clang-24   smatch
hexagon              randconfig-r2202-20261009    clang-21   smatch
hexagon              randconfig-r2302-20261010    clang-17   sparse
hexagon              randconfig-r2303-20261009    clang-22   sparse
hexagon              randconfig-r2306-20261010    gcc-16.1.0 sparse
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
i386                  randconfig-2100-20261010    clang-22   cocci
i386                  randconfig-2101-20261009    clang-22   cocci
i386                  randconfig-2101-20261009    gcc-14     cocci
i386                  randconfig-2101-20261010    clang-22   cocci
i386                  randconfig-2102-20261009    clang-22   cocci
i386                  randconfig-2102-20261009    gcc-14     cocci
i386                  randconfig-2102-20261010    clang-22   cocci
i386                  randconfig-2103-20261009    clang-22   cocci
i386                  randconfig-2103-20261010    clang-22   cocci
i386                  randconfig-2200-20261009    gcc-14     smatch
i386                  randconfig-2200-20261010    gcc-12     smatch
i386                  randconfig-2300-20261009    clang-22   sparse
i386                  randconfig-2300-20261010    gcc-14     sparse
i386                  randconfig-2301-20261009    clang-22   sparse
i386                  randconfig-2301-20261010    gcc-14     sparse
i386                  randconfig-2302-20261009    clang-22   sparse
i386                  randconfig-2302-20261010    gcc-14     sparse
i386                 randconfig-r2103-20261010    gcc-12.5.0 cocci
i386                 randconfig-r2107-20261009    gcc-14     cocci
i386                 randconfig-r2305-20261010    gcc-8.5.0  sparse
i386                 randconfig-r2308-20261010    gcc-16.1.0 sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch             randconfig-1000-20261010    clang-17
loongarch             randconfig-1001-20261010    clang-17
loongarch            randconfig-r2300-20261010    clang-17   sparse
loongarch            randconfig-r2304-20261010    gcc-8.5.0  sparse
loongarch            randconfig-r2309-20261010    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2107-20261009    gcc-16.1.0 cocci
m68k                 randconfig-r2202-20261010    gcc-13.4.0 smatch
m68k                 randconfig-r2303-20261010    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze           randconfig-r2103-20261010    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261010    gcc-8.5.0  cocci
microblaze           randconfig-r2200-20261009    gcc-9.5.0  smatch
microblaze           randconfig-r2302-20261010    gcc-15.2.0 sparse
microblaze           randconfig-r2304-20261010    clang-17   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                            ip22_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20261010    gcc-10.5.0 cocci
mips                 randconfig-r2101-20261010    gcc-12.5.0 cocci
mips                 randconfig-r2103-20261009    gcc-12     cocci
mips                 randconfig-r2105-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2106-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2107-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2202-20261010    clang-18   smatch
mips                 randconfig-r2301-20261010    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                 randconfig-1000-20261010    clang-17
nios2                 randconfig-1001-20261010    clang-17
nios2                randconfig-r2100-20261009    gcc-12     cocci
nios2                randconfig-r2106-20261010    gcc-8.5.0  cocci
nios2                randconfig-r2306-20261010    clang-22   sparse
nios2                randconfig-r2308-20261009    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc             randconfig-r2104-20261010    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261009    gcc-16.1.0 cocci
openrisc             randconfig-r2309-20261009    gcc-11.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc               randconfig-r2201-20261010    gcc-10.5.0 smatch
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    gcc-16.1.0
powerpc              randconfig-r2107-20261010    clang-20   cocci
powerpc              randconfig-r2202-20261010    clang-17   smatch
powerpc              randconfig-r2302-20261010    gcc-8.5.0  sparse
powerpc              randconfig-r2306-20261009    gcc-11.5.0 sparse
powerpc                       tqm8xx_defconfig    gcc-16.1.0
powerpc64            randconfig-r2104-20261010    clang-20   cocci
powerpc64            randconfig-r2105-20261009    gcc-11.5.0 cocci
powerpc64            randconfig-r2301-20261010    clang-17   sparse
powerpc64            randconfig-r2304-20261009    clang-22   sparse
powerpc64            randconfig-r2309-20261010    clang-22   sparse
powerpc64            randconfig-r2309-20261010    gcc-14     sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261010    clang-19
riscv                 randconfig-1001-20261010    clang-19
riscv                 randconfig-2000-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261010    gcc-16.1.0
riscv                 randconfig-2001-20261009    gcc-16.1.0
riscv                 randconfig-2001-20261010    gcc-16.1.0
riscv                randconfig-r2100-20261010    gcc-12.5.0 cocci
riscv                randconfig-r2101-20261009    gcc-12     cocci
riscv                randconfig-r2104-20261009    gcc-8.5.0  cocci
riscv                randconfig-r2200-20261009    gcc-10.5.0 smatch
riscv                randconfig-r2300-20261010    gcc-15.2.0 sparse
riscv                randconfig-r2304-20261010    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261010    clang-19
s390                  randconfig-1001-20261010    clang-19
s390                  randconfig-2000-20261009    gcc-16.1.0
s390                  randconfig-2000-20261010    gcc-16.1.0
s390                  randconfig-2001-20261009    gcc-16.1.0
s390                  randconfig-2001-20261010    gcc-16.1.0
s390                 randconfig-r2100-20261010    gcc-16.1.0 cocci
s390                 randconfig-r2102-20261010    gcc-10.5.0 cocci
s390                 randconfig-r2300-20261010    gcc-8.5.0  sparse
s390                 randconfig-r2307-20261010    gcc-16.1.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261010    clang-19
sh                    randconfig-1001-20261010    clang-19
sh                    randconfig-2000-20261009    gcc-16.1.0
sh                    randconfig-2000-20261010    gcc-16.1.0
sh                    randconfig-2001-20261009    gcc-16.1.0
sh                    randconfig-2001-20261010    gcc-16.1.0
sh                   randconfig-r2101-20261010    gcc-12.5.0 cocci
sh                   randconfig-r2107-20261009    gcc-16.1.0 cocci
sh                   randconfig-r2200-20261010    gcc-9.5.0  smatch
sh                   randconfig-r2201-20261010    gcc-15.2.0 smatch
sh                   randconfig-r2301-20261009    clang-22   sparse
sh                   randconfig-r2303-20261010    clang-17   sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261010    gcc-16.1.0
sparc                 randconfig-1001-20261010    gcc-16.1.0
sparc                 randconfig-2000-20261009    clang-17
sparc                 randconfig-2000-20261009    gcc-8.5.0
sparc                 randconfig-2000-20261010    gcc-16.1.0
sparc                 randconfig-2001-20261009    clang-17
sparc                 randconfig-2001-20261009    gcc-14.3.0
sparc                 randconfig-2001-20261010    gcc-16.1.0
sparc                randconfig-r2100-20261010    gcc-12.5.0 cocci
sparc                randconfig-r2101-20261010    gcc-16.1.0 cocci
sparc                randconfig-r2106-20261009    gcc-16.1.0 cocci
sparc                randconfig-r2106-20261010    clang-20   cocci
sparc                randconfig-r2200-20261010    gcc-16.1.0 smatch
sparc                randconfig-r2201-20261009    gcc-11.5.0 smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261010    gcc-16.1.0
sparc64               randconfig-1001-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261009    clang-17
sparc64               randconfig-2000-20261009    gcc-9.5.0
sparc64               randconfig-2000-20261010    gcc-16.1.0
sparc64               randconfig-2001-20261009    clang-17
sparc64               randconfig-2001-20261009    clang-24
sparc64               randconfig-2001-20261010    gcc-16.1.0
sparc64              randconfig-r2302-20261010    gcc-8.5.0  sparse
sparc64              randconfig-r2305-20261010    gcc-15.2.0 sparse
sparc64              randconfig-r2306-20261010    gcc-14     sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261010    gcc-16.1.0
um                    randconfig-1001-20261010    gcc-16.1.0
um                    randconfig-2000-20261009    clang-17
um                    randconfig-2000-20261009    clang-21
um                    randconfig-2000-20261010    gcc-16.1.0
um                    randconfig-2001-20261009    clang-17
um                    randconfig-2001-20261010    gcc-16.1.0
um                   randconfig-r2102-20261009    gcc-12     cocci
um                   randconfig-r2105-20261009    gcc-16.1.0 cocci
um                   randconfig-r2105-20261010    clang-20   cocci
um                   randconfig-r2302-20261009    clang-22   sparse
um                   randconfig-r2307-20261009    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261010    clang-22
x86_64      buildonly-randconfig-1001-20261010    clang-22
x86_64      buildonly-randconfig-1002-20261010    clang-22
x86_64      buildonly-randconfig-1003-20261010    clang-22
x86_64      buildonly-randconfig-1004-20261010    clang-22
x86_64      buildonly-randconfig-1005-20261010    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261010    gcc-14
x86_64                randconfig-1001-20261010    gcc-14
x86_64                randconfig-1002-20261010    gcc-14
x86_64                randconfig-1003-20261010    gcc-14
x86_64                randconfig-1004-20261010    gcc-14
x86_64                randconfig-1005-20261010    gcc-14
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
x86_64                randconfig-2103-20261009    gcc-13     cocci
x86_64                randconfig-2103-20261010    clang-22   cocci
x86_64                randconfig-2200-20261009    gcc-14     smatch
x86_64                randconfig-2200-20261010    gcc-14     smatch
x86_64                randconfig-2300-20261009    clang-22   sparse
x86_64                randconfig-2300-20261010    gcc-14     sparse
x86_64                randconfig-2301-20261009    clang-22   sparse
x86_64                randconfig-2301-20261010    gcc-14     sparse
x86_64                randconfig-2302-20261009    clang-22   sparse
x86_64                randconfig-2302-20261010    gcc-14     sparse
x86_64               randconfig-r2104-20261010    gcc-8.5.0  cocci
x86_64               randconfig-r2201-20261010    clang-22   smatch
x86_64               randconfig-r2303-20261010    gcc-15.2.0 sparse
x86_64               randconfig-r2305-20261009    clang-22   sparse
x86_64               randconfig-r2307-20261010    gcc-14     sparse
x86_64               randconfig-r2308-20261010    clang-22   sparse
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
xtensa                randconfig-2000-20261010    gcc-16.1.0
xtensa                randconfig-2001-20261009    clang-17
xtensa                randconfig-2001-20261009    gcc-8.5.0
xtensa                randconfig-2001-20261010    gcc-16.1.0
xtensa               randconfig-r2102-20261010    gcc-16.1.0 cocci
xtensa               randconfig-r2104-20261010    gcc-8.5.0  cocci
xtensa               randconfig-r2300-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2301-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2308-20261010    gcc-14     sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
