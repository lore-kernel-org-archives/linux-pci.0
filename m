Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED03AD50A
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696656; cv=none; b=oLvNXdUN0tiQUDr06TqphfGlP2nRj7xGCLtKvALBBZDE7B8crvNW/cJChnMLa+ZjrJNYZ74bQsXOfQ1Kq6zzCCJ32S8w7OjSIkXySZfjAwW7a3X+0letEhumLzXTqskwU82TuiD1BTJM5IvnqJOG5tWWQUKD8ZwSgp7XksyV/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696656; c=relaxed/simple;
	bh=5/GmHNRewgbB8HvZ+AUb2TqaexxCjjTglGDRM/NROGc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZJwJzKNwsA73AoMGw7xSyfhep7ONzxI1fok9FpC04RC6SgERN709lj1Rua3I1msOpVo8sdv7LlpvV6d2dQ0lQIK3lAEXtzajNlaR8NVZ68XqZiOMWEQt2YZ4RKfz/hSUhjdaJwDa6ovpg4otz97pPKXdknoThtDqfPEKgiy3Fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODJgb9xs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODJgb9xs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778696654; x=1810232654;
  h=date:from:to:cc:subject:message-id;
  bh=5/GmHNRewgbB8HvZ+AUb2TqaexxCjjTglGDRM/NROGc=;
  b=ODJgb9xsNs+DGtIJfG1Ui938XXp/ovlpsnQVOgFVLcVLd37Lr27QKf1j
   5i9tgMQDGuBcQFKZ3CUwmPJPAMV7JsoXKSrIShGL2/pNos/n2zutlhIqU
   n4U0wQqjohpin3QisPZKl6EemC44ILx2X1yOsRzAtLhIPEn/VhhGIEE92
   QmdQB3mMJ867YboXnKtb6b5YMughsp85t7cCBK2WKUSkYkhGcbYZJrdBz
   BD77BfbBFu7Ui5jELDIlLOYWLBNu1YUnIU0IB3sAHJO2q3k2Gsmdx3LNF
   zlb+fb0LYyp6l4YS1K9AlWEP57/Rw5hEamBAEaIH4frU6c8CyHXWn+ZFf
   w==;
X-CSE-ConnectionGUID: yxq91XgzRiqjwfezjVOpeg==
X-CSE-MsgGUID: q46pQ9PGR6S/tYqB2snKew==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="78659569"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="78659569"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:24:13 -0700
X-CSE-ConnectionGUID: K1T4OGNiSnexYg/b6CUCpg==
X-CSE-MsgGUID: nleFo+s9RdSbU5pj71S//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="238398872"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 May 2026 11:24:10 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNEFd-000000004qx-23Mk;
	Wed, 13 May 2026 18:24:09 +0000
Date: Thu, 14 May 2026 02:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 962ee96333431e80f71457b66fbcce9d48ad0895
Message-ID: <202605140222.t2InXFOA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 962ee96333431e80f71457b66fbcce9d48ad0895  Merge branch 'pci/misc'

elapsed time: 739m

configs tested: 222
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260513    gcc-14.3.0
arc                   randconfig-001-20260514    clang-23
arc                   randconfig-002-20260513    gcc-14.3.0
arc                   randconfig-002-20260514    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260513    gcc-14.3.0
arm                   randconfig-001-20260514    clang-23
arm                   randconfig-002-20260513    gcc-14.3.0
arm                   randconfig-002-20260514    clang-23
arm                   randconfig-003-20260513    gcc-14.3.0
arm                   randconfig-003-20260514    clang-23
arm                   randconfig-004-20260513    gcc-14.3.0
arm                   randconfig-004-20260514    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260513    clang-23
arm64                 randconfig-001-20260513    gcc-12.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260513    clang-23
arm64                 randconfig-002-20260513    gcc-12.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260513    clang-23
arm64                 randconfig-003-20260513    gcc-12.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260513    clang-23
arm64                 randconfig-004-20260513    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260513    clang-23
csky                  randconfig-001-20260513    gcc-12.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260513    clang-23
csky                  randconfig-002-20260513    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260513    clang-23
hexagon               randconfig-001-20260513    gcc-11.5.0
hexagon               randconfig-001-20260513    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260513    clang-23
hexagon               randconfig-002-20260513    gcc-11.5.0
hexagon               randconfig-002-20260513    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260513    clang-20
i386        buildonly-randconfig-002-20260513    clang-20
i386        buildonly-randconfig-003-20260513    clang-20
i386        buildonly-randconfig-004-20260513    clang-20
i386        buildonly-randconfig-005-20260513    clang-20
i386        buildonly-randconfig-006-20260513    clang-20
i386                  randconfig-001-20260513    clang-20
i386                  randconfig-002-20260513    clang-20
i386                  randconfig-003-20260513    clang-20
i386                  randconfig-004-20260513    clang-20
i386                  randconfig-005-20260513    clang-20
i386                  randconfig-006-20260513    clang-20
i386                  randconfig-007-20260513    clang-20
i386                  randconfig-011-20260513    clang-20
i386                  randconfig-012-20260513    clang-20
i386                  randconfig-013-20260513    clang-20
i386                  randconfig-014-20260513    clang-20
i386                  randconfig-015-20260513    clang-20
i386                  randconfig-016-20260513    clang-20
i386                  randconfig-017-20260513    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260513    clang-19
loongarch             randconfig-001-20260513    gcc-11.5.0
loongarch             randconfig-001-20260513    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260513    clang-23
loongarch             randconfig-002-20260513    gcc-11.5.0
loongarch             randconfig-002-20260513    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260513    gcc-11.5.0
nios2                 randconfig-001-20260513    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260513    gcc-11.5.0
nios2                 randconfig-002-20260513    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260513    gcc-8.5.0
parisc                randconfig-002-20260513    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260513    gcc-8.5.0
powerpc               randconfig-002-20260513    gcc-8.5.0
powerpc64             randconfig-001-20260513    gcc-8.5.0
powerpc64             randconfig-002-20260513    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260513    gcc-15.2.0
riscv                 randconfig-002-20260513    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260513    gcc-15.2.0
s390                  randconfig-002-20260513    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260513    gcc-15.2.0
sh                    randconfig-002-20260513    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260513    gcc-11.5.0
sparc                 randconfig-002-20260513    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260513    gcc-11.5.0
sparc64               randconfig-002-20260513    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260513    gcc-11.5.0
um                    randconfig-002-20260513    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260513    gcc-12
x86_64      buildonly-randconfig-002-20260513    gcc-12
x86_64      buildonly-randconfig-003-20260513    gcc-12
x86_64      buildonly-randconfig-004-20260513    gcc-12
x86_64      buildonly-randconfig-005-20260513    gcc-12
x86_64      buildonly-randconfig-006-20260513    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260513    clang-20
x86_64                randconfig-002-20260513    clang-20
x86_64                randconfig-003-20260513    clang-20
x86_64                randconfig-004-20260513    clang-20
x86_64                randconfig-005-20260513    clang-20
x86_64                randconfig-006-20260513    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260513    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260513    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260513    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260513    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260513    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260513    gcc-14
x86_64                randconfig-071-20260513    gcc-14
x86_64                randconfig-072-20260513    gcc-14
x86_64                randconfig-073-20260513    gcc-14
x86_64                randconfig-074-20260513    gcc-14
x86_64                randconfig-075-20260513    gcc-14
x86_64                randconfig-076-20260513    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260513    gcc-11.5.0
xtensa                randconfig-002-20260513    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
