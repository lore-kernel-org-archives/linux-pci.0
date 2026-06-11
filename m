Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1D40D57C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189448; cv=none; b=Np88/eDAb0e7UFx/o1HKYjzC2s2nD6bJf2Vw2W7ddbZngEjtNZnYQzqhz9kq6vDHIkpsz63py6zAowXTybrNTVsOoDssYDPlzwvEGYV1ME5N0N6VMJ9/rqYbkH5vYdSTMrPlQqN/bUyIsQKit53tcel0EJUbAz309VMrwHavCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189448; c=relaxed/simple;
	bh=HD1zoPXa/SYJh/zYSB+K1t+ttbZi4KJ1meViMldc1lo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sqXCyeSZgJmFKh1HHJ0ljHRkABAUmJpS4bNbk1Pd5HMRLvjIOGL9JxcECcICAvqcha+RjS+1+/cwZv0DTA6/2luJvHyi9fRVBvusp0LDrfWGT20PaHPD22GjHCpUECmILyAP7wjDCdIUjyGPA6FbwKQ3hCahTQhjTXd21uvh7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kI+Kxgt0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kI+Kxgt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781189447; x=1812725447;
  h=date:from:to:cc:subject:message-id;
  bh=HD1zoPXa/SYJh/zYSB+K1t+ttbZi4KJ1meViMldc1lo=;
  b=kI+Kxgt0kPWLkAQbVNkHr9TOiB8YcgK3GY+a908KkcPw6FtGWQmeEJZ5
   3MsLW2+oEy4LgnwkQ2ZmSRw5DAeN+Xd1H9wZZzYJ8cUcciVo6a4X1Pt/e
   bXMJ4aZcI9ozp9YCW5xZ+MM7f3i+S7giQr+RNrdkebvIvqyXapomAVefz
   fne9IS8YxnKAV9eoxhjKV/6xFkHXV4sq74RkBgahbPxkwC+51cS8KS4AE
   faSckfA/FCwVkqTmTzRkFWUSPlfdtT+NeQQ4MzrhdRjp2AcJ+4Wz6Jquh
   X/eHBJli2zgPfSi3IO7LhHlcrsigRz2r/yk+E43Tw2mpySclM2UB3mTch
   A==;
X-CSE-ConnectionGUID: mr+pnuv+TsS+7Txq5WUeJw==
X-CSE-MsgGUID: sykxP02RRzyPswWeuj5dnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81986625"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81986625"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:50:47 -0700
X-CSE-ConnectionGUID: On78mtVvQtOf2cZL1CzC1g==
X-CSE-MsgGUID: 8LtKwYXSSsGUKOQst7kwTQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2026 07:50:45 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXgjy-00000000NFW-239J;
	Thu, 11 Jun 2026 14:50:42 +0000
Date: Thu, 11 Jun 2026 22:49:58 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 d233626c009a515fb3ed823fcd78cee432701d1e
Message-ID: <202606112250.qQiLPI4F-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: d233626c009a515fb3ed823fcd78cee432701d1e  dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza compatible

elapsed time: 784m

configs tested: 245
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                        nsim_700_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-14.3.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                            randconfig-002    gcc-14.3.0
arc                   randconfig-002-20260611    gcc-14.3.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                           omap1_defconfig    gcc-16.1.0
arm                          pxa910_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-14.3.0
arm                   randconfig-001-20260611    gcc-14.3.0
arm                            randconfig-002    gcc-14.3.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                            randconfig-003    gcc-14.3.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260611    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260611    gcc-14.3.0
arm64                 randconfig-002-20260611    gcc-14.3.0
arm64                 randconfig-003-20260611    gcc-14.3.0
arm64                 randconfig-004-20260611    gcc-14.3.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260611    gcc-14.3.0
csky                  randconfig-002-20260611    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260611    clang-16
hexagon               randconfig-001-20260611    clang-17
hexagon               randconfig-002-20260611    clang-16
hexagon               randconfig-002-20260611    clang-17
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260611    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260611    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260611    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260611    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260611    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260611    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260611    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260611    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260611    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260611    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260611    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260611    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260611    gcc-14
i386                  randconfig-011-20260611    gcc-14
i386                  randconfig-012-20260611    gcc-14
i386                  randconfig-013-20260611    gcc-14
i386                  randconfig-014-20260611    gcc-14
i386                  randconfig-015-20260611    gcc-14
i386                  randconfig-016-20260611    gcc-14
i386                  randconfig-017-20260611    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260611    clang-16
loongarch             randconfig-001-20260611    clang-17
loongarch             randconfig-002-20260611    clang-16
loongarch             randconfig-002-20260611    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260611    clang-16
nios2                 randconfig-001-20260611    clang-17
nios2                 randconfig-002-20260611    clang-16
nios2                 randconfig-002-20260611    clang-17
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc                     tqm8540_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-12.5.0
riscv                 randconfig-001-20260611    gcc-12.5.0
riscv                          randconfig-002    gcc-12.5.0
riscv                 randconfig-002-20260611    gcc-12.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-12.5.0
s390                  randconfig-001-20260611    gcc-12.5.0
s390                           randconfig-002    gcc-12.5.0
s390                  randconfig-002-20260611    gcc-12.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-12.5.0
sh                    randconfig-001-20260611    gcc-12.5.0
sh                             randconfig-002    gcc-12.5.0
sh                    randconfig-002-20260611    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64               randconfig-002-20260611    gcc-15.2.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260611    gcc-15.2.0
um                    randconfig-002-20260611    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260611    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260611    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260611    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260611    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260611    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260611    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260611    clang-22
x86_64                randconfig-001-20260611    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260611    clang-22
x86_64                randconfig-002-20260611    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260611    clang-22
x86_64                randconfig-003-20260611    gcc-14
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260611    clang-22
x86_64                randconfig-004-20260611    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260611    clang-22
x86_64                randconfig-005-20260611    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260611    clang-22
x86_64                randconfig-006-20260611    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260611    clang-22
x86_64                randconfig-011-20260611    gcc-14
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260611    clang-22
x86_64                randconfig-012-20260611    gcc-14
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260611    clang-22
x86_64                randconfig-013-20260611    gcc-14
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260611    clang-22
x86_64                randconfig-014-20260611    gcc-14
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260611    clang-22
x86_64                randconfig-015-20260611    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260611    clang-22
x86_64                randconfig-016-20260611    gcc-14
x86_64                randconfig-071-20260611    clang-22
x86_64                randconfig-072-20260611    clang-22
x86_64                randconfig-073-20260611    clang-22
x86_64                randconfig-074-20260611    clang-22
x86_64                randconfig-075-20260611    clang-22
x86_64                randconfig-076-20260611    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                randconfig-002-20260611    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
