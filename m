Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107836A023
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170520; cv=none; b=n/Pqmij9rdK4ykfSmredIh1anjHviN8i88BsDoo7mkyr8vnmeXSoHW7u0i2HH/2/ltPZh2DrShWTX+Z9uXEHvhujysePxPo1F/L9vCLlxgE1RwwI4uTBJWrToGi7YnW0Fkn79erR6Py2hjRbcHACMVutIlHjP7mhV0CTGw8hUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170520; c=relaxed/simple;
	bh=8P3G/BaSOJSPeCocjgLO1IQV8xlBw8sUlQYqk+yngnA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AMWs1dhmO2XFbZr31eGzCr5W5MxQejqKH4EzOpMcAV//LtWH82yRPKRYlK3DwryHsT3aUCIvJ5A1GVpYQJDzT2CeAx6ilIVyGbmIfcPO2tnvjoqjKMxsTHUxzQy2NQWDO+UKrvhxk3qzOuR2mMtFLLM7x6EjvTQq986H51WMgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avdtTN6V; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avdtTN6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779170519; x=1810706519;
  h=date:from:to:cc:subject:message-id;
  bh=8P3G/BaSOJSPeCocjgLO1IQV8xlBw8sUlQYqk+yngnA=;
  b=avdtTN6V1vQrN5tE6U1poeqO2990t9CaarvMDG3JYVE/ft4NKisxpgkR
   p7UvlNHadhPHHVYqc0zMW2f0aSzDNgV4YADS1AU4XhczqOBY1btTWrsnB
   znnys8e16hCeQxXYG7GKX+OqPNqFa9tU/NCkdajbeeXQyhAQd8sh/PuO8
   ffMK7pSsz8EYPTV8AYPovo6nissfwzCv/KQ18PNvBHwE01CBgvomkoE9m
   wHn339sPNmpnjHrNH+4GcuIH7xzLFbYdE16S0Wf47omxn+6NM4ui+2UT7
   8kGUKZaOkDswyr6lc2aQSrH0t6/XEbWtPgI+aKFb0QquV3SWuD2kboZ2h
   A==;
X-CSE-ConnectionGUID: S7YjNndqRuqanxfxuAjI7A==
X-CSE-MsgGUID: QdlkZ0QrSUywxHzXgmn10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97472248"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97472248"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:01:58 -0700
X-CSE-ConnectionGUID: I8C1O1F2QcquakCRcPXNSQ==
X-CSE-MsgGUID: kxDpwN79QziMhBmv0WAfug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239917059"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 May 2026 23:01:57 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPDWc-000000000YJ-0SmI;
	Tue, 19 May 2026 06:01:54 +0000
Date: Tue, 19 May 2026 14:01:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek-gen3] BUILD SUCCESS
 d39d55d7411c18ca6aeb63aafa8035f4ad8b317f
Message-ID: <202605191431.y5qnTiH5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek-gen3
branch HEAD: d39d55d7411c18ca6aeb63aafa8035f4ad8b317f  PCI: mediatek-gen3: Do full device power down on removal

elapsed time: 720m

configs tested: 163
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260519    clang-23
arc                   randconfig-002-20260519    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-004-20260519    clang-23
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    gcc-8.5.0
arm64                 randconfig-002-20260519    gcc-8.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-8.5.0
csky                  randconfig-002-20260519    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260519    gcc-10.5.0
hexagon               randconfig-002-20260519    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20260519    gcc-12
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-12
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20260519    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-12
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20260519    gcc-12
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20260519    gcc-12
i386                  randconfig-011-20260519    gcc-14
i386                  randconfig-012-20260519    gcc-14
i386                  randconfig-013-20260519    gcc-14
i386                  randconfig-014-20260519    gcc-14
i386                  randconfig-015-20260519    gcc-14
i386                  randconfig-016-20260519    gcc-14
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260519    gcc-10.5.0
loongarch             randconfig-002-20260519    gcc-10.5.0
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
mips                        bcm47xx_defconfig    clang-18
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260519    gcc-10.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260519    gcc-8.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260519    gcc-8.5.0
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64             randconfig-001-20260519    gcc-8.5.0
powerpc64             randconfig-002-20260519    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260519    gcc-13.4.0
riscv                 randconfig-002-20260519    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260519    gcc-13.4.0
s390                  randconfig-002-20260519    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260519    gcc-13.4.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64      buildonly-randconfig-003-20260519    gcc-14
x86_64      buildonly-randconfig-004-20260519    gcc-14
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260519    clang-20
x86_64                randconfig-012-20260519    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                randconfig-014-20260519    clang-20
x86_64                randconfig-015-20260519    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
