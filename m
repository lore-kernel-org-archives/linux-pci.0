Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9333FF8A7
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197361; cv=none; b=guJL9JLUi6JOU1TsGRaW+yaIXJsFJvtjtneIWDfOWRRgnvUoPdBHg/F3k/bwMXNtFJ24phuM5Xb3/rxrKVbu341Q33vZHG0LrZfwHK3sXvxCxct7Je64YxkrODy38n5eyc7nHIQqdFdfTLLtecDkwrNErswU6A8KQZ75OZV/52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197361; c=relaxed/simple;
	bh=7Ulpr/0C7px+6+xkvSLo9YWFzJlpcrpY/4+42y1UDzs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PcPyh/odHumyhPj+oqmJ/SdZWPZhHj+5p7c++iRCnIcvtOnfrEXkvW1Yb4xt1lKyS6OhxYmOBw6JcUit4fkjFjW1dsziv6HwNPF2/RbyXNiVSg4i6HD5FqXLoqjx844KOxadTGpmlhVTzSDWH+AOz3U32iMNjmoGvNbzN8YpR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJEMKXN0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJEMKXN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784197360; x=1815733360;
  h=date:from:to:cc:subject:message-id;
  bh=7Ulpr/0C7px+6+xkvSLo9YWFzJlpcrpY/4+42y1UDzs=;
  b=fJEMKXN0U4nId/paulMsg7hEZFdwm5UefIUWOWdXu2fhS9jPaNUJ3OtC
   +H7WadVgKDLAtu9JkdzNMEOOopiRB35J186JRBvdBMlYcx4yYs/vggOGZ
   0S093mGuFJJG/Ei7xTK+2MOL5hV8JK70UMNzlFqZloryelzj2n3GsVrL+
   I9LlISGA1cwoKZhAGIQRd1WcIqxKs+9xWRbtSE1c+xMGVr/Z2SNe/xGzt
   27SRTCAAp9qghXlhz/S11aIENqtBdzl8YXyyqfRaEvgRMmox5ViX9Ul6q
   Az1wHPIdOYsGS93Mf5Gm+waN18Zd078n7DoQGfl595Km2EXYXiC3eB+ZW
   Q==;
X-CSE-ConnectionGUID: yM2/EqlcTCKvx4+3kDjxBg==
X-CSE-MsgGUID: P5vR78/6RHyMwlhhSuay6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96367853"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96367853"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:22:39 -0700
X-CSE-ConnectionGUID: kF2a9CWkTDeEfpHmfB1bkA==
X-CSE-MsgGUID: XwFyN6NkTn6PzBDm9UaAUw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2026 03:22:38 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkJEe-00000000Og8-3T64;
	Thu, 16 Jul 2026 10:22:33 +0000
Date: Thu, 16 Jul 2026 18:22:11 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 068601b547da091d9f56131cbb25e40ad40f4825
Message-ID: <202607161800.Za2aHkvx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: 068601b547da091d9f56131cbb25e40ad40f4825  dt-bindings: PCI: mediatek-gen3: Add support for MT8189 SoC

elapsed time: 1139m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
alpha                     defconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                     allnoconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
arc                       defconfig    gcc-16.1.0
arc         randconfig-001-20260716    gcc-14.3.0
arc         randconfig-002-20260716    gcc-16.1.0
arm                     allnoconfig    clang-17
arm                    allyesconfig    gcc-16.1.0
arm                       defconfig    clang-23
arm         randconfig-001-20260716    gcc-8.5.0
arm         randconfig-002-20260716    clang-17
arm         randconfig-003-20260716    gcc-12.5.0
arm         randconfig-004-20260716    clang-23
arm64                  allmodconfig    clang-23
arm64                   allnoconfig    gcc-16.1.0
arm64                     defconfig    gcc-16.1.0
arm64       randconfig-001-20260716    clang-23
arm64       randconfig-002-20260716    clang-22
arm64       randconfig-003-20260716    clang-23
arm64       randconfig-004-20260716    gcc-12.5.0
csky                   allmodconfig    gcc-16.1.0
csky                    allnoconfig    gcc-16.1.0
csky                      defconfig    gcc-16.1.0
csky        randconfig-001-20260716    gcc-12.5.0
csky        randconfig-002-20260716    gcc-14.3.0
hexagon                allmodconfig    clang-23
hexagon                 allnoconfig    clang-23
hexagon                   defconfig    clang-24
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386                      defconfig    clang-22
i386                 randconfig-001    clang-22
i386        randconfig-001-20260716    clang-22
i386                 randconfig-002    gcc-14
i386        randconfig-002-20260716    clang-22
i386                 randconfig-003    gcc-14
i386        randconfig-003-20260716    gcc-14
i386                 randconfig-004    clang-22
i386        randconfig-004-20260716    gcc-14
i386                 randconfig-005    gcc-14
i386        randconfig-005-20260716    clang-22
i386                 randconfig-006    gcc-14
i386        randconfig-006-20260716    clang-22
i386                 randconfig-007    gcc-14
i386        randconfig-007-20260716    clang-22
i386        randconfig-011-20260716    clang-22
i386        randconfig-012-20260716    gcc-12
i386        randconfig-013-20260716    clang-22
i386        randconfig-014-20260716    gcc-12
i386        randconfig-015-20260716    clang-22
i386        randconfig-016-20260716    gcc-14
i386        randconfig-017-20260716    clang-22
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-20
loongarch                 defconfig    clang-23
m68k                   allmodconfig    gcc-16.1.0
m68k                    allnoconfig    gcc-16.1.0
m68k                   allyesconfig    gcc-16.1.0
m68k                      defconfig    gcc-16.1.0
microblaze              allnoconfig    gcc-16.1.0
microblaze             allyesconfig    gcc-16.1.0
microblaze                defconfig    gcc-16.1.0
mips                   allmodconfig    gcc-16.1.0
mips                    allnoconfig    gcc-16.1.0
mips                   allyesconfig    gcc-16.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-16.1.0
openrisc                allnoconfig    gcc-16.1.0
openrisc                  defconfig    gcc-16.1.0
parisc                 allmodconfig    gcc-16.1.0
parisc                  allnoconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
parisc      randconfig-001-20260716    gcc-15.2.0
parisc      randconfig-002-20260716    gcc-8.5.0
parisc64                  defconfig    gcc-16.1.0
powerpc                allmodconfig    gcc-16.1.0
powerpc                 allnoconfig    gcc-16.1.0
powerpc     randconfig-001-20260716    clang-21
powerpc     randconfig-002-20260716    clang-19
powerpc64   randconfig-001-20260716    clang-22
powerpc64   randconfig-002-20260716    clang-23
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-16.1.0
riscv                  allyesconfig    clang-23
riscv                     defconfig    clang-23
s390                   allmodconfig    clang-23
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-16.1.0
s390                      defconfig    clang-18
sh                     allmodconfig    gcc-16.1.0
sh                      allnoconfig    gcc-16.1.0
sh                     allyesconfig    gcc-16.1.0
sh                        defconfig    gcc-16.1.0
sparc                   allnoconfig    gcc-16.1.0
sparc                     defconfig    gcc-16.1.0
sparc       randconfig-001-20260716    gcc-13.4.0
sparc       randconfig-002-20260716    gcc-11.5.0
sparc64                allmodconfig    clang-20
sparc64                   defconfig    clang-23
sparc64     randconfig-001-20260716    clang-23
sparc64     randconfig-002-20260716    clang-23
um                     allmodconfig    clang-17
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um          randconfig-001-20260716    clang-23
um          randconfig-002-20260716    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-22
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-22
x86_64                    defconfig    gcc-14
x86_64      randconfig-011-20260716    clang-22
x86_64      randconfig-012-20260716    clang-22
x86_64      randconfig-013-20260716    gcc-14
x86_64      randconfig-014-20260716    clang-22
x86_64      randconfig-015-20260716    clang-22
x86_64      randconfig-016-20260716    gcc-14
x86_64                rhel-9.4-rust    clang-22
xtensa                  allnoconfig    gcc-16.1.0
xtensa                 allyesconfig    gcc-16.1.0
xtensa      randconfig-001-20260716    gcc-9.5.0
xtensa      randconfig-002-20260716    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
