Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61024374A1D
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043549; cv=none; b=DiCqvfPggGLVlCNmtUUMlx8gSQWM6tc/o4agqI8o6MPe90NC8eOTEJTI/7xehwbk5yydFhd2CC3OjaAWmpIGimJZTxjouKwUHQoJLMqmUhJ90qCQaO3N9FpYPY+d/HN0IkmaSVLd+WOt/XQbanZHl4zNsN4spdUBDeETjYNBOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043549; c=relaxed/simple;
	bh=v+OTZF+B79f8xlejqfxlSNMM08+RpDzbS9dtDbUYnSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G8Ip04qYOyKphCLHeeixESughjcP0QEEounmLmWSRvT9E8fKxl2iGe5Y8bLYuIx8HaIyuGhJsMYGYnicNZ1AXOzeI124BjDFyTKmWh5CUBe3ci4t5GXKQHrv+SCI2ENefGSGV/F5KuMasj2ZbikTvZSZ26Mf5l5pMvMXaYDMY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhipR536; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhipR536"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781043549; x=1812579549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v+OTZF+B79f8xlejqfxlSNMM08+RpDzbS9dtDbUYnSQ=;
  b=YhipR536TeSNi/Sq6jXQZxd3ogkDWPvGKCb6pKqLD/IUb8wyZkn2o2oM
   HrM83PSyvLBxuz+hMCdAVhXn8kSm1Tstngcg/PTx7slXMgInSidw9q5Yb
   vr0SvbF/HKj58JUScDgTUYKfPNPeTlIDRO93LTutFDCLQ5iU9SvU5rFBI
   52DR0d4GT1lFveBUjdk92GQSxiyJavXAg60titnl1OHU58brcf2ujusM5
   JUfO8xx81OmyXtdAtCWaOs0S+SdMQ0or6ha/2gdVFXXG4mrSCqx9uRkyl
   98MzPJsTXPIqgFsP1RcGTMq1c7qETmHG4V+q6ojsbn4OQfZjP0kdbcPS3
   A==;
X-CSE-ConnectionGUID: JvYPmICLTniOR7VU2ZpQzQ==
X-CSE-MsgGUID: cHqu5HDDTMGYX9o28jXYiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80957058"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="80957058"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 15:19:08 -0700
X-CSE-ConnectionGUID: xzFZfOLVS0SwmjKt/otdEg==
X-CSE-MsgGUID: 5QLfA3CKTsqLEke+KOcs6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="246017886"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jun 2026 15:19:07 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wX4mm-00000000Kbg-0337;
	Tue, 09 Jun 2026 22:19:04 +0000
Date: Wed, 10 Jun 2026 06:18:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-kernelci] BUILD SUCCESS
 6073579e0801aa35ea4f1e41e2180780719b3b23
Message-ID: <202606100649.5yOi2OUN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-kernelci
branch HEAD: 6073579e0801aa35ea4f1e41e2180780719b3b23  Merge branch 'misc'

elapsed time: 4282m

configs tested: 110
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260610    gcc-14
i386        buildonly-randconfig-002-20260610    gcc-14
i386        buildonly-randconfig-003-20260610    gcc-14
i386        buildonly-randconfig-004-20260610    gcc-14
i386        buildonly-randconfig-005-20260610    gcc-14
i386        buildonly-randconfig-006-20260610    gcc-14
i386                  randconfig-011-20260610    gcc-14
i386                  randconfig-012-20260610    gcc-14
i386                  randconfig-013-20260610    gcc-14
i386                  randconfig-014-20260610    gcc-14
i386                  randconfig-015-20260610    gcc-14
i386                  randconfig-016-20260610    gcc-14
i386                  randconfig-017-20260610    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260610    gcc-8.5.0
parisc                randconfig-002-20260610    gcc-8.5.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260610    gcc-8.5.0
powerpc               randconfig-002-20260610    gcc-8.5.0
powerpc64             randconfig-001-20260610    gcc-8.5.0
powerpc64             randconfig-002-20260610    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-16.1.0
riscv                 randconfig-001-20260610    gcc-16.1.0
riscv                          randconfig-002    gcc-16.1.0
riscv                 randconfig-002-20260610    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-16.1.0
s390                  randconfig-001-20260610    gcc-16.1.0
s390                           randconfig-002    gcc-16.1.0
s390                  randconfig-002-20260610    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260610    gcc-16.1.0
sh                             randconfig-002    gcc-16.1.0
sh                    randconfig-002-20260610    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-011-20260610    gcc-14
x86_64                randconfig-012-20260610    gcc-14
x86_64                randconfig-013-20260610    gcc-14
x86_64                randconfig-014-20260610    gcc-14
x86_64                randconfig-015-20260610    gcc-14
x86_64                randconfig-016-20260610    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
