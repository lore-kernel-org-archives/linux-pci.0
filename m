Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC84481AA9
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017849; cv=none; b=DynZqVkWfOWYjyYeeYtSl8uVXj2vt4MeU3bx9SuipRWonMD4sg3ei581dMrDTIPH+JnJv7wjcNimqJwPiaNMlLZvHd8pQf2U3ulTwJuBjv4rzEfKZXuLPHP0kkqqPzSTYmbyiRzwBGg6pQM7V7vt3bFa4CJq4pW0wO/i0onfpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017849; c=relaxed/simple;
	bh=Jhg1Qq329cacV5iDR+cwRKXosFVYs6Oirv3DLG8dHkA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a46nuuMamLJBXXt3FU9H1TmQiZfAPMq8ADTVnCRTs9nootyKr86SDHWNzJSkAeQprFhoipyXXhzdSmuLZiDY4We4hFNUkaa5LvRgteuOS/nnWrjUHVFCDhAxm9pvflGJvH1KBkIlSTrAwdJJeZoUAT0xOwIVDqzDo/QLmYzN3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfTzN5I2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfTzN5I2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792017847; x=1823553847;
  h=date:from:to:cc:subject:message-id;
  bh=Jhg1Qq329cacV5iDR+cwRKXosFVYs6Oirv3DLG8dHkA=;
  b=FfTzN5I23WWszzh8JfqKDquRnnN1/kecwUTvnykdL+oER+Vgc/ujqCKP
   x1oKY/HsxGNVaKjPCACky9Pub+q4DU2JXIVgz0ybQN/+bkj4DtDXI2liK
   T3aX/TnS9jEoSfuWlCwX1cx5tmCVRoGGJZPuW+y6mZ2q9rsS5edk1xupq
   nvuZwwJih5zxbArSH3UyddaWPcYyQCIToWuF5Nc1ZjwmALHR6qWPge5P2
   2VKBcarGJbmJ5jacUaMUW/EIu6liQBsamT9xZhRfRHY3uK9JhWmWuK5ff
   SQiVmhTT4Dk20VselS6ohN1etJYANTpnnsgkFUmY88DiuxL7SC60467iA
   w==;
X-CSE-ConnectionGUID: 1EaOcwJDTaG/IZne0NdqHw==
X-CSE-MsgGUID: gw931+CETLO+Txmd4NvsyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="766041"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="766041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 15:44:04 -0700
X-CSE-ConnectionGUID: llSCcbNfSuyOafq4bAyrkQ==
X-CSE-MsgGUID: ti4v9CC5RtKeKJgdxK7hTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1862411"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Oct 2026 15:44:04 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH7hY-00000000FIH-3fga;
	Wed, 14 Oct 2026 22:44:00 +0000
Date: Thu, 15 Oct 2026 06:43:09 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 4e9f69d08253471d92bcc46b363fbada06bd59c4
Message-ID: <202610150606.VG3TxlWm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 4e9f69d08253471d92bcc46b363fbada06bd59c4  PCI: dw-rockchip: Move INTx IRQ setup to probe

elapsed time: 1784m

configs tested: 339
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2105-20261013    gcc-8.5.0  cocci
alpha                randconfig-r2309-20261013    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261014    clang-17
arc                   randconfig-1001-20261014    clang-17
arc                   randconfig-2000-20261013    gcc-8.5.0
arc                   randconfig-2001-20261013    gcc-8.5.0
arc                  randconfig-r2200-20261013    gcc-13.4.0 smatch
arc                  randconfig-r2301-20261013    gcc-12.5.0 sparse
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
arm                   randconfig-2001-20261013    gcc-8.5.0
arm                  randconfig-r2101-20261013    clang-24   cocci
arm                  randconfig-r2104-20261013    gcc-8.5.0  cocci
arm                  randconfig-r2111-20261013    gcc-14.3.0 cocci
arm                  randconfig-r2202-20261013    gcc-8.5.0  smatch
arm                  randconfig-r2307-20261013    clang-19   sparse
arm                  randconfig-r2308-20261013    clang-24   sparse
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
arm64                 randconfig-2001-20261013    gcc-9.5.0
arm64                randconfig-r2103-20261013    clang-24   cocci
arm64                randconfig-r2201-20261013    gcc-11.5.0 smatch
arm64                randconfig-r2305-20261013    gcc-12.5.0 sparse
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
csky                  randconfig-2001-20261013    gcc-9.5.0
csky                 randconfig-r2101-20261013    gcc-12.5.0 cocci
csky                 randconfig-r2111-20261013    gcc-10.5.0 cocci
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261014    clang-18
hexagon               randconfig-1001-20261014    clang-18
hexagon               randconfig-2000-20261013    gcc-9.5.0
hexagon               randconfig-2001-20261013    gcc-9.5.0
hexagon              randconfig-r2102-20261013    clang-24   cocci
hexagon              randconfig-r2103-20261013    clang-21   cocci
hexagon              randconfig-r2301-20261013    gcc-8.5.0  sparse
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
i386                  randconfig-2001-20261013    gcc-8.5.0
i386                  randconfig-2100-20261013    gcc-14     cocci
i386                  randconfig-2101-20261013    gcc-14     cocci
i386                  randconfig-2102-20261013    gcc-14     cocci
i386                  randconfig-2103-20261013    gcc-14     cocci
i386                  randconfig-2104-20261013    gcc-14     cocci
i386                  randconfig-2105-20261013    gcc-14     cocci
i386                  randconfig-2200-20261013    gcc-14     smatch
i386                  randconfig-2300-20261013    gcc-14     sparse
i386                  randconfig-2301-20261013    gcc-14     sparse
i386                  randconfig-2302-20261013    gcc-14     sparse
i386                 randconfig-r2100-20261013    clang-24   cocci
i386                 randconfig-r2104-20261013    gcc-10.5.0 cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    clang-24
loongarch             randconfig-1000-20261014    clang-18
loongarch             randconfig-1001-20261014    clang-18
loongarch             randconfig-2000-20261013    gcc-11.5.0
loongarch             randconfig-2001-20261013    gcc-11.5.0
loongarch            randconfig-r2100-20261013    gcc-12.5.0 cocci
loongarch            randconfig-r2110-20261013    gcc-14.3.0 cocci
loongarch            randconfig-r2300-20261013    gcc-12.5.0 sparse
loongarch            randconfig-r2306-20261013    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2103-20261013    gcc-12.5.0 cocci
m68k                 randconfig-r2107-20261013    gcc-8.5.0  cocci
m68k                 randconfig-r2109-20261013    gcc-12.5.0 cocci
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2307-20261013    clang-24   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                            ip32_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
mips                 randconfig-r2105-20261013    gcc-10.5.0 cocci
mips                 randconfig-r2106-20261013    gcc-10.5.0 cocci
mips                 randconfig-r2110-20261013    gcc-10.5.0 cocci
mips                 randconfig-r2202-20261013    clang-24   smatch
mips                 randconfig-r2300-20261013    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261014    clang-18
nios2                 randconfig-1001-20261014    clang-18
nios2                 randconfig-2000-20261013    gcc-11.5.0
nios2                 randconfig-2001-20261013    gcc-11.5.0
nios2                randconfig-r2106-20261013    gcc-14.3.0 cocci
nios2                randconfig-r2201-20261013    gcc-8.5.0  smatch
nios2                randconfig-r2202-20261013    gcc-11.5.0 smatch
nios2                randconfig-r2305-20261013    gcc-8.5.0  sparse
nios2                randconfig-r2311-20261013    clang-19   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2201-20261013    gcc-15.2.0 smatch
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261014    clang-22
parisc                randconfig-1000-20261015    gcc-8.5.0
parisc                randconfig-1001-20261014    clang-22
parisc                randconfig-1001-20261015    gcc-8.5.0
parisc                randconfig-2000-20261013    gcc-11.5.0
parisc                randconfig-2001-20261013    gcc-11.5.0
parisc               randconfig-r2106-20261013    gcc-8.5.0  cocci
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
powerpc               randconfig-2001-20261013    gcc-14
powerpc              randconfig-r2107-20261013    gcc-10.5.0 cocci
powerpc              randconfig-r2110-20261013    gcc-8.5.0  cocci
powerpc                      tqm8540_defconfig    clang-24
powerpc64             randconfig-1000-20261014    clang-22
powerpc64             randconfig-1000-20261015    gcc-8.5.0
powerpc64             randconfig-1001-20261014    clang-22
powerpc64             randconfig-1001-20261015    gcc-8.5.0
powerpc64             randconfig-2000-20261013    gcc-14
powerpc64             randconfig-2001-20261013    gcc-14
powerpc64            randconfig-r2109-20261013    clang-21   cocci
powerpc64            randconfig-r2109-20261013    clang-24   cocci
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
riscv                 randconfig-2001-20261013    gcc-15.2.0
riscv                randconfig-r2111-20261013    gcc-8.5.0  cocci
riscv                randconfig-r2310-20261013    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261014    clang-18
s390                  randconfig-1001-20261014    clang-18
s390                  randconfig-2000-20261013    gcc-15.2.0
s390                  randconfig-2001-20261013    gcc-15.2.0
s390                 randconfig-r2100-20261013    clang-21   cocci
s390                 randconfig-r2105-20261013    gcc-14.3.0 cocci
s390                 randconfig-r2108-20261013    gcc-12.5.0 cocci
s390                 randconfig-r2200-20261013    clang-24   smatch
s390                 randconfig-r2302-20261013    gcc-12.5.0 sparse
s390                 randconfig-r2311-20261013    clang-24   sparse
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
sh                    randconfig-2001-20261013    gcc-15.2.0
sh                            se7619_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261014    clang-24
sparc                 randconfig-1001-20261014    clang-24
sparc                 randconfig-2000-20261013    gcc-16.1.0
sparc                 randconfig-2001-20261013    gcc-16.1.0
sparc                randconfig-r2108-20261013    clang-24   cocci
sparc                randconfig-r2306-20261013    clang-19   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261014    clang-24
sparc64               randconfig-1001-20261014    clang-24
sparc64               randconfig-2000-20261013    gcc-16.1.0
sparc64               randconfig-2001-20261013    gcc-16.1.0
sparc64              randconfig-r2200-20261013    clang-24   smatch
sparc64              randconfig-r2304-20261013    gcc-12.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261014    clang-24
um                    randconfig-1001-20261014    clang-24
um                    randconfig-2000-20261013    gcc-16.1.0
um                    randconfig-2001-20261013    gcc-16.1.0
um                   randconfig-r2101-20261013    clang-21   cocci
um                   randconfig-r2102-20261013    gcc-12.5.0 cocci
um                   randconfig-r2108-20261013    clang-21   cocci
um                   randconfig-r2303-20261013    gcc-12.5.0 sparse
um                   randconfig-r2308-20261013    clang-19   sparse
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
x86_64                randconfig-2001-20261013    gcc-14
x86_64                randconfig-2100-20261013    clang-22   cocci
x86_64                randconfig-2101-20261013    clang-22   cocci
x86_64                randconfig-2102-20261013    clang-22   cocci
x86_64                randconfig-2103-20261013    clang-22   cocci
x86_64                randconfig-2104-20261013    clang-22   cocci
x86_64                randconfig-2105-20261013    clang-22   cocci
x86_64                randconfig-2200-20261013    gcc-13     smatch
x86_64                randconfig-2300-20261013    gcc-14     sparse
x86_64                randconfig-2301-20261013    gcc-14     sparse
x86_64                randconfig-2302-20261013    gcc-14     sparse
x86_64               randconfig-r2102-20261013    clang-21   cocci
x86_64               randconfig-r2302-20261013    gcc-8.5.0  sparse
x86_64               randconfig-r2303-20261013    gcc-8.5.0  sparse
x86_64               randconfig-r2304-20261013    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261013    clang-24   sparse
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
xtensa                randconfig-2001-20261013    gcc-16.1.0
xtensa               randconfig-r2104-20261013    gcc-14.3.0 cocci
xtensa               randconfig-r2107-20261013    gcc-14.3.0 cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
