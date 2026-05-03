Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7401DED5B
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777781045; cv=none; b=l8DA5H4Q5rxT35B302pUWad0FBhvk5Djr76qrT7IcjwAhUYKZIe3BBNvpuBbcirUD8cE/I5LGjg4BS1VKxSD7SrU1vP6DSYUkjWir0Mc/+Dg1C/KVu81IcGfPZv7zgEd0v2qVqAlcYae7sU1C6KO5jNSe6SUQ+TBBVt2v4k8ezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777781045; c=relaxed/simple;
	bh=IR+h7rj6huRtSsM53LmK2TL6PJreA1kWTDXEvuY9dO0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F3cyKZOycoA5TaUgqKoCndEqvJZen+PFaNZVzfYQk6ty0yO+FCCqBiMsHJIMRK0mJX2ukJrr5IE0+wplgPz7kXKH9oxhaimtla49I87iwXL6bbuevb3v8GkTfJJCIqqhJCnzI0BNyuiLZSfFWX1qrHnhHr6tXC0A5jH1EkOnlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijTnTmjf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijTnTmjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777781043; x=1809317043;
  h=date:from:to:cc:subject:message-id;
  bh=IR+h7rj6huRtSsM53LmK2TL6PJreA1kWTDXEvuY9dO0=;
  b=ijTnTmjfMuUNvq9UIrUh3D+whmY82k5xdZG2adhcmRbu+JA6TvwUGhzv
   jXQiCjUBOo1nFOcMXrUnu4bW/S5cSQ+61J6kcFhYmS81wc0KklRdPI+XJ
   8KoAd8Af//QbwSyfcmw2upOfFIquzrwLaNbIlTdv5qV6qLlk5NoRVk/5k
   HkPGph0etL2TCkLcyLRyATt4E3jK6QIsMPAju3vHu5Mm3Tfbip0+BQej0
   wo4PKLD5zLBe1lfgGQRQLxuhYnlTa2pWN4gJfoX8P/+/SvDK1XRNEa7g3
   0Dkqya8lsaoPV01N0EH97/dXlXlXXz4m//2JipW78LqnI/MnwN4h+ScYE
   Q==;
X-CSE-ConnectionGUID: BFBN6LCXQxG8Koh2+DJmtg==
X-CSE-MsgGUID: WRbvOY1fQjKU/qV5LCGkIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="78615815"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="78615815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 21:04:03 -0700
X-CSE-ConnectionGUID: /scjVIaiRhyq03Zx55TH1Q==
X-CSE-MsgGUID: o3QpoJj+T4GPwqnA4GMTtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="240187404"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 May 2026 21:04:01 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJO3j-00000000286-17g4;
	Sun, 03 May 2026 04:03:59 +0000
Date: Sun, 03 May 2026 12:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 89b3c5044867c86e421a121481b1ca8cd00a3f6e
Message-ID: <202605031240.P8Cmfo6u-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 89b3c5044867c86e421a121481b1ca8cd00a3f6e  misc: pci_endpoint_test: remove dead BAR read before doorbell trigger

elapsed time: 1921m

configs tested: 227
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
sparc                 randconfig-001-20260503    gcc-15.2.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260502    gcc-8.5.0
sparc                 randconfig-002-20260503    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260502    gcc-8.5.0
sparc64               randconfig-001-20260503    gcc-15.2.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260502    gcc-8.5.0
sparc64               randconfig-002-20260503    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260502    gcc-8.5.0
um                    randconfig-001-20260503    gcc-15.2.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260502    gcc-8.5.0
um                    randconfig-002-20260503    gcc-15.2.0
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
x86_64                randconfig-001-20260503    clang-20
x86_64                randconfig-002-20260502    clang-20
x86_64                randconfig-002-20260503    clang-20
x86_64                randconfig-003-20260502    clang-20
x86_64                randconfig-003-20260503    clang-20
x86_64                randconfig-004-20260502    clang-20
x86_64                randconfig-004-20260503    clang-20
x86_64                randconfig-005-20260502    clang-20
x86_64                randconfig-005-20260503    clang-20
x86_64                randconfig-006-20260502    clang-20
x86_64                randconfig-006-20260503    clang-20
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
xtensa                randconfig-001-20260503    gcc-15.2.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260502    gcc-8.5.0
xtensa                randconfig-002-20260503    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
