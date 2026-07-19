Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92A37E5CD
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784503558; cv=none; b=m3sgbWXlOBdSJD4xnrJpVaVL/1a3TmPIvVlJ21AM0SgAUZvvJk6VkGgOIuywM7HeG7LHxUbMA91OGtjQ3F5mp/OAyxWd4ynKNKXQ9mHAkojRXsFToKkO/7B628a9aSUNVzPKRj8CzVLTGvadW8eEjjuiWff4M9k84H8Y+MCffjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784503558; c=relaxed/simple;
	bh=yFcOzrO8sud7bjVeb/rt33QjMiwXVMCEtunlL9b1pMY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YVyIXZbzGx+hXFWqBQQEBpAXssMqmnE8pxjh7GGEfiP6fM5F1/iP91/kEZOR0ORpMqu1vw41zn8z3/NGuzfp/RFNCk3xPe1jfZLmenW5FNFnDHFMbR3QdINGi6LNCMem2eYCoBe40siEuCPr+US+hsP9tYPRBTKSNK/bqn6EcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kL8VhI/j; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kL8VhI/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784503555; x=1816039555;
  h=date:from:to:cc:subject:message-id;
  bh=yFcOzrO8sud7bjVeb/rt33QjMiwXVMCEtunlL9b1pMY=;
  b=kL8VhI/jovEx2S+BDv2OmPJ5/TkUjiFk8wOWG1gSpDynA09EJ3pPWAfq
   hiyFgxMo3b+u90xBETnmaZPKlK6mNlN1i8Oc6XkkGlm/fKaKjRAMt2IqG
   QJMOtS8PUYkTEJpMNSR2YExX3Gv+6Ka+FSem30dwOMZRv+LYbVNynd095
   nQByc8+hznIXhI2wV+f+Mvh8aH0Qh2OBmea6RTjv1h7dh4I5CTFjFKJeE
   BNfFehf1B3OWY1x34vMpOGMorsxvvvBCi3kIh467JG9OKstxK4pgAf7kH
   L1m55AD+BVcxPVhBQG24GqQpKlHUh6DHpI2Wo8BHVAWT4H3zUHpo0AxUB
   Q==;
X-CSE-ConnectionGUID: pij6tOJCTNyO4uL4kgkp0Q==
X-CSE-MsgGUID: Kfln38n2TJeg+nzdU6xUlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="107873412"
X-IronPort-AV: E=Sophos;i="6.25,173,1779174000"; 
   d="scan'208";a="107873412"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 16:25:55 -0700
X-CSE-ConnectionGUID: Tvl959RQTtS5GbwRrcQLdw==
X-CSE-MsgGUID: olD5nXJxTeaxuBhzN/YHjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,173,1779174000"; 
   d="scan'208";a="261586726"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 19 Jul 2026 16:25:54 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wlatL-00000000Vmv-1SAZ;
	Sun, 19 Jul 2026 23:25:51 +0000
Date: Mon, 20 Jul 2026 07:25:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:portdrv] BUILD SUCCESS
 de7048f2e2c20697cb9e567ed93ea123e6464b96
Message-ID: <202607200722.mK0oicuf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git portdrv
branch HEAD: de7048f2e2c20697cb9e567ed93ea123e6464b96  PCI/portdrv: Allow probing even without child services

elapsed time: 2916m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260718    gcc-12.5.0
arc                  randconfig-002-20260718    gcc-10.5.0
arm                  randconfig-001-20260718    clang-17
arm                  randconfig-002-20260718    clang-17
arm                  randconfig-003-20260718    gcc-10.5.0
arm                  randconfig-004-20260718    gcc-8.5.0
arm64                randconfig-001-20260718    clang-17
arm64                randconfig-002-20260718    clang-17
arm64                randconfig-003-20260718    clang-17
arm64                randconfig-004-20260718    clang-21
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260718    gcc-14.3.0
csky                 randconfig-002-20260718    gcc-16.1.0
hexagon              randconfig-001-20260718    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260718    gcc-14
i386       buildonly-randconfig-002-20260718    gcc-14
i386       buildonly-randconfig-003-20260718    gcc-14
i386       buildonly-randconfig-004-20260718    clang-22
i386       buildonly-randconfig-005-20260718    clang-22
i386       buildonly-randconfig-006-20260718    clang-22
i386                 randconfig-011-20260718    gcc-12
i386                 randconfig-012-20260718    clang-22
i386                 randconfig-013-20260718    clang-22
i386                 randconfig-014-20260718    gcc-14
i386                 randconfig-015-20260718    gcc-14
i386                 randconfig-016-20260718    gcc-14
i386                 randconfig-017-20260718    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260718    clang-18
loongarch            randconfig-002-20260718    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260718    gcc-11.5.0
nios2                randconfig-002-20260718    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260718    gcc-9.5.0
parisc               randconfig-002-20260718    gcc-11.5.0
powerpc              randconfig-001-20260718    clang-24
powerpc              randconfig-002-20260718    gcc-16.1.0
powerpc64            randconfig-001-20260718    clang-24
powerpc64            randconfig-002-20260718    clang-17
riscv                randconfig-001-20260718    gcc-16.1.0
riscv                randconfig-002-20260718    clang-24
s390                 randconfig-001-20260718    gcc-13.4.0
s390                 randconfig-002-20260718    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260718    gcc-16.1.0
sh                   randconfig-002-20260718    gcc-16.1.0
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260718    gcc-8.5.0
sparc64              randconfig-001-20260718    gcc-8.5.0
sparc64              randconfig-002-20260718    gcc-13.4.0
um                   randconfig-001-20260718    gcc-14
um                   randconfig-002-20260718    gcc-14
x86_64     buildonly-randconfig-001-20260718    clang-22
x86_64     buildonly-randconfig-002-20260718    clang-22
x86_64     buildonly-randconfig-003-20260718    clang-22
x86_64     buildonly-randconfig-004-20260718    clang-22
x86_64     buildonly-randconfig-005-20260718    clang-22
x86_64     buildonly-randconfig-006-20260718    clang-22
x86_64               randconfig-001-20260718    clang-22
x86_64               randconfig-002-20260718    clang-22
x86_64               randconfig-003-20260718    gcc-14
x86_64               randconfig-004-20260718    gcc-14
x86_64               randconfig-005-20260718    clang-22
x86_64               randconfig-006-20260718    gcc-12
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260718    gcc-14
x86_64               randconfig-012-20260718    clang-22
x86_64               randconfig-013-20260718    clang-22
x86_64               randconfig-014-20260718    gcc-14
x86_64               randconfig-015-20260718    clang-22
x86_64               randconfig-016-20260718    gcc-13
x86_64               randconfig-071-20260718    gcc-14
x86_64               randconfig-072-20260718    gcc-14
x86_64               randconfig-073-20260718    gcc-13
x86_64               randconfig-074-20260718    clang-22
x86_64               randconfig-075-20260718    clang-22
x86_64               randconfig-076-20260718    clang-22
xtensa               randconfig-001-20260718    gcc-11.5.0
xtensa               randconfig-002-20260718    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
