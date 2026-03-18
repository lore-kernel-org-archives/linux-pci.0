Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B73DEAD8
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845411; cv=none; b=lsEQXRShGmoz6VIb39pXSjWpNGor+yo9AcgfXkMqzSEK8+GoqALqOyNj7sewDfZA0ZuhOJwdSDq6do4pBzAOfiViv43e+ou/FlxYNvXCgKb3DaupDXxn93ML7Frm60ClPEZInn1poHv/5sqXp6FEauX7QdHdVgNdeW1H+jSKFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845411; c=relaxed/simple;
	bh=cJLb0CZfyBWJ+MdJbMJDc/fecFYe655s8nar4YA9Qxo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=m4cUu7C45YTW4s7hh5vUOEn7Mx9xkfXPmnJevgDmUWBCau38JZ1wfmapxB7HmLuyP1/wx5VhZNU2YkzmY1WysZYnnKzbyC4pg8cjIWM/znUxecVDW0xkQLVrxPOwNZG7QYiY372kRN9QmYu3AoCiP8jR+ZtXhLzf2HlLUu1nvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUztx+ng; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUztx+ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773845407; x=1805381407;
  h=date:from:to:cc:subject:message-id;
  bh=cJLb0CZfyBWJ+MdJbMJDc/fecFYe655s8nar4YA9Qxo=;
  b=mUztx+ngwJuMQsFfInTsYv4xeMlwkryptb1dmDyrew+9wc6morv5HSmb
   U/Fquy9bQei01CFBBu9QRXMv4BAQ1qYtF7ehsT2NcExgffxwHVLDEF2LF
   KDpvYbHqxJV8AmwSNLw9WWyer2bWcqsRwuhsM9CY1nv5+W5PbjcBSz2us
   FCo5iaG8KjCigNSaRuTfyrW8jhg61Ul5SVL7Rqey4eJC5CxqUImH9CBx2
   oQ2UYmv6M8wH7Or16KmcDHtPQt12xIQe6rWZLIe21ZBrtEv1xvgAYJ5pf
   +XQAtv6DGXCubfNa06hyLHdyLc+YO0s05wBsik7FBFe4nGaE2gV7PZMjr
   g==;
X-CSE-ConnectionGUID: wZDXxv/GQfCT0rAYadY5gg==
X-CSE-MsgGUID: t+XzBX/ASTGQzYLYVDgYNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92470751"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92470751"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:50:05 -0700
X-CSE-ConnectionGUID: oHq9TIbDQkmtcPcIP5zFOQ==
X-CSE-MsgGUID: sfVDRzVmSKWkqoTikf7ihw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222618519"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2026 07:50:04 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2sDh-0000000031J-1hbB;
	Wed, 18 Mar 2026 14:50:01 +0000
Date: Wed, 18 Mar 2026 22:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 702c1d56c7177a0481abd2814bab9495f1150967
Message-ID: <202603182212.c4PEmjFY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: 702c1d56c7177a0481abd2814bab9495f1150967  PCI/CXL: Hide SBR from reset_methods if masked by CXL

elapsed time: 1118m

configs tested: 192
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260318    gcc-8.5.0
arc                   randconfig-002-20260318    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                   randconfig-001-20260318    gcc-8.5.0
arm                   randconfig-002-20260318    gcc-8.5.0
arm                   randconfig-003-20260318    gcc-8.5.0
arm                   randconfig-004-20260318    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260318    clang-23
arm64                 randconfig-002-20260318    clang-23
arm64                 randconfig-003-20260318    clang-23
arm64                 randconfig-004-20260318    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260318    clang-23
csky                  randconfig-002-20260318    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260318    gcc-8.5.0
hexagon               randconfig-002-20260318    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260318    gcc-14
i386        buildonly-randconfig-002-20260318    gcc-14
i386        buildonly-randconfig-003-20260318    gcc-14
i386        buildonly-randconfig-004-20260318    gcc-14
i386        buildonly-randconfig-005-20260318    gcc-14
i386        buildonly-randconfig-006-20260318    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260318    gcc-14
i386                  randconfig-002-20260318    gcc-14
i386                  randconfig-003-20260318    gcc-14
i386                  randconfig-004-20260318    gcc-14
i386                  randconfig-005-20260318    gcc-14
i386                  randconfig-006-20260318    gcc-14
i386                  randconfig-007-20260318    gcc-14
i386                  randconfig-011-20260318    clang-20
i386                  randconfig-012-20260318    clang-20
i386                  randconfig-013-20260318    clang-20
i386                  randconfig-014-20260318    clang-20
i386                  randconfig-015-20260318    clang-20
i386                  randconfig-016-20260318    clang-20
i386                  randconfig-017-20260318    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260318    gcc-8.5.0
loongarch             randconfig-002-20260318    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260318    gcc-8.5.0
nios2                 randconfig-002-20260318    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260318    gcc-11.5.0
parisc                randconfig-002-20260318    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260318    gcc-11.5.0
powerpc               randconfig-002-20260318    gcc-11.5.0
powerpc                     tqm8548_defconfig    clang-23
powerpc64             randconfig-001-20260318    gcc-11.5.0
powerpc64             randconfig-002-20260318    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260318    gcc-15.2.0
riscv                 randconfig-002-20260318    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260318    gcc-15.2.0
s390                  randconfig-002-20260318    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260318    gcc-15.2.0
sh                    randconfig-002-20260318    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260318    gcc-13.4.0
sparc                 randconfig-002-20260318    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260318    gcc-13.4.0
sparc64               randconfig-002-20260318    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260318    gcc-13.4.0
um                    randconfig-002-20260318    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260318    gcc-14
x86_64      buildonly-randconfig-002-20260318    gcc-14
x86_64      buildonly-randconfig-003-20260318    gcc-14
x86_64      buildonly-randconfig-004-20260318    gcc-14
x86_64      buildonly-randconfig-005-20260318    gcc-14
x86_64      buildonly-randconfig-006-20260318    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260318    gcc-14
x86_64                randconfig-002-20260318    gcc-14
x86_64                randconfig-003-20260318    gcc-14
x86_64                randconfig-004-20260318    gcc-14
x86_64                randconfig-005-20260318    gcc-14
x86_64                randconfig-006-20260318    gcc-14
x86_64                randconfig-011-20260318    clang-20
x86_64                randconfig-012-20260318    clang-20
x86_64                randconfig-013-20260318    clang-20
x86_64                randconfig-014-20260318    clang-20
x86_64                randconfig-015-20260318    clang-20
x86_64                randconfig-016-20260318    clang-20
x86_64                randconfig-071-20260318    gcc-14
x86_64                randconfig-072-20260318    gcc-14
x86_64                randconfig-073-20260318    gcc-14
x86_64                randconfig-074-20260318    gcc-14
x86_64                randconfig-075-20260318    gcc-14
x86_64                randconfig-076-20260318    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260318    gcc-13.4.0
xtensa                randconfig-002-20260318    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
