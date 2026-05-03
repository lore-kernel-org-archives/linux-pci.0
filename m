Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEDCA52
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779120; cv=none; b=k5K22JPDXaMgbdsFb70KQLf55l8VFOU/F/CXtXbJPJ+BautXhWLEH1mjj7Euq6ibz2b3s3jtc3mZoe/qA4h4YOHnesfb/5JeRkElksfjl4gtR6n9eXTizm9p72KrG2NjMAqkbre7OmJIwFobctLDDtJUPFTzvJ4RykrqRXBH3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779120; c=relaxed/simple;
	bh=SESe2YLyGLDdjyLUXL4Ej8hIcn+pv1biYuj9fRsDlnk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UVOX4YUa/1+oIjJL+QlMCR8ggnuougMblPcmaWe3rZjlujZIdt/3Ok1Hh1mBsA+BR+ukQsg2TfS+ESbrQ3Z7v51vPdaR5ekC0WwDDDMJ3O+M2q/FpUrrxRhhYkr4q9cUgnRt6QTNWkY6gMF9NM+QGfNuxU+471c7fa3b9tvBHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSUlk5TG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSUlk5TG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777779119; x=1809315119;
  h=date:from:to:cc:subject:message-id;
  bh=SESe2YLyGLDdjyLUXL4Ej8hIcn+pv1biYuj9fRsDlnk=;
  b=hSUlk5TGJB8kcDEbqiyHVkUyGGqwiZxCaZXAKPrxS8ZE3fLTqBokEgdc
   /q1L7W9GkXXRVbauycZZXWbL1RPSgUYPqhCnwRNylzje3EBV+5uC5ywMr
   53Rb1sBsZ8NKgFQzZ5pbtiS87CgbKvG3XmYcEuPoFFLAHMBXIpyd5wRzr
   4H/BiVylPOYYHH7l4YtSU3TwgbFB8sdanWnIVX/WlR2rCkadzqE7Dvd2l
   Ciue/eZuMyxKRvMeQ3n34zhV/c8tM8KbLpHH+sI/0+VmhdNU2wNX2LOrC
   uymW8UIFo/L2anDoguFGhIsq4qB1p1sz3PbyR2tk2wyHKgWneEHE1boSb
   Q==;
X-CSE-ConnectionGUID: xTKIf7R8TUOxyvDzSidYew==
X-CSE-MsgGUID: TRFy7PFrTjO8Jhzxk31/hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="78880111"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="78880111"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 20:31:58 -0700
X-CSE-ConnectionGUID: 4ocn2wzDThKl9ZfOJRkYcg==
X-CSE-MsgGUID: HWVhdPPZQf6Yv6ZTrPuYtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="234175009"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 May 2026 20:31:57 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJNYg-00000000265-33L4;
	Sun, 03 May 2026 03:31:54 +0000
Date: Sun, 03 May 2026 11:31:05 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 50c94a2351458ee6cb6e52c5678f099534366830
Message-ID: <202605031157.CHX8mSZU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: 50c94a2351458ee6cb6e52c5678f099534366830  dt-bindings: pci: sophgo: Add dma-coherent property for SG2042

elapsed time: 1888m

configs tested: 213
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260503    gcc-10.5.0
arc                   randconfig-002-20260503    gcc-10.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260503    gcc-10.5.0
arm                   randconfig-002-20260503    gcc-10.5.0
arm                   randconfig-003-20260503    gcc-10.5.0
arm                   randconfig-004-20260503    gcc-10.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260502    gcc-10.5.0
arm64                 randconfig-001-20260503    gcc-15.2.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260502    gcc-10.5.0
arm64                 randconfig-002-20260503    gcc-15.2.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260502    gcc-10.5.0
arm64                 randconfig-003-20260503    gcc-15.2.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260502    gcc-10.5.0
arm64                 randconfig-004-20260503    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260502    gcc-10.5.0
csky                  randconfig-001-20260503    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260502    gcc-10.5.0
csky                  randconfig-002-20260503    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260502    clang-23
hexagon               randconfig-001-20260503    clang-23
hexagon               randconfig-002-20260502    clang-23
hexagon               randconfig-002-20260503    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260502    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260502    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260502    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260502    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260502    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260502    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260502    clang-20
i386                  randconfig-002-20260502    clang-20
i386                  randconfig-003-20260502    clang-20
i386                  randconfig-004-20260502    clang-20
i386                  randconfig-005-20260502    clang-20
i386                  randconfig-006-20260502    clang-20
i386                  randconfig-007-20260502    clang-20
i386                  randconfig-011-20260502    clang-20
i386                  randconfig-012-20260502    clang-20
i386                  randconfig-013-20260502    clang-20
i386                  randconfig-014-20260502    clang-20
i386                  randconfig-015-20260502    clang-20
i386                  randconfig-016-20260502    clang-20
i386                  randconfig-017-20260502    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260502    clang-23
loongarch             randconfig-001-20260503    clang-23
loongarch             randconfig-002-20260502    clang-23
loongarch             randconfig-002-20260503    clang-23
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
nios2                 randconfig-001-20260502    clang-23
nios2                 randconfig-001-20260503    clang-23
nios2                 randconfig-002-20260502    clang-23
nios2                 randconfig-002-20260503    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260502    gcc-12.5.0
parisc                randconfig-001-20260503    gcc-15.2.0
parisc                randconfig-002-20260502    gcc-12.5.0
parisc                randconfig-002-20260503    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260502    gcc-12.5.0
powerpc               randconfig-001-20260503    gcc-15.2.0
powerpc               randconfig-002-20260502    gcc-12.5.0
powerpc               randconfig-002-20260503    gcc-15.2.0
powerpc64             randconfig-001-20260502    gcc-12.5.0
powerpc64             randconfig-001-20260503    gcc-15.2.0
powerpc64             randconfig-002-20260502    gcc-12.5.0
powerpc64             randconfig-002-20260503    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260502    gcc-14.3.0
riscv                 randconfig-001-20260503    clang-23
riscv                 randconfig-002-20260502    gcc-14.3.0
riscv                 randconfig-002-20260503    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260502    gcc-14.3.0
s390                  randconfig-001-20260503    clang-23
s390                  randconfig-002-20260502    gcc-14.3.0
s390                  randconfig-002-20260503    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260502    gcc-14.3.0
sh                    randconfig-001-20260503    clang-23
sh                    randconfig-002-20260502    gcc-14.3.0
sh                    randconfig-002-20260503    clang-23
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260502    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260502    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260502    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260502    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260502    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260502    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260502    clang-20
x86_64      buildonly-randconfig-002-20260502    clang-20
x86_64      buildonly-randconfig-003-20260502    clang-20
x86_64      buildonly-randconfig-004-20260502    clang-20
x86_64      buildonly-randconfig-005-20260502    clang-20
x86_64      buildonly-randconfig-006-20260502    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260502    clang-20
x86_64                randconfig-002-20260502    clang-20
x86_64                randconfig-003-20260502    clang-20
x86_64                randconfig-004-20260502    clang-20
x86_64                randconfig-005-20260502    clang-20
x86_64                randconfig-006-20260502    clang-20
x86_64                randconfig-011-20260503    clang-20
x86_64                randconfig-012-20260503    clang-20
x86_64                randconfig-013-20260503    clang-20
x86_64                randconfig-014-20260503    clang-20
x86_64                randconfig-015-20260503    clang-20
x86_64                randconfig-016-20260503    clang-20
x86_64                randconfig-071-20260502    gcc-14
x86_64                randconfig-072-20260502    gcc-14
x86_64                randconfig-073-20260502    gcc-14
x86_64                randconfig-074-20260502    gcc-14
x86_64                randconfig-075-20260502    gcc-14
x86_64                randconfig-076-20260502    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260502    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260502    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
