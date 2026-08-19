Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37896345CA8
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181927; cv=none; b=JqIUdggWyfZbpRYylAQq5msCiEyUKUBibL5PPK67wmt8q1/Ue68CJv/TBTDsXXKd6MpgomiKnKruvvrzs+o1qBqaVTCG/V2kBz9edgtohmK6Q9trW1Z8t5jseKMbsxcKBzWWTyA1aic0XFOY4e49UWGZO6STQluOoOfRA08w/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181927; c=relaxed/simple;
	bh=9WOa5EInHpFZ2HzCa30TeExE9B1gcBksJ4Pux5TlGBw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ugfIg1dWjNFuTz81awyY2+cibvGxmmg0cxazpHLG4UTwW8qbBHGrP7cXX0C3R4EFTjtihLdNb8y2nzp7W04Rnh+I/P1eM7R8Or/jEAqSrbTY4xmXuMbYDfXSw9JzQJB0vBwfQJe0BpH6Ni8mrUdnM6XVqA+Ph7Bzu5qTdnRqOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwWbQjZQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwWbQjZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787181926; x=1818717926;
  h=date:from:to:cc:subject:message-id;
  bh=9WOa5EInHpFZ2HzCa30TeExE9B1gcBksJ4Pux5TlGBw=;
  b=JwWbQjZQdKsBSNMzuj1Oo50xS8c+6+DM2L3l6STeFK2r+NLNIg7IAoc7
   Wy18bQvDHaskaZEXmuI+C8Ra7rc2ymR63Jfu5IpXHEpNwnoJm+Zt+1NXX
   wPaL/IZ1Ygdzik+6WtHpFYu4bCZTB6BuDDfKHLQn1eGOEjEVvKuNhHlzw
   /XnaKQybHnJ/Z2NTa9FJjOvDE84G2hvzvCmwdDSQvw6UQu0oZaE+/rgDc
   RI4b74e0iUb15Gz2cZ2xqnLyqeQQMqQTybGvOfs09zV/Ij55i6NX6jbwg
   CXvg4NGCfxswi+98/2pNR14IIRWlMFgxdsm3UrHRug6sZogV/9h/Na5R7
   Q==;
X-CSE-ConnectionGUID: NN12o55/R26yVeoX2QKaJg==
X-CSE-MsgGUID: dlNFNSYQQw6fmlkg/fayKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87917574"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87917574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:25:25 -0700
X-CSE-ConnectionGUID: N6Ksmc7aRRuhtCynM7PLsA==
X-CSE-MsgGUID: /OcRDUfhQI63lrNxV4XtlA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2026 16:25:23 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwpeq-00000000gtT-3dIj;
	Wed, 19 Aug 2026 23:25:20 +0000
Date: Thu, 20 Aug 2026 07:24:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 eddba19b8b5f76d57424ee328a68fd495c5db857
Message-ID: <202608200733.V5McaZ68-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: eddba19b8b5f76d57424ee328a68fd495c5db857  PCI/AER: Support Advisory Non-Fatal Errors

elapsed time: 1463m

configs tested: 195
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260819    gcc-11.5.0
arc                  randconfig-001-20260820    clang-24
arc                  randconfig-002-20260819    gcc-11.5.0
arc                  randconfig-002-20260820    clang-24
arm                  randconfig-001-20260819    gcc-11.5.0
arm                  randconfig-001-20260820    clang-24
arm                  randconfig-002-20260819    gcc-11.5.0
arm                  randconfig-002-20260820    clang-24
arm                  randconfig-003-20260819    gcc-11.5.0
arm                  randconfig-003-20260820    clang-24
arm                  randconfig-004-20260819    gcc-11.5.0
arm                  randconfig-004-20260820    clang-24
arm64                randconfig-001-20260819    gcc-9.5.0
arm64                randconfig-001-20260820    clang-24
arm64                randconfig-002-20260819    gcc-9.5.0
arm64                randconfig-002-20260820    clang-24
arm64                randconfig-003-20260819    gcc-9.5.0
arm64                randconfig-003-20260820    clang-24
arm64                randconfig-004-20260819    gcc-9.5.0
arm64                randconfig-004-20260820    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260819    gcc-9.5.0
csky                 randconfig-001-20260820    clang-24
csky                 randconfig-002-20260819    gcc-9.5.0
csky                 randconfig-002-20260820    clang-24
hexagon                       randconfig-001    gcc-11.5.0
hexagon              randconfig-001-20260819    gcc-11.5.0
hexagon              randconfig-001-20260820    gcc-14.3.0
hexagon              randconfig-002-20260819    gcc-11.5.0
hexagon              randconfig-002-20260820    gcc-14.3.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260819    gcc-14
i386       buildonly-randconfig-001-20260820    gcc-14
i386       buildonly-randconfig-002-20260819    gcc-14
i386       buildonly-randconfig-002-20260820    gcc-14
i386       buildonly-randconfig-003-20260819    gcc-14
i386       buildonly-randconfig-003-20260820    gcc-14
i386       buildonly-randconfig-004-20260819    gcc-14
i386       buildonly-randconfig-004-20260820    gcc-14
i386       buildonly-randconfig-005-20260819    gcc-14
i386       buildonly-randconfig-005-20260820    gcc-14
i386       buildonly-randconfig-006-20260819    gcc-14
i386       buildonly-randconfig-006-20260820    gcc-14
i386                          randconfig-001    gcc-14
i386                 randconfig-001-20260819    gcc-14
i386                 randconfig-001-20260820    clang-22
i386                 randconfig-002-20260819    gcc-14
i386                 randconfig-002-20260820    clang-22
i386                 randconfig-003-20260819    gcc-14
i386                 randconfig-003-20260820    clang-22
i386                 randconfig-004-20260819    gcc-14
i386                 randconfig-004-20260820    clang-22
i386                 randconfig-005-20260819    gcc-14
i386                 randconfig-005-20260820    clang-22
i386                 randconfig-006-20260819    gcc-14
i386                 randconfig-006-20260820    clang-22
i386                 randconfig-007-20260819    gcc-14
i386                 randconfig-007-20260820    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260819    gcc-14
i386                 randconfig-011-20260820    gcc-14
i386                 randconfig-012-20260819    gcc-14
i386                 randconfig-012-20260820    gcc-14
i386                 randconfig-013-20260819    gcc-14
i386                 randconfig-013-20260820    gcc-14
i386                 randconfig-014-20260819    gcc-14
i386                 randconfig-014-20260820    gcc-14
i386                 randconfig-015-20260819    gcc-14
i386                 randconfig-015-20260820    gcc-14
i386                 randconfig-016-20260819    gcc-14
i386                 randconfig-016-20260820    gcc-14
i386                 randconfig-017-20260819    gcc-14
i386                 randconfig-017-20260820    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260819    gcc-11.5.0
loongarch            randconfig-001-20260820    gcc-14.3.0
loongarch            randconfig-002-20260819    gcc-11.5.0
loongarch            randconfig-002-20260820    gcc-14.3.0
m68k                         atari_defconfig    gcc-16.1.0
mips                    cu1000-neo_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260819    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-14.3.0
nios2                randconfig-002-20260819    gcc-11.5.0
nios2                randconfig-002-20260820    gcc-14.3.0
openrisc        de0_nano_multicore_defconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    clang-24
parisc               randconfig-001-20260819    clang-24
parisc               randconfig-001-20260820    gcc-8.5.0
parisc               randconfig-002-20260819    clang-24
parisc               randconfig-002-20260820    gcc-8.5.0
powerpc                        ps3_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260819    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-002-20260819    clang-24
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc                   sam440ep_defconfig    gcc-16.1.0
powerpc                    sequoia_defconfig    clang-24
powerpc64            randconfig-001-20260819    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260819    clang-24
powerpc64            randconfig-002-20260820    gcc-8.5.0
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260819    clang-24
riscv                randconfig-001-20260820    clang-24
riscv                randconfig-002-20260819    clang-24
riscv                randconfig-002-20260820    clang-24
s390                 randconfig-001-20260819    clang-24
s390                 randconfig-001-20260820    clang-24
s390                 randconfig-002-20260819    clang-24
s390                 randconfig-002-20260820    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260819    clang-24
sh                   randconfig-001-20260820    clang-24
sh                   randconfig-002-20260819    clang-24
sh                   randconfig-002-20260820    clang-24
sparc                randconfig-001-20260819    gcc-10.5.0
sparc                randconfig-001-20260820    gcc-13.4.0
sparc                randconfig-002-20260819    gcc-10.5.0
sparc                randconfig-002-20260820    gcc-13.4.0
sparc                      sparc32_defconfig    gcc-16.1.0
sparc64              randconfig-001-20260819    gcc-10.5.0
sparc64              randconfig-001-20260820    gcc-13.4.0
sparc64              randconfig-002-20260819    gcc-10.5.0
sparc64              randconfig-002-20260820    gcc-13.4.0
um                   randconfig-001-20260819    gcc-10.5.0
um                   randconfig-001-20260820    gcc-13.4.0
um                   randconfig-002-20260819    gcc-10.5.0
um                   randconfig-002-20260820    gcc-13.4.0
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260819    gcc-14
x86_64     buildonly-randconfig-001-20260820    gcc-14
x86_64     buildonly-randconfig-002-20260819    gcc-14
x86_64     buildonly-randconfig-002-20260820    gcc-14
x86_64     buildonly-randconfig-003-20260819    gcc-14
x86_64     buildonly-randconfig-003-20260820    gcc-14
x86_64     buildonly-randconfig-004-20260819    gcc-14
x86_64     buildonly-randconfig-004-20260820    gcc-14
x86_64     buildonly-randconfig-005-20260819    gcc-14
x86_64     buildonly-randconfig-005-20260820    gcc-14
x86_64     buildonly-randconfig-006-20260819    gcc-14
x86_64     buildonly-randconfig-006-20260820    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260819    gcc-14
x86_64               randconfig-001-20260820    clang-22
x86_64               randconfig-002-20260819    gcc-14
x86_64               randconfig-002-20260820    clang-22
x86_64               randconfig-003-20260819    gcc-14
x86_64               randconfig-003-20260820    clang-22
x86_64               randconfig-004-20260819    gcc-14
x86_64               randconfig-004-20260820    clang-22
x86_64               randconfig-005-20260819    gcc-14
x86_64               randconfig-005-20260820    clang-22
x86_64               randconfig-006-20260819    gcc-14
x86_64               randconfig-006-20260820    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260819    clang-22
x86_64               randconfig-011-20260820    clang-22
x86_64               randconfig-012-20260819    clang-22
x86_64               randconfig-012-20260820    clang-22
x86_64               randconfig-013-20260819    clang-22
x86_64               randconfig-013-20260820    clang-22
x86_64               randconfig-014-20260819    clang-22
x86_64               randconfig-014-20260820    clang-22
x86_64               randconfig-015-20260819    clang-22
x86_64               randconfig-015-20260820    clang-22
x86_64               randconfig-016-20260819    clang-22
x86_64               randconfig-016-20260820    clang-22
x86_64               randconfig-071-20260819    clang-22
x86_64               randconfig-071-20260820    clang-22
x86_64               randconfig-072-20260819    clang-22
x86_64               randconfig-072-20260820    clang-22
x86_64               randconfig-073-20260819    clang-22
x86_64               randconfig-073-20260820    clang-22
x86_64               randconfig-074-20260819    clang-22
x86_64               randconfig-074-20260820    clang-22
x86_64               randconfig-075-20260819    clang-22
x86_64               randconfig-075-20260820    clang-22
x86_64               randconfig-076-20260819    clang-22
x86_64               randconfig-076-20260820    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260819    gcc-10.5.0
xtensa               randconfig-001-20260820    gcc-13.4.0
xtensa               randconfig-002-20260819    gcc-10.5.0
xtensa               randconfig-002-20260820    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
