Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF329BDB5
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748006; cv=none; b=cwfLArNiWZRM3Uw+tYdJvNb9qzVkhI6s0nBsMynyZrTWaW2qgZMZGp1wdwI4HbDZcR+hxRn+4+XYPnbL42vYaZHmX10vKaNl4M9Yug4swbK1AF63hgbdKKdTodpcMCQ267YoQydHYtnwTYN3dAZR8VZzN/f7S5d3R2DHHVn6EmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748006; c=relaxed/simple;
	bh=dSRJPYox4HcDBguGIh7IeJx8X5psfW+5Gfrmpf9GUW0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pIz3+6vKIsGZd+tTGvbgzhUFI/Nhm5NNebmgY0KL/ABW+tA15ep/F4F8FVdHcZh3IZ6IBtQy6rXmY8n965exKqqD7j85DTmbUeSCfXZnzMwQ744wu0gGwP58baSbV8sozTvSrWtUzhKn8UHOfzfQ8Ynqsoae7wpLXjII6f1lfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITzWMnp7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITzWMnp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786748005; x=1818284005;
  h=date:from:to:cc:subject:message-id;
  bh=dSRJPYox4HcDBguGIh7IeJx8X5psfW+5Gfrmpf9GUW0=;
  b=ITzWMnp7JGcisn0fZHHUm+zzUatRhousJgWCZMHFkCg6yk0djyFOtwfD
   y6svjPZEm2qXuXyNQmVd5Pshv2UQtewh+QMaQs7mXfZomtb57Vi4USgVW
   Dg/NEN5LAfSy12ijj+xhWsdHTk/N+h2eIwd466LP9KY3WgU1Q+DJoqJOb
   ZcTDC/hqqjRAF3rFIKKedJPrvo2RvZK6/eiZDn+2DXjCvpt1gnK69cCuF
   EjQfL685Dzc4n6g1ADJg0bFS7fA2b2OYBZm73SDp2tpjkmDtv7cdHMV1j
   hQJdACcj3Sg6+0OnM4na7g7z5qLCU9bqSDHkIRJ1eppViQx6Xp0ko8VQ3
   Q==;
X-CSE-ConnectionGUID: NcSkaZVNRqq6PEcf6nDJjA==
X-CSE-MsgGUID: 8D1tz5dtTAGnZSzV2nHCVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="97919827"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="97919827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 15:53:24 -0700
X-CSE-ConnectionGUID: 2XEcD3CGTF6vQefO3KggLA==
X-CSE-MsgGUID: DWDoJWUMQZem4LvR50gcQg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Aug 2026 15:53:23 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wv0m8-00000000aQQ-0f4z;
	Fri, 14 Aug 2026 22:53:20 +0000
Date: Sat, 15 Aug 2026 06:52:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:virtualization] BUILD SUCCESS
 23d7eed5974989de56273c964d7e510e4aad91e8
Message-ID: <202608150622.Zc6KJlpH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git virtualization
branch HEAD: 23d7eed5974989de56273c964d7e510e4aad91e8  PCI: Fix 32-bit config write in Intel PCH Root Port MPC ACS quirk

elapsed time: 862m

configs tested: 98
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260814    gcc-10.5.0
arc                  randconfig-002-20260814    gcc-12.5.0
arm                  randconfig-001-20260814    gcc-16.1.0
arm                  randconfig-002-20260814    gcc-10.5.0
arm                  randconfig-003-20260814    gcc-16.1.0
arm                  randconfig-004-20260814    clang-17
arm64                randconfig-001-20260814    gcc-10.5.0
arm64                randconfig-002-20260814    clang-24
arm64                randconfig-003-20260814    clang-19
arm64                randconfig-004-20260814    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260814    gcc-16.1.0
csky                 randconfig-002-20260814    gcc-10.5.0
hexagon              randconfig-001-20260814    clang-17
hexagon              randconfig-002-20260814    clang-19
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260814    clang-22
i386       buildonly-randconfig-002-20260814    gcc-13
i386       buildonly-randconfig-003-20260814    clang-22
i386       buildonly-randconfig-004-20260814    clang-22
i386       buildonly-randconfig-005-20260814    gcc-13
i386       buildonly-randconfig-006-20260814    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260814    clang-22
i386                 randconfig-002-20260814    gcc-14
i386                 randconfig-003-20260814    gcc-14
i386                 randconfig-004-20260814    clang-22
i386                 randconfig-005-20260814    clang-22
i386                 randconfig-006-20260814    clang-22
i386                 randconfig-007-20260814    clang-22
i386                 randconfig-011-20260814    gcc-14
i386                 randconfig-012-20260814    gcc-12
i386                 randconfig-013-20260814    gcc-12
i386                 randconfig-014-20260814    gcc-14
i386                 randconfig-015-20260814    gcc-12
i386                 randconfig-016-20260814    gcc-14
i386                 randconfig-017-20260814    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260814    gcc-16.1.0
loongarch            randconfig-002-20260814    clang-24
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260814    gcc-11.5.0
nios2                randconfig-002-20260814    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260814    gcc-15.2.0
parisc               randconfig-002-20260814    gcc-9.5.0
powerpc              randconfig-001-20260814    gcc-8.5.0
powerpc              randconfig-002-20260814    clang-18
powerpc64            randconfig-001-20260814    gcc-14.3.0
powerpc64            randconfig-002-20260814    gcc-8.5.0
riscv                randconfig-001-20260814    gcc-14.3.0
riscv                randconfig-002-20260814    clang-24
s390                 randconfig-001-20260814    gcc-11.5.0
s390                 randconfig-002-20260814    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260814    gcc-16.1.0
sh                   randconfig-002-20260814    gcc-16.1.0
sh                             ul2_defconfig    gcc-16.1.0
sparc                randconfig-001-20260814    gcc-16.1.0
sparc                randconfig-002-20260814    gcc-15.2.0
sparc64              randconfig-001-20260814    gcc-8.5.0
sparc64              randconfig-002-20260814    clang-24
um                   randconfig-001-20260814    gcc-14
um                   randconfig-002-20260814    clang-22
x86_64     buildonly-randconfig-001-20260814    clang-22
x86_64     buildonly-randconfig-002-20260814    clang-22
x86_64     buildonly-randconfig-003-20260814    clang-22
x86_64     buildonly-randconfig-004-20260814    clang-22
x86_64     buildonly-randconfig-005-20260814    clang-22
x86_64     buildonly-randconfig-006-20260814    gcc-14
x86_64               randconfig-001-20260814    gcc-14
x86_64               randconfig-002-20260814    clang-22
x86_64               randconfig-003-20260814    clang-22
x86_64               randconfig-004-20260814    clang-22
x86_64               randconfig-005-20260814    gcc-14
x86_64               randconfig-006-20260814    gcc-14
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260814    clang-22
x86_64               randconfig-012-20260814    gcc-13
x86_64               randconfig-013-20260814    clang-22
x86_64               randconfig-014-20260814    gcc-14
x86_64               randconfig-015-20260814    gcc-14
x86_64               randconfig-016-20260814    clang-22
x86_64               randconfig-071-20260814    gcc-14
x86_64               randconfig-072-20260814    clang-22
x86_64               randconfig-073-20260814    clang-22
x86_64               randconfig-074-20260814    gcc-13
x86_64               randconfig-075-20260814    gcc-14
x86_64               randconfig-076-20260814    clang-22
xtensa               randconfig-001-20260814    gcc-9.5.0
xtensa               randconfig-002-20260814    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
