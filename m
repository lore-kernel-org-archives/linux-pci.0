Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313B2FE598
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519010; cv=none; b=ZTe7QVfGsKDMrT4NdebWqV4AqyNPUcUbkhZKKG3gGZ1Xf6TmdZvivN1nixJ7XYaORKNbCWCEZrovxDxFwwKNvp7iNytFLDwA17XH+92/9HZUmtQdxhTkO34P3PR2nRMcAAi7lhBeWvWzZLs9bL8pSPaagYBQMssDqB87TMRKkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519010; c=relaxed/simple;
	bh=j1lcCaT+W60W2FEe/fRbfBcnH5oO7EazA7eW7u57Xfw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b2R3caTuJvCKiwpSij/PLLl39p7RFzCQhlkLRyV6zRiUnrJuNFRRHl/H1iVBrdk/mDOJShvvdjtbx2GAq028+clQ+4vuesEDMy5CaAU80lNAeCjNg0YM8WRcc03X2Xjwak4h1gdkSVZS/84Ck+YS9zHtkhdchxYRQHGV+9I7MJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEQLsqQ+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEQLsqQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769519008; x=1801055008;
  h=date:from:to:cc:subject:message-id;
  bh=j1lcCaT+W60W2FEe/fRbfBcnH5oO7EazA7eW7u57Xfw=;
  b=jEQLsqQ+u4oiMANlqjL6qSvcdLve2Z399fW9s+d6LI1pMqkFj63TUGDV
   sa0kpT7WmY6cBnWKK7vpwZfMVufR3fTU5WJnyhixZm+mQpvWyHy30RCIm
   2K6opPKRRo9a88/x0Qn6xxB8c40X60b0ZdhCXWznuOCiwv3gu2hr1ys5j
   FdbIHhg0iCdD4WV2E16BsU103btPWODmyrJTP20LskW5QvqlrBh7RMGno
   TOqq/bPxVH1zp79V7VE/UzIlhbhTc7O3IpDyKPSNrQFqfOFkIatJLhAfR
   cVIFywZJgrqelLo0Q/zSPP3hvtE7SLc3kfO/tXELNNVkxqpSZLC+pu1qv
   w==;
X-CSE-ConnectionGUID: LMB63XeMTW270LQdFoqtiw==
X-CSE-MsgGUID: dUaf+pwBRHGZX1PQ8r6PcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="73298733"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="73298733"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:03:28 -0800
X-CSE-ConnectionGUID: xO+q/r6/TFmKOKUps1LaOg==
X-CSE-MsgGUID: MNhhbGqGQ3G7l4jeQCJpZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207763310"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Jan 2026 05:03:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkij6-00000000YUi-0joO;
	Tue, 27 Jan 2026 13:03:24 +0000
Date: Tue, 27 Jan 2026 21:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 40880ffac17ded5a8b583ea7d052afccd4029f99
Message-ID: <202601272146.0ib3p7FK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 40880ffac17ded5a8b583ea7d052afccd4029f99  Merge branch 'pci/misc'

elapsed time: 877m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260127    gcc-8.5.0
arc                   randconfig-002-20260127    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20260127    clang-22
arm                   randconfig-002-20260127    clang-18
arm                   randconfig-003-20260127    gcc-14.3.0
arm                   randconfig-004-20260127    clang-18
arm                        spear6xx_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260127    gcc-10.5.0
arm64                 randconfig-002-20260127    clang-22
arm64                 randconfig-003-20260127    gcc-11.5.0
arm64                 randconfig-004-20260127    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260127    gcc-15.2.0
csky                  randconfig-002-20260127    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260127    clang-22
hexagon               randconfig-002-20260127    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260127    clang-20
i386        buildonly-randconfig-002-20260127    clang-20
i386        buildonly-randconfig-003-20260127    gcc-14
i386        buildonly-randconfig-004-20260127    clang-20
i386        buildonly-randconfig-005-20260127    gcc-14
i386        buildonly-randconfig-006-20260127    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260127    gcc-14
i386                  randconfig-002-20260127    gcc-14
i386                  randconfig-003-20260127    clang-20
i386                  randconfig-004-20260127    gcc-14
i386                  randconfig-005-20260127    gcc-14
i386                  randconfig-006-20260127    clang-20
i386                  randconfig-007-20260127    clang-20
i386                  randconfig-011-20260127    gcc-14
i386                  randconfig-012-20260127    gcc-12
i386                  randconfig-013-20260127    gcc-14
i386                  randconfig-014-20260127    clang-20
i386                  randconfig-015-20260127    clang-20
i386                  randconfig-016-20260127    gcc-14
i386                  randconfig-017-20260127    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260127    gcc-15.2.0
loongarch             randconfig-002-20260127    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-22
mips                          eyeq6_defconfig    clang-22
mips                      malta_kvm_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260127    gcc-11.5.0
nios2                 randconfig-002-20260127    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260127    gcc-11.5.0
parisc                randconfig-002-20260127    gcc-13.4.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260127    gcc-14.3.0
powerpc               randconfig-002-20260127    clang-22
powerpc64             randconfig-001-20260127    gcc-11.5.0
powerpc64             randconfig-002-20260127    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260127    clang-22
riscv                 randconfig-002-20260127    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260127    gcc-13.4.0
s390                  randconfig-002-20260127    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260127    gcc-13.4.0
sh                    randconfig-002-20260127    gcc-10.5.0
sh                   sh7770_generic_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260127    gcc-15.2.0
sparc                 randconfig-002-20260127    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260127    clang-20
sparc64               randconfig-002-20260127    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260127    clang-20
um                    randconfig-002-20260127    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260127    clang-20
x86_64      buildonly-randconfig-002-20260127    gcc-14
x86_64      buildonly-randconfig-003-20260127    gcc-14
x86_64      buildonly-randconfig-004-20260127    gcc-14
x86_64      buildonly-randconfig-005-20260127    gcc-14
x86_64      buildonly-randconfig-006-20260127    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260127    gcc-14
x86_64                randconfig-002-20260127    gcc-14
x86_64                randconfig-003-20260127    clang-20
x86_64                randconfig-004-20260127    gcc-14
x86_64                randconfig-005-20260127    clang-20
x86_64                randconfig-006-20260127    gcc-14
x86_64                randconfig-071-20260127    gcc-14
x86_64                randconfig-072-20260127    gcc-14
x86_64                randconfig-073-20260127    gcc-14
x86_64                randconfig-074-20260127    clang-20
x86_64                randconfig-075-20260127    clang-20
x86_64                randconfig-076-20260127    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-002-20260127    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
