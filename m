Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309532;
	b=3JpJM//XYfudsn731fEMlfXLSWvZqRiAq5ozjdVFT766Hmb+88abswzCd66c86y0fX0/
	 LqQBtqPAamNxHNCML8zrod9aJa56/6lzmlwQI+M8LNFr8AyxdKMqoqID9ulBZz0CjsHpm
	 DT1ydGUDm+DuuP9/iwHCElA/fNi6SzccXXsXcqW5vOxBc6ln2qj/sC4VUadj47AWd/tON
	 /AVUyLtM9gAI/un9SCf8RRRD/wVQujG+pQHvl1x+VW5jhlkf4c9ZiEz5lusfZ4vC9EXnP
	 8YiGliYPHuL+DeQcz+EJwwdPPfNtyfcBpWyf0Pnv2KXnlxJx6dcloRLknSooDJwYhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309532;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=xEbd/pb+bNc0bXJyilmOZXmCsj8ZyLWTiS7RVtM3qgs=;
	b=KF/hetA5Dw/FBS6ARbL9QoWArw2oRy/sPf8Lgcgiykw2PLWlPSEtrRgliFIXueJluxV3
	 XGjqwvel7NJ4JIsHnckrPorT46BO0/D9Ern1rcyR0698JKqO8/dphQWZ57gLpe9NNs6CT
	 6OyDKxRT76CsYjv1v2969TtkoltylMlusNzVGJ5FN06jIk2taUZp4pVrTNm0ScuVmXTdK
	 ZMft0XGFP1BoFfZS2YZb1Q1xKDl5tincSw0zuGqLr2SZdtTEnlVbWVpEVBU8cf3DYViMa
	 Ixaf17YtTCe8FdttHb6kEXZgxUWw41y1gpNeZK8xnr3IrKRUA375hScidphB7IRhBNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKrNJW4T;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A0606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 11:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKrNJW4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794309532; x=1825845532;
  h=date:from:to:cc:subject:message-id;
  bh=PLuJAEML15g2ph23RgQU1VdtHn6U5SMI/4jFBUEzQUE=;
  b=CKrNJW4Ta0xy3NZBpUUlc1GEi/nsdszHaJfeCPnbmSRiUEij9rFYWb3h
   YVcOzzrU5VZuGBl2lcFUGPJmwpS18tAPLcHRy6EcGh7Eqlg7uMZEEy8d6
   xoIfN8gGiHYoAeq9/3ifBM4/rMjjsW9OF76xPtbWhaogSnAzIGZmRkQHu
   tf6HYFkirlQ3V/QItglHMNK9ekg7SLKHF1vGmwTc/+THVnxY1wvkjIxCh
   bMv7u58rIUwTeu93ClBnvz75eC2xfe+nzXicvsA2xhzBuqnZ9DqftPwkf
   ze1AJNxIbmd0mjvNU/jWx5RCD0kdK8q6bqNQff/3JIbiNZnxNUBMdbWJ2
   w==;
X-CSE-ConnectionGUID: oiCwPoK0SUe3kVFi/mCBaw==
X-CSE-MsgGUID: kynJxHhhTFWyylt0I7P4UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3077002"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3077002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:18:51 -0800
X-CSE-ConnectionGUID: GsBVP3SSQa6yEu9VDwDjVg==
X-CSE-MsgGUID: jS6Wy4qYR++VdeDHscJW6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7994124"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Nov 2026 03:18:50 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQjsF-00000000whr-3jfc;
	Tue, 10 Nov 2026 11:18:47 +0000
Date: Tue, 10 Nov 2026 19:18:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 6633c535abc356ff868e72025ecd65aa0106630d
Message-ID: <20261110191805.8u3ApNvo-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 6633c535abc356ff868e72025ecd65aa0106630d  Merge branch 'pci/controller/vmd'

elapsed time: 782m

configs tested: 184
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261110    gcc-10.5.0
arc                   randconfig-1001-20261110    gcc-10.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       jornada720_defconfig    clang-24
arm                          mv78xx0_defconfig    clang-24
arm                   randconfig-1000-20261110    gcc-10.5.0
arm                   randconfig-1001-20261110    gcc-10.5.0
arm                   randconfig-1002-20261110    gcc-10.5.0
arm                   randconfig-1003-20261110    gcc-10.5.0
arm                         shmobile_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261110    gcc-12.5.0
arm64                 randconfig-1001-20261110    gcc-12.5.0
arm64                 randconfig-1002-20261110    gcc-12.5.0
arm64                 randconfig-1003-20261110    gcc-12.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261110    gcc-12.5.0
csky                  randconfig-1001-20261110    gcc-12.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261110    clang-17
hexagon               randconfig-1001-20261110    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261110    clang-22
i386        buildonly-randconfig-1001-20261110    clang-22
i386        buildonly-randconfig-1002-20261110    clang-22
i386        buildonly-randconfig-1003-20261110    clang-22
i386        buildonly-randconfig-1004-20261110    clang-22
i386        buildonly-randconfig-1005-20261110    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1007-20261110    clang-22
i386                  randconfig-1008-20261110    clang-22
i386                  randconfig-1009-20261110    clang-22
i386                  randconfig-1010-20261110    clang-22
i386                  randconfig-1011-20261110    clang-22
i386                  randconfig-1012-20261110    clang-22
i386                  randconfig-1013-20261110    clang-22
loongarch                         alldefconfig    clang-24
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261110    clang-17
loongarch             randconfig-1001-20261110    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         m5307c3_defconfig    clang-24
m68k                         stmark2_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-24
mips                            ci20_defconfig    clang-24
mips                      eyeq6lplus_defconfig    clang-24
mips                             gpr_defconfig    clang-24
mips                            jazz_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261110    clang-17
nios2                 randconfig-1001-20261110    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc          de0_nano_multicore_defconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261110    gcc-14.4.0
parisc                randconfig-1001-20261110    gcc-14.4.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                         cell_defconfig    clang-24
powerpc                       mgcoge_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-1000-20261110    gcc-14.4.0
powerpc               randconfig-1001-20261110    gcc-14.4.0
powerpc                   storcenter_defconfig    clang-24
powerpc                         warp_defconfig    clang-24
powerpc64             randconfig-1000-20261110    gcc-14.4.0
powerpc64             randconfig-1001-20261110    gcc-14.4.0
riscv                             alldefconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_k210_defconfig    clang-24
riscv                 randconfig-1000-20261110    clang-24
riscv                 randconfig-1001-20261110    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261110    clang-24
s390                  randconfig-1001-20261110    clang-24
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261110    clang-24
sh                    randconfig-1001-20261110    clang-24
sh                   sh7785lcr_32bit_defconfig    clang-24
sh                             shmin_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261110    gcc-12.5.0
sparc                 randconfig-1001-20261110    gcc-12.5.0
sparc                        sparc64_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261110    gcc-12.5.0
sparc64               randconfig-1001-20261110    gcc-12.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261110    gcc-12.5.0
um                    randconfig-1001-20261110    gcc-12.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261110    gcc-14
x86_64      buildonly-randconfig-1001-20261110    gcc-14
x86_64      buildonly-randconfig-1002-20261110    gcc-14
x86_64      buildonly-randconfig-1003-20261110    gcc-14
x86_64      buildonly-randconfig-1004-20261110    gcc-14
x86_64      buildonly-randconfig-1005-20261110    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261110    gcc-14
x86_64                randconfig-1001-20261110    gcc-14
x86_64                randconfig-1002-20261110    gcc-14
x86_64                randconfig-1003-20261110    gcc-14
x86_64                randconfig-1004-20261110    gcc-14
x86_64                randconfig-1005-20261110    gcc-14
x86_64                randconfig-1006-20261110    gcc-14
x86_64                randconfig-1007-20261110    gcc-14
x86_64                randconfig-1008-20261110    gcc-14
x86_64                randconfig-1009-20261110    gcc-14
x86_64                randconfig-1010-20261110    gcc-14
x86_64                randconfig-1011-20261110    gcc-14
x86_64                randconfig-1012-20261110    gcc-14
x86_64                randconfig-1013-20261110    gcc-14
x86_64                randconfig-1014-20261110    gcc-14
x86_64                randconfig-1015-20261110    gcc-14
x86_64                randconfig-1016-20261110    gcc-14
x86_64                randconfig-1017-20261110    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261110    gcc-12.5.0
xtensa                randconfig-1001-20261110    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
