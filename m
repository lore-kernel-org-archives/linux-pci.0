Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80D3264D9
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263905; cv=none; b=lue428Rs67KklTtWpp11EmOuLAGR6II/qwlSKI/EO/7buv2XmDHVkELMb17W78fGC7J/ht3rhnDmXR0WQgmsFwQHcc9E8UZhZtzForv96BEm2hzAHDdRwXhIQYX32baEiRoYzhSPPwfzVo12I7kc9GxagqvLjuhPC6Snt4LOo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263905; c=relaxed/simple;
	bh=PlI08ugspAz5+4bDkP7LXb8bdlq2R1ijevieQ2NMOMQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MtG0Wtu6Q1pKLEQgAwapm3CSogeWhrrXbjlEr4Qw6zYhE6Fn9eip5WJ2DVY4XvuPAO2Jo427QaLjHeyB2uR1aATMnJA8i7Z6wKHNxLD9vXzmpVFakEL8o6+Kp9mECkRCtPVtyubveml5WT/SIzGcoJvNPMo48vAWJaqC+1yUg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbOQP01a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbOQP01a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787263903; x=1818799903;
  h=date:from:to:cc:subject:message-id;
  bh=PlI08ugspAz5+4bDkP7LXb8bdlq2R1ijevieQ2NMOMQ=;
  b=bbOQP01awhio8uPZe+0vSNuk3w5CiQds3ykZhNy7q8S4FcCO+WktBrfx
   i69l59J/KlDjjqibUPgMRUprf+VFzEb+ORbIZ5QLuFy7YWh+lAD/s/Oh3
   3gjr/Pr0IocEbe3TKhuILcyL83kyYRuaQcDzxP3brTcWAyIoH2NJxaiL+
   0bdJNoMPQM0rBegIKkk8AZsgwI4XJTZGgHN/Qml/7bXxGIuHZ95uFO2WW
   prz/WdOQ7CjtGfRvqr6x2feTN/5JIfD+5J4H3aO6IOXdCUdBQ4Qs5meIx
   YA13jEwg8wYKe4EqEkI9gri40R7ZR9GNlk/Mak21I6O4I6BJqtGLbmOnE
   A==;
X-CSE-ConnectionGUID: DZFURLF4QUmnM2KOYE5acA==
X-CSE-MsgGUID: b1JdnMYRRlqdVglb2wLYSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87577194"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87577194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:11:43 -0700
X-CSE-ConnectionGUID: /W2oIfOqRoezZl1YCCWXdg==
X-CSE-MsgGUID: PvKH/Pq6TrC60jpzHYiUoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="266765872"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Aug 2026 15:11:42 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxAz5-00000000nrL-3c3m;
	Thu, 20 Aug 2026 22:11:39 +0000
Date: Fri, 21 Aug 2026 06:11:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pending/pwrctrl] BUILD SUCCESS
 4943d7a5559f0734e5c725c992dfeb02e7306b6a
Message-ID: <202608210603.gngl9Oyz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pending/pwrctrl
branch HEAD: 4943d7a5559f0734e5c725c992dfeb02e7306b6a  PCI/pwrctrl: tc9563: Use devm-managed I2C dummy device allocation

elapsed time: 1497m

configs tested: 180
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
arc                  randconfig-001-20260820    clang-24
arc                  randconfig-001-20260820    gcc-16.1.0
arc                  randconfig-002-20260820    clang-24
arc                  randconfig-002-20260820    gcc-10.5.0
arm                  randconfig-001-20260820    clang-24
arm                  randconfig-002-20260820    clang-24
arm                  randconfig-003-20260820    clang-24
arm                  randconfig-003-20260820    gcc-8.5.0
arm                  randconfig-004-20260820    clang-24
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
i386                 randconfig-002-20260820    clang-22
i386                 randconfig-002-20260820    gcc-14
i386                 randconfig-003-20260820    clang-22
i386                 randconfig-003-20260820    gcc-14
i386                 randconfig-004-20260820    clang-22
i386                 randconfig-004-20260820    gcc-14
i386                 randconfig-005-20260820    clang-22
i386                 randconfig-006-20260820    clang-22
i386                 randconfig-007-20260820    clang-22
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
parisc               randconfig-002-20260820    gcc-11.5.0
parisc               randconfig-002-20260820    gcc-8.5.0
powerpc                  lite5200b_defconfig    clang-24
powerpc              randconfig-001-20260820    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc64            randconfig-001-20260820    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260820    gcc-10.5.0
powerpc64            randconfig-002-20260820    gcc-8.5.0
riscv                         randconfig-001    clang-24
riscv                         randconfig-001    gcc-13.4.0
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
x86_64               randconfig-012-20260820    clang-22
x86_64               randconfig-013-20260820    clang-22
x86_64               randconfig-013-20260820    gcc-13
x86_64               randconfig-014-20260820    clang-22
x86_64               randconfig-015-20260820    clang-22
x86_64               randconfig-015-20260820    gcc-14
x86_64               randconfig-016-20260820    clang-22
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
