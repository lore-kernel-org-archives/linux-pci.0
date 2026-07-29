Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEA42B33E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319801; cv=none; b=MTABNuuKBmK5hq87SvY4qpMUY/CbLSNfms8KqrsMXi9yuxhHTaclPyjx8eT9Gkb/VDrRLVP9i5hh+zyEcznk7WnMctS+l6OR3uEjyFFGri/MIiAjUx6JskHXCMypBgmfiP4udIcpPhYhoiKgWvGoNLvxOKwVprzqeRtY16sFMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319801; c=relaxed/simple;
	bh=vRlyvh/SPwRwk8igqFK0OlQwLWEAptOp8NFPBrP0S1g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ldjBwt5Xj1giywguf9j9d2ATmV1gKU/A+TBLNF7HrUEXtQwmtsJZSPewxDwYXrS+feWVRjlw3afMr6lfDn2PEvnfz4gVOcVp1jQW0Mp8xxuBA0IhEhxdDvdKRPPLkT6CJVYL+BkyMARH/snNFvTdZxEWY1wEkPI1p8EuXj+vv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I75Ed4Kd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I75Ed4Kd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785319799; x=1816855799;
  h=date:from:to:cc:subject:message-id;
  bh=vRlyvh/SPwRwk8igqFK0OlQwLWEAptOp8NFPBrP0S1g=;
  b=I75Ed4KdUX6PAqdNLn2yuv6XtutN0Wh66KPrjYoqdYZ9N/5XTWYsedh3
   udBC0TP5EDwZU9imebaqU8UmJHxmR1XDfbXZiuJ+vDvWHVUMOahRznSji
   29eRusuzHtY5gRSJ/MMSbmr9DV2iKK6tNHoWuaa2ypQkKGNVMSwS0mEnZ
   LZtTJ2P/P2jttGYE+w6JvhInJe0F79OnmCMasMqwbwd+1sXAY4jLfX8Bx
   FgynMutqFR+rwKJG1TgjvQUR+vIdPBTyDB2x9vebu/mOAGlbKKylcRp9n
   5TntwACj/aW04TSq1ijJiTdLtcokx6mgLRTX2blITjzMYMWlDsp3ElyYE
   A==;
X-CSE-ConnectionGUID: Z/bKKKqdRTiDUb9voCedug==
X-CSE-MsgGUID: t2zfCM+JT3SJFCYdsuVsKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85864966"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85864966"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:09:58 -0700
X-CSE-ConnectionGUID: Y2NQyrhCTdGQari7ypnBSA==
X-CSE-MsgGUID: 16iVanbnR+C1Pc8fCwB2lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="253631748"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2026 03:09:57 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wp1EZ-00000000fG3-0UuK;
	Wed, 29 Jul 2026 10:09:55 +0000
Date: Wed, 29 Jul 2026 18:09:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 7678e81498e20e78d7d5f64e552cd153117c1d66
Message-ID: <202607291803.gxik7KAx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 7678e81498e20e78d7d5f64e552cd153117c1d66  PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing

elapsed time: 993m

configs tested: 98
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-13.4.0
arm                  randconfig-001-20260729    gcc-10.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    clang-24
arm                  randconfig-004-20260729    clang-18
arm64                randconfig-001-20260729    gcc-15.2.0
arm64                randconfig-002-20260729    gcc-13.4.0
arm64                randconfig-003-20260729    gcc-11.5.0
arm64                randconfig-004-20260729    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    gcc-16.1.0
csky                 randconfig-002-20260729    gcc-16.1.0
hexagon              randconfig-001-20260729    clang-21
hexagon              randconfig-002-20260729    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    clang-22
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    clang-22
i386       buildonly-randconfig-005-20260729    clang-22
i386       buildonly-randconfig-006-20260729    gcc-14
i386                 randconfig-001-20260729    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                 randconfig-011-20260729    clang-22
i386                 randconfig-012-20260729    clang-22
i386                 randconfig-013-20260729    clang-22
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    clang-22
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    clang-19
loongarch            randconfig-002-20260729    gcc-13.4.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-11.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    gcc-10.5.0
parisc               randconfig-002-20260729    gcc-16.1.0
powerpc              randconfig-001-20260729    clang-21
powerpc              randconfig-002-20260729    gcc-8.5.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-002-20260729    gcc-10.5.0
riscv                randconfig-001-20260729    gcc-8.5.0
riscv                randconfig-002-20260729    gcc-9.5.0
s390                 randconfig-001-20260729    clang-17
s390                 randconfig-002-20260729    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-13.4.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-8.5.0
sparc                randconfig-002-20260729    gcc-16.1.0
sparc64              randconfig-001-20260729    gcc-12.5.0
sparc64              randconfig-002-20260729    clang-21
um                   randconfig-001-20260729    gcc-14
um                   randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-12
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    gcc-13
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    gcc-14
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-016-20260729    gcc-14
x86_64               randconfig-071-20260729    clang-22
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-074-20260729    clang-22
x86_64               randconfig-075-20260729    gcc-14
x86_64               randconfig-076-20260729    gcc-14
xtensa                 cadence_csp_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260729    gcc-12.5.0
xtensa               randconfig-002-20260729    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
