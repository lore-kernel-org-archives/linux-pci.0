Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A923859EF
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181980; cv=none; b=SQii1FGKgbYoxpy2txLKWCpJniJcMk9tBLGvn1V1dscs0gnJ3NOTa5uBktkFwNu5IM19yrK3ccxTyYOq+yJ8mHOyaib68N7prWVV2q/lNZLRm0OlLGAqXxuvvRcg4VEtOuKIDy6386Ns+H+GrnteVKYPx7jWYssLN/rR2hcOAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181980; c=relaxed/simple;
	bh=UwUbdqwbRI/9N5mGDTl3xli+nj4LvquwyB8KZh+Vdnw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LaxBgivsUMrQ5PLpjqfsUEJrNgzYcFNiUUcRFs923ADeCtpXbF1SRDMSUHrkXMK3wZ3SicX/ehqeOoxkWjFsh0xWx8VF8EtC8iuPMZ2Cy8e2AD2ts0zLh/zwaopbEP2mKQPhf6CzhGdnrZB0v/iWOVDtbiMVb9yVXj77PeYgMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggnw8KsS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggnw8KsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784181978; x=1815717978;
  h=date:from:to:cc:subject:message-id;
  bh=UwUbdqwbRI/9N5mGDTl3xli+nj4LvquwyB8KZh+Vdnw=;
  b=ggnw8KsSM82Xf3ZBDryHhLYBnGZzxUeHTdVw5kkHSY7KnBCE5IFbysTt
   xE+zp10WLR/S2dEIdhjA6/N3BargmK+ZD4OsKHZR/L1UXr9hRJz+ByV2j
   oXygaQCzOsRB0Y4ngMXX/rlOw+Hm84vbRBeRxvLDgIrl1apW4rSchBVfM
   h0sWGRw9Wgqm07p4dLks4p5bT9XlsqSuOXJCTWFil4MuOSyfoy0xoUWP7
   ERoiRDWehYK7skiiS3YbSCDEH3qHRczBgAjqjft3iLdJgbSXZ8uZLd1Dm
   BdiIlEzgwDWSY/LP/GPjLW02p3svXubqCXtGE3fL1fvU0IWDShWDqfWTr
   Q==;
X-CSE-ConnectionGUID: PLXlAsDdS/CWk1DkREX7BA==
X-CSE-MsgGUID: c60TuERLSdy0prt9wjBpCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84686801"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84686801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 23:06:18 -0700
X-CSE-ConnectionGUID: T5bi/xrRSxWWwEkmawfnRA==
X-CSE-MsgGUID: z8KvgN8pTdOQjNyY1uyorA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260211707"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2026 23:06:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkFEc-00000000OMm-1xVM;
	Thu, 16 Jul 2026 06:06:14 +0000
Date: Thu, 16 Jul 2026 14:05:35 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-keystone] BUILD SUCCESS
 3260336defeb292a91de29e4d1d93469e3cec663
Message-ID: <202607161421.ephYWZHp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-keystone
branch HEAD: 3260336defeb292a91de29e4d1d93469e3cec663  PCI: keystone: Fix OF node reference leak in init

elapsed time: 902m

configs tested: 154
configs skipped: 11

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
arm                                 defconfig    clang-24
arm                      footbridge_defconfig    clang-23
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
csky                                defconfig    gcc-16.1.0
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
i386                  randconfig-003-20260716    gcc-14
i386                  randconfig-004-20260716    gcc-14
i386                  randconfig-006-20260716    clang-22
i386                  randconfig-007-20260716    clang-22
i386                  randconfig-011-20260716    clang-22
i386                  randconfig-012-20260716    gcc-12
i386                  randconfig-013-20260716    clang-22
i386                  randconfig-014-20260716    gcc-12
i386                  randconfig-015-20260716    clang-22
i386                  randconfig-016-20260716    gcc-14
i386                  randconfig-017-20260716    clang-22
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
powerpc               randconfig-001-20260716    clang-21
powerpc               randconfig-002-20260716    clang-19
powerpc64             randconfig-001-20260716    clang-22
powerpc64             randconfig-002-20260716    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260716    gcc-14.3.0
riscv                 randconfig-002-20260716    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260716    clang-23
s390                  randconfig-002-20260716    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260716    gcc-16.1.0
sh                    randconfig-002-20260716    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260716    gcc-13.4.0
sparc                 randconfig-002-20260716    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260716    clang-23
sparc64               randconfig-002-20260716    clang-23
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260716    clang-23
um                    randconfig-002-20260716    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260716    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260716    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260716    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260716    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260716    gcc-14
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260716    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260716    gcc-12
x86_64                randconfig-002-20260716    gcc-14
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
