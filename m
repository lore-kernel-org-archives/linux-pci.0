Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDE4CA273
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044135; cv=none; b=iKG/FCW32Q9n2rVD78VhJjGVcoWkiP+Vezgn3mGHRZD/CNnD35iDgxJeNQKCvmu4dpzJkSv3gp6bva1Sd+SAzJ9keBgGzlewSLSefT+3aAoX8cToQSHUoQmcTzAPGith7yOxjdshIm713Bly1CS2GeZNoq+98Wp1u7zZKhIGcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044135; c=relaxed/simple;
	bh=38EqDnElI9QICLQrFcXXj3ILcrT1rsYTmwx80ij0h8I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JeEAuFspaYJTKR5m+RSnQ5GcGImvYgV4Wo0E1GzM+zwtmHv4md45U3FWbpxRLDt5ehAadBAHKKV0mgANhp42s9wJhVM/1VsbeX6tM5KbY2TnJPwVJLcLlY/mk790/yVkEDcyunmlGVmqo+2GPHB10fqTw9hE+ntrqm7U+jxne7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ML5x4DZj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ML5x4DZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786044130; x=1817580130;
  h=date:from:to:cc:subject:message-id;
  bh=38EqDnElI9QICLQrFcXXj3ILcrT1rsYTmwx80ij0h8I=;
  b=ML5x4DZjTOksE3Dr6OTE/LwWZxtJORYUCK2sQagYBMUOBBvd4eaUuof3
   rb9HsuQCTrfbnod721IeQrPvJ4gAjQ7GXsv5q2SG62HfDP0/6fPu4y8mZ
   ztFfOpoCXXNK9xBYBiwqnyC3YeHL5/1WhRis020qvuf5r5oHypRIj9pNT
   VU9lZz9/X3vrsRnvPjjk/LWOnoGlSumHC0Zur2ileNYxK+vcoGz2SQYiR
   VThjgbTvRjvBiglToY6FfrTNdSGtsdrTnOz019eKgyUEh1iLkKQ54DfG3
   HucB5bgm+fPulnhJL4YiTkSMuX746yWGkzZDvB0jfe96aPj0GZUatPxsQ
   g==;
X-CSE-ConnectionGUID: JpL3gRfnS9aUldCrLLNYXw==
X-CSE-MsgGUID: L7R/HYamTSOEgnC4ZlWyTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86659793"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86659793"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:22:08 -0700
X-CSE-ConnectionGUID: Mel/loHoRqSH5zQtI/U6Ng==
X-CSE-MsgGUID: p205eGXbSPeWNAbbeg6c5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286866735"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Aug 2026 12:22:07 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws3fI-00000000G1S-2KDt;
	Thu, 06 Aug 2026 19:22:04 +0000
Date: Fri, 07 Aug 2026 03:21:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/root-port-reset] BUILD SUCCESS
 29e179cb7f636dca79b047db3dd7f0e588fdba37
Message-ID: <202608070302.JwNK79Rx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/root-port-reset
branch HEAD: 29e179cb7f636dca79b047db3dd7f0e588fdba37  misc: pci_endpoint_test: Add AER error handlers

elapsed time: 1870m

configs tested: 131
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-004-20260806    gcc-13.4.0
arm64                randconfig-004-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-002-20260806    gcc-13.4.0
csky                 randconfig-002-20260807    gcc-16.1.0
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-002-20260806    clang-24
hexagon              randconfig-002-20260807    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    gcc-14
i386       buildonly-randconfig-004-20260806    gcc-14
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260806    clang-22
i386                 randconfig-002-20260806    clang-22
i386                 randconfig-003-20260806    clang-22
i386                 randconfig-004-20260806    clang-22
i386                 randconfig-005-20260806    clang-22
i386                 randconfig-006-20260806    clang-22
i386                 randconfig-007-20260806    clang-22
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-017-20260806    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-002-20260806    clang-24
loongarch            randconfig-002-20260807    clang-18
m68k                      m5208evb_defconfig    gcc-16.1.0
m68k                         sun3x_defconfig    gcc-16.1.0
mips                          xway_defconfig    clang-19
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-002-20260806    clang-24
nios2                randconfig-002-20260807    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-8.5.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260806    gcc-13.4.0
riscv                randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-002-20260807    gcc-12.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-002-20260806    gcc-13.4.0
sh                   randconfig-002-20260807    gcc-12.5.0
sh                         urquell_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260806    gcc-8.5.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-001-20260806    gcc-8.5.0
sparc64              randconfig-002-20260806    gcc-8.5.0
um                   randconfig-001-20260806    gcc-8.5.0
um                   randconfig-002-20260806    gcc-8.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-003-20260806    clang-22
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-006-20260806    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-012-20260806    clang-22
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-016-20260806    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-076-20260806    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260806    gcc-8.5.0
xtensa               randconfig-002-20260806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
