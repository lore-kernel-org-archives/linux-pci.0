Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477C1F2B88
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172234; cv=none; b=e4IhhgoqMpqdV2uspmUga3w2qUUG38K2Gut+e6AEsbMnPqaYBarH1U27fZEqA9klfDW7zE8/zJBKLRiPReHU+t3AlqJ5wgoDIY8bbq/7HoPSCwHLwGz5H+VwHxm28pBW6e2gcilH6XExEm86JqR6i88EFng0wt+3jLoiPciUwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172234; c=relaxed/simple;
	bh=cfQNj47gsqBWhh3kHDFRWKBkTljJyS5hU7VtAVdom+Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KjW6AlbUNu+t6QGJuXSKgH1pYaH2QHS2RoUgN4WeV1pI36vmOGsbiFWgfxO0DKfoibnmRdd20QsCUBvUNWr7Z0NTQvOhzyBjFhosS0tDwRS8wiSX7ckTlA6Dbqec3owgFNV29PTI6QvYO6HzvY/rCGgcq4r/FbkevqDf0zpgdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8BAF2N1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8BAF2N1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784172231; x=1815708231;
  h=date:from:to:cc:subject:message-id;
  bh=cfQNj47gsqBWhh3kHDFRWKBkTljJyS5hU7VtAVdom+Q=;
  b=j8BAF2N1tViNBvFBYKqi7rsbrTv54kw0wrx3v8rpBix5xCT3Z2niyzXO
   6PxbRC1xDkepmbX36rpLSI4/ipcctgjXEyzemMfOF9PybhV9eot+0goUU
   xIPRJ/Gi9pMWW6EEaJsEXm5JkvHea1ETkIWEnVH2Fs9IvwREp5hv1pU+X
   aOJCZ8YgHkS4b+5so0txzeOGMksicMPRYs2ZQAUl80PX7ToxxiJX1k16n
   RhlbXdbvnjvv9MhEtmCwNjHHqRRFs2nPV3xNhzqfuFRD9Q7p4S8zD1RXY
   eK6111JUPuWoqD6H5lZ7T7DYGBQw6WvOGP7mxAMnbgDBgB79KKD2f+F7r
   Q==;
X-CSE-ConnectionGUID: GUmmShQJQtim6PLQgYVI2A==
X-CSE-MsgGUID: fYdsJ160QF6gEIK79KtCtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84784814"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84784814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 20:23:51 -0700
X-CSE-ConnectionGUID: 6gZS9zS6RhilKoZ+6Ca89Q==
X-CSE-MsgGUID: uGs+pOHfQ1CcFH14+lASdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="252402289"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2026 20:23:50 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkChP-00000000OH1-29xS;
	Thu, 16 Jul 2026 03:23:47 +0000
Date: Thu, 16 Jul 2026 11:21:55 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-spacemit-k1] BUILD SUCCESS
 46a1b74f2cafaa0152a4c994c60034f14119570b
Message-ID: <202607161144.0PBNqfG0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-spacemit-k1
branch HEAD: 46a1b74f2cafaa0152a4c994c60034f14119570b  PCI: dwc: spacemit: Add missing MODULE_DEVICE_TABLE()

elapsed time: 732m

configs tested: 135
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260716    gcc-14.3.0
arc                   randconfig-002-20260716    gcc-16.1.0
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260716    gcc-8.5.0
arm                   randconfig-003-20260716    gcc-12.5.0
arm                   randconfig-004-20260716    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-24
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
i386                  randconfig-011-20260716    clang-22
i386                  randconfig-012-20260716    gcc-12
i386                  randconfig-013-20260716    clang-22
i386                  randconfig-014-20260716    gcc-12
i386                  randconfig-015-20260716    clang-22
i386                  randconfig-016-20260716    gcc-14
i386                  randconfig-017-20260716    clang-22
loongarch                        allmodconfig    clang-19
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
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
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
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260716    clang-22
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260716    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260716    clang-22
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260716    gcc-14
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260716    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260716    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260716    gcc-9.5.0
xtensa                randconfig-002-20260716    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
