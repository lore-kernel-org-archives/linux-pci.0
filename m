Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235043AB0
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684799; cv=none; b=DHvMUFCyswPGvYAi56Zxu3jBj7SUWxZcxf5elGFCSqO+ZwMzkjyp0vgBQK6of7rdt5KQH1d0kACVe638a2zP7krXa7IVUJ6uCKvzYDVcwB6260XVtoJpTX/EiiUzJOatatfJa2103uGQFCJUo0FlcVNDhiMo8tU1IAZLHlABq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684799; c=relaxed/simple;
	bh=/j9XnfnEREQBxhP2RiRRqNZ/Exqaqa72TPN5QES4m6s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gUfu+0B/I9/wKITENI8qZF8jFwSicordLgVtDByX2y2E7i8px1qCcQ/4heILPBGrLELUK8no8gdUqmlIQoZV6esY89w2Sr8WE3CkCCkvEVcvfCJEQyFMpBV+rXZSj+z1wBX2BQIsu6ubQv+QZREkrleXbjn00ut0RMBi3MHPi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bASdFqDj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bASdFqDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786684797; x=1818220797;
  h=date:from:to:cc:subject:message-id;
  bh=/j9XnfnEREQBxhP2RiRRqNZ/Exqaqa72TPN5QES4m6s=;
  b=bASdFqDjHQ4+aurqn+BYI2hp7qo5YgKcWtsBMcarlmwUmnjtml2ybeD7
   Ba2kp+C06Dw8unRMDy/HwSXiKBeL8rSVSWwMtABKyLCjYFwrRYjwEEHAu
   +0gCcrbvuwcckbot9kV4VR9wRTsLcwNcraK+9DzTo7y+I8QkuWjiXqZn4
   zMICF4FlIH3iBZSlP6ZO3E0+Vpde9gxy7v1WnBOEeDLfdA06oUHeBjfSi
   eaaS444uIoawACBMqlwrjmN0sosPZImde1MK+7PvjpnEb49aix8oIyIpR
   vKyd7QY7X5KEkIzo7C/D11M4dWf9aQo2v7U4mjFagtfXZnqgeTGjsL7Au
   w==;
X-CSE-ConnectionGUID: zO05qLtDQFW4jqWbasEu1w==
X-CSE-MsgGUID: TeUsplLHTdWa/AF3xC7L1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97929344"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97929344"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 22:19:52 -0700
X-CSE-ConnectionGUID: vqhyZEDhSfqQW7hVVWVDGw==
X-CSE-MsgGUID: vnSk7GxhSamibxVTIumU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302370956"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Aug 2026 22:19:51 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wukKa-00000000XqA-3Myz;
	Fri, 14 Aug 2026 05:19:48 +0000
Date: Fri, 14 Aug 2026 13:18:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 d4c79b63d82d408c81f1629bcdc8cdbeebd85014
Message-ID: <202608141338.oA8eFcK7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: d4c79b63d82d408c81f1629bcdc8cdbeebd85014  PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms

elapsed time: 2516m

configs tested: 170
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-001-20260814    gcc-10.5.0
arc                  randconfig-002-20260813    gcc-13.4.0
arc                  randconfig-002-20260813    gcc-8.5.0
arc                  randconfig-002-20260814    gcc-10.5.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-001-20260813    gcc-8.5.0
arm                  randconfig-001-20260814    gcc-10.5.0
arm                  randconfig-002-20260813    clang-19
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-002-20260814    gcc-10.5.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-003-20260813    gcc-8.5.0
arm                  randconfig-003-20260814    gcc-10.5.0
arm                  randconfig-004-20260813    gcc-10.5.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm                  randconfig-004-20260814    gcc-10.5.0
arm                   vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                randconfig-001-20260813    clang-24
arm64                randconfig-001-20260813    gcc-16.1.0
arm64                randconfig-002-20260813    gcc-16.1.0
arm64                randconfig-002-20260813    gcc-8.5.0
arm64                randconfig-003-20260813    gcc-16.1.0
arm64                randconfig-003-20260813    gcc-9.5.0
arm64                randconfig-004-20260813    gcc-15.2.0
arm64                randconfig-004-20260813    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260813    gcc-16.1.0
csky                 randconfig-002-20260813    gcc-16.1.0
hexagon              randconfig-001-20260813    clang-24
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-002-20260813    clang-17
hexagon              randconfig-002-20260813    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260813    gcc-14
i386       buildonly-randconfig-001-20260814    clang-22
i386       buildonly-randconfig-002-20260813    clang-22
i386       buildonly-randconfig-002-20260813    gcc-14
i386       buildonly-randconfig-002-20260814    clang-22
i386       buildonly-randconfig-003-20260813    gcc-14
i386       buildonly-randconfig-003-20260814    clang-22
i386       buildonly-randconfig-004-20260813    gcc-14
i386       buildonly-randconfig-004-20260814    clang-22
i386       buildonly-randconfig-005-20260813    clang-22
i386       buildonly-randconfig-005-20260813    gcc-14
i386       buildonly-randconfig-005-20260814    clang-22
i386       buildonly-randconfig-006-20260813    gcc-12
i386       buildonly-randconfig-006-20260813    gcc-14
i386       buildonly-randconfig-006-20260814    clang-22
i386                 randconfig-001-20260813    gcc-14
i386                 randconfig-002-20260813    clang-22
i386                 randconfig-003-20260813    clang-22
i386                 randconfig-004-20260813    clang-22
i386                 randconfig-005-20260813    gcc-14
i386                 randconfig-006-20260813    clang-22
i386                 randconfig-007-20260813    clang-22
i386                 randconfig-011-20260813    clang-22
i386                 randconfig-012-20260813    clang-22
i386                 randconfig-013-20260813    clang-22
i386                 randconfig-014-20260813    clang-22
i386                 randconfig-015-20260813    clang-22
i386                 randconfig-016-20260813    clang-22
i386                 randconfig-017-20260813    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-001-20260813    gcc-16.1.0
loongarch            randconfig-002-20260813    gcc-11.5.0
loongarch            randconfig-002-20260813    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-10.5.0
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-001-20260813    gcc-12.5.0
parisc               randconfig-002-20260813    gcc-10.5.0
powerpc                   adder875_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-001-20260813    gcc-8.5.0
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc              randconfig-002-20260813    gcc-13.4.0
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260813    gcc-11.5.0
riscv                         randconfig-001    gcc-10.5.0
riscv                randconfig-001-20260813    clang-24
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-001-20260814    gcc-13.4.0
riscv                randconfig-002-20260813    gcc-10.5.0
riscv                randconfig-002-20260813    gcc-15.2.0
riscv                randconfig-002-20260814    gcc-13.4.0
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-001-20260813    gcc-8.5.0
s390                 randconfig-001-20260814    gcc-13.4.0
s390                 randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-002-20260814    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-001-20260813    gcc-11.5.0
sh                   randconfig-001-20260814    gcc-13.4.0
sh                   randconfig-002-20260813    gcc-10.5.0
sh                   randconfig-002-20260813    gcc-9.5.0
sh                   randconfig-002-20260814    gcc-13.4.0
sparc                         randconfig-001    clang-20
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-001-20260813    gcc-14.3.0
sparc                randconfig-001-20260814    clang-24
sparc                randconfig-002-20260813    clang-20
sparc                randconfig-002-20260813    gcc-8.5.0
sparc                randconfig-002-20260814    clang-24
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-001-20260813    clang-24
sparc64              randconfig-001-20260814    clang-24
sparc64              randconfig-002-20260813    clang-20
sparc64              randconfig-002-20260814    clang-24
um                   randconfig-001-20260813    clang-20
um                   randconfig-001-20260813    gcc-14
um                   randconfig-001-20260814    clang-24
um                   randconfig-002-20260813    clang-20
um                   randconfig-002-20260813    gcc-14
um                   randconfig-002-20260814    clang-24
x86_64     buildonly-randconfig-001-20260813    gcc-14
x86_64     buildonly-randconfig-002-20260813    clang-22
x86_64     buildonly-randconfig-003-20260813    gcc-14
x86_64     buildonly-randconfig-004-20260813    gcc-14
x86_64     buildonly-randconfig-005-20260813    gcc-14
x86_64     buildonly-randconfig-006-20260813    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260813    gcc-13
x86_64               randconfig-001-20260813    gcc-14
x86_64               randconfig-002-20260813    clang-22
x86_64               randconfig-002-20260813    gcc-13
x86_64               randconfig-003-20260813    clang-22
x86_64               randconfig-003-20260813    gcc-13
x86_64               randconfig-004-20260813    clang-22
x86_64               randconfig-004-20260813    gcc-13
x86_64               randconfig-005-20260813    gcc-13
x86_64               randconfig-006-20260813    clang-22
x86_64               randconfig-006-20260813    gcc-13
x86_64               randconfig-011-20260813    clang-22
x86_64               randconfig-012-20260813    gcc-14
x86_64               randconfig-013-20260813    clang-22
x86_64               randconfig-014-20260813    clang-22
x86_64               randconfig-015-20260813    gcc-14
x86_64               randconfig-016-20260813    clang-22
x86_64               randconfig-071-20260813    gcc-14
x86_64               randconfig-072-20260813    gcc-14
x86_64               randconfig-073-20260813    gcc-14
x86_64               randconfig-074-20260813    gcc-14
x86_64               randconfig-075-20260813    gcc-14
x86_64               randconfig-076-20260813    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-001-20260813    gcc-14.3.0
xtensa               randconfig-001-20260814    clang-24
xtensa               randconfig-002-20260813    clang-20
xtensa               randconfig-002-20260813    gcc-12.5.0
xtensa               randconfig-002-20260814    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
