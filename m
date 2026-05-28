Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7B3FBED8
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995824; cv=none; b=TKeaiYSfrH/yabhOn8lJKr7sCzbR6+sN9rpMSnJQSb2N5nbdYMLqkQZe0XInLG/6C1sxV1BTeP4U5ndRVVvUlOMG9HpNmSNQjPEJbq9TGe+C9xOz4nplmY2ZFIhfIM4CbrdqoY8BzcNO/zQy3/lt3+Z2nAmeNVRfK9pg2ZiqVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995824; c=relaxed/simple;
	bh=Ah6mryx9xjHLbFz78Faj0ptLtXnKLEArXeW8UFt1I0g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SWwnegE5aicU72jWpXjmgXfm07o/x3ufZQBp6gqej34d/u9+/GdNhRGJL7GYh5QMVMN19CzYFhOoRJPCCqBCHi54Bsq/NEX7Cx2+m3bIGxOYLjkudlilimh7NQjzKSK6Pw7M2MVBEgwwqO/mjl2ODPVluo14hAxhLmZC5Zylvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzZwKMxC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzZwKMxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779995822; x=1811531822;
  h=date:from:to:cc:subject:message-id;
  bh=Ah6mryx9xjHLbFz78Faj0ptLtXnKLEArXeW8UFt1I0g=;
  b=AzZwKMxCYI3PeP/kCP+qU3PFGZZiTFVjLlmJOmAOQrcuGKBnnZEEFw4Y
   ybFc+LEdtvaQUyu51tMn31P2KeLab9MNAGkX4dByCa6As3PZwd3t5rKhi
   zYNpxS3Yo5l24folvhPtsdcUSAoK6B4uYe/G0v3s2ilcWdN3DvmXa5fHz
   vqi31eJg/msCANomtu/nEeSgTFXV+jWOCtzfuKzpzBEqA2kQkGERxJoec
   R2BtWo6gJRohaEIAtDdyWqaEXlHK2tO8pCiKzFQ8WmImdmJSdLPl6diJc
   IkIKyBBzLwWhSPCa+IaCJddcnCATuFb16DeHgnVHH4h/DNinz2L2mmuMG
   w==;
X-CSE-ConnectionGUID: danR8CSfSgOombLwM0lPPQ==
X-CSE-MsgGUID: LI4Y/94SRcqGpfYTzQgmKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80960079"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80960079"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:17:00 -0700
X-CSE-ConnectionGUID: VJ9zaNiCStawTc4KACEJmQ==
X-CSE-MsgGUID: 7+S3R1z3TgqqZGIbpj4KYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247717214"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2026 12:16:59 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSgDx-000000006M2-0Dcj;
	Thu, 28 May 2026 19:16:57 +0000
Date: Fri, 29 May 2026 03:16:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 e6ff30150738af5c7aa20fad08b74cbf9b86d3a2
Message-ID: <202605290314.CRYzutFm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: e6ff30150738af5c7aa20fad08b74cbf9b86d3a2  NTB: epf: Implement db_vector_count/mask for doorbells

elapsed time: 1631m

configs tested: 183
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260528    clang-23
arc                   randconfig-002-20260528    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260528    clang-23
arm                   randconfig-002-20260528    clang-23
arm                   randconfig-003-20260528    clang-23
arm                   randconfig-004-20260528    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260528    gcc-15.2.0
arm64                 randconfig-002-20260528    gcc-15.2.0
arm64                 randconfig-003-20260528    gcc-15.2.0
arm64                 randconfig-004-20260528    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260528    gcc-15.2.0
csky                  randconfig-002-20260528    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260528    gcc-11.5.0
hexagon               randconfig-002-20260528    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260528    clang-20
i386        buildonly-randconfig-002-20260528    clang-20
i386        buildonly-randconfig-003-20260528    clang-20
i386        buildonly-randconfig-004-20260528    clang-20
i386        buildonly-randconfig-005-20260528    clang-20
i386        buildonly-randconfig-006-20260528    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260528    gcc-14
i386                  randconfig-002-20260528    gcc-14
i386                  randconfig-003-20260528    gcc-14
i386                  randconfig-004-20260528    gcc-14
i386                  randconfig-005-20260528    gcc-14
i386                  randconfig-006-20260528    gcc-14
i386                  randconfig-007-20260528    gcc-14
i386                  randconfig-011-20260528    clang-20
i386                  randconfig-012-20260528    clang-20
i386                  randconfig-013-20260528    clang-20
i386                  randconfig-014-20260528    clang-20
i386                  randconfig-015-20260528    clang-20
i386                  randconfig-016-20260528    clang-20
i386                  randconfig-017-20260528    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260528    gcc-11.5.0
loongarch             randconfig-002-20260528    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260528    gcc-11.5.0
nios2                 randconfig-002-20260528    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    clang-23
parisc                randconfig-001-20260528    clang-23
parisc                         randconfig-002    clang-23
parisc                randconfig-002-20260528    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    clang-23
powerpc               randconfig-001-20260528    clang-23
powerpc                        randconfig-002    clang-23
powerpc               randconfig-002-20260528    clang-23
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260528    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260528    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260528    gcc-13.4.0
riscv                 randconfig-002-20260528    gcc-13.4.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260528    gcc-13.4.0
s390                  randconfig-002-20260528    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260528    gcc-13.4.0
sh                    randconfig-002-20260528    gcc-13.4.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-15.2.0
sparc                 randconfig-001-20260528    gcc-15.2.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260528    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-15.2.0
sparc64               randconfig-001-20260528    gcc-15.2.0
sparc64                        randconfig-002    gcc-15.2.0
sparc64               randconfig-002-20260528    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-15.2.0
um                    randconfig-001-20260528    gcc-15.2.0
um                             randconfig-002    gcc-15.2.0
um                    randconfig-002-20260528    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260528    gcc-14
x86_64      buildonly-randconfig-002-20260528    gcc-14
x86_64      buildonly-randconfig-003-20260528    gcc-14
x86_64      buildonly-randconfig-004-20260528    gcc-14
x86_64      buildonly-randconfig-005-20260528    gcc-14
x86_64      buildonly-randconfig-006-20260528    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260528    gcc-14
x86_64                randconfig-002-20260528    gcc-14
x86_64                randconfig-003-20260528    gcc-14
x86_64                randconfig-004-20260528    gcc-14
x86_64                randconfig-005-20260528    gcc-14
x86_64                randconfig-006-20260528    gcc-14
x86_64                randconfig-011-20260528    gcc-14
x86_64                randconfig-012-20260528    gcc-14
x86_64                randconfig-013-20260528    gcc-14
x86_64                randconfig-014-20260528    gcc-14
x86_64                randconfig-015-20260528    gcc-14
x86_64                randconfig-016-20260528    gcc-14
x86_64                randconfig-071-20260528    gcc-14
x86_64                randconfig-072-20260528    gcc-14
x86_64                randconfig-073-20260528    gcc-14
x86_64                randconfig-074-20260528    gcc-14
x86_64                randconfig-075-20260528    gcc-14
x86_64                randconfig-076-20260528    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-15.2.0
xtensa                randconfig-001-20260528    gcc-15.2.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260528    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
