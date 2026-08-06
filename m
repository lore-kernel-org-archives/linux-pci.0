Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87A4CA29F
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044140; cv=none; b=JK501fYqhcCr/3s5iiMRNfCBGE1o+kAjqr556h2FpjCM66ZxLfaP+su8jorBnCFIeaOfan5/ezzXlKuyBfu80+9MVa8ySqHtdp/6bL9FjQJxvs05txOWJSfxmp91LTT8IvkH/3Cb4xA/Y0mgdhb5HRirN/+1gneB92O8ni5uLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044140; c=relaxed/simple;
	bh=mYNuTEI+iw2cegsUU1ef1MwTY6ztc6SXmgSifQF2PCk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eSh4lnEanarrsLHjJgaDr8K/vupY6C1zoNOXVpR+YyUHzqYqQuzNf7LFZT+vaguBAj/L/W9VSSw91tvw0pG0Beh3IUOmQq1IUBAKmqSLdM/f9i2WW44ArUMQooJfS83DDBGWvgW1717vgoRiXPElVqjaG/Y8H2EH0oAzr7HvX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHtFPd+y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHtFPd+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786044137; x=1817580137;
  h=date:from:to:cc:subject:message-id;
  bh=mYNuTEI+iw2cegsUU1ef1MwTY6ztc6SXmgSifQF2PCk=;
  b=AHtFPd+y7OZNNhKIZDoQDv1DYTvGUqDMNjMY0nHKwRLbR6qn/YKf4JXk
   P3KQ1EQKF5yoSGDdw/QPnFPsvkXS5XAZtsQnuoHcXahzEDsxejlW+8QCw
   nldOgeocx8VaLDOj4IxZT1FZ5PbEkU5F3IwrmAHcbhnkyaykZI0LX65P2
   V7HoyIVQb/EHniUGHkgVhF8mB6lef23O7O/JwSet7bHl4UYP+YIpkpZhd
   u1lW0suz0ht70MSlTer3IxuW12hHppFz3R9VgyLNoT2CXfaBb6F6pf5n1
   C4zvLe1fgMdMZo7g5pSWYLQJJo5g6PHeO+mzzTxObw1mOoUXnQF/NPO1p
   g==;
X-CSE-ConnectionGUID: aKye4QJQSKOXTpKamvs5Ow==
X-CSE-MsgGUID: 2F8OLnffSM+3Qmzznvy5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86659797"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86659797"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:22:08 -0700
X-CSE-ConnectionGUID: PJIqmQ6mQGauBFiccYu6jw==
X-CSE-MsgGUID: +CJ+kQK5QSSw6WFm4q3Oxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286866739"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Aug 2026 12:22:07 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws3fI-00000000G1W-2gyN;
	Thu, 06 Aug 2026 19:22:04 +0000
Date: Fri, 07 Aug 2026 03:21:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 1b7c9855bb686f271f4e356cc01dab788957c5fb
Message-ID: <202608070332.CjU7L9Us-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 1b7c9855bb686f271f4e356cc01dab788957c5fb  PCI/sysfs: Add legacy I/O and memory attribute macros

elapsed time: 1870m

configs tested: 138
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-004-20260806    gcc-13.4.0
arm64                randconfig-004-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-002-20260806    gcc-13.4.0
csky                 randconfig-002-20260807    gcc-16.1.0
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-002-20260806    clang-24
hexagon              randconfig-002-20260807    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    gcc-14
i386       buildonly-randconfig-004-20260806    gcc-14
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260806    clang-22
i386                 randconfig-002-20260806    clang-22
i386                 randconfig-003-20260806    clang-22
i386                 randconfig-004-20260806    clang-22
i386                 randconfig-005-20260806    clang-22
i386                 randconfig-006-20260806    clang-22
i386                 randconfig-007-20260806    clang-22
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-017-20260806    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-002-20260806    clang-24
loongarch            randconfig-002-20260807    clang-18
m68k                      m5208evb_defconfig    gcc-16.1.0
m68k                         sun3x_defconfig    gcc-16.1.0
mips                  sb1250_swarm_defconfig    gcc-16.1.0
mips                          xway_defconfig    clang-19
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-002-20260806    clang-24
nios2                randconfig-002-20260807    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-8.5.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260806    gcc-13.4.0
riscv                randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-002-20260807    gcc-12.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-002-20260806    gcc-13.4.0
sh                   randconfig-002-20260807    gcc-12.5.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260806    gcc-8.5.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-001-20260806    gcc-8.5.0
sparc64              randconfig-002-20260806    gcc-8.5.0
um                   randconfig-001-20260806    gcc-8.5.0
um                   randconfig-002-20260806    gcc-8.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-002-20260805    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-003-20260805    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-004-20260805    gcc-13
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-006-20260805    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-003-20260806    clang-22
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-006-20260806    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-012-20260806    clang-22
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-016-20260806    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-076-20260806    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260806    gcc-8.5.0
xtensa               randconfig-002-20260806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
