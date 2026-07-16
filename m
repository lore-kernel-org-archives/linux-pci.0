Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D930D3FD
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171544; cv=none; b=Ud3KcvbyYFzBp6/MhayQ/WQcTKHUN2phUMP8Atau727Bw9UJGD1sY9wBRTTbnx/xPzibMLLCIxSjZqOYKDcMx7IlVT5rx9Py1C1Dpd4IhsvO/jcHPJm6Cm0MS8dBPopIBVVXlRE4m0XB/HxrOhcY+5TesSNFmdDI8B+qM7z0fsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171544; c=relaxed/simple;
	bh=cgYEzXUEVg45bT0Wg/uDzff9+TruSRCOATK9/f8yYnM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cd8xOikQkuaBcPI6y2/CCfAuPQqGapfpX1YWEK7C8tpvkJmy2CF2gTKO2+5bsYLtwFSxDx+ytyDbJweiqFow1lTBBnQ85iHVgoTqAPlfctjExGljAsjaJHQ44iTH+fgZ85G3GTHRhZxtSrUPieGpyyXoOOJfAV5b2BzPOLakOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3zUVjrJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3zUVjrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784171543; x=1815707543;
  h=date:from:to:cc:subject:message-id;
  bh=cgYEzXUEVg45bT0Wg/uDzff9+TruSRCOATK9/f8yYnM=;
  b=P3zUVjrJAiAoXUTzIzLta3Tj1XqTEMxAoX8TRe4ufaSZYJKnG8Zsl4dt
   I8vC6SDtLpnkj/5+SlRCM6mPmZmloDy/+pU7Y8/Jd/l0RmKMQ/x4pdnjM
   9kWefnHttruhnMTOaMPKC8hSx3+aAfQKPe3n1OuPocbDkUXb88Ae6BGg7
   eNipGTXt6lq7aX6c1hJSdrS2k6xmlT34LibIyJQQPq9ImQfhQS1HnfyXf
   WPuPM862hzCVlNf8dXSvoeu//oFgomrv1NEIyVFjChvIN5zA/rimCfRQl
   t0HVcFdWExB+aW6E8OhyFKhvcPCu0JqCsxO4rmLCzhpGt9b5FAfAuUNBS
   A==;
X-CSE-ConnectionGUID: c+ev5WXFS5qitBRiEVxcJg==
X-CSE-MsgGUID: ekaPhsvCTKayOClVKhD/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88500283"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88500283"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 20:12:22 -0700
X-CSE-ConnectionGUID: Bi3/O8KSQiKAnRjAngyRsQ==
X-CSE-MsgGUID: 5Y5IbJlSTs+T5d6yDFBlsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="256419412"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 15 Jul 2026 20:12:21 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkCWH-00000000OGE-2WeY;
	Thu, 16 Jul 2026 03:12:17 +0000
Date: Thu, 16 Jul 2026 11:10:09 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-rcar-gen4] BUILD SUCCESS
 a8818827486cd303f63be6ceadd949f64665938f
Message-ID: <202607161159.xS4wHs9U-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
branch HEAD: a8818827486cd303f63be6ceadd949f64665938f  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround

elapsed time: 724m

configs tested: 143
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260716    gcc-14.3.0
arc                   randconfig-002-20260716    gcc-16.1.0
arm                              allyesconfig    gcc-16.1.0
arm                   randconfig-001-20260716    gcc-8.5.0
arm                   randconfig-002-20260716    clang-17
arm                   randconfig-003-20260716    gcc-12.5.0
arm                   randconfig-004-20260716    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-001-20260716    clang-23
arm64                 randconfig-002-20260716    clang-22
arm64                 randconfig-003-20260716    clang-23
arm64                 randconfig-004-20260716    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260716    gcc-12.5.0
csky                  randconfig-002-20260716    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260716    clang-23
hexagon               randconfig-002-20260716    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260716    clang-22
i386        buildonly-randconfig-002-20260716    clang-22
i386        buildonly-randconfig-003-20260716    clang-22
i386        buildonly-randconfig-004-20260716    clang-22
i386        buildonly-randconfig-005-20260716    clang-22
i386        buildonly-randconfig-006-20260716    clang-22
i386                                defconfig    clang-22
i386                  randconfig-001-20260716    clang-22
i386                  randconfig-002-20260716    clang-22
i386                  randconfig-003-20260716    gcc-14
i386                  randconfig-004-20260716    gcc-14
i386                  randconfig-005-20260716    clang-22
i386                  randconfig-006-20260716    clang-22
i386                  randconfig-007-20260716    clang-22
i386                  randconfig-011-20260716    clang-22
i386                  randconfig-012-20260716    gcc-12
i386                  randconfig-013-20260716    clang-22
i386                  randconfig-014-20260716    gcc-12
i386                  randconfig-015-20260716    clang-22
i386                  randconfig-016-20260716    gcc-14
i386                  randconfig-017-20260716    clang-22
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260716    clang-20
loongarch             randconfig-002-20260716    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260716    gcc-8.5.0
nios2                 randconfig-002-20260716    gcc-8.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260716    gcc-15.2.0
parisc                randconfig-002-20260716    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                 randconfig-001-20260716    gcc-14.3.0
riscv                 randconfig-002-20260716    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                  randconfig-001-20260716    clang-23
s390                  randconfig-002-20260716    gcc-9.5.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260716    gcc-16.1.0
sh                    randconfig-002-20260716    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                 randconfig-001-20260716    gcc-13.4.0
sparc                 randconfig-002-20260716    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-002-20260716    clang-23
um                               allmodconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260716    clang-23
um                    randconfig-002-20260716    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260716    clang-22
x86_64      buildonly-randconfig-002-20260716    gcc-14
x86_64      buildonly-randconfig-003-20260716    gcc-14
x86_64      buildonly-randconfig-004-20260716    gcc-14
x86_64      buildonly-randconfig-005-20260716    gcc-14
x86_64      buildonly-randconfig-006-20260716    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260716    gcc-12
x86_64                randconfig-002-20260716    gcc-14
x86_64                randconfig-003-20260716    clang-22
x86_64                randconfig-004-20260716    clang-22
x86_64                randconfig-005-20260716    clang-22
x86_64                randconfig-006-20260716    gcc-14
x86_64                randconfig-011-20260716    clang-22
x86_64                randconfig-012-20260716    clang-22
x86_64                randconfig-013-20260716    gcc-14
x86_64                randconfig-014-20260716    clang-22
x86_64                randconfig-015-20260716    clang-22
x86_64                randconfig-016-20260716    gcc-14
x86_64                randconfig-074-20260716    gcc-14
x86_64                randconfig-076-20260716    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260716    gcc-9.5.0
xtensa                randconfig-002-20260716    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
