Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDAF3F65E7
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621915; cv=none; b=to9Tm4Pk3ryn/Mnwa7fRGyqeZj44563f//EkRQEHvcJdJ67yB+qUU8fVy52xhwh7ihdsnVOW75T3ZZRoH/hJfrPQjXg7ifkVVaUYgRldtSgzY53cppdsEIy4DU6PgSxe84z8dGqCZzmr25NI5CM7fZJJ7pSI0gSmfS8nGerKEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621915; c=relaxed/simple;
	bh=UQP38PD4XRwRvq5Rc5XTxdlOmJ71d5vjOyRdfVuwc1M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gbTmHe5GfOVuC+Gabwsp1i9uRSw16pNk39LEzcs6bKuwf4gleoqQCaUBofJkTU9alPt0eXIvKYhnMfvEPuGInto/zb/RwDUUIH8Rk7kFWzXPUc7KvquMfUpnRszFr1FZ8E0RVf8yxxera+6MOe1tApRwJpWcBfZCYLYJC43LOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcFtAyGh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcFtAyGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774621914; x=1806157914;
  h=date:from:to:cc:subject:message-id;
  bh=UQP38PD4XRwRvq5Rc5XTxdlOmJ71d5vjOyRdfVuwc1M=;
  b=PcFtAyGhL9Lb++lBVKOsprmsYfKRp1OQ2J+Aaw9J3/9NEVQFF006LqgN
   jEtwXx8rPyIY+RUkl6esHfuxgxJX2QoVB9LYrDaZdB+ZMKY6hKciWQHD6
   PGxc6gEjjUIQGkNKuN2g4RTNlsat39AN0S/CEasIQEK+q2T+VyM40lfd0
   WgL6cOa92N1S5nJ79Cmr0u6X7R+0lMOGCDZXtFEcYQKhP6SKMYuwag2vr
   wuqwVI8OWcKp0w1HMr5MdoG5RE/s0x+2OoQYv2wbHyrXT2kQ6ga1klTy4
   3bHZlkodk+7IZFIGyCrlCyIQMwiqEmPWiUFHPLyj5DlG7Lk8Be3QKkNzT
   w==;
X-CSE-ConnectionGUID: 7uWGLGzGQMqSl+/u3U3Y9Q==
X-CSE-MsgGUID: oOzEWPhSSJylpLXvsxsJHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78290490"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="78290490"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 07:31:42 -0700
X-CSE-ConnectionGUID: Awjbtp+/TvuQV5Hl1f9ahw==
X-CSE-MsgGUID: t5rzNUj5ReG3bg6NTTkGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220934606"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Mar 2026 07:31:40 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w68Dq-00000000AMT-0v87;
	Fri, 27 Mar 2026 14:31:38 +0000
Date: Fri, 27 Mar 2026 22:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/max-link-speed] BUILD SUCCESS
 c8b610341914cb62899e31b41f724b5c4831a645
Message-ID: <202603272206.4n9dD42o-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/max-link-speed
branch HEAD: c8b610341914cb62899e31b41f724b5c4831a645  PCI: of: Remove max-link-speed generation validation

elapsed time: 1117m

configs tested: 151
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260327    gcc-11.5.0
arc                   randconfig-002-20260327    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260327    gcc-8.5.0
arm                   randconfig-002-20260327    clang-23
arm                   randconfig-003-20260327    clang-18
arm                   randconfig-004-20260327    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260327    clang-23
arm64                 randconfig-002-20260327    clang-18
arm64                 randconfig-003-20260327    gcc-9.5.0
arm64                 randconfig-004-20260327    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260327    gcc-15.2.0
csky                  randconfig-002-20260327    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260327    clang-23
hexagon               randconfig-002-20260327    clang-19
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260327    clang-20
i386        buildonly-randconfig-002-20260327    clang-20
i386        buildonly-randconfig-003-20260327    gcc-14
i386        buildonly-randconfig-004-20260327    clang-20
i386        buildonly-randconfig-005-20260327    clang-20
i386        buildonly-randconfig-006-20260327    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260327    clang-20
i386                  randconfig-002-20260327    clang-20
i386                  randconfig-003-20260327    gcc-14
i386                  randconfig-004-20260327    clang-20
i386                  randconfig-005-20260327    clang-20
i386                  randconfig-006-20260327    clang-20
i386                  randconfig-007-20260327    gcc-14
i386                  randconfig-011-20260327    clang-20
i386                  randconfig-012-20260327    gcc-14
i386                  randconfig-013-20260327    gcc-12
i386                  randconfig-014-20260327    gcc-12
i386                  randconfig-015-20260327    clang-20
i386                  randconfig-016-20260327    gcc-14
i386                  randconfig-017-20260327    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260327    gcc-15.2.0
loongarch             randconfig-002-20260327    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                          hp300_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260327    gcc-9.5.0
nios2                 randconfig-002-20260327    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260327    gcc-8.5.0
parisc                randconfig-002-20260327    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260327    gcc-8.5.0
powerpc               randconfig-002-20260327    clang-18
powerpc64             randconfig-001-20260327    clang-23
powerpc64             randconfig-002-20260327    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260327    clang-23
riscv                 randconfig-002-20260327    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260327    clang-23
s390                  randconfig-002-20260327    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260327    gcc-14.3.0
sh                    randconfig-002-20260327    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260327    gcc-14.3.0
sparc                 randconfig-002-20260327    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260327    clang-23
sparc64               randconfig-002-20260327    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260327    gcc-14
um                    randconfig-002-20260327    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260327    clang-20
x86_64      buildonly-randconfig-002-20260327    clang-20
x86_64      buildonly-randconfig-003-20260327    gcc-14
x86_64      buildonly-randconfig-004-20260327    clang-20
x86_64      buildonly-randconfig-005-20260327    gcc-14
x86_64      buildonly-randconfig-006-20260327    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260327    clang-20
x86_64                randconfig-002-20260327    clang-20
x86_64                randconfig-003-20260327    gcc-14
x86_64                randconfig-004-20260327    clang-20
x86_64                randconfig-005-20260327    gcc-14
x86_64                randconfig-006-20260327    gcc-14
x86_64                randconfig-071-20260327    clang-20
x86_64                randconfig-072-20260327    clang-20
x86_64                randconfig-073-20260327    clang-20
x86_64                randconfig-074-20260327    gcc-13
x86_64                randconfig-075-20260327    clang-20
x86_64                randconfig-076-20260327    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260327    gcc-14.3.0
xtensa                randconfig-002-20260327    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
