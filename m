Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAF3382FC
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566048; cv=none; b=cSq9GjbaWG1INrgzvEB2ULbKQZznA3pU2fcmtPWfZy3RngJJyZkfY9Wh4baO6849XD6K/FxQaNifI9GHYRqlrjnFgeeAX0EH+W4cTL2sHX7K8Kq7TO0cjSceENnxubimKpXOdLxVHDIb8zOO7igLQGwH6GWireknGU6TCunJCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566048; c=relaxed/simple;
	bh=3fHQpXjSlD7V5JUqIf/bkY2GCZCqJ8rSHW5hbbNmrk8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gdBr8bEZFZfdYFDtvTFnZGRWSbC8muVb8ZswjnAhvIxPXEAz58jCpe4TmkPuSBJq61fou/15bYvJ5wM5gI7VcTuIXT8Xt2VF/cudLAX9iYd12jjcBTfm4QE+qny6Ml6M8VlUgtbnuAP3vLQBenfHudv4fsqteTcJ+E+kSpz9a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELiovi2R; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELiovi2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777566047; x=1809102047;
  h=date:from:to:cc:subject:message-id;
  bh=3fHQpXjSlD7V5JUqIf/bkY2GCZCqJ8rSHW5hbbNmrk8=;
  b=ELiovi2R79SPWKi3ActxTslGTBD6AFPof7qAlADcBdn8xqLwHfPots6L
   nv+GiwThPDX9tjzU6rt9DN7VE8lbIwtlU6eR3bgJWn4HMtHssC4SUJh73
   d6LE2behQeR58TfFDpUkcx6EOuOTr+DFAn3X3inO41u1wZF6zg3V0zFBV
   ksPmC24ihVaUrnz6kjqom1c8wV6TvX4AycUd9KvEZ7DxvLjbc7hJ4G3rX
   hypyTbUOXn3nwgnBdR2O3jnCTMy7+04o5kOnrxNp/+dhUuXUBZbrH5DRE
   P3yu64b6VlonuWyEOjC9RfkxkI+5HTj8JqucXk+KBv41fL5jBpl4u6hcR
   g==;
X-CSE-ConnectionGUID: nk6CrSeXSJyx+cdK7Ccw5A==
X-CSE-MsgGUID: DMcoD8olS1a6jimzoQwEfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78419630"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78419630"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:20:47 -0700
X-CSE-ConnectionGUID: Wy4bCDEcRIOC7IiWETLrAA==
X-CSE-MsgGUID: zoqRvVmuR1iIRsmEPXk0zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="272732816"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Apr 2026 09:20:45 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIU82-00000000Ccm-3SP6;
	Thu, 30 Apr 2026 16:20:42 +0000
Date: Fri, 01 May 2026 00:20:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 f34f1712229d71ce4286440fef12526fd4590b37
Message-ID: <202605010011.nBIpamg9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: f34f1712229d71ce4286440fef12526fd4590b37  PCI/IOV: Skip VF Resizable BAR restore on read error

elapsed time: 4233m

configs tested: 162
configs skipped: 1

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260430    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260430    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260430    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260430    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260430    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260430    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260430    clang-23
arm64                 randconfig-002-20260430    clang-23
arm64                 randconfig-003-20260430    clang-23
arm64                 randconfig-004-20260430    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260430    clang-23
csky                  randconfig-002-20260430    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260430    gcc-14.3.0
hexagon               randconfig-002-20260430    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260430    gcc-14
i386        buildonly-randconfig-002-20260430    gcc-14
i386        buildonly-randconfig-003-20260430    gcc-14
i386        buildonly-randconfig-004-20260430    gcc-14
i386        buildonly-randconfig-005-20260430    gcc-14
i386        buildonly-randconfig-006-20260430    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260430    clang-20
i386                  randconfig-002-20260430    clang-20
i386                  randconfig-003-20260430    clang-20
i386                  randconfig-004-20260430    clang-20
i386                  randconfig-005-20260430    clang-20
i386                  randconfig-006-20260430    clang-20
i386                  randconfig-007-20260430    clang-20
i386                  randconfig-011-20260430    clang-20
i386                  randconfig-012-20260430    clang-20
i386                  randconfig-013-20260430    clang-20
i386                  randconfig-014-20260430    clang-20
i386                  randconfig-015-20260430    clang-20
i386                  randconfig-016-20260430    clang-20
i386                  randconfig-017-20260430    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260430    gcc-14.3.0
loongarch             randconfig-002-20260430    gcc-14.3.0
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
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260430    gcc-14.3.0
nios2                 randconfig-002-20260430    gcc-14.3.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                randconfig-001-20260430    gcc-13.4.0
parisc                randconfig-002-20260430    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260430    gcc-13.4.0
powerpc               randconfig-002-20260430    gcc-13.4.0
powerpc64             randconfig-001-20260430    gcc-13.4.0
powerpc64             randconfig-002-20260430    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260430    clang-23
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260430    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260430    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260430    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260430    clang-23
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260430    clang-23
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260430    gcc-14
x86_64      buildonly-randconfig-002-20260430    gcc-14
x86_64      buildonly-randconfig-003-20260430    gcc-14
x86_64      buildonly-randconfig-004-20260430    gcc-14
x86_64      buildonly-randconfig-005-20260430    gcc-14
x86_64      buildonly-randconfig-006-20260430    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260430    clang-20
x86_64                randconfig-012-20260430    clang-20
x86_64                randconfig-013-20260430    clang-20
x86_64                randconfig-014-20260430    clang-20
x86_64                randconfig-015-20260430    clang-20
x86_64                randconfig-016-20260430    clang-20
x86_64                randconfig-071-20260430    gcc-14
x86_64                randconfig-072-20260430    gcc-14
x86_64                randconfig-073-20260430    gcc-14
x86_64                randconfig-074-20260430    gcc-14
x86_64                randconfig-075-20260430    gcc-14
x86_64                randconfig-076-20260430    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
