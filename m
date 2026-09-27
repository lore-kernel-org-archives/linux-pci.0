Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A698379C35
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516607; cv=none; b=Zz11t12Seo5XAdHu/o7DRhyHK/whVAyb+fYWLXYL2YMxyW+6FbaIY4PyJrPOatbJG0WKFx6lUQMs/ByyEqsEpEjVqbcd5hgfdhL1Mubfnl5N7Wgfb3H5zKhwXV6UAQoEB1YSt2cFS3lPhMRL7zFIo5Ky59LPMnvsxaw8rvbUygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516607; c=relaxed/simple;
	bh=tOaBgrWiAYn0mcqwIiC6Abmu9BDGdgziY8trhaFGpoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D3ebsrSxWOWQiYGsW1N3Kbp++PDTH4x9oHk9qMLC/0wIX1E+pmBErqCiL8FLwLx2rSPfAxJWXVspSouo+IMiQwIsUa0EA1lKg2X/HGHmVz2k7no04+rpsaU8g3mWCOSNJLPMyvDmGPEebRIa9pUOFPi49gIh3K8cH4ZRZDH7uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iILSYTsj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iILSYTsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790516605; x=1822052605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tOaBgrWiAYn0mcqwIiC6Abmu9BDGdgziY8trhaFGpoU=;
  b=iILSYTsj0J1OkxOxH8fpVLVWKrowrnDlAkjQIUDudonDemU/bIjgkcMn
   KPRALXseKJN7owGp2SGSU8Q/7ggadTWMXAw2r7YaZJVNuCk46BllgikHp
   JAlbTjveflHDlsGUFambLPtUYEvFGlA7doqPN5D9TtFIRTCELsNpQh1Ol
   GY6Sx8TW1e+z765gTsnNJFPiVlhYf2gQDz1+z0Qm4yRCmSq4/Xz+Op2js
   M6FV5CIlGvitXefEHHz69jjBCcADSFCflsrAj47qIclBm21yaUgRPz22e
   4zWuU3a2TXv46Kg0oDgRzABOOjumbatQo9+uL3ojQdkqYqvg4gfrk5Pjg
   w==;
X-CSE-ConnectionGUID: +nEDbSIMQ8y8XvzOONt/kw==
X-CSE-MsgGUID: G+A+9lFwS6euO5GAPgpM/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11917"; a="100567026"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="100567026"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 06:43:25 -0700
X-CSE-ConnectionGUID: rzRB9tZpQtGEvYvDKdhjyA==
X-CSE-MsgGUID: t1k2dwuORgi7TauO7/NWyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="272970369"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Sep 2026 06:43:24 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xApA1-00000000Mtn-21ak;
	Sun, 27 Sep 2026 13:43:21 +0000
Date: Sun, 27 Sep 2026 21:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 9f8a65b456fe54a01c80a754be8d566891d53a80
Message-ID: <202609272107.uf6Qgvjw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 9f8a65b456fe54a01c80a754be8d566891d53a80  PCI/sysfs: Pass the device name length in UTF-16 code units

elapsed time: 1803m

configs tested: 233
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2201-20260925    gcc-13.4.0 smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1001-20260927    gcc-11.5.0
arc                  randconfig-r2100-20260925    gcc-9.5.0  cocci
arc                  randconfig-r2101-20260925    gcc-9.5.0  cocci
arc                  randconfig-r2107-20260925    gcc-16.1.0 cocci
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1003-20260927    gcc-11.5.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1003-20260927    clang-17
arm64                randconfig-r2104-20260925    gcc-15.2.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1001-20260927    clang-17
csky                 randconfig-r2200-20260925    gcc-10.5.0 smatch
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260927    gcc-11.5.0
hexagon              randconfig-r2101-20260925    gcc-9.5.0  cocci
hexagon              randconfig-r2102-20260925    gcc-9.5.0  cocci
hexagon              randconfig-r2202-20260925    clang-24   smatch
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1005-20260927    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1013-20260927    gcc-14
i386                  randconfig-2100-20260925    clang-22   cocci
i386                  randconfig-2100-20260925    gcc-14     cocci
i386                  randconfig-2101-20260925    clang-22   cocci
i386                  randconfig-2102-20260925    clang-22   cocci
i386                  randconfig-2103-20260925    clang-22   cocci
i386                  randconfig-2200-20260925    gcc-14     smatch
i386                 randconfig-r2202-20260925    clang-22   smatch
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1001-20260927    gcc-11.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                            sun3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          db1xxx_defconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                        lemote2f_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
openrisc             randconfig-r2201-20260925    gcc-16.1.0 smatch
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1001-20260927    clang-24
parisc               randconfig-r2106-20260925    gcc-15.2.0 cocci
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc                      tqm8541_defconfig    gcc-16.1.0
powerpc                      tqm8560_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1001-20260927    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260927    gcc-16.1.0
riscv                 randconfig-2000-20260925    gcc-11.5.0
riscv                 randconfig-2001-20260925    gcc-11.5.0
riscv                 randconfig-2001-20260925    gcc-9.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1001-20260927    gcc-16.1.0
s390                  randconfig-2000-20260925    gcc-11.5.0
s390                  randconfig-2000-20260925    gcc-8.5.0
s390                  randconfig-2001-20260925    clang-24
s390                  randconfig-2001-20260925    gcc-11.5.0
s390                 randconfig-r2103-20260925    gcc-9.5.0  cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           polaris_defconfig    gcc-16.1.0
sh                           r7780mp_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                    randconfig-2000-20260925    gcc-11.5.0
sh                    randconfig-2000-20260925    gcc-14.3.0
sh                    randconfig-2001-20260925    gcc-11.5.0
sh                    randconfig-2001-20260925    gcc-16.1.0
sh                   randconfig-r2100-20260925    gcc-9.5.0  cocci
sh                   randconfig-r2104-20260925    gcc-16.1.0 cocci
sh                   randconfig-r2105-20260925    gcc-15.2.0 cocci
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1001-20260927    clang-24
sparc                 randconfig-2000-20260925    gcc-16.1.0
sparc                 randconfig-2001-20260925    gcc-16.1.0
sparc                randconfig-r2105-20260925    gcc-16.1.0 cocci
sparc                randconfig-r2106-20260925    gcc-16.1.0 cocci
sparc                randconfig-r2202-20260925    gcc-15.2.0 smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1001-20260927    clang-24
sparc64               randconfig-2000-20260925    gcc-16.1.0
sparc64               randconfig-2001-20260925    gcc-16.1.0
sparc64              randconfig-r2103-20260925    gcc-9.5.0  cocci
sparc64              randconfig-r2200-20260925    gcc-8.5.0  smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1001-20260927    clang-24
um                    randconfig-2000-20260925    gcc-16.1.0
um                    randconfig-2001-20260925    gcc-16.1.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                randconfig-2100-20260925    clang-22   cocci
x86_64                randconfig-2101-20260925    clang-22   cocci
x86_64                randconfig-2102-20260925    clang-22   cocci
x86_64                randconfig-2103-20260925    clang-22   cocci
x86_64                randconfig-2200-20260925    gcc-14     smatch
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
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1001-20260927    clang-24
xtensa                randconfig-2000-20260925    gcc-16.1.0
xtensa                randconfig-2001-20260925    gcc-16.1.0
xtensa               randconfig-r2102-20260925    gcc-9.5.0  cocci
xtensa               randconfig-r2107-20260925    gcc-15.2.0 cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
