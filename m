Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8A3DA5DB
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792211811; cv=none; b=EoD7p1JK/GZO/9ZTMmhrTGQtFW04j1iFUNvNhnAkPgafniYQKR34TgjE3HpZiCCGVIrltV5aOjbWMp5nFKq0P/z6sM1w1fNCrCZld3INxNw291xTHuuJQ2JWtyLDN4M0ozeaT9VymFk5V3tkpfwSf6XF3QYOd5xi0uxvXo/sKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792211811; c=relaxed/simple;
	bh=bblUyL30zeQluo9Y126wMlReYHDjzK6ipaiVAq3pl4A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qJioSvTMIcfwNVtbju7cf6A3RiN0YD7FwQaIlw81ezKWqNNHpSsYwInv6hXmsEVoTrBWp1qEUVh94/KeXqoFooeQt9ZK292ZdCDhZA4y6kF16i2/Naj1jFzXSEyka1JF7prBNK9xGbCeTZ0NH/a2VB3GxtRdTPErxzjt2/jNe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aq8SuJgR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aq8SuJgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792211806; x=1823747806;
  h=date:from:to:cc:subject:message-id;
  bh=bblUyL30zeQluo9Y126wMlReYHDjzK6ipaiVAq3pl4A=;
  b=Aq8SuJgRNASEJn77Jux3EpLrkEAeXqLpbZC8/MtQbWoBV/Or4JfEOzBs
   CtfWYuALy+wrQMfloOxgHJr7uwPp8KsJZnDeEbcVJsQVI0zU3nDOd0TY1
   kGsx0wSW0NDRqKXKhH1DiNqKLFVGRKkQYvyTQBD0NfDEwVbPROrQQpTwq
   FHv5xxoBNBTBWkgRYyDBdyu/zLt3S5tNkndQ8KC3MMLhqDYuQST87CNJX
   qKiq+Lf204WKgiOaFXJuHDnbqtqgb/arPCcu/A+14723oFxdv34BgviAu
   N72FCCw96THy/U3D4va2h5I3i2iV75rBdlHkgJMhvXUo00TWFdCYlU97h
   A==;
X-CSE-ConnectionGUID: T79+RGcUTWSti42mb9VYdA==
X-CSE-MsgGUID: vXn7XNnWTKyDzmBPn9X6xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="876203"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="876203"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 21:36:45 -0700
X-CSE-ConnectionGUID: 3POI/cpXRK2XRh+iNZPBqQ==
X-CSE-MsgGUID: sjZJUnjiT7KxxoRU+M115w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2567208"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Oct 2026 21:36:44 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHw9x-00000000J4o-44Xf;
	Sat, 17 Oct 2026 04:36:41 +0000
Date: Sat, 17 Oct 2026 12:36:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 6563dc03745a959fee1f5a1ee6a00355bcaadf7f
Message-ID: <202610171235.vzUuIb0C-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 6563dc03745a959fee1f5a1ee6a00355bcaadf7f  PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

elapsed time: 903m

configs tested: 283
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2304-20261016    gcc-11.5.0 sparse
alpha                randconfig-r2311-20261016    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-2000-20261016    gcc-8.5.0
arc                   randconfig-2001-20261016    gcc-8.5.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-2000-20261016    gcc-12.5.0
arm                   randconfig-2000-20261016    gcc-8.5.0
arm                   randconfig-2001-20261016    gcc-8.5.0
arm                  randconfig-r2110-20261016    gcc-8.5.0  cocci
arm                  randconfig-r2305-20261016    gcc-11.5.0 sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-2000-20261016    gcc-12.5.0
arm64                 randconfig-2000-20261016    gcc-13.4.0
arm64                 randconfig-2001-20261016    clang-18
arm64                 randconfig-2001-20261016    gcc-12.5.0
arm64                randconfig-r2201-20261016    clang-24   smatch
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-2000-20261016    gcc-12.5.0
csky                  randconfig-2000-20261016    gcc-16.1.0
csky                  randconfig-2001-20261016    gcc-12.5.0
csky                 randconfig-r2103-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2108-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2109-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2306-20261016    gcc-16.1.0 sparse
csky                 randconfig-r2309-20261016    gcc-15.2.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-2000-20261016    clang-22
hexagon               randconfig-2000-20261016    gcc-12.5.0
hexagon               randconfig-2001-20261016    clang-22
hexagon               randconfig-2001-20261016    gcc-12.5.0
hexagon              randconfig-r2106-20261016    gcc-8.5.0  cocci
hexagon              randconfig-r2302-20261016    clang-24   sparse
hexagon              randconfig-r2307-20261016    clang-24   sparse
i386                               allnoconfig    gcc-16.1.0
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
i386                  randconfig-2000-20261016    clang-22
i386                  randconfig-2000-20261016    gcc-8.5.0
i386                  randconfig-2001-20261016    clang-22
i386                  randconfig-2001-20261016    gcc-8.5.0
i386                  randconfig-2100-20261016    clang-22   cocci
i386                  randconfig-2100-20261016    gcc-14     cocci
i386                  randconfig-2101-20261016    clang-22   cocci
i386                  randconfig-2102-20261016    clang-22   cocci
i386                  randconfig-2103-20261016    clang-22   cocci
i386                  randconfig-2103-20261016    gcc-14     cocci
i386                  randconfig-2104-20261016    clang-22   cocci
i386                  randconfig-2105-20261016    clang-22   cocci
i386                  randconfig-2200-20261016    clang-22   smatch
i386                  randconfig-2300-20261016    clang-22   sparse
i386                  randconfig-2301-20261016    clang-22   sparse
i386                  randconfig-2302-20261016    clang-22   sparse
i386                 randconfig-r2308-20261016    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-2000-20261016    gcc-11.5.0
loongarch             randconfig-2000-20261016    gcc-16.1.0
loongarch             randconfig-2001-20261016    clang-18
loongarch             randconfig-2001-20261016    gcc-11.5.0
loongarch            randconfig-r2102-20261016    gcc-15.2.0 cocci
loongarch            randconfig-r2301-20261016    gcc-11.5.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261016    gcc-8.5.0  cocci
microblaze           randconfig-r2103-20261016    gcc-12.5.0 cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip30_defconfig    clang-24
mips                 randconfig-r2200-20261016    clang-24   smatch
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-2000-20261016    gcc-11.5.0
nios2                 randconfig-2000-20261016    gcc-8.5.0
nios2                 randconfig-2001-20261016    gcc-11.5.0
nios2                randconfig-r2305-20261016    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20261016    gcc-16.1.0 cocci
openrisc             randconfig-r2303-20261016    gcc-13.4.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-2000-20261016    gcc-11.5.0
parisc                randconfig-2000-20261016    gcc-8.5.0
parisc                randconfig-2001-20261016    gcc-10.5.0
parisc                randconfig-2001-20261016    gcc-11.5.0
parisc               randconfig-r2202-20261016    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc              randconfig-r2105-20261016    gcc-8.5.0  cocci
powerpc              randconfig-r2111-20261016    gcc-8.5.0  cocci
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64            randconfig-r2101-20261016    gcc-16.1.0 cocci
powerpc64            randconfig-r2304-20261016    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-2000-20261016    clang-24
riscv                 randconfig-2000-20261016    gcc-16.1.0
riscv                 randconfig-2001-20261016    clang-24
riscv                 randconfig-2001-20261016    gcc-16.1.0
riscv                randconfig-r2108-20261016    clang-24   cocci
riscv                randconfig-r2300-20261016    gcc-11.5.0 sparse
riscv                randconfig-r2301-20261016    gcc-13.4.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-2000-20261016    clang-24
s390                  randconfig-2000-20261016    gcc-16.1.0
s390                  randconfig-2001-20261016    gcc-16.1.0
s390                  randconfig-2001-20261016    gcc-8.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-2000-20261016    gcc-16.1.0
sh                    randconfig-2001-20261016    gcc-12.5.0
sh                    randconfig-2001-20261016    gcc-16.1.0
sh                   randconfig-r2100-20261016    gcc-16.1.0 cocci
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-2000-20261016    gcc-12.5.0
sparc                 randconfig-2000-20261016    gcc-16.1.0
sparc                 randconfig-2001-20261016    gcc-12.5.0
sparc                randconfig-r2102-20261016    gcc-16.1.0 cocci
sparc                randconfig-r2200-20261016    gcc-8.5.0  smatch
sparc                        sparc32_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-2000-20261016    clang-24
sparc64               randconfig-2000-20261016    gcc-12.5.0
sparc64               randconfig-2001-20261016    clang-24
sparc64               randconfig-2001-20261016    gcc-12.5.0
sparc64              randconfig-r2104-20261016    gcc-8.5.0  cocci
sparc64              randconfig-r2201-20261016    gcc-12.5.0 smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-2000-20261016    clang-17
um                    randconfig-2000-20261016    gcc-12.5.0
um                    randconfig-2001-20261016    gcc-12.5.0
um                    randconfig-2001-20261016    gcc-14
um                   randconfig-r2107-20261016    gcc-8.5.0  cocci
um                   randconfig-r2310-20261016    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
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
x86_64                randconfig-2100-20261016    clang-22   cocci
x86_64                randconfig-2100-20261016    gcc-14     cocci
x86_64                randconfig-2101-20261016    clang-22   cocci
x86_64                randconfig-2102-20261016    clang-22   cocci
x86_64                randconfig-2103-20261016    clang-22   cocci
x86_64                randconfig-2104-20261016    clang-22   cocci
x86_64                randconfig-2105-20261016    clang-22   cocci
x86_64                randconfig-2105-20261016    gcc-14     cocci
x86_64                randconfig-2200-20261016    gcc-14     smatch
x86_64                randconfig-2300-20261016    clang-22   sparse
x86_64                randconfig-2301-20261016    clang-22   sparse
x86_64                randconfig-2302-20261016    clang-22   sparse
x86_64               randconfig-r2303-20261016    gcc-11.5.0 sparse
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
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-2000-20261016    gcc-12.5.0
xtensa                randconfig-2001-20261016    gcc-10.5.0
xtensa                randconfig-2001-20261016    gcc-12.5.0
xtensa               randconfig-r2109-20261016    gcc-11.5.0 cocci
xtensa               randconfig-r2300-20261016    gcc-15.2.0 sparse
xtensa               randconfig-r2302-20261016    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
