Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6683101D4
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760096; cv=none; b=nSzfijLHWLThW+nF54GczuzspXE1ND8hwNDKLpl/IOcLydEbcu33U9xgRKXKbr5+KkbGkcGkg4CADN6KBPJbwnWVwRbmbDdwpurbMudess1tgbiI+PuKorbv87/malG/SVAtpUPRLaAFX3kWR99o/PFiXTZqplJZPhGoAQ03UQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760096; c=relaxed/simple;
	bh=zPKbZMaaH9LA4iUOwtgJjzCnTHDN5tt2k6HoyDK6cGg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H2JxBnICbaXJ+CnG8GssANxbvW+knysgUqtsC66KsjcgvcauWLdi5KFjDJ3artPws+N1dl6Bo7Ad4WKPuMThYgh7ppdXs9lBhSab8tSXk8Klht3+OOfodoInPPqkYf5VmKamCGUuRa/GP3lz8v4IgqBmJrtIivY9BmiiHtsRK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFFmZebe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFFmZebe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772760094; x=1804296094;
  h=date:from:to:cc:subject:message-id;
  bh=zPKbZMaaH9LA4iUOwtgJjzCnTHDN5tt2k6HoyDK6cGg=;
  b=RFFmZebeNi1ksDerRqMsmV3r7JNXLxwON39pDOXwsL3Kd861OjVvjbtF
   N8Jy4skwBCffxlZWS5JpP/dLzZ3wqPmRRnABaUK6HAf47Jh2TtEPBI2lB
   4RKXwS9Ukx4AfZP5lt9kgEnZDnFi8IC1j+IDV3WdX8xo78yt41YhFj2Bf
   puQk72EDYUbGa7DSde/hIU52a9cttCHp3KfaKtUfg561CqU1S339HvHeN
   4i0PXvjqc3D0jaEARim+ZZEKA68RTw4xaGjz4BFVwHyKQooC/Vx4Ol1Gg
   dVOsJ921NG6PuXNIV9UabgkvTc5pilMGkMUdK/XZESTIW9Q/DcMII2LrZ
   Q==;
X-CSE-ConnectionGUID: /XzsNlfDT7+XJmbOezx6gw==
X-CSE-MsgGUID: X1KlZeyrQkO0+ck474+UXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73059107"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73059107"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:21:33 -0800
X-CSE-ConnectionGUID: YxDOC+0eSeuIvTUDm2u3Ig==
X-CSE-MsgGUID: OFDxKeHFQg23Pwl359A+jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="217082752"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Mar 2026 17:21:32 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyJsg-0000000009x-0qQX;
	Fri, 06 Mar 2026 01:21:30 +0000
Date: Fri, 06 Mar 2026 09:20:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 0b74f7d72399d4c4422ed3d68ef28b3612f71e74
Message-ID: <202603060924.2rRcZQSL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 0b74f7d72399d4c4422ed3d68ef28b3612f71e74  PCI: endpoint: Propagate error from pci_epf_create()

elapsed time: 1074m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260306    gcc-14.3.0
arc                   randconfig-002-20260306    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260306    gcc-14.3.0
arm                   randconfig-002-20260306    gcc-14.3.0
arm                   randconfig-003-20260306    gcc-14.3.0
arm                   randconfig-004-20260306    gcc-14.3.0
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260306    clang-23
hexagon               randconfig-002-20260306    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260306    gcc-14
i386        buildonly-randconfig-002-20260306    gcc-14
i386        buildonly-randconfig-003-20260306    gcc-14
i386        buildonly-randconfig-004-20260306    gcc-14
i386        buildonly-randconfig-005-20260306    gcc-14
i386        buildonly-randconfig-006-20260306    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260306    clang-20
i386                  randconfig-002-20260306    clang-20
i386                  randconfig-003-20260306    clang-20
i386                  randconfig-004-20260306    clang-20
i386                  randconfig-005-20260306    clang-20
i386                  randconfig-006-20260306    clang-20
i386                  randconfig-007-20260306    clang-20
i386                  randconfig-011-20260306    gcc-14
i386                  randconfig-012-20260306    gcc-14
i386                  randconfig-013-20260306    gcc-14
i386                  randconfig-014-20260306    gcc-14
i386                  randconfig-015-20260306    gcc-14
i386                  randconfig-016-20260306    gcc-14
i386                  randconfig-017-20260306    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260306    clang-23
loongarch             randconfig-002-20260306    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260306    clang-23
nios2                 randconfig-002-20260306    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260306    gcc-14.3.0
parisc                randconfig-002-20260306    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260306    gcc-14.3.0
powerpc               randconfig-002-20260306    gcc-14.3.0
powerpc64             randconfig-001-20260306    gcc-14.3.0
powerpc64             randconfig-002-20260306    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260306    clang-19
riscv                 randconfig-002-20260306    clang-19
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260306    clang-19
s390                  randconfig-002-20260306    clang-19
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260306    clang-19
sh                    randconfig-002-20260306    clang-19
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260306    gcc-9.5.0
sparc                 randconfig-002-20260306    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260306    gcc-9.5.0
sparc64               randconfig-002-20260306    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260306    gcc-9.5.0
um                    randconfig-002-20260306    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260306    clang-20
x86_64      buildonly-randconfig-002-20260306    clang-20
x86_64      buildonly-randconfig-003-20260306    clang-20
x86_64      buildonly-randconfig-004-20260306    clang-20
x86_64      buildonly-randconfig-005-20260306    clang-20
x86_64      buildonly-randconfig-006-20260306    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260306    gcc-14
x86_64                randconfig-002-20260306    gcc-14
x86_64                randconfig-003-20260306    gcc-14
x86_64                randconfig-004-20260306    gcc-14
x86_64                randconfig-005-20260306    gcc-14
x86_64                randconfig-006-20260306    gcc-14
x86_64                randconfig-071-20260306    gcc-14
x86_64                randconfig-072-20260306    gcc-14
x86_64                randconfig-073-20260306    gcc-14
x86_64                randconfig-074-20260306    gcc-14
x86_64                randconfig-075-20260306    gcc-14
x86_64                randconfig-076-20260306    gcc-14
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
xtensa                randconfig-001-20260306    gcc-9.5.0
xtensa                randconfig-002-20260306    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
