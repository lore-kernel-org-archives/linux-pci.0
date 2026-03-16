Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856629AB07
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687689; cv=none; b=BUknHQdXYLHkx3xT5mtkg4F2EUepyL2TFt5zVsrwbrgu4i1a9OZUVVppjs58Qf0eXhEcD4v0+CkPKAKqK0c7M2FBMTw9UW62nenzoAitJHyo/HKSzE7fuBDvDw6jfaGJRLIPwmXqJwPqlLAYCJwB8D4pE7dEHNOFpQ7t4+9The4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687689; c=relaxed/simple;
	bh=driNK4J51Bk9UPimt1M6cPOKHEw5sGJTcocHJ33A6c0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ifdtxd7BdKvRNF2DPUVhMc0gBHCCvfSiVV8tbSiwm8ARIDGSckb77men+2JWo7AHfcS6xxr2ESFpMPtSvDHZue6YdPZ5u85XvAJU0O6sgV/W4vSnA8UD6j5q5TZHSzAHj4jEAeWewVh7c0kHBECrc8un3QJSsnlEe9Rd67VCO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCk1Icrg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCk1Icrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773687688; x=1805223688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=driNK4J51Bk9UPimt1M6cPOKHEw5sGJTcocHJ33A6c0=;
  b=TCk1IcrgfJtdrcg1sLFlQYYPZF43DhnJEnUM/JETybSjwzM/rljrzQIs
   ayhD3ybUgKMZLewmP9lKnb82IWvp6YgzyGydOwiP59YvGBmxCdmhJrqA6
   wgQ+qlhwVc4PBgEdqcOqanv+Nm6nGKy0M/Il+knNddEYZn94jaUBXw68Z
   Pgy4TTifuSRlMlq95fcWjuyKtP4WmYAzFDIJOrrF2UrWSNAfeSiwjLrzY
   tsRATtBItw31U3GZ4AKRJ2NgojtxjkK7AS6KaEmLtI1A9PU4O0emdGp9l
   PZFdSGYH7cTxHvSQ1RA9iVbR+APuS1zErv1zXLjFNg0RbA739qQHKS0fD
   Q==;
X-CSE-ConnectionGUID: DQBcUgfnTBG905SwPImrSw==
X-CSE-MsgGUID: eglHp60PRSe7WjQK6xvYbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74628888"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74628888"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:01:27 -0700
X-CSE-ConnectionGUID: ro40eGsdQzedkoMuV5QGMQ==
X-CSE-MsgGUID: Kv4GEsN3RIKXBy1cIgBc5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221957123"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 12:01:25 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2DBq-0000000019a-3bwW;
	Mon, 16 Mar 2026 19:01:22 +0000
Date: Tue, 17 Mar 2026 03:00:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/static-sysfs-attributes] BUILD SUCCESS
 26f955e78ef594ae462731c861ce168dfe05e803
Message-ID: <202603170336.zSLrDvlj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/static-sysfs-attributes
branch HEAD: 26f955e78ef594ae462731c861ce168dfe05e803  PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()

elapsed time: 1423m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260316    gcc-10.5.0
arc                   randconfig-002-20260316    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260316    clang-23
arm                   randconfig-002-20260316    clang-23
arm                   randconfig-003-20260316    clang-23
arm                   randconfig-004-20260316    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260316    gcc-11.5.0
arm64                 randconfig-002-20260316    clang-23
arm64                 randconfig-003-20260316    clang-23
arm64                 randconfig-004-20260316    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260316    gcc-15.2.0
csky                  randconfig-002-20260316    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260316    clang-23
hexagon               randconfig-002-20260316    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260316    clang-20
i386        buildonly-randconfig-002-20260316    gcc-14
i386        buildonly-randconfig-003-20260316    clang-20
i386        buildonly-randconfig-004-20260316    clang-20
i386        buildonly-randconfig-005-20260316    clang-20
i386        buildonly-randconfig-006-20260316    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    clang-20
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    clang-20
i386                  randconfig-006-20260316    gcc-12
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260316    clang-20
i386                  randconfig-012-20260316    gcc-14
i386                  randconfig-013-20260316    clang-20
i386                  randconfig-014-20260316    gcc-13
i386                  randconfig-015-20260316    clang-20
i386                  randconfig-016-20260316    gcc-14
i386                  randconfig-017-20260316    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260316    gcc-14.3.0
loongarch             randconfig-002-20260316    clang-18
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
nios2                 randconfig-001-20260316    gcc-11.5.0
nios2                 randconfig-002-20260316    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-8.5.0
parisc                randconfig-002-20260316    gcc-12.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260316    clang-23
powerpc               randconfig-002-20260316    clang-23
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260316    gcc-15.2.0
riscv                 randconfig-002-20260316    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260316    clang-18
s390                  randconfig-002-20260316    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260316    gcc-15.2.0
sh                    randconfig-002-20260316    gcc-12.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-8.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260316    gcc-8.5.0
sparc64               randconfig-002-20260316    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260316    gcc-14
um                    randconfig-002-20260316    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260316    gcc-14
x86_64      buildonly-randconfig-002-20260316    clang-20
x86_64      buildonly-randconfig-003-20260316    clang-20
x86_64      buildonly-randconfig-004-20260316    gcc-14
x86_64      buildonly-randconfig-005-20260316    gcc-14
x86_64      buildonly-randconfig-006-20260316    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260316    gcc-14
x86_64                randconfig-002-20260316    clang-20
x86_64                randconfig-004-20260316    gcc-14
x86_64                randconfig-005-20260316    clang-20
x86_64                randconfig-006-20260316    clang-20
x86_64                randconfig-011-20260316    gcc-14
x86_64                randconfig-012-20260316    gcc-14
x86_64                randconfig-013-20260316    gcc-14
x86_64                randconfig-014-20260316    gcc-14
x86_64                randconfig-015-20260316    clang-20
x86_64                randconfig-016-20260316    gcc-14
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-14
x86_64                randconfig-073-20260316    gcc-14
x86_64                randconfig-074-20260316    gcc-14
x86_64                randconfig-075-20260316    clang-20
x86_64                randconfig-076-20260316    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260316    gcc-15.2.0
xtensa                randconfig-002-20260316    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
