Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D9547059
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790747873; cv=none; b=keCtbwFv0QDtvIuRfmmZNdPXxrgUer5yWOnIK3RE9GLGmJb236tC7yXauO8jRYNLw0oV0T8EY6odS26IJZ1UJiVUTvY0B2mu5f/mPszhc9sNDlhUE+XaszPsYoXx1gyL8WvvMCJbvfSFbVPKzsssb+NJ8NQLo9Lo6KcV5CvapFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790747873; c=relaxed/simple;
	bh=WAgjzmXjbAHuc4dbzBJkZzxCEi/L1dEHutmqKAwh+2s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jgtl7TTDlYSoyH5shIObHM+AaSwEZr/iUJjyuajYHebpg555/sk+5nNl09ns1egFdTq+mZU117gAvTQUXSfmbva+h0YcyMa0WlXPymOLWS9CKoJZbXH8oTzgE2/Sg6fSjVhSVH5Si/+JHS8EvqUtlP6FxKov1TNGb1WUfqRUPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpEUrfNr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpEUrfNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790747870; x=1822283870;
  h=date:from:to:cc:subject:message-id;
  bh=WAgjzmXjbAHuc4dbzBJkZzxCEi/L1dEHutmqKAwh+2s=;
  b=JpEUrfNrf+Ol06aG20UEZlHIzA/l5rkGWmblLrFbZ3np29pd8YYGtUTd
   vBBMfnUqwjxGpkCurGEh1vG4nKjSXNRxpFR/PZxwj0LorHdB/5nJCAsXn
   GPflENt86QquF3Yh2HV98XTkjZvnrcXf8j83A5/Z5lB1I/C+/bmSe7zeL
   0WRryWueD4JyOPLEanPAMCIFD0jlu5qByLCcQgfWZ0MFpJe9QosFMzh0I
   iM4CevtKlApVhS/R/yLVLPQJdcB8sPuZxjRnOpHoaLei8TfjCWUmhHek8
   3blRd3P8AwzW8/XfI9ZeO/ORz+AxAaF7qCzvY5mFz+jMrEWyoYSDe290j
   A==;
X-CSE-ConnectionGUID: Nw2Yp7UBSkqRVIm7DF1X9Q==
X-CSE-MsgGUID: bFTG4W6QThuj+EgPnOkVEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102150720"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102150720"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:57:49 -0700
X-CSE-ConnectionGUID: mXLsh3RKQmCEqhnae2JnvQ==
X-CSE-MsgGUID: SdOBTv+nROeLHwgXDtiJyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275157682"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Sep 2026 22:57:48 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xBnK5-00000000QBw-2OJW;
	Wed, 30 Sep 2026 05:57:45 +0000
Date: Wed, 30 Sep 2026 13:57:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 81bebadfa0f7f9337a0b4e8e218731457b7eb9af
Message-ID: <202609301335.dXLavPpl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 81bebadfa0f7f9337a0b4e8e218731457b7eb9af  Merge branch 'pci/misc'

elapsed time: 1674m

configs tested: 378
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2107-20260929    gcc-15.2.0 cocci
alpha                randconfig-r2302-20260929    gcc-12.5.0 sparse
alpha                randconfig-r2303-20260929    gcc-12.5.0 sparse
alpha                randconfig-r2305-20260929    gcc-13.4.0 sparse
alpha                randconfig-r2309-20260929    gcc-13.4.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2100-20260929    clang-24   cocci
arc                  randconfig-r2102-20260929    gcc-9.5.0  cocci
arc                  randconfig-r2103-20260929    clang-22   cocci
arc                  randconfig-r2105-20260929    gcc-13.4.0 cocci
arc                  randconfig-r2307-20260929    gcc-13.4.0 sparse
arc                  randconfig-r2309-20260929    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g5_defconfig    gcc-16.1.0
arm                          at91_dt_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                  randconfig-r2305-20260929    gcc-12.5.0 sparse
arm                  randconfig-r2308-20260929    gcc-13.4.0 sparse
arm                  randconfig-r2308-20260929    gcc-9.5.0  sparse
arm                            sama5_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260929    clang-24
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260929    clang-24
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260929    clang-24
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260929    clang-24
arm64                 randconfig-1003-20260930    gcc-16.1.0
arm64                randconfig-r2102-20260929    clang-24   cocci
arm64                randconfig-r2301-20260929    gcc-12.5.0 sparse
arm64                randconfig-r2301-20260929    gcc-13.4.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260929    clang-24
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260929    clang-24
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2105-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2107-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2200-20260929    gcc-14.3.0 smatch
csky                 randconfig-r2300-20260929    gcc-12.5.0 sparse
csky                 randconfig-r2309-20260929    gcc-11.5.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260929    gcc-8.5.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260929    gcc-8.5.0
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2202-20260929    clang-17   smatch
hexagon              randconfig-r2306-20260929    gcc-9.5.0  sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260929    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260929    clang-22
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260929    clang-22
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260929    clang-22
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260929    clang-22
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260929    clang-22
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260929    gcc-13
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260929    gcc-13
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260929    gcc-13
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260929    gcc-13
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260929    gcc-13
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260929    gcc-13
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260929    gcc-13
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260929    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260929    gcc-14
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260929    gcc-14
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260929    gcc-14
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260929    gcc-14
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260929    gcc-14
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260929    gcc-14
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260929    clang-22   cocci
i386                  randconfig-2101-20260929    clang-22   cocci
i386                  randconfig-2102-20260929    clang-22   cocci
i386                  randconfig-2103-20260929    clang-22   cocci
i386                  randconfig-2200-20260929    gcc-14     smatch
i386                  randconfig-2300-20260929    gcc-14     sparse
i386                  randconfig-2301-20260929    gcc-14     sparse
i386                  randconfig-2302-20260929    gcc-14     sparse
i386                 randconfig-r2106-20260929    gcc-16.1.0 cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260929    gcc-8.5.0
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260929    gcc-8.5.0
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2102-20260929    clang-24   cocci
loongarch            randconfig-r2107-20260929    clang-22   cocci
loongarch            randconfig-r2201-20260929    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                        bvme6000_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    gcc-16.1.0
m68k                 randconfig-r2101-20260929    clang-24   cocci
m68k                 randconfig-r2104-20260929    clang-22   cocci
m68k                 randconfig-r2105-20260929    clang-22   cocci
m68k                 randconfig-r2200-20260929    gcc-11.5.0 smatch
m68k                 randconfig-r2304-20260929    gcc-13.4.0 sparse
m68k                 randconfig-r2305-20260929    gcc-12.5.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2201-20260929    gcc-13.4.0 smatch
microblaze           randconfig-r2306-20260929    clang-24   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                             gpr_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    gcc-16.1.0
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                            mtx1_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20260929    clang-22   cocci
mips                 randconfig-r2103-20260929    clang-24   cocci
mips                 randconfig-r2104-20260929    gcc-13.4.0 cocci
mips                 randconfig-r2200-20260929    gcc-12.5.0 smatch
mips                 randconfig-r2300-20260929    gcc-13.4.0 sparse
mips                 randconfig-r2302-20260929    gcc-13.4.0 sparse
mips                 randconfig-r2306-20260929    gcc-13.4.0 sparse
mips                           rm200_defconfig    gcc-16.1.0
nios2                          10m50_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260929    gcc-8.5.0
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260929    gcc-8.5.0
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2200-20260929    gcc-11.5.0 smatch
nios2                randconfig-r2202-20260929    gcc-10.5.0 smatch
nios2                randconfig-r2303-20260929    gcc-13.4.0 sparse
nios2                randconfig-r2306-20260929    gcc-11.5.0 sparse
nios2                randconfig-r2307-20260929    gcc-11.5.0 sparse
nios2                randconfig-r2309-20260929    gcc-9.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20260929    gcc-9.5.0  cocci
openrisc             randconfig-r2304-20260929    gcc-12.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260929    gcc-8.5.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260929    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2101-20260929    gcc-9.5.0  cocci
parisc               randconfig-r2200-20260929    gcc-14.3.0 smatch
parisc               randconfig-r2301-20260929    gcc-12.5.0 sparse
parisc               randconfig-r2303-20260929    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                      akebono_defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.1.0
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc                         icon_defconfig    gcc-16.1.0
powerpc                      ksi8560_defconfig    gcc-16.1.0
powerpc                      mpc512x_defconfig    gcc-16.1.0
powerpc                       ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260929    gcc-8.5.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260929    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2103-20260929    gcc-9.5.0  cocci
powerpc              randconfig-r2104-20260929    gcc-16.1.0 cocci
powerpc              randconfig-r2202-20260929    clang-24   smatch
powerpc64             randconfig-1000-20260929    gcc-8.5.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260929    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2104-20260929    gcc-15.2.0 cocci
powerpc64            randconfig-r2106-20260929    gcc-15.2.0 cocci
powerpc64            randconfig-r2307-20260929    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260929    clang-24
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260929    clang-24
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260929    gcc-11.5.0
riscv                 randconfig-2001-20260929    gcc-11.5.0
riscv                randconfig-r2100-20260929    clang-24   cocci
riscv                randconfig-r2202-20260929    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260929    clang-24
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260929    clang-24
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260929    gcc-11.5.0
s390                  randconfig-2001-20260929    gcc-11.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                             hp6xx_defconfig    gcc-16.1.0
sh                           r7780mp_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260929    clang-24
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260929    clang-24
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260929    gcc-11.5.0
sh                    randconfig-2001-20260929    gcc-11.5.0
sh                            se7619_defconfig    gcc-16.1.0
sh                            se7705_defconfig    gcc-16.1.0
sh                              sh03_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260929    gcc-14
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260929    gcc-14
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260929    gcc-12.5.0
sparc                 randconfig-2001-20260929    gcc-12.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260929    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260929    gcc-14
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260929    gcc-12.5.0
sparc64               randconfig-2001-20260929    gcc-12.5.0
sparc64              randconfig-r2300-20260929    gcc-12.5.0 sparse
um                                alldefconfig    gcc-16.1.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260929    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260929    gcc-14
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260929    gcc-12.5.0
um                    randconfig-2001-20260929    gcc-12.5.0
um                   randconfig-r2201-20260929    gcc-14     smatch
um                   randconfig-r2202-20260929    clang-24   smatch
um                   randconfig-r2308-20260929    clang-24   sparse
um                            x86_64_defconfig    gcc-14
um                            x86_64_defconfig    gcc-16.1.0
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260929    clang-22
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1001-20260929    clang-22
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260929    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260929    clang-22
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260929    clang-22
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1005-20260929    clang-22
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260929    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260929    clang-22
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260929    clang-22
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260929    clang-22
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260929    clang-22
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260929    clang-22
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260929    gcc-13
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260929    gcc-13
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260929    gcc-13
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260929    gcc-13
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260929    gcc-13
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260929    gcc-13
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2100-20260929    clang-22   cocci
x86_64                randconfig-2101-20260929    clang-22   cocci
x86_64                randconfig-2102-20260929    clang-22   cocci
x86_64                randconfig-2103-20260929    clang-22   cocci
x86_64                randconfig-2200-20260929    clang-22   smatch
x86_64                randconfig-2300-20260929    gcc-14     sparse
x86_64                randconfig-2301-20260929    gcc-14     sparse
x86_64                randconfig-2302-20260929    gcc-14     sparse
x86_64               randconfig-r2101-20260929    clang-24   cocci
x86_64               randconfig-r2102-20260929    clang-22   cocci
x86_64               randconfig-r2106-20260929    clang-22   cocci
x86_64               randconfig-r2107-20260929    gcc-13.4.0 cocci
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
xtensa                randconfig-1000-20260929    gcc-14
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1001-20260929    gcc-14
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-2000-20260929    gcc-12.5.0
xtensa                randconfig-2001-20260929    gcc-12.5.0
xtensa               randconfig-r2101-20260929    clang-22   cocci
xtensa               randconfig-r2105-20260929    gcc-15.2.0 cocci
xtensa               randconfig-r2106-20260929    gcc-13.4.0 cocci
xtensa               randconfig-r2201-20260929    gcc-10.5.0 smatch
xtensa               randconfig-r2307-20260929    gcc-9.5.0  sparse
xtensa               randconfig-r2308-20260929    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
