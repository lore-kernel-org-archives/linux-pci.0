Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D34175A99
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785819118; cv=none; b=TgwqboBcu+U6Wj9vE3svBRM4kI1BEwrcPRu/V4ze9HRYZ6DNg+Nkk9SrpRRvJIr09n/JyS/xdV/56nWAVBRpHbBQCg36QSNf2x7Q8dQUm45MLCp8BnKtWthwPI5a4lx26oliQFNQkMZKewUVNOtDlu4UTcjj7AzPmv8eLrKlCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785819118; c=relaxed/simple;
	bh=WhYGoYquhhIbO67klIR+dS+NBTpfxcKvuEGkz2x3wmw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r8TPLQAxcMOTESzegFSUXCxLFlBb+tnSnJk2rvR+6WQDVmXMApwshgZ1fUzafUW3V7Mycn7bclwX7TVKV4zpXY4B6eU9H61ULgwAUzc0ZE5hsCHFMsIOWGaSe7dYhtrqVnXyBT22/KMetjVRmCGYhs6nNpf2jWGkXURCuiCuW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrIkXhGc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrIkXhGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785819116; x=1817355116;
  h=date:from:to:cc:subject:message-id;
  bh=WhYGoYquhhIbO67klIR+dS+NBTpfxcKvuEGkz2x3wmw=;
  b=MrIkXhGcd36hIpb9NQBXa0MYu0SRNxZF7nCDFonwy4HpB1ybteJ5vnu6
   GN+l3ZHoppV7CubuR4Td7k4A9ezUBwGB3Y6mk/9+S6qXb9zixd9/I0uIA
   qecg3o11JCFNGBQSnf499Ux7KxSllHsCGzmx3X5/V7VS9yoIs5Op+GRzE
   qPqXIzZyVUPSDhZwTFtY65OcKuTFyUZpMehKBvUrQpm/fBs2PrWtCH/C3
   0xE1EPLdAauVHG3b6XG1AptrmY1XgYpiGhkNY41aiQU14jnLB6P0mqPlb
   coxRTSKzKPU7qk2BQFKihXsAi9JKFJAa8xlKg2dzKE8A6yprhSvbG3Bid
   g==;
X-CSE-ConnectionGUID: ymAGQBSfT4iDG/f7tioEEw==
X-CSE-MsgGUID: 2zL8FkVdTDux21ooyDyxLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86559222"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86559222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 21:51:55 -0700
X-CSE-ConnectionGUID: KvtBx/VfSlS2Ta1MhMKg+w==
X-CSE-MsgGUID: mdyIEE9vT7OSKUkzQvRV9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261992468"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Aug 2026 21:51:54 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr784-000000008xF-2ChC;
	Tue, 04 Aug 2026 04:51:52 +0000
Date: Tue, 04 Aug 2026 12:51:10 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 92bf60fbb80f94c1b0fc24c7ff67d7aee936a58c
Message-ID: <202608041257.z6DaOeu9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 92bf60fbb80f94c1b0fc24c7ff67d7aee936a58c  PCI: brcmstb: Reserve only the MSI vectors that are handed out

elapsed time: 736m

configs tested: 95
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-002-20260804    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260804    gcc-14
i386       buildonly-randconfig-002-20260804    gcc-14
i386       buildonly-randconfig-003-20260804    gcc-14
i386       buildonly-randconfig-004-20260804    gcc-14
i386       buildonly-randconfig-005-20260804    gcc-14
i386       buildonly-randconfig-006-20260804    gcc-14
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260804    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-002-20260804    gcc-16.1.0
m68k                         atari_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-002-20260804    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                          se7206_defconfig    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-002-20260804    gcc-16.1.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-002-20260804    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-006-20260804    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260804    clang-22
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260804    clang-22
x86_64               randconfig-072-20260804    clang-22
x86_64               randconfig-073-20260804    clang-22
x86_64               randconfig-074-20260804    clang-22
x86_64               randconfig-075-20260804    clang-22
x86_64               randconfig-076-20260804    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-002-20260804    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
