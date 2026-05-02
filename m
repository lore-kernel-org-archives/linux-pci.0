Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAF2741A0
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739667; cv=none; b=WvY2DVgYP9Pz+eN3/Kyf9+kNPJBALdsxmDzmGmtec2tj5aGENW1lU+QHv0fS5722JFce2HQbstUbKxSQWmPeik0uZvyBFWCNCFDFw0mL1jYO37+sKijtNAhkH/zCLUgj9af3VRK/xGCsCLRlj4wR4H/WXvH4tI9qLS9/lzutbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739667; c=relaxed/simple;
	bh=FBKMDvECAOjf2xmxa/Rx/LH2l0w/839Pme42NI9Kglg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HXyjV4aw0AgKoUu0cdPu0MHFsg3NW0qpwCxnDLHBJTH6yrjLYCAJOR7mKWkH0eSlmy1/lAb2lk9UCEouPywNni6v4Rv33KSRg60KvVOMjyvNeOC4f7fmGcGIgmcohU3cUghqHPi57ju80HJWlRdQXjqNOVyB3CTzH+fIVy0oXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWRNyVdW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWRNyVdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777739667; x=1809275667;
  h=date:from:to:cc:subject:message-id;
  bh=FBKMDvECAOjf2xmxa/Rx/LH2l0w/839Pme42NI9Kglg=;
  b=WWRNyVdW8WOb2BJG20Kn1wkXHXgXjNfC8J8RE4TM7rUVFo1st6JbKusz
   TQKoHGfVFK5DNFPSqK3UG1OTXKmPKQhe9eB5OfkTg51vzplgquyHb6/Qz
   1vb3xnRbZp+jdyk3ux5/bQmxbY+vCQ077OEyqXOqHIDEJLaBLSQG6WtFq
   e7wPwsa35HQCdE6bUjq1BBhKBtZs0DQU1eGwmOY55Bq1Na2mD+xTW48nd
   eRUcq5ynRJFiWRGFSw9BvyjGbvWa6hpxl21e04dO/3eE+R5EXFghz+A12
   WTWkI8JfvzPIHyBGycR6WXm7gpJaM0F115W2Wc5r9pJcZyLbApp3csX+P
   w==;
X-CSE-ConnectionGUID: WKe4WJF8Qrqky/jsA2FE1g==
X-CSE-MsgGUID: 7+fc6U+ZSWOsiD6juiSyfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="78598677"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="78598677"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 09:34:26 -0700
X-CSE-ConnectionGUID: wz6XNtSHR6q6kIYOvmvQjQ==
X-CSE-MsgGUID: yh4PUPV1TsKHXKM7Ep8gRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="235378092"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 May 2026 09:34:24 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJDIL-000000001aB-33pb;
	Sat, 02 May 2026 16:34:21 +0000
Date: Sun, 03 May 2026 00:34:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 64861f301c34a2ad6e0e843d2b6636d46deacd6e
Message-ID: <202605030058.gAApVVm5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 64861f301c34a2ad6e0e843d2b6636d46deacd6e  Merge branch 'pci/misc'

elapsed time: 4017m

configs tested: 205
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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260502    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260502    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260502    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260502    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260502    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260502    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260501    gcc-12.5.0
arm64                 randconfig-001-20260502    gcc-10.5.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260501    gcc-12.5.0
arm64                 randconfig-002-20260502    gcc-10.5.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260501    gcc-12.5.0
arm64                 randconfig-003-20260502    gcc-10.5.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260501    gcc-12.5.0
arm64                 randconfig-004-20260502    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260501    gcc-12.5.0
csky                  randconfig-001-20260502    gcc-10.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260501    gcc-12.5.0
csky                  randconfig-002-20260502    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260501    clang-23
hexagon               randconfig-001-20260502    clang-23
hexagon               randconfig-002-20260501    clang-23
hexagon               randconfig-002-20260502    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260502    gcc-14
i386        buildonly-randconfig-002-20260502    gcc-14
i386        buildonly-randconfig-003-20260502    gcc-14
i386        buildonly-randconfig-004-20260502    gcc-14
i386        buildonly-randconfig-005-20260502    gcc-14
i386        buildonly-randconfig-006-20260502    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-011-20260501    clang-20
i386                  randconfig-012-20260501    clang-20
i386                  randconfig-013-20260501    clang-20
i386                  randconfig-014-20260501    clang-20
i386                  randconfig-015-20260501    clang-20
i386                  randconfig-016-20260501    clang-20
i386                  randconfig-017-20260501    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260501    clang-23
loongarch             randconfig-001-20260502    clang-23
loongarch             randconfig-002-20260501    clang-23
loongarch             randconfig-002-20260502    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260501    clang-23
nios2                 randconfig-001-20260502    clang-23
nios2                 randconfig-002-20260501    clang-23
nios2                 randconfig-002-20260502    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-12.5.0
parisc                randconfig-001-20260501    gcc-12.5.0
parisc                randconfig-001-20260502    gcc-12.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260501    gcc-12.5.0
parisc                randconfig-002-20260502    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      ppc44x_defconfig    clang-23
powerpc                        randconfig-001    gcc-12.5.0
powerpc               randconfig-001-20260501    gcc-12.5.0
powerpc               randconfig-001-20260502    gcc-12.5.0
powerpc                        randconfig-002    gcc-12.5.0
powerpc               randconfig-002-20260501    gcc-12.5.0
powerpc               randconfig-002-20260502    gcc-12.5.0
powerpc64                      randconfig-001    gcc-12.5.0
powerpc64             randconfig-001-20260501    gcc-12.5.0
powerpc64             randconfig-001-20260502    gcc-12.5.0
powerpc64                      randconfig-002    gcc-12.5.0
powerpc64             randconfig-002-20260501    gcc-12.5.0
powerpc64             randconfig-002-20260502    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260502    gcc-14.3.0
riscv                 randconfig-002-20260502    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260502    gcc-14.3.0
s390                  randconfig-002-20260502    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260502    gcc-14.3.0
sh                    randconfig-002-20260502    gcc-14.3.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260502    gcc-8.5.0
sparc                 randconfig-002-20260502    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260502    gcc-8.5.0
sparc64               randconfig-002-20260502    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260502    gcc-8.5.0
um                    randconfig-002-20260502    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    clang-20
x86_64      buildonly-randconfig-001-20260502    clang-20
x86_64               buildonly-randconfig-002    clang-20
x86_64      buildonly-randconfig-002-20260502    clang-20
x86_64               buildonly-randconfig-003    clang-20
x86_64      buildonly-randconfig-003-20260502    clang-20
x86_64               buildonly-randconfig-004    clang-20
x86_64      buildonly-randconfig-004-20260502    clang-20
x86_64               buildonly-randconfig-005    clang-20
x86_64      buildonly-randconfig-005-20260502    clang-20
x86_64               buildonly-randconfig-006    clang-20
x86_64      buildonly-randconfig-006-20260502    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260502    clang-20
x86_64                randconfig-002-20260502    clang-20
x86_64                randconfig-003-20260502    clang-20
x86_64                randconfig-004-20260502    clang-20
x86_64                randconfig-005-20260502    clang-20
x86_64                randconfig-006-20260502    clang-20
x86_64                randconfig-071-20260501    gcc-14
x86_64                randconfig-071-20260502    gcc-14
x86_64                randconfig-072-20260501    gcc-14
x86_64                randconfig-072-20260502    gcc-14
x86_64                randconfig-073-20260501    gcc-14
x86_64                randconfig-073-20260502    gcc-14
x86_64                randconfig-074-20260501    gcc-14
x86_64                randconfig-074-20260502    gcc-14
x86_64                randconfig-075-20260501    gcc-14
x86_64                randconfig-075-20260502    gcc-14
x86_64                randconfig-076-20260501    gcc-14
x86_64                randconfig-076-20260502    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260502    gcc-8.5.0
xtensa                randconfig-002-20260502    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
