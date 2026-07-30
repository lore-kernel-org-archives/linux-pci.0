Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3336A01A
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378472; cv=none; b=falo1nM6QRB2gfjEYEkSlRThaDTrbq+blikm/s90WwkVAPQrfzvwtqGdLzIDvG6rfoQLikVMrn+k+CRemXcYvQVkn9KE7k7dOp6oAWPeRUQOlsY90rOPfPxgmfJlTt/blGmV6Wl4oYQ1wmDZSXQ6HtTRODZVzsOwSM7FyI3Y/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378472; c=relaxed/simple;
	bh=YKV5Ld8Tj29Vf0II+AkzatD2c8oKpWE/PauLCI66MzE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bV1EN3vx8z4A3xS2DNorra92wvVtw9R7ptaGcOA+Lu4WCIrYze6EfZ13Ubo77qAtVVgIC5SHRSepuxgLanE7U7kefZjCRnhlQ6rwwmkp1erFI09QzmSKgKHREqI9DwO3lYlEm3yi4I2agidMV4BRzoopW35+fGolxbirsoPMW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClaRDZ8f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClaRDZ8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785378470; x=1816914470;
  h=date:from:to:cc:subject:message-id;
  bh=YKV5Ld8Tj29Vf0II+AkzatD2c8oKpWE/PauLCI66MzE=;
  b=ClaRDZ8fxT4kj3UsjWz2Q/UPCUJTFKJld69Y9MOHjh2GYyHsrXV6D7Nd
   YcK2+qrSDnUbmcIssp4yk5jcKvlhPBks7z9gwf9bKsltBZy3f2Z8PA61G
   yeeoj4sdFHbsYGR3Gz7km3PGsw5mQhx9ikYBYvinq9wRxEapPDGA1g5iw
   FIK6IlsVm1XHTS0M/ICUYnzJDFLat31uq8bvrPsz+JEH+5PeZLX0uzY66
   a4hyRcSSvVMXq166uQzNzbpCYkYZlvVn6EudZhDMHx7xbSLOeIYHu/i9Y
   94884wyFFO1cR+igbDw98GCasUjdvpVMnaLHzs8X1xkqhMlJcOajrPFc/
   Q==;
X-CSE-ConnectionGUID: QZzjyV2FTTiZ85Ftc26vxQ==
X-CSE-MsgGUID: 3Udu8Yy0Qg+5Vd0Vj4adnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86111796"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86111796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 19:27:49 -0700
X-CSE-ConnectionGUID: 3XDoO6eMQ22rbBgU7cRu0Q==
X-CSE-MsgGUID: oOqqWPKATPycM6qUuRQmOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="265227451"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jul 2026 19:27:48 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpGUf-00000000fvo-0cqk;
	Thu, 30 Jul 2026 02:27:37 +0000
Date: Thu, 30 Jul 2026 10:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 2162572d34c503882e9047a2b07adafd6139dc2d
Message-ID: <202607301037.T2BuvT43-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 2162572d34c503882e9047a2b07adafd6139dc2d  PCI: vmd: Only copy root bridge _OSC control flags in bare metal OS

elapsed time: 800m

configs tested: 123
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-13.4.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-10.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260729    clang-24
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260729    clang-18
arm                  randconfig-004-20260730    gcc-8.5.0
arm                       realview_defconfig    clang-17
arm64                randconfig-001-20260729    gcc-15.2.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260729    gcc-13.4.0
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260729    gcc-11.5.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260729    gcc-16.1.0
csky                 randconfig-002-20260730    gcc-15.2.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
i386                 randconfig-001-20260730    gcc-14
i386                 randconfig-002-20260730    gcc-14
i386                 randconfig-003-20260730    gcc-14
i386                 randconfig-004-20260730    gcc-14
i386                 randconfig-005-20260730    gcc-14
i386                 randconfig-006-20260730    gcc-14
i386                 randconfig-007-20260730    gcc-14
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-017-20260730    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260730    clang-24
mips                         ath25_defconfig    clang-24
mips                          ip30_defconfig    gcc-16.1.0
mips                       maltaup_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260730    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-14.3.0
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260729    gcc-8.5.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-9.5.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260729    clang-17
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260729    clang-24
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-13.4.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sparc                         randconfig-001    clang-24
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-002-20260730    clang-24
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260730    clang-24
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260730    clang-24
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260730    clang-22
x86_64               randconfig-002-20260730    clang-22
x86_64               randconfig-003-20260730    clang-22
x86_64               randconfig-004-20260730    clang-22
x86_64               randconfig-005-20260730    clang-22
x86_64               randconfig-006-20260730    clang-22
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260730    clang-22
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-076-20260730    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-002-20260730    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
