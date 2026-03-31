Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019D3A7840
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961677; cv=none; b=q6nQVL8QwVw16Khu1FDBosNhojj9cfbG2rQ3R8BzCq/oj+n9oKqfSf6zC22XrwitPUeuzC8TrB0KvHGP7JO2cncKbXp6HdCbqGXJ6uztehR4ni/aei7YLXvjyEC+Q5RcPit8s5xOdut2Dzjy8YrLsJyKwCP8eFrUokAIlvpuEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961677; c=relaxed/simple;
	bh=KoNPm2hCTbP2+BqobkpFV2nVNom0ySoCWseF9Qdebmg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EsWx77MbCP8OVToGXSI/taFqu8poH6ebsznAe8g+nAkg0JLHcOzXPnIkEC3tFHKP6QhLIk7MD0VM/wXjZVH66a7pHCf7LoDRlS7h/8y24gAkM+cQHYBE2943ZtRO5ChCyZv6X0qkyIDNQP9sV6+9OolyXghUT8pEJC/k2sKbUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ5yYLKX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ5yYLKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961676; x=1806497676;
  h=date:from:to:cc:subject:message-id;
  bh=KoNPm2hCTbP2+BqobkpFV2nVNom0ySoCWseF9Qdebmg=;
  b=RJ5yYLKXHby1OIHCSlCiWfxfjmXVfvk1D39UbkZtfPGEphcOCxXwpcjv
   pxyErfFymPRSRp38TL7KUrAqIoKiBGxqe1zQHS3OPLw5Q1f/xS2stwr3+
   kk7yZjUeh6FB71x4yTIshrITqBgTO63YMvtVj9AvyRkU1SnROHEgyjuL2
   IHBQy1HxA0YgMlxuvX+uGnVfBHvmtJKcch+KEvwWkvpyOmnpcIIKCtpa5
   cyV2xEM0O3UAuWwNDWIUak4Yh6IaINKKMsx06Jtzx3wHmbMXZ2q6I5C/X
   IgtHS2seCrlEkhlp04+7lOZg/cxzQLaRr4fXGqyX9k5XOefVbGpiUG+qU
   w==;
X-CSE-ConnectionGUID: GE5ckMAESz+BMDDL9zhZcQ==
X-CSE-MsgGUID: c502wqHyTf6+i7Jof4W77g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75144758"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75144758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:54:35 -0700
X-CSE-ConnectionGUID: yqpa5wcBQsGFA/+uL/zo5Q==
X-CSE-MsgGUID: oSo7KW0uSHa6nHsgSiZaVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225351113"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Mar 2026 05:54:34 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Yc3-000000002d7-0exy;
	Tue, 31 Mar 2026 12:54:31 +0000
Date: Tue, 31 Mar 2026 20:54:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 bf2dbae2efd216c409636815d1539bd105aface4
Message-ID: <202603312058.70hTQvAv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: bf2dbae2efd216c409636815d1539bd105aface4  PCI: Disable ATS via quirk before notifying IOMMU drivers

elapsed time: 744m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260331    clang-23
arc                   randconfig-002-20260331    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260331    clang-23
arm                   randconfig-002-20260331    clang-23
arm                   randconfig-003-20260331    clang-23
arm                   randconfig-004-20260331    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260331    clang-18
arm64                 randconfig-002-20260331    clang-18
arm64                 randconfig-003-20260331    clang-18
arm64                 randconfig-004-20260331    clang-18
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260331    clang-18
csky                  randconfig-002-20260331    clang-18
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260331    gcc-11.5.0
hexagon               randconfig-002-20260331    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260331    clang-20
i386        buildonly-randconfig-002-20260331    clang-20
i386        buildonly-randconfig-003-20260331    clang-20
i386        buildonly-randconfig-004-20260331    clang-20
i386        buildonly-randconfig-005-20260331    clang-20
i386        buildonly-randconfig-006-20260331    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260331    gcc-14
i386                  randconfig-002-20260331    gcc-14
i386                  randconfig-003-20260331    gcc-14
i386                  randconfig-004-20260331    gcc-14
i386                  randconfig-005-20260331    gcc-14
i386                  randconfig-006-20260331    gcc-14
i386                  randconfig-007-20260331    gcc-14
i386                  randconfig-011-20260331    clang-20
i386                  randconfig-012-20260331    clang-20
i386                  randconfig-013-20260331    clang-20
i386                  randconfig-014-20260331    clang-20
i386                  randconfig-015-20260331    clang-20
i386                  randconfig-016-20260331    clang-20
i386                  randconfig-017-20260331    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260331    gcc-11.5.0
loongarch             randconfig-002-20260331    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip32_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260331    gcc-11.5.0
nios2                 randconfig-002-20260331    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260331    clang-23
parisc                randconfig-002-20260331    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260331    clang-23
powerpc               randconfig-002-20260331    clang-23
powerpc64                        alldefconfig    clang-23
powerpc64             randconfig-001-20260331    clang-23
powerpc64             randconfig-002-20260331    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260331    gcc-15.2.0
riscv                 randconfig-002-20260331    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260331    gcc-15.2.0
s390                  randconfig-002-20260331    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260331    gcc-15.2.0
sh                    randconfig-002-20260331    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260331    gcc-15.2.0
sparc                 randconfig-002-20260331    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260331    gcc-15.2.0
sparc64               randconfig-002-20260331    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260331    gcc-15.2.0
um                    randconfig-002-20260331    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260331    clang-20
x86_64      buildonly-randconfig-002-20260331    clang-20
x86_64      buildonly-randconfig-003-20260331    clang-20
x86_64      buildonly-randconfig-004-20260331    clang-20
x86_64      buildonly-randconfig-005-20260331    clang-20
x86_64      buildonly-randconfig-006-20260331    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260331    gcc-14
x86_64                randconfig-002-20260331    gcc-14
x86_64                randconfig-003-20260331    gcc-14
x86_64                randconfig-004-20260331    gcc-14
x86_64                randconfig-005-20260331    gcc-14
x86_64                randconfig-006-20260331    gcc-14
x86_64                randconfig-011-20260331    clang-20
x86_64                randconfig-012-20260331    clang-20
x86_64                randconfig-013-20260331    clang-20
x86_64                randconfig-014-20260331    clang-20
x86_64                randconfig-015-20260331    clang-20
x86_64                randconfig-016-20260331    clang-20
x86_64                randconfig-071-20260331    clang-20
x86_64                randconfig-072-20260331    clang-20
x86_64                randconfig-073-20260331    clang-20
x86_64                randconfig-074-20260331    clang-20
x86_64                randconfig-075-20260331    clang-20
x86_64                randconfig-076-20260331    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260331    gcc-15.2.0
xtensa                randconfig-002-20260331    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
