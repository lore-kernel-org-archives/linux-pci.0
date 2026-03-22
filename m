Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295A1D7E41
	for <linux-pci@vger.kernel.org>; Sun, 22 Mar 2026 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774154248; cv=none; b=YP0B+GQoxtrUYqelwidNiQWfgcnqO1HV+aZDvxDXYLihUgFb0GZqWkexAgn04iNrzVVyD9VLf//RKz6EZcGr/Uu4elh0XJ/CZu3piAzhNodcZ4bbxwr+gaQtkzeBMbklXr8yo8eRUtNj31XWL6aXtSUUu+35vg19xcL+KLJRnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774154248; c=relaxed/simple;
	bh=0q6Knk3PtBiAFPKLr9osuNcvjJwqg+FjeTPoK8HFgHM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Gf9g8FzsqBg1fcPQNPZSxyGpbLF+KfG5fb8TgnxGdo8zNvcXrR92KudwbKhrSWUHkdWJGxiboc5xz1Yl1Q7Wcp/xcCIR3p6qq+4QyhfprNA452DZRU20cwTTQ2bBe3OTJTW5SPpC9j1TdPmxE2KBWX3yJtMT4rz0BY7nKjZYH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNQDzKsj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNQDzKsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774154247; x=1805690247;
  h=date:from:to:cc:subject:message-id;
  bh=0q6Knk3PtBiAFPKLr9osuNcvjJwqg+FjeTPoK8HFgHM=;
  b=gNQDzKsjE4fBrAIIYL7W1xtPhpLGp3BYqKGzFIMZr2jyfj+6EKye1h5k
   CjAistuK5jE15AjTLqoFFB0piNRHWQrP9yaAn0cK/OJ7KnVWTkNDxhg0y
   Qf3AEpURwuOkSP8GEr253OVaEd62t6u8HwvLp1QbmDSgHAdz6gfM60RcI
   g4SDxY/DMb3Vau4GLZvcG/Q9q4poj1JO0WLQTlkVxwGp+iqmFNwj0K3gV
   DwBooWlFP8J78D6fyPojS6/fIe2RIWJAM1dDZU3qIBwh1BvLuv8Dh7eK+
   iUOSHGTjkpaDY3L3yeOybTTw9RhlE5HU0vEN/h0pgg7maH9sezUzCEGDm
   Q==;
X-CSE-ConnectionGUID: ZGMFkJ8DR7KH/c2M7vBsqg==
X-CSE-MsgGUID: I+DG8QxyTR+NWW8Y3U1KBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="74902496"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="74902496"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 21:37:27 -0700
X-CSE-ConnectionGUID: tL80GRJAQQ29go+hfsKE0w==
X-CSE-MsgGUID: gW18jo7PRV+T9kfsTh19hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="254158048"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 21 Mar 2026 21:37:24 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4AZ0-000000001gt-1R4j;
	Sun, 22 Mar 2026 04:37:22 +0000
Date: Sun, 22 Mar 2026 12:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-rcar-gen4-ep] BUILD SUCCESS
 380627b3a5ec51a7fdfa156c14af5022980d6333
Message-ID: <202603221254.6FZmcSio-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4-ep
branch HEAD: 380627b3a5ec51a7fdfa156c14af5022980d6333  PCI: dwc: rcar-gen4: Change EPC BAR alignment to 4K as per the documentation

elapsed time: 792m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260322    gcc-14.3.0
arc                   randconfig-002-20260322    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260322    gcc-14.3.0
arm                   randconfig-002-20260322    gcc-14.3.0
arm                   randconfig-003-20260322    gcc-14.3.0
arm                   randconfig-004-20260322    gcc-14.3.0
arm                           sama5_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260322    gcc-11.5.0
arm64                 randconfig-002-20260322    gcc-11.5.0
arm64                 randconfig-003-20260322    gcc-11.5.0
arm64                 randconfig-004-20260322    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260322    gcc-11.5.0
csky                  randconfig-002-20260322    gcc-11.5.0
hexagon                          alldefconfig    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260322    gcc-11.5.0
hexagon               randconfig-002-20260322    gcc-11.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260322    clang-20
i386        buildonly-randconfig-002-20260322    clang-20
i386        buildonly-randconfig-003-20260322    clang-20
i386        buildonly-randconfig-004-20260322    clang-20
i386        buildonly-randconfig-005-20260322    clang-20
i386        buildonly-randconfig-006-20260322    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260322    gcc-14
i386                  randconfig-002-20260322    gcc-14
i386                  randconfig-003-20260322    gcc-14
i386                  randconfig-004-20260322    gcc-14
i386                  randconfig-005-20260322    gcc-14
i386                  randconfig-006-20260322    gcc-14
i386                  randconfig-007-20260322    gcc-14
i386                  randconfig-011-20260322    gcc-13
i386                  randconfig-012-20260322    gcc-13
i386                  randconfig-013-20260322    gcc-13
i386                  randconfig-014-20260322    gcc-13
i386                  randconfig-015-20260322    gcc-13
i386                  randconfig-016-20260322    gcc-13
i386                  randconfig-017-20260322    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260322    gcc-11.5.0
loongarch             randconfig-002-20260322    gcc-11.5.0
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260322    gcc-11.5.0
nios2                 randconfig-002-20260322    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260322    clang-23
parisc                randconfig-002-20260322    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260322    clang-23
powerpc               randconfig-002-20260322    clang-23
powerpc64             randconfig-001-20260322    clang-23
powerpc64             randconfig-002-20260322    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260322    gcc-12.5.0
riscv                 randconfig-002-20260322    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260322    gcc-12.5.0
s390                  randconfig-002-20260322    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260322    gcc-12.5.0
sh                    randconfig-002-20260322    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260322    gcc-14
sparc                 randconfig-002-20260322    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260322    gcc-14
sparc64               randconfig-002-20260322    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260322    gcc-14
um                    randconfig-002-20260322    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260322    clang-20
x86_64      buildonly-randconfig-002-20260322    clang-20
x86_64      buildonly-randconfig-003-20260322    clang-20
x86_64      buildonly-randconfig-004-20260322    clang-20
x86_64      buildonly-randconfig-005-20260322    clang-20
x86_64      buildonly-randconfig-006-20260322    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260322    clang-20
x86_64                randconfig-002-20260322    clang-20
x86_64                randconfig-003-20260322    clang-20
x86_64                randconfig-004-20260322    clang-20
x86_64                randconfig-005-20260322    clang-20
x86_64                randconfig-006-20260322    clang-20
x86_64                randconfig-011-20260322    gcc-14
x86_64                randconfig-012-20260322    gcc-14
x86_64                randconfig-013-20260322    gcc-14
x86_64                randconfig-014-20260322    gcc-14
x86_64                randconfig-015-20260322    gcc-14
x86_64                randconfig-016-20260322    gcc-14
x86_64                randconfig-071-20260322    gcc-14
x86_64                randconfig-072-20260322    gcc-14
x86_64                randconfig-073-20260322    gcc-14
x86_64                randconfig-074-20260322    gcc-14
x86_64                randconfig-075-20260322    gcc-14
x86_64                randconfig-076-20260322    gcc-14
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
xtensa                randconfig-001-20260322    gcc-14
xtensa                randconfig-002-20260322    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
