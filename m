Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0432475E3
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784398336; cv=none; b=C/F6QArozIQreeYkkTUwKEDGcueakSc+9AxT62eT0//OXIqou0spBXS3O/Z+84PKIJVii538ryTf3D1sX3Sf9XYIdj+JChCuTd9X18VBi6lY3J7TOyH2s/WmIF842WHAFUQpcVbbOmzy5IWePYWIDotlu/Kicx4pkGsNiZ9QIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784398336; c=relaxed/simple;
	bh=zofF1+DpRS6JStH9vjwfoW4HEt/J2fNc0jLpGdRSeeA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mZUWFtJJqDtjy4YC8C7Gs78O8K8wZuCBoLnVfndq3WU65arNN/JRAhrIT3mHq9QsM1eJP2C/KBxC5Puypb30hCCKS3TctwWbyeBxT0jR6w4H+to80jV/jgl7kG1a/a10rptNbW7jccU53XPzX6CKyfX07GAbj+Fy2Qjg4I4gDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKZZZwx3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKZZZwx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784398333; x=1815934333;
  h=date:from:to:cc:subject:message-id;
  bh=zofF1+DpRS6JStH9vjwfoW4HEt/J2fNc0jLpGdRSeeA=;
  b=mKZZZwx3IGUsLnBrnrzJ3pQRxwIaGgOp906AmHnyYh82JPvLTfhkPgkz
   nssIhBHooc1or6f0YTuJ3NtPhXuYo87uQzyiKbgPnhx7R/o5nDyaMWGg8
   RiOrcNBvUcFrMWN/l8LMftMLyGy8DcvjViQhSbeXW8KTY2RIvN9sFkiSt
   tPciqtKzdJBYwtigkHAKZuJfVejKMaL4lzvlRgagRLscQ/+8JFt9wiX8D
   bFj0EBo/mIat6M6v2Y6YT4vw42KOhn99k58isriLUTkSP0YuBGnSn87Ma
   3sQG8rbbOw+Q0N5w7/vPFOUSV3VI1xruS5FBBsTS6AtmkJfxNu4JVucm+
   w==;
X-CSE-ConnectionGUID: +K8HerkdRNaD3rJNw3+6kw==
X-CSE-MsgGUID: E1cAikGVS4SCapi6TkVdyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="107820989"
X-IronPort-AV: E=Sophos;i="6.25,171,1779174000"; 
   d="scan'208";a="107820989"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 11:12:13 -0700
X-CSE-ConnectionGUID: x2UYSs3sSEGM6GGWUU7fPw==
X-CSE-MsgGUID: MkPD95SHRYeP+mbfh4zdhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,171,1779174000"; 
   d="scan'208";a="281529322"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jul 2026 11:12:12 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wl9WD-00000000V0Q-2pkR;
	Sat, 18 Jul 2026 18:12:09 +0000
Date: Sun, 19 Jul 2026 02:12:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/plda-starfive] BUILD SUCCESS
 22877a061f81c5d58041e384b3131684bec636b9
Message-ID: <202607190253.MZsWeg9b-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/plda-starfive
branch HEAD: 22877a061f81c5d58041e384b3131684bec636b9  PCI: starfive: Fix resource leaks on error paths in host_init()

elapsed time: 2912m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260717    gcc-11.5.0
arc                  randconfig-002-20260717    gcc-13.4.0
arm                         exynos_defconfig    clang-17
arm                  randconfig-001-20260717    clang-24
arm                  randconfig-002-20260717    clang-24
arm                  randconfig-003-20260717    gcc-8.5.0
arm                  randconfig-004-20260717    gcc-11.5.0
arm64                randconfig-001-20260717    gcc-11.5.0
arm64                randconfig-002-20260717    gcc-8.5.0
arm64                randconfig-003-20260717    gcc-8.5.0
arm64                randconfig-004-20260717    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260717    gcc-13.4.0
csky                 randconfig-002-20260717    gcc-15.2.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260717    clang-24
hexagon              randconfig-002-20260717    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260717    gcc-14
i386       buildonly-randconfig-002-20260717    gcc-14
i386       buildonly-randconfig-003-20260717    clang-22
i386       buildonly-randconfig-004-20260717    gcc-14
i386       buildonly-randconfig-005-20260717    gcc-14
i386       buildonly-randconfig-006-20260717    clang-22
i386                 randconfig-001-20260717    gcc-14
i386                 randconfig-002-20260717    clang-22
i386                 randconfig-003-20260717    clang-22
i386                 randconfig-004-20260717    gcc-14
i386                 randconfig-005-20260717    gcc-14
i386                 randconfig-006-20260717    gcc-14
i386                 randconfig-007-20260717    gcc-14
i386                 randconfig-011-20260717    clang-22
i386                 randconfig-012-20260717    clang-22
i386                 randconfig-013-20260717    clang-22
i386                 randconfig-014-20260717    clang-22
i386                 randconfig-015-20260717    clang-22
i386                 randconfig-016-20260717    gcc-14
i386                 randconfig-017-20260717    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260717    gcc-16.1.0
loongarch            randconfig-002-20260717    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260717    gcc-8.5.0
nios2                randconfig-002-20260717    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260717    gcc-10.5.0
parisc               randconfig-002-20260717    gcc-16.1.0
powerpc              randconfig-001-20260717    gcc-13.4.0
powerpc              randconfig-002-20260717    gcc-11.5.0
powerpc64            randconfig-001-20260717    gcc-15.2.0
powerpc64            randconfig-002-20260717    gcc-8.5.0
riscv                randconfig-001-20260717    clang-17
riscv                randconfig-002-20260717    clang-24
s390                 randconfig-001-20260717    clang-24
s390                 randconfig-002-20260717    clang-20
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260717    gcc-9.5.0
sh                   randconfig-002-20260717    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260717    gcc-8.5.0
sparc                randconfig-002-20260717    gcc-14.3.0
sparc64              randconfig-001-20260717    clang-22
sparc64              randconfig-002-20260717    clang-24
um                   randconfig-001-20260717    clang-24
um                   randconfig-002-20260717    clang-21
x86_64     buildonly-randconfig-001-20260717    gcc-14
x86_64     buildonly-randconfig-002-20260717    gcc-14
x86_64     buildonly-randconfig-003-20260717    gcc-14
x86_64     buildonly-randconfig-004-20260717    gcc-14
x86_64     buildonly-randconfig-005-20260717    clang-22
x86_64     buildonly-randconfig-006-20260717    clang-22
x86_64               randconfig-001-20260717    clang-22
x86_64               randconfig-002-20260717    clang-22
x86_64               randconfig-003-20260717    gcc-14
x86_64               randconfig-004-20260717    gcc-14
x86_64               randconfig-005-20260717    gcc-14
x86_64               randconfig-006-20260717    gcc-13
x86_64               randconfig-011-20260717    gcc-14
x86_64               randconfig-012-20260717    gcc-14
x86_64               randconfig-013-20260717    clang-22
x86_64               randconfig-014-20260717    gcc-12
x86_64               randconfig-015-20260717    gcc-14
x86_64               randconfig-016-20260717    gcc-14
x86_64               randconfig-071-20260717    gcc-14
x86_64               randconfig-072-20260717    gcc-14
x86_64               randconfig-073-20260717    gcc-14
x86_64               randconfig-074-20260717    gcc-12
x86_64               randconfig-075-20260717    gcc-14
x86_64               randconfig-076-20260717    clang-22
xtensa               randconfig-001-20260717    gcc-16.1.0
xtensa               randconfig-002-20260717    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
