Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E91C5D72
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787267151; cv=none; b=O5vPFa7HHhbnOUjiecdVs+qVRPEFg3COy8MEvG+nmsst09ESrbDl8o3NWrhplcwrjryjJfbrMuh/fBM0QqA3x4dgW6TNztDqWm2u2/1fI9q/IEP/WthU4hkj2eZR0lYkWTXZDLNvKbknKr1/H5a7hUCqBJ+JWuqkjrwAQwD5J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787267151; c=relaxed/simple;
	bh=kWnlj/e60P/edSTcscWkAb5aPij3iAJnUkjFsVJm7+E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VGqi+hEuFA+stu1DRIHyc+ezi9xBT64/JCA+cKkSzSP/lfh9kSyfBRQEk+PH/iIawKCVRcXYxuDz2hUpZ4+p6IO0fUy1ZiDR/H//VwqI/2PuFgxbQDX6UIg0nayID8ubz89el3q/iozSB+SZmDUpD2d3aNgNV83qQT1ykez/Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJGpm/mz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJGpm/mz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787267150; x=1818803150;
  h=date:from:to:cc:subject:message-id;
  bh=kWnlj/e60P/edSTcscWkAb5aPij3iAJnUkjFsVJm7+E=;
  b=WJGpm/mz3kQ1OAsKvNJ0hDgiMzdVcxFpAupHZyQktC7cUVFkOYsL5ScQ
   TjqfH43z4gUcB0VMulBTZVyveUrt1aVcw1+3tZh5ClzksrB/vHWTyrLI8
   VP2fugd6h1+2UmWVTNL0L7O6d7DslhjeGkGy+PLwkI/ar5ebMT5aETlOx
   5Lzi7JaMRsqnWRkWV7EasmogtIr+7Ynx0QWiR1cj9MmTIAOuwhZeYhsIu
   Ss8WFrY+NSMosgNsojDlB8iGu3XJsVuzX6Rqd9Rr7IuX0vsMXj3oPQeZw
   0M/17dwGu+iLO/05P9xb5UPq5TXMxe8WtJrcd0j6vi7knfbAuvI42Vb+f
   Q==;
X-CSE-ConnectionGUID: mqfw4rYRTQmRxQ4wzuasbg==
X-CSE-MsgGUID: Zp/B06XfR4yt6KP9WVr64A==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87832274"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87832274"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:05:49 -0700
X-CSE-ConnectionGUID: QIHkAqQ6S6C7L+Pax7jucw==
X-CSE-MsgGUID: IRH25/2TSoyWKrwnND9Bvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264866338"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 16:05:48 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxBpR-00000000nzD-1npI;
	Thu, 20 Aug 2026 23:05:45 +0000
Date: Fri, 21 Aug 2026 07:05:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 115c7e572e50570ab25fc5c0e83bbf93b22ea880
Message-ID: <202608210733.RjbRBxqX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 115c7e572e50570ab25fc5c0e83bbf93b22ea880  Merge branch 'pci/misc'

elapsed time: 1552m

configs tested: 206
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    clang-24
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260820    clang-24
arc                  randconfig-001-20260820    gcc-16.1.0
arc                  randconfig-001-20260821    gcc-10.5.0
arc                  randconfig-002-20260820    clang-24
arc                  randconfig-002-20260820    gcc-10.5.0
arc                  randconfig-002-20260821    gcc-10.5.0
arm                  randconfig-001-20260820    clang-24
arm                  randconfig-001-20260821    gcc-10.5.0
arm                  randconfig-002-20260820    clang-24
arm                  randconfig-002-20260821    gcc-10.5.0
arm                  randconfig-003-20260820    clang-24
arm                  randconfig-003-20260820    gcc-8.5.0
arm                  randconfig-003-20260821    gcc-10.5.0
arm                  randconfig-004-20260820    clang-24
arm                  randconfig-004-20260821    gcc-10.5.0
arm64                randconfig-001-20260820    clang-24
arm64                randconfig-001-20260821    gcc-8.5.0
arm64                randconfig-002-20260820    clang-24
arm64                randconfig-002-20260821    gcc-8.5.0
arm64                randconfig-003-20260820    clang-24
arm64                randconfig-003-20260821    gcc-8.5.0
arm64                randconfig-004-20260820    clang-24
arm64                randconfig-004-20260821    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260820    clang-24
csky                 randconfig-001-20260820    gcc-16.1.0
csky                 randconfig-001-20260821    gcc-8.5.0
csky                 randconfig-002-20260820    clang-24
csky                 randconfig-002-20260820    gcc-16.1.0
csky                 randconfig-002-20260821    gcc-8.5.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260820    clang-18
hexagon              randconfig-001-20260820    gcc-14.3.0
hexagon              randconfig-002-20260820    clang-19
hexagon              randconfig-002-20260820    gcc-14.3.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260820    gcc-14
i386       buildonly-randconfig-001-20260821    gcc-14
i386       buildonly-randconfig-002-20260820    clang-22
i386       buildonly-randconfig-002-20260820    gcc-14
i386       buildonly-randconfig-002-20260821    gcc-14
i386       buildonly-randconfig-003-20260820    gcc-14
i386       buildonly-randconfig-003-20260821    gcc-14
i386       buildonly-randconfig-004-20260820    clang-22
i386       buildonly-randconfig-004-20260820    gcc-14
i386       buildonly-randconfig-004-20260821    gcc-14
i386       buildonly-randconfig-005-20260820    gcc-14
i386       buildonly-randconfig-005-20260821    gcc-14
i386       buildonly-randconfig-006-20260820    gcc-13
i386       buildonly-randconfig-006-20260820    gcc-14
i386       buildonly-randconfig-006-20260821    gcc-14
i386                 randconfig-001-20260820    clang-22
i386                 randconfig-001-20260820    gcc-14
i386                 randconfig-001-20260821    clang-22
i386                 randconfig-002-20260820    clang-22
i386                 randconfig-002-20260820    gcc-14
i386                 randconfig-002-20260821    clang-22
i386                 randconfig-003-20260820    clang-22
i386                 randconfig-003-20260820    gcc-14
i386                 randconfig-003-20260821    clang-22
i386                 randconfig-004-20260820    clang-22
i386                 randconfig-004-20260820    gcc-14
i386                 randconfig-004-20260821    clang-22
i386                 randconfig-005-20260820    clang-22
i386                 randconfig-005-20260821    clang-22
i386                 randconfig-006-20260820    clang-22
i386                 randconfig-006-20260821    clang-22
i386                 randconfig-007-20260820    clang-22
i386                 randconfig-007-20260821    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260820    gcc-14
i386                 randconfig-012-20260820    gcc-14
i386                 randconfig-013-20260820    gcc-14
i386                 randconfig-014-20260820    gcc-14
i386                 randconfig-015-20260820    clang-22
i386                 randconfig-015-20260820    gcc-14
i386                 randconfig-016-20260820    gcc-14
i386                 randconfig-017-20260820    clang-22
i386                 randconfig-017-20260820    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260820    clang-18
loongarch            randconfig-001-20260820    gcc-14.3.0
loongarch            randconfig-002-20260820    gcc-14.3.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-14.3.0
nios2                randconfig-002-20260820    gcc-11.5.0
nios2                randconfig-002-20260820    gcc-14.3.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260820    gcc-8.5.0
parisc               randconfig-001-20260821    gcc-12.5.0
parisc               randconfig-002-20260820    gcc-11.5.0
parisc               randconfig-002-20260820    gcc-8.5.0
parisc               randconfig-002-20260821    gcc-12.5.0
powerpc              randconfig-001-20260820    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-001-20260821    gcc-12.5.0
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc              randconfig-002-20260821    gcc-12.5.0
powerpc                   socrates_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260820    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-001-20260821    gcc-12.5.0
powerpc64            randconfig-002-20260820    gcc-10.5.0
powerpc64            randconfig-002-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260821    gcc-12.5.0
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260820    clang-24
riscv                randconfig-001-20260820    gcc-8.5.0
riscv                randconfig-001-20260821    clang-24
riscv                randconfig-002-20260820    clang-21
riscv                randconfig-002-20260820    clang-24
riscv                randconfig-002-20260821    clang-24
s390                 randconfig-001-20260820    clang-24
s390                 randconfig-001-20260820    gcc-8.5.0
s390                 randconfig-001-20260821    clang-24
s390                 randconfig-002-20260820    clang-24
s390                 randconfig-002-20260821    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260820    clang-24
sh                   randconfig-001-20260820    gcc-10.5.0
sh                   randconfig-001-20260821    clang-24
sh                   randconfig-002-20260820    clang-24
sh                   randconfig-002-20260820    gcc-12.5.0
sh                   randconfig-002-20260821    clang-24
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260820    gcc-13.4.0
sparc                randconfig-001-20260820    gcc-8.5.0
sparc                randconfig-001-20260821    gcc-8.5.0
sparc                randconfig-002-20260820    gcc-13.4.0
sparc                randconfig-002-20260820    gcc-16.1.0
sparc                randconfig-002-20260821    gcc-8.5.0
sparc                      sparc64_defconfig    gcc-16.1.0
sparc64              randconfig-001-20260820    gcc-11.5.0
sparc64              randconfig-001-20260820    gcc-13.4.0
sparc64              randconfig-001-20260821    gcc-8.5.0
sparc64              randconfig-002-20260820    gcc-13.4.0
sparc64              randconfig-002-20260820    gcc-9.5.0
sparc64              randconfig-002-20260821    gcc-8.5.0
um                   randconfig-001-20260820    gcc-13.4.0
um                   randconfig-001-20260820    gcc-14
um                   randconfig-001-20260821    gcc-8.5.0
um                   randconfig-002-20260820    gcc-13.4.0
um                   randconfig-002-20260820    gcc-14
um                   randconfig-002-20260821    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260820    gcc-14
x86_64     buildonly-randconfig-002-20260820    gcc-14
x86_64     buildonly-randconfig-003-20260820    clang-22
x86_64     buildonly-randconfig-003-20260820    gcc-14
x86_64     buildonly-randconfig-004-20260820    clang-22
x86_64     buildonly-randconfig-004-20260820    gcc-14
x86_64     buildonly-randconfig-005-20260820    clang-22
x86_64     buildonly-randconfig-005-20260820    gcc-14
x86_64     buildonly-randconfig-006-20260820    clang-22
x86_64     buildonly-randconfig-006-20260820    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260820    clang-22
x86_64               randconfig-001-20260820    gcc-14
x86_64               randconfig-002-20260820    clang-22
x86_64               randconfig-002-20260820    gcc-14
x86_64               randconfig-003-20260820    clang-22
x86_64               randconfig-004-20260820    clang-22
x86_64               randconfig-005-20260820    clang-22
x86_64               randconfig-006-20260820    clang-22
x86_64               randconfig-011-20260820    clang-22
x86_64               randconfig-011-20260821    gcc-14
x86_64               randconfig-012-20260820    clang-22
x86_64               randconfig-012-20260821    gcc-14
x86_64               randconfig-013-20260820    clang-22
x86_64               randconfig-013-20260820    gcc-13
x86_64               randconfig-013-20260821    gcc-14
x86_64               randconfig-014-20260820    clang-22
x86_64               randconfig-014-20260821    gcc-14
x86_64               randconfig-015-20260820    clang-22
x86_64               randconfig-015-20260820    gcc-14
x86_64               randconfig-015-20260821    gcc-14
x86_64               randconfig-016-20260820    clang-22
x86_64               randconfig-016-20260821    gcc-14
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260820    clang-22
x86_64               randconfig-071-20260820    gcc-14
x86_64               randconfig-072-20260820    gcc-14
x86_64               randconfig-073-20260820    clang-22
x86_64               randconfig-073-20260820    gcc-14
x86_64               randconfig-074-20260820    clang-22
x86_64               randconfig-074-20260820    gcc-14
x86_64               randconfig-075-20260820    clang-22
x86_64               randconfig-075-20260820    gcc-14
x86_64               randconfig-076-20260820    clang-22
x86_64               randconfig-076-20260820    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260820    gcc-13.4.0
xtensa               randconfig-001-20260820    gcc-8.5.0
xtensa               randconfig-001-20260821    gcc-8.5.0
xtensa               randconfig-002-20260820    gcc-13.4.0
xtensa               randconfig-002-20260821    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
