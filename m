Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8233F584
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154031; cv=none; b=VfGNMjQHzSkW1vjYQ8C6QZDGuJy4Hg0zeXpNEniwbP18HrmmVtqSyU4GfK0p1Ua2TIJrGkVmmGQ0ubBkScxV/UP6ZrLnqPPQnh1XYCklBDC/q2RJJwK/fqQyDq+v0idzkN6llHm8rg/neDYmUfXfMDJDF5Qs4eGlGn7kWe6yk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154031; c=relaxed/simple;
	bh=WB/+W12pa79V2zwNceUjnd5OY+7KovDNYWIRXBEX3h4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oe1Wte9hgstxtmSmEubf5kZffBOVxHEojnviTFh/xJOuk/dsoUAN74oUxWhYinxQTj/4eP2IoXQVITUGVn0ch8fsyco/z2DdEm2YrtrlJyMjI2MswKHEdn1E5ZYj+VMne/0eqWfbL44Ik/EKhaoyKN7AH1MstHt2gpW6HlolAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9aOtmNo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9aOtmNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782154031; x=1813690031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WB/+W12pa79V2zwNceUjnd5OY+7KovDNYWIRXBEX3h4=;
  b=h9aOtmNorgXt+YiwDpojPdPmO2EuiPK8cObglpz8EwTbv8KImQcKF87X
   urURrbpLpCARIu2QqTzN3iGIFxQEwp0105dhKcW9Qy+MwYeiF1aEG2FeM
   iFn44yMAsmIEGNvDTtFeO/1jMXgwX4X9nUNnin0U7W0fCyVM45kxkTaEt
   Dl8CQQ/ASpeID4P2dli4jzLEJB0qIEFPIJstfj3+ppuxE7l15UydfuuDQ
   muIidlMg3hDrmqa5+NWxvlyWogz6iKW6rpB3IF5mSHfxgY50SZFNAIy5k
   TX4Mo4941yAiUtBNoxH55Me5cYvFlkpj48YyfhSeDwXJrqg7xTkHDSYXd
   A==;
X-CSE-ConnectionGUID: ucbJl1McSseyNrady9dLuQ==
X-CSE-MsgGUID: VNiRySCJRGaoDXybi7NpOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100318120"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="100318120"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 11:47:10 -0700
X-CSE-ConnectionGUID: VKt9X26jQg6jEOeX7s+L9A==
X-CSE-MsgGUID: vsmrwRloRLilJvtQkn0o2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="279487629"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Jun 2026 11:47:08 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbjfW-000000001jv-3oX4;
	Mon, 22 Jun 2026 18:46:55 +0000
Date: Tue, 23 Jun 2026 02:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:sysfs] BUILD SUCCESS
 814565ddc12a58904dcdab8d68d1051f716e28f8
Message-ID: <202606230233.pOF3U2Td-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git sysfs
branch HEAD: 814565ddc12a58904dcdab8d68d1051f716e28f8  PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

elapsed time: 949m

configs tested: 164
configs skipped: 4

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260622    gcc-15.2.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260622    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260622    gcc-13.4.0
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260622    clang-23
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260622    gcc-8.5.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260622    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260622    gcc-8.5.0
arm64                 randconfig-002-20260622    gcc-13.4.0
arm64                 randconfig-003-20260622    gcc-8.5.0
arm64                 randconfig-004-20260622    clang-22
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260622    gcc-13.4.0
csky                  randconfig-002-20260622    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260622    clang-23
hexagon               randconfig-002-20260622    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260622    gcc-14
i386        buildonly-randconfig-002-20260622    clang-22
i386        buildonly-randconfig-003-20260622    gcc-14
i386        buildonly-randconfig-004-20260622    gcc-12
i386        buildonly-randconfig-005-20260622    gcc-14
i386        buildonly-randconfig-006-20260622    gcc-14
i386                                defconfig    clang-22
i386                  randconfig-001-20260622    gcc-14
i386                  randconfig-002-20260622    clang-22
i386                  randconfig-003-20260622    gcc-14
i386                  randconfig-004-20260622    gcc-14
i386                  randconfig-005-20260622    clang-22
i386                  randconfig-006-20260622    gcc-14
i386                  randconfig-007-20260622    clang-22
i386                  randconfig-011-20260622    gcc-14
i386                  randconfig-012-20260622    clang-22
i386                  randconfig-013-20260622    gcc-14
i386                  randconfig-014-20260622    clang-22
i386                  randconfig-015-20260622    clang-22
i386                  randconfig-016-20260622    clang-22
i386                  randconfig-017-20260622    clang-22
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260622    clang-18
loongarch             randconfig-002-20260622    clang-18
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
nios2                 randconfig-001-20260622    gcc-8.5.0
nios2                 randconfig-002-20260622    gcc-8.5.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260622    gcc-14.3.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260622    gcc-12.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260622    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260622    gcc-8.5.0
powerpc64                      randconfig-001    clang-16
powerpc64             randconfig-001-20260622    clang-21
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260622    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260622    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260622    gcc-14.3.0
s390                  randconfig-002-20260622    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                 kfr2r09-romimage_defconfig    gcc-16.1.0
sh                    randconfig-001-20260622    gcc-13.4.0
sh                    randconfig-002-20260622    gcc-15.2.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260622    gcc-16.1.0
sparc                 randconfig-002-20260622    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260622    gcc-16.1.0
sparc64               randconfig-002-20260622    clang-23
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260622    gcc-14
um                    randconfig-002-20260622    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260622    clang-22
x86_64      buildonly-randconfig-002-20260622    clang-22
x86_64      buildonly-randconfig-003-20260622    clang-22
x86_64      buildonly-randconfig-004-20260622    clang-22
x86_64      buildonly-randconfig-005-20260622    gcc-14
x86_64      buildonly-randconfig-006-20260622    clang-22
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260622    clang-22
x86_64                randconfig-002-20260622    gcc-14
x86_64                randconfig-003-20260622    clang-22
x86_64                randconfig-004-20260622    clang-22
x86_64                randconfig-005-20260622    gcc-14
x86_64                randconfig-006-20260622    gcc-14
x86_64                randconfig-011-20260622    clang-22
x86_64                randconfig-012-20260622    clang-22
x86_64                randconfig-013-20260622    gcc-14
x86_64                randconfig-014-20260622    gcc-14
x86_64                randconfig-015-20260622    clang-22
x86_64                randconfig-016-20260622    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                randconfig-001-20260622    gcc-16.1.0
xtensa                randconfig-002-20260622    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
