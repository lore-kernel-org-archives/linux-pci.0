Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367A475336
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550471; cv=none; b=Yc5DJtrJWLsIyOoAluRU/4OJRHZ09rPVKNZvOs0xxa88kgSWm5GMP2WZZrtcn+SX54PLG6o0/4ASmu2RDyZ+SelNARNbg8cQgvbGIoEVuZffUarZEmp71rfjbf2boKl71ekWotuBflrYNJDZs7BrsU5m1n8Iwh0z92uD7ysL9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550471; c=relaxed/simple;
	bh=ZmNBd8yc+Y5tFeITHVnvxxxrt+jLld8gZ4AcwwF2cbw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EEDOBGif01zBlt22OzxBUXVgd+E7N8+q6ss645H2D8EvCBIVV1j0QQPyLK7h6DHmBKk5D4bgkWipCLB5zWugsA8T9Lw5G10IGVZ3MFp0hHDYFi4xb4Q5hkGZyX3rNszvRD5bynB12JSs+gaFzGmOO7Zv9pFU7PTsEn8Pvm4F4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByQhqsAE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByQhqsAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791550468; x=1823086468;
  h=date:from:to:cc:subject:message-id;
  bh=ZmNBd8yc+Y5tFeITHVnvxxxrt+jLld8gZ4AcwwF2cbw=;
  b=ByQhqsAEyw1L3gCOjln5LasxrZfrEomR+Tj5R/yec4rfgNxV4Lyt7p8t
   /uDeaGgVNpq2FkQWSo+eVI53IZHK44SnYLJ2hM4DybdB2ieN1IU/MTCK4
   HpXnK38uJSNxfNy378ZaU/VmfNsvqSCquHQTfhh+U1eta2P0ZYv2MhMRi
   qbVQdQg+dpoeaskX4UA2gl7T6WUYP6aY+eWm6tCRoa31qSJsZ+nqdtWBH
   gL3fJk3hvympXgU6+0okCYx83aR4w6eC5Ujon1obbXz9g1yFCKxtxmCHO
   uQhxVdPmgUpevpQfLdSKuY+dujzIs5yuoFBhQ8GvYI+7UpucjuowPx8sD
   Q==;
X-CSE-ConnectionGUID: MWMOqMDAQuaF65nKid3yJw==
X-CSE-MsgGUID: S074Wz5eSbe0Q0pTOAgnHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="375662"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="375662"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:54:27 -0700
X-CSE-ConnectionGUID: JAPXnqjORL+tE4ZCUksAZg==
X-CSE-MsgGUID: 5S5O656/SPO39HcNJqHdOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="661567"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Oct 2026 05:54:26 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFA7D-000000005nc-2dSF;
	Fri, 09 Oct 2026 12:54:23 +0000
Date: Fri, 09 Oct 2026 20:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 e86ac10110d00e6c3801f38bde1863951315222b
Message-ID: <202610092040.h52nUtKm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: e86ac10110d00e6c3801f38bde1863951315222b  PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

elapsed time: 1426m

configs tested: 370
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20261007    clang-17   cocci
alpha                randconfig-r2201-20261007    gcc-13.4.0 smatch
alpha                randconfig-r2202-20261007    gcc-8.5.0  smatch
alpha                randconfig-r2304-20261007    clang-24   sparse
alpha                randconfig-r2307-20261007    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261009    gcc-10.5.0
arc                   randconfig-1001-20261009    gcc-10.5.0
arc                  randconfig-r2101-20261007    gcc-15.2.0 cocci
arc                  randconfig-r2102-20261007    clang-24   cocci
arc                  randconfig-r2102-20261007    gcc-15.2.0 cocci
arc                  randconfig-r2104-20261007    clang-24   cocci
arc                  randconfig-r2105-20261007    gcc-9.5.0  cocci
arc                  randconfig-r2300-20261007    gcc-8.5.0  sparse
arc                  randconfig-r2302-20261007    gcc-8.5.0  sparse
arc                  randconfig-r2302-20261007    gcc-9.5.0  sparse
arc                  randconfig-r2304-20261007    clang-17   sparse
arc                  randconfig-r2305-20261007    gcc-16.1.0 sparse
arc                  randconfig-r2306-20261007    clang-24   sparse
arc                  randconfig-r2307-20261007    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261009    gcc-10.5.0
arm                   randconfig-1001-20261009    gcc-10.5.0
arm                   randconfig-1002-20261009    gcc-10.5.0
arm                   randconfig-1003-20261009    gcc-10.5.0
arm                  randconfig-r2102-20261007    clang-20   cocci
arm                  randconfig-r2103-20261007    gcc-15.2.0 cocci
arm                  randconfig-r2107-20261007    gcc-16.1.0 cocci
arm                  randconfig-r2200-20261007    gcc-12.5.0 smatch
arm                  randconfig-r2201-20261007    clang-17   smatch
arm                  randconfig-r2202-20261007    gcc-12.5.0 smatch
arm                  randconfig-r2304-20261007    gcc-9.5.0  sparse
arm                  randconfig-r2305-20261007    clang-18   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261009    gcc-15.2.0
arm64                 randconfig-1001-20261009    gcc-15.2.0
arm64                 randconfig-1002-20261009    gcc-15.2.0
arm64                 randconfig-1003-20261009    gcc-15.2.0
arm64                randconfig-r2107-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2300-20261007    gcc-16.1.0 sparse
arm64                randconfig-r2305-20261007    gcc-9.5.0  sparse
arm64                randconfig-r2306-20261007    clang-17   sparse
arm64                randconfig-r2306-20261007    gcc-14     sparse
arm64                randconfig-r2309-20261007    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261009    gcc-15.2.0
csky                  randconfig-1001-20261009    gcc-15.2.0
csky                 randconfig-r2100-20261007    clang-20   cocci
csky                 randconfig-r2100-20261007    gcc-16.1.0 cocci
csky                 randconfig-r2102-20261007    gcc-10.5.0 cocci
csky                 randconfig-r2104-20261007    gcc-16.1.0 cocci
csky                 randconfig-r2106-20261007    gcc-9.5.0  cocci
csky                 randconfig-r2200-20261007    gcc-10.5.0 smatch
csky                 randconfig-r2300-20261007    gcc-9.5.0  sparse
csky                 randconfig-r2304-20261007    gcc-8.5.0  sparse
csky                 randconfig-r2306-20261007    gcc-13.4.0 sparse
csky                 randconfig-r2307-20261007    gcc-13.4.0 sparse
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261009    clang-18
hexagon               randconfig-1001-20261009    clang-18
hexagon              randconfig-r2300-20261007    gcc-14     sparse
hexagon              randconfig-r2304-20261007    gcc-9.5.0  sparse
hexagon              randconfig-r2309-20261007    gcc-8.5.0  sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261009    clang-22
i386        buildonly-randconfig-1001-20261009    clang-22
i386        buildonly-randconfig-1002-20261009    clang-22
i386        buildonly-randconfig-1003-20261009    clang-22
i386        buildonly-randconfig-1004-20261009    clang-22
i386        buildonly-randconfig-1005-20261009    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261009    clang-22
i386                  randconfig-1001-20261009    clang-22
i386                  randconfig-1002-20261009    clang-22
i386                  randconfig-1003-20261009    clang-22
i386                  randconfig-1004-20261009    clang-22
i386                  randconfig-1005-20261009    clang-22
i386                  randconfig-1006-20261009    clang-22
i386                  randconfig-1007-20261009    clang-22
i386                  randconfig-1008-20261009    clang-22
i386                  randconfig-1009-20261009    clang-22
i386                  randconfig-1010-20261009    clang-22
i386                  randconfig-1011-20261009    clang-22
i386                  randconfig-1012-20261009    clang-22
i386                  randconfig-1013-20261009    clang-22
i386                  randconfig-2100-20261007    clang-22   cocci
i386                  randconfig-2101-20261007    clang-22   cocci
i386                  randconfig-2102-20261007    clang-22   cocci
i386                  randconfig-2103-20261007    clang-22   cocci
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                  randconfig-2300-20261007    clang-22   sparse
i386                  randconfig-2301-20261007    clang-22   sparse
i386                  randconfig-2302-20261007    clang-22   sparse
i386                 randconfig-r2100-20261007    gcc-10.5.0 cocci
i386                 randconfig-r2106-20261007    gcc-9.5.0  cocci
i386                 randconfig-r2201-20261007    clang-22   smatch
i386                 randconfig-r2302-20261007    gcc-16.1.0 sparse
i386                 randconfig-r2307-20261007    gcc-13.4.0 sparse
i386                 randconfig-r2309-20261007    gcc-14     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261009    clang-18
loongarch             randconfig-1001-20261009    clang-18
loongarch            randconfig-r2100-20261007    clang-24   cocci
loongarch            randconfig-r2104-20261007    gcc-8.5.0  cocci
loongarch            randconfig-r2105-20261007    gcc-16.1.0 cocci
loongarch            randconfig-r2106-20261007    clang-24   cocci
loongarch            randconfig-r2106-20261007    gcc-16.1.0 cocci
loongarch            randconfig-r2107-20261007    gcc-16.1.0 cocci
loongarch            randconfig-r2200-20261007    clang-24   smatch
loongarch            randconfig-r2202-20261007    gcc-16.1.0 smatch
loongarch            randconfig-r2304-20261007    gcc-16.1.0 sparse
loongarch            randconfig-r2309-20261007    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-24
m68k                 randconfig-r2101-20261007    clang-20   cocci
m68k                 randconfig-r2101-20261007    gcc-10.5.0 cocci
m68k                 randconfig-r2202-20261007    gcc-15.2.0 smatch
m68k                 randconfig-r2301-20261007    clang-17   sparse
m68k                 randconfig-r2301-20261007    gcc-16.1.0 sparse
m68k                 randconfig-r2302-20261007    clang-24   sparse
m68k                 randconfig-r2304-20261007    clang-18   sparse
m68k                 randconfig-r2307-20261007    clang-17   sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261007    clang-20   cocci
microblaze           randconfig-r2105-20261007    gcc-9.5.0  cocci
microblaze           randconfig-r2300-20261007    clang-18   sparse
microblaze           randconfig-r2301-20261007    gcc-8.5.0  sparse
microblaze           randconfig-r2306-20261007    gcc-13.4.0 sparse
microblaze           randconfig-r2309-20261007    clang-17   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                            ci20_defconfig    gcc-16.1.0
mips                 randconfig-r2103-20261007    gcc-15.2.0 cocci
mips                 randconfig-r2104-20261007    clang-17   cocci
mips                 randconfig-r2105-20261007    clang-17   cocci
mips                 randconfig-r2202-20261007    clang-17   smatch
mips                 randconfig-r2301-20261007    gcc-9.5.0  sparse
mips                 randconfig-r2304-20261007    gcc-14     sparse
mips                 randconfig-r2308-20261007    gcc-8.5.0  sparse
mips                 randconfig-r2309-20261007    gcc-11.5.0 sparse
nios2                             alldefconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261009    clang-18
nios2                 randconfig-1001-20261009    clang-18
nios2                randconfig-r2100-20261007    clang-17   cocci
nios2                randconfig-r2100-20261007    gcc-15.2.0 cocci
nios2                randconfig-r2105-20261007    gcc-8.5.0  cocci
nios2                randconfig-r2106-20261007    clang-17   cocci
nios2                randconfig-r2106-20261007    gcc-16.1.0 cocci
nios2                randconfig-r2302-20261007    gcc-9.5.0  sparse
nios2                randconfig-r2303-20261007    gcc-9.5.0  sparse
nios2                randconfig-r2305-20261007    clang-24   sparse
nios2                randconfig-r2307-20261007    gcc-11.5.0 sparse
nios2                randconfig-r2307-20261007    gcc-14     sparse
nios2                randconfig-r2309-20261007    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261007    clang-24   cocci
openrisc             randconfig-r2104-20261007    gcc-9.5.0  cocci
openrisc             randconfig-r2301-20261007    clang-24   sparse
openrisc             randconfig-r2308-20261007    gcc-11.5.0 sparse
openrisc             randconfig-r2309-20261007    gcc-13.4.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261009    gcc-8.5.0
parisc                randconfig-1001-20261009    gcc-8.5.0
parisc               randconfig-r2303-20261007    gcc-8.5.0  sparse
parisc               randconfig-r2303-20261007    gcc-9.5.0  sparse
parisc               randconfig-r2304-20261007    gcc-8.5.0  sparse
parisc               randconfig-r2305-20261007    gcc-14     sparse
parisc               randconfig-r2305-20261007    gcc-8.5.0  sparse
parisc               randconfig-r2306-20261007    gcc-11.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.1.0
powerpc                       chrp32_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc               randconfig-1000-20261009    gcc-8.5.0
powerpc               randconfig-1001-20261009    gcc-8.5.0
powerpc              randconfig-r2100-20261007    clang-20   cocci
powerpc              randconfig-r2104-20261007    gcc-13.4.0 cocci
powerpc              randconfig-r2107-20261007    clang-17   cocci
powerpc              randconfig-r2201-20261007    clang-24   smatch
powerpc              randconfig-r2302-20261007    gcc-14     sparse
powerpc              randconfig-r2308-20261007    clang-24   sparse
powerpc              randconfig-r2308-20261007    gcc-13.4.0 sparse
powerpc64             randconfig-1000-20261009    gcc-8.5.0
powerpc64             randconfig-1001-20261009    gcc-8.5.0
powerpc64            randconfig-r2100-20261007    gcc-15.2.0 cocci
powerpc64            randconfig-r2103-20261007    gcc-10.5.0 cocci
powerpc64            randconfig-r2107-20261007    clang-24   cocci
powerpc64            randconfig-r2202-20261007    gcc-10.5.0 smatch
powerpc64            randconfig-r2300-20261007    clang-24   sparse
powerpc64            randconfig-r2302-20261007    gcc-8.5.0  sparse
powerpc64            randconfig-r2303-20261007    clang-17   sparse
powerpc64            randconfig-r2303-20261007    gcc-16.1.0 sparse
powerpc64            randconfig-r2308-20261007    gcc-14     sparse
riscv                             alldefconfig    gcc-16.1.0
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261009    gcc-16.1.0
riscv                 randconfig-1001-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261007    gcc-12.5.0
riscv                 randconfig-2001-20261007    gcc-12.5.0
riscv                randconfig-r2101-20261007    clang-17   cocci
riscv                randconfig-r2102-20261007    gcc-15.2.0 cocci
riscv                randconfig-r2104-20261007    gcc-9.5.0  cocci
riscv                randconfig-r2106-20261007    gcc-8.5.0  cocci
riscv                randconfig-r2201-20261007    clang-24   smatch
riscv                randconfig-r2202-20261007    gcc-12.5.0 smatch
riscv                randconfig-r2303-20261007    clang-18   sparse
riscv                randconfig-r2308-20261007    clang-17   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261009    gcc-16.1.0
s390                  randconfig-1001-20261009    gcc-16.1.0
s390                  randconfig-2000-20261007    gcc-12.5.0
s390                  randconfig-2001-20261007    gcc-12.5.0
s390                 randconfig-r2105-20261007    gcc-13.4.0 cocci
s390                 randconfig-r2200-20261007    clang-22   smatch
s390                 randconfig-r2300-20261007    gcc-9.5.0  sparse
s390                 randconfig-r2301-20261007    gcc-9.5.0  sparse
s390                 randconfig-r2303-20261007    gcc-8.5.0  sparse
s390                 randconfig-r2305-20261007    gcc-8.5.0  sparse
s390                 randconfig-r2306-20261007    clang-24   sparse
s390                 randconfig-r2308-20261007    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20261009    gcc-16.1.0
sh                    randconfig-1001-20261009    gcc-16.1.0
sh                    randconfig-2000-20261007    gcc-12.5.0
sh                    randconfig-2001-20261007    gcc-12.5.0
sh                   randconfig-r2301-20261007    clang-18   sparse
sh                   randconfig-r2305-20261007    clang-17   sparse
sh                   randconfig-r2306-20261007    gcc-8.5.0  sparse
sh                   randconfig-r2308-20261007    gcc-13.4.0 sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261009    clang-18
sparc                 randconfig-1001-20261009    clang-18
sparc                 randconfig-2000-20261007    clang-24
sparc                 randconfig-2001-20261007    clang-24
sparc                randconfig-r2102-20261007    clang-20   cocci
sparc                randconfig-r2107-20261007    gcc-13.4.0 cocci
sparc                randconfig-r2301-20261007    gcc-8.5.0  sparse
sparc                randconfig-r2303-20261007    clang-24   sparse
sparc                randconfig-r2303-20261007    gcc-14     sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261009    clang-18
sparc64               randconfig-1001-20261009    clang-18
sparc64               randconfig-2000-20261007    clang-24
sparc64               randconfig-2001-20261007    clang-24
sparc64              randconfig-r2101-20261007    gcc-15.2.0 cocci
sparc64              randconfig-r2101-20261007    gcc-16.1.0 cocci
sparc64              randconfig-r2103-20261007    clang-20   cocci
sparc64              randconfig-r2103-20261007    clang-24   cocci
sparc64              randconfig-r2106-20261007    gcc-13.4.0 cocci
sparc64              randconfig-r2200-20261007    clang-21   smatch
sparc64              randconfig-r2300-20261007    gcc-8.5.0  sparse
sparc64              randconfig-r2306-20261007    gcc-11.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261009    clang-18
um                    randconfig-1001-20261009    clang-18
um                    randconfig-2000-20261007    clang-24
um                    randconfig-2001-20261007    clang-24
um                   randconfig-r2105-20261007    clang-24   cocci
um                   randconfig-r2107-20261007    gcc-9.5.0  cocci
um                   randconfig-r2301-20261007    gcc-14     sparse
um                   randconfig-r2302-20261007    clang-17   sparse
um                   randconfig-r2302-20261007    clang-18   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261009    clang-22
x86_64      buildonly-randconfig-1001-20261009    clang-22
x86_64      buildonly-randconfig-1002-20261009    clang-22
x86_64      buildonly-randconfig-1003-20261009    clang-22
x86_64      buildonly-randconfig-1004-20261009    clang-22
x86_64      buildonly-randconfig-1005-20261009    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261009    gcc-14
x86_64                randconfig-1001-20261009    gcc-14
x86_64                randconfig-1002-20261009    gcc-14
x86_64                randconfig-1003-20261009    gcc-14
x86_64                randconfig-1004-20261009    gcc-14
x86_64                randconfig-1005-20261009    gcc-14
x86_64                randconfig-1012-20261009    gcc-14
x86_64                randconfig-1013-20261009    gcc-14
x86_64                randconfig-1014-20261009    gcc-14
x86_64                randconfig-1015-20261009    gcc-14
x86_64                randconfig-1016-20261009    gcc-14
x86_64                randconfig-1017-20261009    gcc-14
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2200-20261007    gcc-14     smatch
x86_64                randconfig-2300-20261007    clang-22   sparse
x86_64                randconfig-2301-20261007    clang-22   sparse
x86_64                randconfig-2302-20261007    clang-22   sparse
x86_64               randconfig-r2103-20261007    gcc-16.1.0 cocci
x86_64               randconfig-r2305-20261007    gcc-9.5.0  sparse
x86_64               randconfig-r2307-20261007    clang-24   sparse
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
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261009    clang-18
xtensa                randconfig-1001-20261009    clang-18
xtensa                randconfig-2000-20261007    clang-24
xtensa                randconfig-2001-20261007    clang-24
xtensa               randconfig-r2102-20261007    gcc-16.1.0 cocci
xtensa               randconfig-r2105-20261007    gcc-16.1.0 cocci
xtensa               randconfig-r2107-20261007    gcc-9.5.0  cocci
xtensa               randconfig-r2201-20261007    gcc-8.5.0  smatch
xtensa               randconfig-r2300-20261007    clang-17   sparse
xtensa               randconfig-r2307-20261007    clang-24   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
