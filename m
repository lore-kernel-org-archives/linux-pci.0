Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E683E6382
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246958; cv=none; b=t//R+ZGSQIiAV6YbKanFzV/6xw+6GBspWO4LdKo9tG9/6edxcwBbI/hlrIpxHg83qgxXC+jeIEFYaecBDKtYEasjeIy2ZDaQoBIHPS1Q8CWLloZuQChuLOIVbHIfWvMmvbMZM7S4kKN6u5gAaCrLb5q2sV1UsKpDZjGlvDUYJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246958; c=relaxed/simple;
	bh=PINxONOAgQKaDaoG0glSi501OqehsK4HY9uiomhBv9I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oiC9mzGD55brFjwTDOm8Bt/tae2NcHgIQz06YcrYT6J88NT+QXEvkPmJkIJB1vqwJKJ6WkAyI8T852gnVNCL/a53U1aAAwgAQhVXhSg5N2MiCBD45D7G9+eKAK/r/PTDMk8MUwOLvN+r4E0j6KJByS45CY99K8VaOXEKtBRhGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSVBKH9h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSVBKH9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778246953; x=1809782953;
  h=date:from:to:cc:subject:message-id;
  bh=PINxONOAgQKaDaoG0glSi501OqehsK4HY9uiomhBv9I=;
  b=jSVBKH9hg6du7vrLxUz9r86B67u91JgUnHnGzijN4/o6k8wAXjW2by1G
   JcGEbG0gYWpITlFlAGRRt+zRXYFVX7gw3H+OdfGv6fcWTIfp+Nb1NSUqB
   T5GOxT9ZoyHd9Uok6FTejZHQv7JGi0MHBNT3O6Nuo8PqkjPP4JMtHu/rS
   xfe58XQotD7YIbIW3GMEOicq2d2HwS6wI2Cd8efLZYVb1A+HbCIYNZNX5
   VkHXrMoO561TPHoMgPKhA1/lAN9GwtvkHyZaBZr1EXlGojddirGvmP/uS
   UkxvixCowbyVhrqswBGeCe3X+Q4mprV5ixVV8fo6DVhum3AIkbYwXp3vf
   w==;
X-CSE-ConnectionGUID: Fz1hxI5NT3GvydWiITJHWQ==
X-CSE-MsgGUID: OGyN7h2ATuWZ6bJGlLwGjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90594452"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90594452"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:29:07 -0700
X-CSE-ConnectionGUID: IkzrDJ1BRAKnEaLxk4DBQA==
X-CSE-MsgGUID: Jn6sdDsfTZeOT/Z8tRtS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="238547382"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 May 2026 06:29:06 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLLGJ-000000000Ah-3FzZ;
	Fri, 08 May 2026 13:29:03 +0000
Date: Fri, 08 May 2026 21:28:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 e4715c055efcdfa6e5b5d0eaa01ff19505049ad7
Message-ID: <202605082129.tNXNLDJs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: e4715c055efcdfa6e5b5d0eaa01ff19505049ad7  Merge branch 'pci/misc'

elapsed time: 723m

configs tested: 121
configs skipped: 2

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
arc                   randconfig-001-20260508    gcc-13.4.0
arc                   randconfig-002-20260508    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260508    gcc-8.5.0
arm                   randconfig-002-20260508    gcc-10.5.0
arm                   randconfig-003-20260508    gcc-14.3.0
arm                   randconfig-004-20260508    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260508    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260508    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386        buildonly-randconfig-002-20260508    clang-20
i386        buildonly-randconfig-003-20260508    gcc-14
i386        buildonly-randconfig-004-20260508    clang-20
i386        buildonly-randconfig-005-20260508    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    clang-18
loongarch             randconfig-001-20260508    clang-23
loongarch                      randconfig-002    gcc-13.4.0
loongarch             randconfig-002-20260508    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260508    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260508    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-002-20260508    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260508    gcc-15.2.0
powerpc               randconfig-002-20260508    gcc-8.5.0
powerpc64             randconfig-001-20260508    clang-19
powerpc64             randconfig-002-20260508    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260508    gcc-12.5.0
sparc                 randconfig-002-20260508    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260508    gcc-8.5.0
sparc64               randconfig-002-20260508    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260508    gcc-12
um                    randconfig-002-20260508    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260508    gcc-14
x86_64                randconfig-013-20260508    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260508    gcc-14.3.0
xtensa                randconfig-002-20260508    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
