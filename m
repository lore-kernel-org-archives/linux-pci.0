Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CA397B0B
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208894; cv=none; b=aNr+G+vFN5FyUllkvZrSPyLra+K4CWT/jCzOV8/eOS82J/hVKtODfqyEeq03gSFfQeLS9jRzKxP63AptLSc4Lf0X9q8O9Q9CwoTJeob3Cd5UOVV7pl3Pe5Ll0hF9M5kPzNFNFKz1Rh/r4ggbZ7EYKumU3/SLzNPJHILUysO+ZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208894; c=relaxed/simple;
	bh=dtVtOXL1e7I5z09kMJhMua8InDWkhMctrKhN27tRiE4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CfyZ0Ho6z3w4mVaoVfaTH18+bSUQ17rCyUO6g+jofoljf+Wr9ODIcNZpdJqc7W4J+9x3V7jtyLWN5XLyBtb4jYGyqQtuhAj/Iej+Q1Q6cdToM9GckkSUdkvXrkB1NvY6/VpZlKNgzA4ZOTXHGxv9GgH+bx2sF6zkntQk+bTueQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnQVfb5G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnQVfb5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786208892; x=1817744892;
  h=date:from:to:cc:subject:message-id;
  bh=dtVtOXL1e7I5z09kMJhMua8InDWkhMctrKhN27tRiE4=;
  b=ZnQVfb5GlbA5tQxUq3d/aiZQUIPmCBeouoe2lXGFareDiWdgRYzC4dsD
   6aZAyuHb/U5Jny52oJl+4/pS1njQZc8TXsIIRb08pBRkwkBBltlYH+bX5
   f1XqiWITYbdDARNDoV/3ZvoNWOSp6A22OfcsdRn5nnRKrIYTXaVDCK2uJ
   r77NL91bHC+GnmVEzbMsO3IZvP3PWDVdjRBgsaddDztyao1uXxe4Cbmm/
   tx3V3D6dZNX/drBSjWvWBvXwJXGvgQk+rNFgCogSMzu6Y6VNXVnjTmw5R
   w0v6mom+ZcXjaILLLeXkdmnusz+vWeN2UQ/THRoQ37V0+t9yzPf9CSqq2
   w==;
X-CSE-ConnectionGUID: I0mJuXp8SqudaKxPAFBtlw==
X-CSE-MsgGUID: 26hYtf1+QTiViSEyBuBg8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="90469130"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="90469130"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:08:11 -0700
X-CSE-ConnectionGUID: 9SVxhJ12RYiDeixyL9Sdxg==
X-CSE-MsgGUID: JjR9yBWXR12bkp5nRf35oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="260045758"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2026 10:08:09 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wskWl-00000000KUe-1U9A;
	Sat, 08 Aug 2026 17:08:07 +0000
Date: Sun, 09 Aug 2026 01:07:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 79752653c136493ae8c3b4260f9f80de0b91d0bf
Message-ID: <202608090133.CAOj1Kzo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 79752653c136493ae8c3b4260f9f80de0b91d0bf  PCI: cadence: Fix host/endpoint dependencies for cadence-plat driver

elapsed time: 2811m

configs tested: 147
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arc                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260807    gcc-16.1.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260807    gcc-16.1.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-002-20260807    clang-18
hexagon              randconfig-002-20260808    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260807    gcc-13
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-002-20260807    gcc-13
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-003-20260807    gcc-13
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-004-20260807    gcc-13
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-005-20260807    gcc-13
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-006-20260807    gcc-13
i386       buildonly-randconfig-006-20260808    clang-22
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260807    clang-22
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-002-20260807    clang-18
loongarch            randconfig-002-20260808    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-002-20260807    clang-18
nios2                randconfig-002-20260808    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
powerpc                     ep88xc_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-002-20260808    clang-24
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-002-20260808    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-002-20260808    clang-24
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-002-20260808    gcc-8.5.0
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-002-20260808    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-016-20260808    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-002-20260808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
