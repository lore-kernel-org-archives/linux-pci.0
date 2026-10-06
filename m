Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11037FF46
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285383; cv=none; b=EBNvYUAYz7hKY2rZthZckw8RLhN/yG+yeZzrwTH6C38zYVUu9f+OaBsgIWf7DeTDwaZyFiCPloy4klDGe44nRhiEbPU8Adx0fs/m/GTGL2C+RwM5wHxdDP84LFa2Yc1thdFwWVUwwz16qY9KeB8KqIjToyq+HC2EkS/fQ3HfhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285383; c=relaxed/simple;
	bh=PNS1fNf8BJgl8WEPygMVUXM6NNio+Ykoxq/zqh5/Xy8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X9++v8IxPneCQhgpOP7cu1kST+VEnZ4a5gyuXda7sK2CDmR25acpRaFjbJ580gFV16/gtolW7efJkBEOPr5YTGgIa5EanuLgbAxrvfMH1vK5QOPnCnUhx8MGJzZnXTq0+80x0Rbdthp2oYoU9mwvbPly4Yba9lHCdbEum9kbuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1yjxJZ4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1yjxJZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791285382; x=1822821382;
  h=date:from:to:cc:subject:message-id;
  bh=PNS1fNf8BJgl8WEPygMVUXM6NNio+Ykoxq/zqh5/Xy8=;
  b=j1yjxJZ4XGHj5852lNUet6JPMtbHj4+7tqvP9UnQ0fO56Ghgw6a3kDAX
   qFPfnv23QujZjJo2zaixwgCnHf7R0ozQeoxT190c6Ez9upS8dX6NY7jeE
   y+eGssxD3wfNJASnG5d1WL6dRUYdxSgYutZE8mAbGVc97Vo57NlfhMC7S
   /nEVVwBhx2IA9z3IRFuP6XJdYFAfD5TsY57uK3MiSATurVz8hCokO8rq3
   DTijXttHREvc5YpgSnO6yALENMkth/1waOIPuxTByqb6FtfTCWDI8BoOj
   4EClpjxM5mGePdS2LZz58gD21K8re1iWiU+mb2EPprFgCjhBFi1uIpndX
   Q==;
X-CSE-ConnectionGUID: YrLZURR3TWmh/lYUd0wNPw==
X-CSE-MsgGUID: LDrs1IqrTymIYqMDodujgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109461618"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="109461618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 04:16:21 -0700
X-CSE-ConnectionGUID: hMIcEKUPT0O9qJjLo65idA==
X-CSE-MsgGUID: mxjoXCYlRAm9MkSW9rYjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="285228807"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Oct 2026 04:16:19 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xE39d-000000001Ws-1Apg;
	Tue, 06 Oct 2026 11:16:17 +0000
Date: Tue, 06 Oct 2026 19:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 2973773a8c011d06addebfad5f18f1288fb0fb56
Message-ID: <202610061927.urOxJoQ4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: 2973773a8c011d06addebfad5f18f1288fb0fb56  PCI: Add device-specific reset for Qualcomm WCN6855/WCN7850 WLAN

elapsed time: 1113m

configs tested: 339
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    clang-24
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261006    gcc-8.5.0  cocci
alpha                randconfig-r2103-20261005    gcc-14.3.0 cocci
alpha                randconfig-r2103-20261006    gcc-8.5.0  cocci
alpha                randconfig-r2104-20261006    clang-17   cocci
alpha                randconfig-r2200-20261005    gcc-9.5.0  smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                      haps_hs_smp_defconfig    clang-24
arc                   randconfig-1000-20261006    clang-24
arc                   randconfig-1001-20261006    clang-24
arc                  randconfig-r2100-20261005    gcc-11.5.0 cocci
arc                  randconfig-r2102-20261006    gcc-8.5.0  cocci
arc                  randconfig-r2106-20261006    clang-24   cocci
arc                  randconfig-r2202-20261005    gcc-14.3.0 smatch
arc                  randconfig-r2307-20261006    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                          lpc32xx_defconfig    gcc-16.1.0
arm                         multi_v7_defconfig    gcc-16.1.0
arm                         mvebu_v7_defconfig    clang-24
arm                         mvebu_v7_defconfig    gcc-16.1.0
arm                           pxa3xx_defconfig    clang-24
arm                   randconfig-1000-20261006    clang-24
arm                   randconfig-1001-20261006    clang-24
arm                   randconfig-1002-20261006    clang-24
arm                   randconfig-1003-20261006    clang-24
arm                  randconfig-r2104-20261005    clang-24   cocci
arm                  randconfig-r2201-20261005    clang-24   smatch
arm                  randconfig-r2305-20261005    gcc-10.5.0 sparse
arm                         realview_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261006    gcc-16.1.0
arm64                 randconfig-1001-20261006    gcc-16.1.0
arm64                 randconfig-1002-20261006    gcc-16.1.0
arm64                 randconfig-1003-20261006    gcc-16.1.0
arm64                randconfig-r2101-20261005    gcc-14.3.0 cocci
arm64                randconfig-r2105-20261006    clang-24   cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261006    gcc-16.1.0
csky                  randconfig-1001-20261006    gcc-16.1.0
csky                 randconfig-r2106-20261006    gcc-8.5.0  cocci
csky                 randconfig-r2107-20261005    clang-24   cocci
csky                 randconfig-r2201-20261006    gcc-9.5.0  smatch
csky                 randconfig-r2302-20261005    gcc-9.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261006    gcc-13.4.0
hexagon               randconfig-1001-20261006    gcc-13.4.0
hexagon              randconfig-r2100-20261006    gcc-8.5.0  cocci
hexagon              randconfig-r2301-20261005    gcc-9.5.0  sparse
hexagon              randconfig-r2301-20261006    clang-20   sparse
hexagon              randconfig-r2303-20261006    clang-20   sparse
hexagon              randconfig-r2305-20261006    clang-20   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261006    gcc-14
i386        buildonly-randconfig-1001-20261006    gcc-14
i386        buildonly-randconfig-1002-20261006    gcc-14
i386        buildonly-randconfig-1003-20261006    gcc-14
i386        buildonly-randconfig-1004-20261006    gcc-14
i386        buildonly-randconfig-1005-20261006    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261006    gcc-14
i386                  randconfig-1001-20261006    gcc-14
i386                  randconfig-1002-20261006    gcc-14
i386                  randconfig-1003-20261006    gcc-14
i386                  randconfig-1004-20261006    gcc-14
i386                  randconfig-1005-20261006    gcc-14
i386                  randconfig-1006-20261006    gcc-14
i386                  randconfig-1007-20261006    gcc-14
i386                  randconfig-1008-20261006    gcc-14
i386                  randconfig-1009-20261006    gcc-14
i386                  randconfig-1010-20261006    gcc-14
i386                  randconfig-1011-20261006    gcc-14
i386                  randconfig-1012-20261006    gcc-14
i386                  randconfig-1013-20261006    gcc-14
i386                  randconfig-2100-20261005    gcc-14     cocci
i386                  randconfig-2100-20261006    clang-22   cocci
i386                  randconfig-2101-20261005    gcc-14     cocci
i386                  randconfig-2101-20261006    clang-22   cocci
i386                  randconfig-2102-20261005    gcc-14     cocci
i386                  randconfig-2102-20261006    clang-22   cocci
i386                  randconfig-2103-20261005    gcc-14     cocci
i386                  randconfig-2103-20261006    clang-22   cocci
i386                  randconfig-2200-20261005    gcc-14     smatch
i386                  randconfig-2200-20261006    gcc-13     smatch
i386                  randconfig-2300-20261005    clang-22   sparse
i386                  randconfig-2300-20261006    gcc-14     sparse
i386                  randconfig-2301-20261005    clang-22   sparse
i386                  randconfig-2301-20261006    gcc-14     sparse
i386                  randconfig-2302-20261005    clang-22   sparse
i386                  randconfig-2302-20261006    gcc-14     sparse
i386                 randconfig-r2100-20261005    gcc-14.3.0 cocci
i386                 randconfig-r2101-20261005    gcc-11.5.0 cocci
i386                 randconfig-r2107-20261005    gcc-8.5.0  cocci
i386                 randconfig-r2300-20261005    gcc-9.5.0  sparse
i386                 randconfig-r2306-20261005    gcc-12.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261006    gcc-13.4.0
loongarch             randconfig-1001-20261006    gcc-13.4.0
loongarch            randconfig-r2104-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2106-20261006    gcc-16.1.0 cocci
loongarch            randconfig-r2201-20261006    gcc-13.4.0 smatch
loongarch            randconfig-r2302-20261006    clang-20   sparse
loongarch            randconfig-r2305-20261006    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         m5307c3_defconfig    gcc-16.1.0
m68k                 randconfig-r2101-20261005    gcc-8.5.0  cocci
m68k                 randconfig-r2107-20261006    gcc-8.5.0  cocci
m68k                 randconfig-r2304-20261006    clang-20   sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261006    gcc-8.5.0  cocci
microblaze           randconfig-r2103-20261005    gcc-8.5.0  cocci
microblaze           randconfig-r2200-20261005    gcc-9.5.0  smatch
microblaze           randconfig-r2302-20261005    gcc-10.5.0 sparse
microblaze           randconfig-r2304-20261005    gcc-9.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                          db1xxx_defconfig    gcc-16.1.0
mips                         omega2p_defconfig    gcc-16.1.0
mips                 randconfig-r2107-20261006    clang-24   cocci
mips                 randconfig-r2300-20261005    gcc-10.5.0 sparse
mips                 randconfig-r2301-20261005    gcc-10.5.0 sparse
mips                 randconfig-r2302-20261006    clang-24   sparse
mips                 randconfig-r2309-20261006    gcc-10.5.0 sparse
mips                    sb1250_swarm_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261006    gcc-13.4.0
nios2                 randconfig-1001-20261006    gcc-13.4.0
nios2                randconfig-r2105-20261005    gcc-8.5.0  cocci
nios2                randconfig-r2200-20261006    gcc-11.5.0 smatch
nios2                randconfig-r2303-20261005    gcc-9.5.0  sparse
nios2                randconfig-r2304-20261006    clang-24   sparse
nios2                randconfig-r2307-20261006    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
openrisc             randconfig-r2102-20261005    gcc-8.5.0  cocci
openrisc             randconfig-r2103-20261005    gcc-11.5.0 cocci
openrisc             randconfig-r2106-20261005    clang-24   cocci
openrisc             randconfig-r2308-20261006    gcc-10.5.0 sparse
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261006    gcc-14.3.0
parisc                randconfig-1001-20261006    gcc-14.3.0
parisc               randconfig-r2101-20261006    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-1000-20261006    gcc-14.3.0
powerpc               randconfig-1001-20261006    gcc-14.3.0
powerpc              randconfig-r2104-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2105-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2106-20261006    clang-17   cocci
powerpc              randconfig-r2202-20261005    clang-24   smatch
powerpc              randconfig-r2202-20261006    gcc-9.5.0  smatch
powerpc                      tqm8541_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261006    gcc-14.3.0
powerpc64             randconfig-1001-20261006    gcc-14.3.0
powerpc64            randconfig-r2103-20261006    gcc-8.5.0  cocci
powerpc64            randconfig-r2104-20261005    gcc-8.5.0  cocci
powerpc64            randconfig-r2201-20261005    clang-24   smatch
powerpc64            randconfig-r2201-20261006    gcc-13.4.0 smatch
powerpc64            randconfig-r2202-20261005    gcc-12.5.0 smatch
powerpc64            randconfig-r2303-20261006    clang-24   sparse
powerpc64            randconfig-r2305-20261005    gcc-9.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_virt_defconfig    clang-24
riscv                 randconfig-1000-20261006    clang-24
riscv                 randconfig-1001-20261006    clang-24
riscv                 randconfig-2000-20261005    gcc-16.1.0
riscv                 randconfig-2000-20261006    gcc-16.1.0
riscv                 randconfig-2001-20261005    gcc-16.1.0
riscv                 randconfig-2001-20261006    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261006    clang-24
s390                  randconfig-1001-20261006    clang-24
s390                  randconfig-2000-20261005    gcc-16.1.0
s390                  randconfig-2000-20261006    gcc-16.1.0
s390                  randconfig-2001-20261005    gcc-16.1.0
s390                  randconfig-2001-20261006    gcc-16.1.0
s390                 randconfig-r2102-20261005    gcc-14.3.0 cocci
s390                 randconfig-r2102-20261006    gcc-8.5.0  cocci
s390                 randconfig-r2201-20261005    clang-22   smatch
s390                 randconfig-r2306-20261006    gcc-10.5.0 sparse
s390                 randconfig-r2308-20261005    gcc-12.5.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                                j2_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261006    clang-24
sh                    randconfig-1001-20261006    clang-24
sh                    randconfig-2000-20261005    gcc-16.1.0
sh                    randconfig-2000-20261006    gcc-16.1.0
sh                    randconfig-2001-20261005    gcc-16.1.0
sh                    randconfig-2001-20261006    gcc-16.1.0
sh                   randconfig-r2102-20261005    gcc-11.5.0 cocci
sh                   randconfig-r2107-20261006    clang-17   cocci
sh                   randconfig-r2200-20261006    gcc-16.1.0 smatch
sh                   randconfig-r2300-20261006    clang-20   sparse
sh                            se7619_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261006    gcc-14
sparc                 randconfig-1001-20261006    gcc-14
sparc                 randconfig-2000-20261005    clang-17
sparc                 randconfig-2001-20261005    clang-17
sparc                randconfig-r2106-20261005    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261006    gcc-16.1.0 cocci
sparc                randconfig-r2300-20261006    clang-24   sparse
sparc                randconfig-r2307-20261005    gcc-12.5.0 sparse
sparc                randconfig-r2309-20261005    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261006    gcc-14
sparc64               randconfig-1001-20261006    gcc-14
sparc64               randconfig-2000-20261005    clang-17
sparc64               randconfig-2001-20261005    clang-17
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261006    gcc-14
um                    randconfig-1001-20261006    gcc-14
um                    randconfig-2000-20261005    clang-17
um                    randconfig-2001-20261005    clang-17
um                   randconfig-r2104-20261006    clang-24   cocci
um                   randconfig-r2105-20261005    clang-24   cocci
um                   randconfig-r2105-20261006    clang-17   cocci
um                   randconfig-r2105-20261006    gcc-8.5.0  cocci
um                   randconfig-r2301-20261006    clang-24   sparse
um                   randconfig-r2304-20261005    gcc-10.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261006    gcc-14
x86_64      buildonly-randconfig-1001-20261006    gcc-14
x86_64      buildonly-randconfig-1002-20261006    gcc-14
x86_64      buildonly-randconfig-1003-20261006    gcc-14
x86_64      buildonly-randconfig-1004-20261006    gcc-14
x86_64      buildonly-randconfig-1005-20261006    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261006    gcc-14
x86_64                randconfig-1001-20261006    gcc-14
x86_64                randconfig-1002-20261006    gcc-14
x86_64                randconfig-1003-20261006    gcc-14
x86_64                randconfig-1004-20261006    gcc-14
x86_64                randconfig-1005-20261006    gcc-14
x86_64                randconfig-1006-20261006    gcc-14
x86_64                randconfig-1007-20261006    gcc-14
x86_64                randconfig-1008-20261006    gcc-14
x86_64                randconfig-1009-20261006    gcc-14
x86_64                randconfig-1010-20261006    gcc-14
x86_64                randconfig-1011-20261006    gcc-14
x86_64                randconfig-1012-20261006    gcc-14
x86_64                randconfig-1013-20261006    gcc-14
x86_64                randconfig-1014-20261006    gcc-14
x86_64                randconfig-1015-20261006    gcc-14
x86_64                randconfig-1016-20261006    gcc-14
x86_64                randconfig-1017-20261006    gcc-14
x86_64                randconfig-2100-20261005    clang-22   cocci
x86_64                randconfig-2100-20261006    clang-22   cocci
x86_64                randconfig-2101-20261005    clang-22   cocci
x86_64                randconfig-2101-20261006    clang-22   cocci
x86_64                randconfig-2102-20261005    clang-22   cocci
x86_64                randconfig-2102-20261006    clang-22   cocci
x86_64                randconfig-2103-20261005    clang-22   cocci
x86_64                randconfig-2103-20261006    clang-22   cocci
x86_64                randconfig-2200-20261005    clang-22   smatch
x86_64                randconfig-2200-20261006    clang-22   smatch
x86_64                randconfig-2300-20261005    clang-22   sparse
x86_64                randconfig-2300-20261006    gcc-14     sparse
x86_64                randconfig-2301-20261005    clang-22   sparse
x86_64                randconfig-2301-20261006    gcc-14     sparse
x86_64                randconfig-2302-20261005    clang-22   sparse
x86_64                randconfig-2302-20261006    gcc-14     sparse
x86_64               randconfig-r2303-20261005    gcc-10.5.0 sparse
x86_64               randconfig-r2308-20261006    gcc-10.5.0 sparse
x86_64               randconfig-r2309-20261006    gcc-10.5.0 sparse
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
xtensa                randconfig-1000-20261006    gcc-14
xtensa                randconfig-1001-20261006    gcc-14
xtensa                randconfig-2000-20261005    clang-17
xtensa                randconfig-2001-20261005    clang-17
xtensa               randconfig-r2100-20261005    gcc-8.5.0  cocci
xtensa               randconfig-r2200-20261005    gcc-14.3.0 smatch
xtensa               randconfig-r2202-20261006    gcc-9.5.0  smatch
xtensa               randconfig-r2306-20261006    gcc-10.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
