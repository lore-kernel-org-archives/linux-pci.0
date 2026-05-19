Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C183769E8
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202128; cv=none; b=ojot87IJC8vN7JUi3Ywec+AOvOhBSYa8IyspLbnJmQFJNksGtX40ZRYDap91rZnEB/QP7i/QGRGX+xwF2vSJbJo7q3EolDP2w67v3lsN+BpvaC+FnMws41hvPZxs/rxpmzhtNFsWFXYQ6+KV6/DNzPgubT95sq1HF9pRQoxXXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202128; c=relaxed/simple;
	bh=5ckp5CDw3Qro/nvHoyDTCyW4g3cNgGap68MOutV7DNY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SO3JxL14pIrO1n0LaMzpyg1c6mYLhq/HCskwGzJdz96GSgucdPWpYa3TuTO4gHfbBcAEKu0mCLzHHE9LEajIM1YIiwK1qStkRs9J06xeLfrAt4qwHyWuBayNKPWt4Jd2VmsZj0rha28Swzfow9pLL5NWp0VVqU7472pwJrs7sL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQ2s/nyE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQ2s/nyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779202126; x=1810738126;
  h=date:from:to:cc:subject:message-id;
  bh=5ckp5CDw3Qro/nvHoyDTCyW4g3cNgGap68MOutV7DNY=;
  b=dQ2s/nyE/GZaPO3KJ1GoSVZixGtIK+pVPiPXRfIT6TSHqJjtoJo0asvf
   GBPEJrem6ZFdomjvtjY9X+UCdpZcr11Xm4JIufk3FuNsJYqFylPhe+CbC
   7DOeRbOECVYg+PhNlkNJ40es6WB5vf49gaTxEobX/5MCaSWj02afb5G6n
   Vhdn+VQcoHfPHTXNxanZ6DCCltz+1Udeg6ijFDlcIV45Vw/EubrJ5lmzi
   fgz2T8vuQfkrEjtP2bDanXdSlDthJq29LVlBAihp3lQ40Gqn+owsftjG6
   /Tvl3m8RlCPNgaYNBYbOnncdxpZ+vFhndwE9KOOWwvK/ToUii25VYaH6J
   A==;
X-CSE-ConnectionGUID: e1i85JYkRpuqSFVEGRIFGg==
X-CSE-MsgGUID: oCu1JmX3QaqI5vONfDGgXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91187987"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91187987"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:48:46 -0700
X-CSE-ConnectionGUID: MAIW5oEPSr+2JWsYHQDgfw==
X-CSE-MsgGUID: Knk9omPQTP6Eb5trkKEoTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233421739"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2026 07:48:44 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPLkP-000000001D5-3yFS;
	Tue, 19 May 2026 14:48:41 +0000
Date: Tue, 19 May 2026 22:40:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 b1ad4420983a1d8ddb0f770f6ed48d11b91d92aa
Message-ID: <202605192249.BNnIFFN7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: b1ad4420983a1d8ddb0f770f6ed48d11b91d92aa  Merge branch 'pci/misc'

elapsed time: 889m

configs tested: 294
configs skipped: 5

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
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260519    clang-23
arc                   randconfig-001-20260519    gcc-8.5.0
arc                   randconfig-001-20260519    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260519    clang-23
arc                   randconfig-002-20260519    gcc-10.5.0
arc                   randconfig-002-20260519    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-001-20260519    gcc-8.5.0
arm                            randconfig-002    gcc-11.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-002-20260519    gcc-8.5.0
arm                            randconfig-003    clang-20
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-003-20260519    gcc-8.5.0
arm                            randconfig-004    gcc-14.3.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260519    clang-23
arm                   randconfig-004-20260519    gcc-8.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    clang-18
arm64                 randconfig-001-20260519    gcc-8.5.0
arm64                 randconfig-002-20260519    gcc-11.5.0
arm64                 randconfig-002-20260519    gcc-8.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-12.5.0
csky                  randconfig-001-20260519    gcc-8.5.0
csky                  randconfig-002-20260519    gcc-11.5.0
csky                  randconfig-002-20260519    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    clang-17
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260519    clang-23
hexagon               randconfig-001-20260519    gcc-10.5.0
hexagon               randconfig-001-20260519    gcc-11.5.0
hexagon                        randconfig-002    clang-23
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260519    clang-23
hexagon               randconfig-002-20260519    gcc-10.5.0
hexagon               randconfig-002-20260519    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-12
i386        buildonly-randconfig-003-20260519    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-12
i386        buildonly-randconfig-005-20260519    gcc-12
i386        buildonly-randconfig-006-20260519    gcc-12
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260519    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260519    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260519    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260519    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260519    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260519    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260519    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260519    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260519    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260519    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260519    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260519    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260519    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    clang-18
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260519    clang-18
loongarch             randconfig-001-20260519    gcc-10.5.0
loongarch             randconfig-001-20260519    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch                      randconfig-002    gcc-13.4.0
loongarch             randconfig-002-20260519    gcc-10.5.0
loongarch             randconfig-002-20260519    gcc-11.5.0
loongarch             randconfig-002-20260519    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-10.5.0
nios2                 randconfig-001-20260519    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
nios2                 randconfig-002-20260519    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260519    gcc-12.5.0
parisc                randconfig-001-20260519    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260519    clang-23
powerpc               randconfig-001-20260519    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260519    clang-23
powerpc64             randconfig-001-20260519    gcc-8.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260519    gcc-14.3.0
powerpc64             randconfig-002-20260519    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260519    gcc-13.4.0
riscv                          randconfig-002    gcc-13.4.0
riscv                 randconfig-002-20260519    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-13.4.0
s390                  randconfig-001-20260519    gcc-13.4.0
s390                           randconfig-002    gcc-13.4.0
s390                  randconfig-002-20260519    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-13.4.0
sh                    randconfig-001-20260519    gcc-13.4.0
sh                             randconfig-002    gcc-13.4.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-14.3.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                          randconfig-002    gcc-14.3.0
sparc                 randconfig-002-20260519    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-14.3.0
sparc64               randconfig-001-20260519    gcc-14.3.0
sparc64                        randconfig-002    gcc-14.3.0
sparc64               randconfig-002-20260519    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-14.3.0
um                    randconfig-001-20260519    gcc-14.3.0
um                             randconfig-002    gcc-14.3.0
um                    randconfig-002-20260519    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64               buildonly-randconfig-002    clang-20
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260519    clang-20
x86_64      buildonly-randconfig-003-20260519    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260519    clang-20
x86_64      buildonly-randconfig-004-20260519    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64               buildonly-randconfig-006    clang-20
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260519    clang-20
x86_64                randconfig-002-20260519    clang-20
x86_64                randconfig-003-20260519    clang-20
x86_64                randconfig-004-20260519    clang-20
x86_64                randconfig-005-20260519    clang-20
x86_64                randconfig-006-20260519    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260519    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260519    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260519    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260519    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260519    gcc-14
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260519    gcc-14
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
xtensa                         randconfig-001    gcc-14.3.0
xtensa                randconfig-001-20260519    gcc-14.3.0
xtensa                         randconfig-002    gcc-14.3.0
xtensa                randconfig-002-20260519    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
