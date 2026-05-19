Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61E330B2D
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191894; cv=none; b=Odm7KvQa37CLcEY064/y1HVlElfLOsyVr3AeHRQj8x0jekNYBfl2rBgj4Wt5WCv2mb7iy/zLkGnYK6TgVKrt+OFiw9jonV4UcJsaK8f5+TtsmCONsrsF4jt0bQXcmS4Qt0z94o6YSqlbKUQnu3mQTVaeq94lIFrNJeFlWDBWtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191894; c=relaxed/simple;
	bh=OUMQvkubfXcA71p1KCr/UgHTEfd+7XMlOBI02QSJIRI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E87dMdJbT5dny3ymGUGfUvMc5k7Xi3GH3Eep3OrCB5+rKyJfTBIik99kdawBPdeicEoItTO6M+53MWuHCVtkWzr1JBXYslBVXNRFKnOi3L3RA20cMOOHCgMy+x5zzNkjexns8L2jMZHCwL/EhXqS1nbV55KJRQfvyzMNv7t4yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN+p+d2m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN+p+d2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779191891; x=1810727891;
  h=date:from:to:cc:subject:message-id;
  bh=OUMQvkubfXcA71p1KCr/UgHTEfd+7XMlOBI02QSJIRI=;
  b=gN+p+d2mLXb4iakW0BKavvTkTaqe1dT51az9v8I1OPCCAPelExe8Fgv9
   I6D8LWLHCpJ2fE7p1fW2vKLsbVb2FKIVxURJIzg/5r8RPphyzueXe0vlu
   ByDS1Wz1pIl8W1/7ygpysLRBbLupAmcbHOk7gpHgLwDkTn2PCu6U4y/Wq
   J57yJyiUv8UgaR8pCBiMZDl2rSoQojj9WCy5giHI9ru/a2j6kBu2TCi3B
   AUjaO85ubmYznuAvEjD0fpXdOUH9TD63DjS8tbT7UlVPn+trL5L1jte6v
   QtbqbdvADo6Tuwl82V9Vw3l+XDWIhEDsqMAvngvUsFxOLxbM1H/xyieSp
   Q==;
X-CSE-ConnectionGUID: mXUGZShSQleG+Z6Q1JlC2w==
X-CSE-MsgGUID: TT0yM+3kSVm/MwOJyD0t6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91459692"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91459692"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 04:58:08 -0700
X-CSE-ConnectionGUID: u4iRtsbBSkCKMeRVwigcnQ==
X-CSE-MsgGUID: Y853v3NBRq63vmFo0t7Qdg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2026 04:58:04 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPJ4u-000000000zt-18fW;
	Tue, 19 May 2026 11:57:47 +0000
Date: Tue, 19 May 2026 19:56:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 23499e7be16635a1c9c295026550903bf9486695
Message-ID: <202605191954.TPRGciCi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 23499e7be16635a1c9c295026550903bf9486695  PCI: qcom: Program T_POWER_ON

elapsed time: 724m

configs tested: 161
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260519    gcc-9.5.0
arc                   randconfig-002-20260519    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-004-20260519    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    clang-18
arm64                 randconfig-002-20260519    gcc-11.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-12.5.0
csky                  randconfig-002-20260519    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260519    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260519    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-14
i386        buildonly-randconfig-003-20260519    clang-20
i386        buildonly-randconfig-004-20260519    gcc-14
i386        buildonly-randconfig-005-20260519    gcc-14
i386        buildonly-randconfig-006-20260519    clang-20
i386                  randconfig-001-20260519    gcc-14
i386                  randconfig-002-20260519    gcc-14
i386                  randconfig-003-20260519    gcc-14
i386                  randconfig-004-20260519    gcc-14
i386                  randconfig-005-20260519    gcc-12
i386                  randconfig-006-20260519    clang-20
i386                  randconfig-007-20260519    clang-20
i386                  randconfig-011-20260519    clang-20
i386                  randconfig-012-20260519    clang-20
i386                  randconfig-013-20260519    gcc-14
i386                  randconfig-014-20260519    clang-20
i386                  randconfig-015-20260519    clang-20
i386                  randconfig-016-20260519    clang-20
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                      randconfig-001    clang-18
loongarch             randconfig-001-20260519    clang-18
loongarch                      randconfig-002    gcc-13.4.0
loongarch             randconfig-002-20260519    gcc-15.2.0
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260519    gcc-12.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260519    clang-23
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64             randconfig-001-20260519    clang-23
powerpc64             randconfig-002-20260519    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260519    gcc-8.5.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260519    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20260519    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260519    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260519    gcc-15.2.0
sh                             randconfig-002    gcc-14.3.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                 randconfig-002-20260519    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260519    gcc-8.5.0
sparc64               randconfig-002-20260519    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260519    clang-23
um                    randconfig-002-20260519    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64      buildonly-randconfig-003-20260519    clang-20
x86_64      buildonly-randconfig-004-20260519    clang-20
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260519    gcc-14
x86_64                randconfig-002-20260519    gcc-13
x86_64                randconfig-011-20260519    gcc-14
x86_64                randconfig-012-20260519    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                randconfig-014-20260519    gcc-14
x86_64                randconfig-015-20260519    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260519    gcc-12
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260519    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260519    gcc-10.5.0
xtensa                randconfig-002-20260519    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
