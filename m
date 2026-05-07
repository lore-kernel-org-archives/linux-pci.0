Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD03F9F46
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161858; cv=none; b=dIxwv/lrNBWh87uvKwAB++TrmFzi6ksEHSb4PZR6A0GXoAXRlRxORmvrs6a16UiLZ6z2tV6Wx98WjbIL3EnCIj/1/MS1MXS6tq9KClangrEf0mmOmecisXt4SmYPLkGDhJeNEZnfESQc6Bw/qaYY+c6bOdCWqvpfIYrMFMG0Pgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161858; c=relaxed/simple;
	bh=A9tloqLO3MivRI8SWRtbw6IBEItXyRuvtNnEaNE+iKs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KoryE3IbMREAcY0tsrKldIXGBYdFtEX+lQ5+EvLQgrDE/yJBH3Wc7HfwRcDRrR7+UBjduC8DW4EinLBQMspwu4tUq6Y2AEigH6WsWXKh2wvmNZBc6vrDg7B7mLPvYFx2HpKZpQFqYigJ2B3P7j5ZJ2RMP73/OuWKLXADSrVySsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKptxliQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKptxliQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778161856; x=1809697856;
  h=date:from:to:cc:subject:message-id;
  bh=A9tloqLO3MivRI8SWRtbw6IBEItXyRuvtNnEaNE+iKs=;
  b=CKptxliQ8xNXHMSU3GVRrZobGb7MWrhvbKXYmad1B232z9Dpeney6h+x
   x3xYxfi8tuRL+ALMZczywev3vFWwJAWBF9iDpdCCUh8o8rzVAbDXJPOTU
   rVS3Q7LkybbrLqcTx+VpwAfNjf95Q+252J/mMLBZdFtGezN2XR4arU0Xg
   qW7ZSPbMYmYPoEWj6yuZBjNH0950RFVLQk3wGUToN09F6y5Q37LyZW0Jn
   CFg2X28S2F8Vmt8gYUTdf7Xrkv6kxABM4X2kCl4EsMXJeflxbyvVIccuK
   X1U9YtlXk75ZTBnC/uGjZaFkUv8dnAkIGQGw1TGRRvROwwm4P8buYlD0R
   A==;
X-CSE-ConnectionGUID: 8hUXpkhnTfSzdHK41pDaXg==
X-CSE-MsgGUID: +2dtKOn8RTG82krK5vyQTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79012215"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79012215"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:50:56 -0700
X-CSE-ConnectionGUID: +MWFXXd5QpaqrUOjH2VA6w==
X-CSE-MsgGUID: NBAAb0rYSZOpnzYyUjj31A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="235635646"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 May 2026 06:50:55 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKz7s-0000000007B-09Am;
	Thu, 07 May 2026 13:50:52 +0000
Date: Thu, 07 May 2026 21:50:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 cede9116c5e1572d38b9d357f35556d480867822
Message-ID: <202605072127.1tAgAcgp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: cede9116c5e1572d38b9d357f35556d480867822  PCI: Initialize temporary device in new_id_store()

elapsed time: 729m

configs tested: 104
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
alpha                     defconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    clang-23
arc                    allyesconfig    gcc-15.2.0
arc                       defconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                     allnoconfig    gcc-15.2.0
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                  allmodconfig    clang-23
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky                      defconfig    gcc-15.2.0
csky        randconfig-001-20260507    gcc-15.2.0
csky        randconfig-002-20260507    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                allmodconfig    gcc-15.2.0
hexagon                 allnoconfig    clang-23
hexagon                 allnoconfig    gcc-15.2.0
hexagon                   defconfig    clang-23
hexagon     randconfig-001-20260507    clang-23
hexagon     randconfig-002-20260507    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-15.2.0
i386                   allyesconfig    gcc-14
i386                      defconfig    clang-20
i386        randconfig-001-20260507    gcc-13
i386        randconfig-002-20260507    clang-20
i386        randconfig-003-20260507    gcc-14
i386        randconfig-004-20260507    gcc-14
i386        randconfig-005-20260507    gcc-14
i386        randconfig-006-20260507    gcc-14
i386        randconfig-007-20260507    clang-20
loongarch              allmodconfig    clang-19
loongarch              allmodconfig    clang-23
loongarch               allnoconfig    clang-23
loongarch               allnoconfig    gcc-15.2.0
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20260507    clang-23
loongarch   randconfig-002-20260507    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
m68k                      defconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
microblaze                defconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
mips              bcm47xx_defconfig    clang-18
nios2                  allmodconfig    clang-23
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    gcc-11.5.0
nios2       randconfig-001-20260507    gcc-9.5.0
nios2       randconfig-002-20260507    gcc-10.5.0
openrisc               allmodconfig    clang-23
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
openrisc                  defconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc                    defconfig    gcc-15.2.0
parisc64                  defconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv                     defconfig    clang-23
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390                      defconfig    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc                     defconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                     allyesconfig    gcc-15.2.0
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    clang-23
xtensa                 allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
