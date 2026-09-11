Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E9348896
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152235; cv=none; b=DLO1Ay8dquyg1DBNcFndnUw2mUi7jAKidvloUnaSow2EXPF5nkN5De1Tad9/d3ZUzye4vsvbNTeN/Co1aDiY3MN/WNntFSz24EePI2Lom7z5Nm6YSPTtPXIZHm7DeT4eZS1ALO/ktE2dcqvYuwemv/HLZPwdusCN/Ad/FZQaAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152235; c=relaxed/simple;
	bh=7RPPJMxNVt5Mr+wZTvDLtx1m8fte/l7rHbQoSRiGG/o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=erAIxdky05JcUlWJ2nTvOKpjprUZ8ghvCwQMKL0YD5xcDfN01/k+303Zb9ihAOn8fD3QgFNeQV6bVCrT5o1H09pURMM1zThJ3Hbz4JN/4VZBnFG1+uMHEKubjfk1a5w+IDYUDG3KK0fIu+YiZ6UXQxdHqCKPvZ5PTnLTeJVqcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK6hG0pS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK6hG0pS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789152231; x=1820688231;
  h=date:from:to:cc:subject:message-id;
  bh=7RPPJMxNVt5Mr+wZTvDLtx1m8fte/l7rHbQoSRiGG/o=;
  b=iK6hG0pSSVh82dEPNk7p9VWayUUuuukT5IP7sa1QeeS34gG3nl5cXlsK
   AmqeAdxYBe15GIZ7gwiiwh66yZ6whJpHGcyWkmslGkC/Axe+VOZsSjutA
   bX9vh2Nvgn9AASVIEoo/RUepijqmGKaUy45gbp0iWAp5GrwUZfHCwKp71
   Bo4Y4oF+8DUD1LFxtPTpwfmaetoBJAezsyqtHmCVwLIkksMRmyB02Fcth
   m8JOb1O54/oD370PkzHjgP6rXJziDvFydnaV92nJodO8lmXG/Tus1LDiv
   fp5CfmORpNXzHtEtCqSid4p3L9EiKlSdt+lfIUDbhcfjez/tQbdFajJMq
   Q==;
X-CSE-ConnectionGUID: aX7eDyAuRv6O5blnEVOXpA==
X-CSE-MsgGUID: DdtJmTx0T72c/s9v5ZfG5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="99949473"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99949473"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 11:43:47 -0700
X-CSE-ConnectionGUID: V23pez0gRriPtmBynuUdoQ==
X-CSE-MsgGUID: D9SSAiehQnO2EpbqQx1oFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="375983"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by fmviesa013.fm.intel.com with ESMTP; 11 Sep 2026 11:43:45 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x56Di-000000001wl-38xS;
	Fri, 11 Sep 2026 18:43:35 +0000
Date: Sat, 12 Sep 2026 02:38:50 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 e26ff299ac09405fbe3a2525b060d32988fad17c
Message-ID: <202609120247.S2iv6rSj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: e26ff299ac09405fbe3a2525b060d32988fad17c  PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime

elapsed time: 1573m

configs tested: 214
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                          axs103_defconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260911    clang-24
arc                   randconfig-002-20260911    clang-24
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                       aspeed_g5_defconfig    gcc-16.1.0
arm                        clps711x_defconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          pxa3xx_defconfig    gcc-16.1.0
arm                   randconfig-001-20260911    clang-24
arm                   randconfig-002-20260911    clang-24
arm                   randconfig-003-20260911    clang-24
arm                   randconfig-004-20260911    clang-24
arm                           sama5_defconfig    gcc-16.1.0
arm                           sama7_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260911    gcc-16.1.0
arm64                 randconfig-002-20260911    gcc-16.1.0
arm64                 randconfig-003-20260911    gcc-16.1.0
arm64                 randconfig-004-20260911    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260911    gcc-16.1.0
csky                  randconfig-002-20260911    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260911    gcc-12.5.0
hexagon               randconfig-001-20260912    clang-24
hexagon               randconfig-002-20260911    gcc-12.5.0
hexagon               randconfig-002-20260912    clang-24
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260911    clang-22
i386        buildonly-randconfig-002-20260911    clang-22
i386        buildonly-randconfig-003-20260911    clang-22
i386        buildonly-randconfig-004-20260911    clang-22
i386        buildonly-randconfig-005-20260911    clang-22
i386        buildonly-randconfig-006-20260911    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260911    clang-22
i386                  randconfig-002-20260911    clang-22
i386                  randconfig-003-20260911    clang-22
i386                  randconfig-004-20260911    clang-22
i386                  randconfig-005-20260911    clang-22
i386                  randconfig-006-20260911    clang-22
i386                  randconfig-007-20260911    clang-22
i386                  randconfig-011-20260911    clang-22
i386                  randconfig-012-20260911    clang-22
i386                  randconfig-013-20260911    clang-22
i386                  randconfig-014-20260911    clang-22
i386                  randconfig-015-20260911    clang-22
i386                  randconfig-016-20260911    clang-22
i386                  randconfig-017-20260911    clang-22
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260911    gcc-12.5.0
loongarch             randconfig-001-20260912    clang-24
loongarch             randconfig-002-20260911    gcc-12.5.0
loongarch             randconfig-002-20260912    clang-24
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5249evb_defconfig    gcc-16.1.0
m68k                       m5275evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze                      mmu_defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     decstation_defconfig    clang-24
mips                           gcw0_defconfig    clang-24
mips                           jazz_defconfig    clang-24
mips                      loongson1_defconfig    gcc-16.1.0
mips                      loongson3_defconfig    gcc-16.1.0
mips                       rbtx49xx_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260911    gcc-12.5.0
nios2                 randconfig-001-20260912    clang-24
nios2                 randconfig-002-20260911    gcc-12.5.0
nios2                 randconfig-002-20260912    clang-24
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260911    gcc-8.5.0
parisc                randconfig-002-20260911    gcc-8.5.0
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        icon_defconfig    clang-24
powerpc                     mpc5200_defconfig    clang-24
powerpc                     rainier_defconfig    clang-24
powerpc               randconfig-001-20260911    gcc-8.5.0
powerpc               randconfig-002-20260911    gcc-8.5.0
powerpc                      tqm8xx_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260911    gcc-8.5.0
powerpc64             randconfig-002-20260911    gcc-8.5.0
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                    nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-001-20260911    gcc-16.1.0
riscv                 randconfig-002-20260911    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                          debug_defconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260911    gcc-16.1.0
s390                  randconfig-002-20260911    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                        apsh4ad0a_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260911    gcc-16.1.0
sh                    randconfig-002-20260911    gcc-16.1.0
sh                      rts7751r2d1_defconfig    gcc-16.1.0
sh                   rts7751r2dplus_defconfig    gcc-16.1.0
sh                           se7619_defconfig    gcc-16.1.0
sh                           se7722_defconfig    gcc-16.1.0
sh                   sh7770_generic_defconfig    gcc-16.1.0
sh                             shx3_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260911    gcc-13.4.0
sparc                 randconfig-002-20260911    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260911    gcc-13.4.0
sparc64               randconfig-002-20260911    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260911    gcc-13.4.0
um                    randconfig-002-20260911    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260911    gcc-14
x86_64      buildonly-randconfig-002-20260911    gcc-14
x86_64      buildonly-randconfig-003-20260911    gcc-14
x86_64      buildonly-randconfig-004-20260911    gcc-14
x86_64      buildonly-randconfig-005-20260911    gcc-14
x86_64      buildonly-randconfig-006-20260911    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260911    clang-22
x86_64                randconfig-002-20260911    clang-22
x86_64                randconfig-003-20260911    clang-22
x86_64                randconfig-004-20260911    clang-22
x86_64                randconfig-005-20260911    clang-22
x86_64                randconfig-006-20260911    clang-22
x86_64                randconfig-011-20260911    gcc-14
x86_64                randconfig-012-20260911    gcc-14
x86_64                randconfig-013-20260911    gcc-14
x86_64                randconfig-014-20260911    gcc-14
x86_64                randconfig-015-20260911    gcc-14
x86_64                randconfig-016-20260911    gcc-14
x86_64                randconfig-071-20260911    gcc-14
x86_64                randconfig-072-20260911    gcc-14
x86_64                randconfig-073-20260911    gcc-14
x86_64                randconfig-074-20260911    gcc-14
x86_64                randconfig-075-20260911    gcc-14
x86_64                randconfig-076-20260911    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260911    gcc-13.4.0
xtensa                randconfig-002-20260911    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
