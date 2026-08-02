Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5841FECCD
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634613; cv=none; b=i+jlvmRvQQKjy5YNpvdQywttmUc3K/zOsaCnOMReehmwjGnQqor9iFjhoMEp4PhyiAU1CIzT8VKNq78rQ6RphsBhLJt7b+NtzO+/hiPKDk0YA0lpYSEoMrhzU6uruRm61xUMXfsjQRXKq1RDEOlYFEf+HW3k6eWTfJpLyRZWITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634613; c=relaxed/simple;
	bh=9KlgiOywAdeD+cZlwGSU8Rhj2vCyIX1ESh4tb5MGNQQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NXN1r8IFuOEi3ML5dz9nVHAxdqkTkQY/ofpaLVoSAD4DYh78I7CiYGj8DGKzhTyKTmCSsOwp04WlBVwy31u5pmXMp2138N2cdulBh8oYreqRmG7pkpMgJAhAsPxtFBbeGthAvI9rpTgvdh1aEdUvIoXtkxq6y250Wwr8Wev4Myo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIv3DaHP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIv3DaHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785634611; x=1817170611;
  h=date:from:to:cc:subject:message-id;
  bh=9KlgiOywAdeD+cZlwGSU8Rhj2vCyIX1ESh4tb5MGNQQ=;
  b=IIv3DaHP/PeIWVmdR3zDC95uF7OeleKJoCJmm2ziiIB2mziQi2KU4UaM
   mS8v9+h4kcerEcxMi3dSFB5btKuDWDqex5gxZ1LhSirnq+NTZDtOj66Ae
   K0UOUbJNxBj1ZquAPPdAKunr5q0MidPP5jvJlmOaPxrPB5LJWSb5fPcVN
   WMScf8bxEeKh5+8RE2TnfvhW7UkBqD/qT5oZfk84+qJtSuoC30icHqDIs
   H0NyLpyRvg8ZhOxfVqAgRGCRCut/bgX7nwca8yA0nHpwYEJBf65l+Qv5o
   zrR0gK2yOMxVnfF9F9M8B+BYTANg/0RAaLTU7kIIJQD/GjPnOO+fx2Izt
   w==;
X-CSE-ConnectionGUID: mc8b0fo5Sv60aN+UanjkFQ==
X-CSE-MsgGUID: Y+cWramORUK90tPesooIXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="111766950"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="111766950"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 18:36:51 -0700
X-CSE-ConnectionGUID: 2ExrMmvpRGec2jicFhUmAw==
X-CSE-MsgGUID: FVg4KaHiRO+zaA9AyVLV+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="258220226"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 01 Aug 2026 18:36:50 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqL8B-000000004EH-3kTx;
	Sun, 02 Aug 2026 01:36:47 +0000
Date: Sun, 02 Aug 2026 09:36:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 c57d8c82f8ca02b8166d6d46caa7c6abe6dd70eb
Message-ID: <202608020952.bEpRy9Ao-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: c57d8c82f8ca02b8166d6d46caa7c6abe6dd70eb  Merge branch 'pci/misc'

elapsed time: 746m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260801    gcc-14.3.0
arc                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-001-20260801    clang-24
arm                  randconfig-002-20260801    gcc-8.5.0
arm                  randconfig-003-20260801    gcc-12.5.0
arm                  randconfig-004-20260801    clang-18
arm64                randconfig-001-20260802    clang-18
arm64                randconfig-002-20260802    gcc-15.2.0
arm64                randconfig-003-20260802    gcc-13.4.0
arm64                randconfig-004-20260802    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260802    gcc-11.5.0
csky                 randconfig-002-20260802    gcc-9.5.0
hexagon              randconfig-001-20260802    clang-24
hexagon              randconfig-002-20260802    clang-17
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260801    clang-22
i386       buildonly-randconfig-002-20260801    clang-22
i386       buildonly-randconfig-003-20260801    clang-22
i386       buildonly-randconfig-004-20260801    clang-22
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
i386                 randconfig-001-20260802    gcc-14
i386                 randconfig-002-20260802    clang-22
i386                 randconfig-003-20260802    gcc-14
i386                 randconfig-004-20260802    gcc-14
i386                 randconfig-005-20260802    clang-22
i386                 randconfig-006-20260802    gcc-14
i386                 randconfig-007-20260802    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260802    gcc-16.1.0
loongarch            randconfig-002-20260802    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260802    gcc-9.5.0
nios2                randconfig-002-20260802    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260802    gcc-8.5.0
parisc               randconfig-002-20260802    gcc-14.3.0
powerpc              randconfig-001-20260802    gcc-8.5.0
powerpc              randconfig-002-20260802    clang-24
powerpc64            randconfig-001-20260802    gcc-10.5.0
powerpc64            randconfig-002-20260802    clang-24
riscv                randconfig-001-20260801    gcc-14.3.0
riscv                randconfig-002-20260801    clang-20
s390                 randconfig-001-20260801    gcc-15.2.0
s390                 randconfig-002-20260801    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260801    gcc-16.1.0
sh                   randconfig-002-20260801    gcc-16.1.0
sh                            sh03_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260801    gcc-8.5.0
sparc                randconfig-002-20260801    gcc-11.5.0
sparc64              randconfig-001-20260801    gcc-9.5.0
sparc64              randconfig-002-20260801    gcc-15.2.0
um                   randconfig-001-20260801    clang-17
um                   randconfig-002-20260801    gcc-14
x86_64     buildonly-randconfig-001-20260801    clang-22
x86_64     buildonly-randconfig-002-20260801    clang-22
x86_64     buildonly-randconfig-003-20260801    gcc-13
x86_64     buildonly-randconfig-004-20260801    clang-22
x86_64     buildonly-randconfig-005-20260801    clang-22
x86_64     buildonly-randconfig-006-20260801    clang-22
x86_64               randconfig-071-20260801    gcc-14
x86_64               randconfig-072-20260801    gcc-14
x86_64               randconfig-073-20260801    clang-22
x86_64               randconfig-074-20260801    gcc-14
x86_64               randconfig-075-20260801    clang-22
x86_64               randconfig-076-20260801    clang-22
xtensa               randconfig-001-20260801    gcc-9.5.0
xtensa               randconfig-002-20260801    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
