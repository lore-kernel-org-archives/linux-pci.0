Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE53403E1
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381803; cv=none; b=fCvNXgWBuzAdWhHRfufypT0LGLIVrTK2DQiFPG08sIxqU5fzu6X8DdNBhVGSIwkGQUiLna8LaW/FBiWhCDHMXiD/J0zLeieGsul9Zqj2cx8HLT46onlqzOV2Ik3xV7nWMuNTjJAEclq5WPHVxLuMq7o4pokBClUD3p1598hEdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381803; c=relaxed/simple;
	bh=jly5kvm02Q2TpJ2nIzi4SuEoKLYSurV2tBkbBbAve5E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EgLqw71w0k/SiovvVbHHrMc6gyIeSRjPOXKrH00IOHeiK99NYSxD9aDsMMpl8EJSzPo/oQU/GKbnOz7b1Wmq0yuqjEVJ2ues3IoHTmH2Qj8cX2l8xyhjusQcPeGONZ2w/GiUBpcUx1t3MiWdvldPGmG5apsjUK7C72FvihFvQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8/pqtDm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8/pqtDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785381802; x=1816917802;
  h=date:from:to:cc:subject:message-id;
  bh=jly5kvm02Q2TpJ2nIzi4SuEoKLYSurV2tBkbBbAve5E=;
  b=H8/pqtDm+ZekzaC6U/Oe/YkRMWgDtyDBTYS70dK9aRCkiBZbebmaPMPG
   L0ajqLIfIwrfr33pgbefnoLqG4LusCNfLvPdg838X43gjC6OMRcr4RYoC
   EgkCHXhk4f4TgZnThaie2xVpYae8yaSWx1Ctm7Zgg6+R0MMHfyfICQaIy
   EEP7OmNy+1TwWIvbzeRVQK9lvDi9jtItoZmhRXAsNOWqHcVO+05xTMi6X
   3Cg4fz4lUx42XBLN+ojBi29prIneZVVyXba9Br+1vUsgefPMhbwlaIm1x
   TIn7lQgf2O6TJ0o6Hd0ua8Flg+g1iC0cXSPJUqZHcCFs+8E6JC0cWhUPT
   w==;
X-CSE-ConnectionGUID: +3q5B87dRo+RwooKztSu/w==
X-CSE-MsgGUID: IvVigodnT2CpUt2FelTcZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85871199"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85871199"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 20:23:20 -0700
X-CSE-ConnectionGUID: nbGr2d5eTBOHYMnicIi2kQ==
X-CSE-MsgGUID: PxAQEZitS12zInvBuImjaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="262137731"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 29 Jul 2026 20:23:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpHMR-00000000fyg-161e;
	Thu, 30 Jul 2026 03:23:10 +0000
Date: Thu, 30 Jul 2026 11:22:49 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-qcom] BUILD SUCCESS
 7b7f5c32762109be07298e7499a251cbf04c3f06
Message-ID: <202607301137.or5ToQR7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-qcom
branch HEAD: 7b7f5c32762109be07298e7499a251cbf04c3f06  PCI: qcom: Clear Attention Button Present in Slot Capabilities

elapsed time: 857m

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
arc                           randconfig-001    gcc-8.5.0
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
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260730    clang-21
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-8.5.0
arm64                randconfig-004-20260730    gcc-13.4.0
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-13.4.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-16.1.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
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
sh                  sh7724_generic_defconfig    gcc-16.1.0
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
