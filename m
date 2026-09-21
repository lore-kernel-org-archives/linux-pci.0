Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38261493D38
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992695; cv=none; b=tOWnR4IVe5J/RBJLRKqJPzu70Ai8YE6BxIYZDd7MvtSn+1MzGDw+yiuJ7MgnImQgPD3yboBjWtI2+APsUEvse34W3D/gl6WTzgrR5s2ZC5/34TuUvDkRfNyXKFO9Kdm/4sv+K9ggXmlPRBuxqJQBsAD+I29oV/Cm8ljntB/5MWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992695; c=relaxed/simple;
	bh=sJP9jk9aMoe7o5R9FiARm5DsLAxoVkj1RKilgBnNC/c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XiS3fyXcF98pkyjAvdY2RkDKYhmoEp5+x2lFxqc+zD/7uutHnXC5EWnl0WCv0Y834NEU66GGp9V4DhDK32T0VdN4UOE5BZj49PFG9HJRM559vlL6joUAYRXxudf62/3fuNKEgJ2GmQ0m9DvAWdMvpiv8KoM7cailWhlPH17vbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7IEhIqB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7IEhIqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789992693; x=1821528693;
  h=date:from:to:cc:subject:message-id;
  bh=sJP9jk9aMoe7o5R9FiARm5DsLAxoVkj1RKilgBnNC/c=;
  b=g7IEhIqBJwJzgDZOA/4j8wAVSXaHJlXZVtidgEd5DqpxK6Q+uIYqZ9Q0
   0T/Y7BjWqt5zl0J8xLED+vmXAr8iE3MfkdOmif3czOyDXVT5xHNKeExCr
   SQwDYDnpacwXneoZak2SzQVqO47Vml7Zmd5aKCY1pOIPiZF0gvWdFJymo
   G+6KU8RwznNdcZlS3Y5aUZDvrtD54PGiETyAefEX3hwkJbxJo7hD115AT
   TnbbDeUDRHG/8wq5xHZNLjHCX9TRI05h8k3KB43DJFHyqrH+AMmHZjOQm
   gFZj0q+S6/rrU94S0UugTY4Fxng/+6lKFg5gARLkq9iXVQc6ulVfJnqb6
   g==;
X-CSE-ConnectionGUID: /ulaTgSzTuuPMRiWbhWMkg==
X-CSE-MsgGUID: l4P1XLQfQK6tKAvg6V5mJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94325422"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="94325422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:11:32 -0700
X-CSE-ConnectionGUID: zJ84v6dFQFy9qVIln02Dpw==
X-CSE-MsgGUID: X2fOC+fWSSeLm0XZFt+JWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="300562322"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 Sep 2026 05:11:31 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x8cro-00000000DjD-495E;
	Mon, 21 Sep 2026 12:11:28 +0000
Date: Mon, 21 Sep 2026 20:11:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 c6d17c3a542095046bd3ae187e82fc5aeaa6e0fc
Message-ID: <202609212013.SKj6V8lZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: c6d17c3a542095046bd3ae187e82fc5aeaa6e0fc  Merge branch 'pci/misc'

elapsed time: 2706m

configs tested: 219
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20260918    clang-22
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260921    gcc-9.5.0
arc                   randconfig-1001-20260921    gcc-15.2.0
arc                  randconfig-r2107-20260918    clang-24
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm                      am200epdkit_defconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                   randconfig-1000-20260921    clang-24
arm                   randconfig-1001-20260921    gcc-13.4.0
arm                   randconfig-1002-20260921    gcc-15.2.0
arm                   randconfig-1003-20260921    clang-24
arm                  randconfig-r1300-20260921    clang-24   sparse
arm                            u8500_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260921    clang-24
arm64                 randconfig-1001-20260921    clang-24
arm64                 randconfig-1002-20260921    clang-24
arm64                 randconfig-1003-20260921    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260921    gcc-9.5.0
csky                  randconfig-1001-20260921    gcc-11.5.0
csky                 randconfig-r1306-20260921    gcc-10.5.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260921    clang-18
hexagon               randconfig-1001-20260921    clang-17
i386                               allnoconfig    gcc-14
i386        buildonly-randconfig-1000-20260920    clang-22
i386        buildonly-randconfig-1001-20260920    clang-22
i386        buildonly-randconfig-1002-20260920    clang-22
i386        buildonly-randconfig-1003-20260920    gcc-14
i386        buildonly-randconfig-1004-20260920    clang-22
i386        buildonly-randconfig-1005-20260920    clang-22
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260921    clang-22
i386                  randconfig-1001-20260921    clang-22
i386                  randconfig-1002-20260921    clang-22
i386                  randconfig-1003-20260921    gcc-14
i386                  randconfig-1004-20260921    gcc-13
i386                  randconfig-1005-20260921    clang-22
i386                  randconfig-1006-20260921    clang-22
i386                  randconfig-1007-20260921    gcc-14
i386                  randconfig-1008-20260921    clang-22
i386                  randconfig-1009-20260921    gcc-14
i386                  randconfig-1010-20260921    gcc-14
i386                  randconfig-1011-20260921    clang-22
i386                  randconfig-1012-20260921    clang-22
i386                  randconfig-1013-20260921    clang-22
i386                  randconfig-1300-20260921    clang-22   sparse
i386                  randconfig-1302-20260921    gcc-14     sparse
i386                  randconfig-2100-20260918    clang-22
i386                  randconfig-2101-20260918    clang-22
i386                  randconfig-2102-20260918    clang-22
i386                  randconfig-2103-20260918    clang-22
i386                  randconfig-2200-20260918    clang-22
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260921    clang-18
loongarch             randconfig-1001-20260921    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                         m5407c3_defconfig    gcc-16.1.0
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r1307-20260921    gcc-9.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r1309-20260921    gcc-9.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                 randconfig-r2202-20260918    gcc-15.2.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260921    gcc-8.5.0
nios2                 randconfig-1001-20260921    gcc-11.5.0
nios2                randconfig-r1308-20260921    gcc-10.5.0 sparse
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260921    gcc-8.5.0
parisc                randconfig-1001-20260921    gcc-13.4.0
parisc               randconfig-r1304-20260921    gcc-14.3.0 sparse
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc               randconfig-1000-20260921    clang-17
powerpc               randconfig-1001-20260921    clang-24
powerpc              randconfig-r2105-20260918    clang-24
powerpc64             randconfig-1000-20260921    gcc-10.5.0
powerpc64             randconfig-1001-20260921    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260921    gcc-12.5.0
riscv                 randconfig-1001-20260921    gcc-8.5.0
riscv                 randconfig-2000-20260918    gcc-13.4.0
riscv                 randconfig-2001-20260918    gcc-13.4.0
riscv                randconfig-r2102-20260918    clang-22
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260921    clang-24
s390                  randconfig-1001-20260921    clang-24
s390                  randconfig-2000-20260918    gcc-13.4.0
s390                  randconfig-2001-20260918    gcc-13.4.0
s390                        zfcpdump_defconfig    clang-22
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                           kfr2r09_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260921    gcc-9.5.0
sh                    randconfig-1001-20260921    gcc-16.1.0
sh                    randconfig-2000-20260918    gcc-13.4.0
sh                    randconfig-2001-20260918    gcc-13.4.0
sh                   randconfig-r1302-20260921    gcc-15.2.0 sparse
sh                   randconfig-r1305-20260921    gcc-13.4.0 sparse
sh                   randconfig-r2200-20260918    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260921    gcc-8.5.0
sparc                 randconfig-1001-20260921    gcc-11.5.0
sparc                 randconfig-2000-20260918    gcc-14
sparc                 randconfig-2001-20260918    gcc-14
sparc                randconfig-r1301-20260921    gcc-8.5.0  sparse
sparc                randconfig-r2104-20260918    clang-24
sparc                randconfig-r2106-20260918    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260921    clang-21
sparc64               randconfig-1001-20260921    clang-22
sparc64               randconfig-2000-20260918    gcc-14
sparc64               randconfig-2001-20260918    gcc-14
sparc64              randconfig-r2103-20260918    clang-22
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260921    gcc-14
um                    randconfig-1001-20260921    gcc-14
um                    randconfig-2000-20260918    gcc-14
um                    randconfig-2001-20260918    gcc-14
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260921    clang-22
x86_64      buildonly-randconfig-1001-20260921    gcc-13
x86_64      buildonly-randconfig-1002-20260921    clang-22
x86_64      buildonly-randconfig-1003-20260921    clang-22
x86_64      buildonly-randconfig-1004-20260921    clang-22
x86_64      buildonly-randconfig-1005-20260921    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260921    gcc-13
x86_64                randconfig-1001-20260921    clang-22
x86_64                randconfig-1002-20260921    gcc-14
x86_64                randconfig-1003-20260921    gcc-14
x86_64                randconfig-1004-20260921    clang-22
x86_64                randconfig-1005-20260921    clang-22
x86_64                randconfig-1006-20260921    gcc-14
x86_64                randconfig-1007-20260921    clang-22
x86_64                randconfig-1008-20260921    clang-22
x86_64                randconfig-1009-20260921    clang-22
x86_64                randconfig-1010-20260921    gcc-14
x86_64                randconfig-1011-20260921    clang-22
x86_64                randconfig-1012-20260921    clang-22
x86_64                randconfig-1013-20260921    clang-22
x86_64                randconfig-1014-20260921    clang-22
x86_64                randconfig-1015-20260921    clang-22
x86_64                randconfig-1016-20260921    clang-22
x86_64                randconfig-1017-20260921    gcc-12
x86_64                randconfig-1300-20260921    gcc-14     sparse
x86_64                randconfig-1301-20260921    clang-22   sparse
x86_64                randconfig-1302-20260921    clang-22   sparse
x86_64                randconfig-2100-20260918    clang-22
x86_64                randconfig-2101-20260918    clang-22
x86_64                randconfig-2102-20260918    clang-22
x86_64                randconfig-2103-20260918    clang-22
x86_64                randconfig-2200-20260918    gcc-14
x86_64               randconfig-r2100-20260918    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                            rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260921    gcc-11.5.0
xtensa                randconfig-1001-20260921    gcc-9.5.0
xtensa                randconfig-2000-20260918    gcc-14
xtensa                randconfig-2001-20260918    gcc-14
xtensa               randconfig-r1303-20260921    gcc-10.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
