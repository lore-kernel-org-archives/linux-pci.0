Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72C3491C4
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905919; cv=none; b=sfOdSn7NlEg0LYeVOJUhWil5Yi/SRTfpMJ+o5SilxNYaaQ4NxQ+xMlRCIobZtEQkEjCP9ur3RKXmd/UKiEma8eNU62Q7tZhQrrJxw7rfVD7Y2dCsGGDr3ORhBURVLr3IS9i8hSvKvC1eiJ+Zq4RPMoKYsQNqjMPOuYUszmFhmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905919; c=relaxed/simple;
	bh=WL/RLeXC3Pyheii4Ioj2REq0VDiMRsCHpbnPiS+at7k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N9Drn04TypSOhSczG8m1eb1gjcfKbXwuMVtjCGX0mU6SawTtxNo+retUd2S5u/puEFkUFEtCDOn+yXc0MWsdJY1zpbpDYr5mjWezA0plwq4ICtl+YXwmwBXBoExDEk7qjlmRA9xycLqSVButmsBYlVtRwYqMDgtE93vMKF8Axf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVk9qzQK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVk9qzQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772905917; x=1804441917;
  h=date:from:to:cc:subject:message-id;
  bh=WL/RLeXC3Pyheii4Ioj2REq0VDiMRsCHpbnPiS+at7k=;
  b=lVk9qzQKExvpjCNjyehh62kYA7xmCIG4RENSqH1PoOVq5Z5ewNNpWGmS
   YWyXsDju8kXYM4M2hVuCtTTO4Vc/VhrzFZwvXn8RzAN+e+1I7VcJYhfVa
   dQ4/qu2HPDIPkTAhQ3ldGvkFMnxOuDHhYEnKZGLyO8+DhWmxF8+BOvWzh
   c1By+8SVw3p+lp4RiDDraq2eJck2lLUlTvDsjAIuyvebwN5v6GxisgCvN
   DmmeDysX95oAXnN22IbRHb3xLcaFyxSlJqFxD1kHu43PKWKiB5c9oG71J
   aI9Tro8zyTsq1imGsLknPYPwiu/M/w8YWYp0jAIHAjZrAi40QQKK28FjN
   Q==;
X-CSE-ConnectionGUID: IdqqQJRYRBCeKpHl2WfnzA==
X-CSE-MsgGUID: N8n1uI9OTZK5NqarBJ93Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="85341038"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="85341038"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:51:56 -0800
X-CSE-ConnectionGUID: AHj4GLqvQ5eJQRXzW1o/WQ==
X-CSE-MsgGUID: VRasxAgwQcmMSymzgvtWgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="222073812"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Mar 2026 09:51:55 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyvoe-000000002TT-3EbB;
	Sat, 07 Mar 2026 17:51:52 +0000
Date: Sun, 08 Mar 2026 01:51:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 fa6dbe906d1b0ad5cc31ee08e9941f938474dfda
Message-ID: <202603080111.0PsQn27f-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: fa6dbe906d1b0ad5cc31ee08e9941f938474dfda  PCI: Consolidate pci_bus/slot_lock/unlock/trylock()

elapsed time: 2490m

configs tested: 254
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
arc                   randconfig-001-20260307    gcc-15.2.0
arc                   randconfig-002-20260306    gcc-14.3.0
arc                   randconfig-002-20260307    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260306    gcc-14.3.0
arm                   randconfig-001-20260307    gcc-15.2.0
arm                   randconfig-002-20260306    gcc-14.3.0
arm                   randconfig-002-20260307    gcc-15.2.0
arm                   randconfig-003-20260306    gcc-14.3.0
arm                   randconfig-003-20260307    gcc-15.2.0
arm                   randconfig-004-20260306    gcc-14.3.0
arm                   randconfig-004-20260307    gcc-15.2.0
arm                           u8500_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260306    clang-23
arm64                 randconfig-001-20260307    gcc-8.5.0
arm64                 randconfig-002-20260306    clang-23
arm64                 randconfig-002-20260307    gcc-8.5.0
arm64                 randconfig-003-20260306    clang-23
arm64                 randconfig-003-20260307    gcc-8.5.0
arm64                 randconfig-004-20260306    clang-23
arm64                 randconfig-004-20260307    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260306    clang-23
csky                  randconfig-001-20260307    gcc-8.5.0
csky                  randconfig-002-20260306    clang-23
csky                  randconfig-002-20260307    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260306    clang-23
hexagon               randconfig-001-20260307    gcc-15.2.0
hexagon               randconfig-002-20260306    clang-23
hexagon               randconfig-002-20260307    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260306    gcc-14
i386        buildonly-randconfig-001-20260307    gcc-14
i386        buildonly-randconfig-002-20260306    gcc-14
i386        buildonly-randconfig-002-20260307    gcc-14
i386        buildonly-randconfig-003-20260306    gcc-14
i386        buildonly-randconfig-003-20260307    gcc-14
i386        buildonly-randconfig-004-20260306    gcc-14
i386        buildonly-randconfig-004-20260307    gcc-14
i386        buildonly-randconfig-005-20260306    gcc-14
i386        buildonly-randconfig-005-20260307    gcc-14
i386        buildonly-randconfig-006-20260306    gcc-14
i386        buildonly-randconfig-006-20260307    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260306    clang-20
i386                  randconfig-001-20260307    clang-20
i386                  randconfig-002-20260306    clang-20
i386                  randconfig-002-20260307    clang-20
i386                  randconfig-003-20260306    clang-20
i386                  randconfig-003-20260307    clang-20
i386                  randconfig-004-20260306    clang-20
i386                  randconfig-004-20260307    clang-20
i386                  randconfig-005-20260306    clang-20
i386                  randconfig-005-20260307    clang-20
i386                  randconfig-006-20260306    clang-20
i386                  randconfig-006-20260307    clang-20
i386                  randconfig-007-20260306    clang-20
i386                  randconfig-007-20260307    clang-20
i386                  randconfig-011-20260306    gcc-14
i386                  randconfig-011-20260307    gcc-14
i386                  randconfig-012-20260306    gcc-14
i386                  randconfig-012-20260307    gcc-14
i386                  randconfig-013-20260306    gcc-14
i386                  randconfig-013-20260307    gcc-14
i386                  randconfig-014-20260306    gcc-14
i386                  randconfig-014-20260307    gcc-14
i386                  randconfig-015-20260306    gcc-14
i386                  randconfig-015-20260307    gcc-14
i386                  randconfig-016-20260306    gcc-14
i386                  randconfig-016-20260307    gcc-14
i386                  randconfig-017-20260306    gcc-14
i386                  randconfig-017-20260307    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260306    clang-23
loongarch             randconfig-001-20260307    gcc-15.2.0
loongarch             randconfig-002-20260306    clang-23
loongarch             randconfig-002-20260307    gcc-15.2.0
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
mips                  cavium_octeon_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260306    clang-23
nios2                 randconfig-001-20260307    gcc-15.2.0
nios2                 randconfig-002-20260306    clang-23
nios2                 randconfig-002-20260307    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260306    gcc-14.3.0
parisc                randconfig-001-20260307    gcc-12.5.0
parisc                randconfig-002-20260306    gcc-14.3.0
parisc                randconfig-002-20260307    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                   currituck_defconfig    clang-23
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260306    gcc-14.3.0
powerpc               randconfig-001-20260307    gcc-12.5.0
powerpc               randconfig-002-20260306    gcc-14.3.0
powerpc               randconfig-002-20260307    gcc-12.5.0
powerpc64             randconfig-001-20260306    gcc-14.3.0
powerpc64             randconfig-001-20260307    gcc-12.5.0
powerpc64             randconfig-002-20260306    gcc-14.3.0
powerpc64             randconfig-002-20260307    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260306    clang-19
riscv                 randconfig-001-20260307    clang-23
riscv                 randconfig-002-20260306    clang-19
riscv                 randconfig-002-20260307    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260306    clang-19
s390                  randconfig-001-20260307    clang-23
s390                  randconfig-002-20260306    clang-19
s390                  randconfig-002-20260307    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.2.0
sh                    randconfig-001-20260306    clang-19
sh                    randconfig-001-20260307    clang-23
sh                    randconfig-002-20260306    clang-19
sh                    randconfig-002-20260307    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260306    gcc-9.5.0
sparc                 randconfig-001-20260307    gcc-8.5.0
sparc                 randconfig-002-20260306    gcc-9.5.0
sparc                 randconfig-002-20260307    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260306    gcc-9.5.0
sparc64               randconfig-001-20260307    gcc-8.5.0
sparc64               randconfig-002-20260306    gcc-9.5.0
sparc64               randconfig-002-20260307    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260306    gcc-9.5.0
um                    randconfig-001-20260307    gcc-8.5.0
um                    randconfig-002-20260306    gcc-9.5.0
um                    randconfig-002-20260307    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260306    clang-20
x86_64      buildonly-randconfig-001-20260307    clang-20
x86_64      buildonly-randconfig-002-20260306    clang-20
x86_64      buildonly-randconfig-002-20260307    clang-20
x86_64      buildonly-randconfig-003-20260306    clang-20
x86_64      buildonly-randconfig-003-20260307    clang-20
x86_64      buildonly-randconfig-004-20260306    clang-20
x86_64      buildonly-randconfig-004-20260307    clang-20
x86_64      buildonly-randconfig-005-20260306    clang-20
x86_64      buildonly-randconfig-005-20260307    clang-20
x86_64      buildonly-randconfig-006-20260306    clang-20
x86_64      buildonly-randconfig-006-20260307    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260306    gcc-14
x86_64                randconfig-001-20260307    gcc-14
x86_64                randconfig-002-20260306    gcc-14
x86_64                randconfig-002-20260307    gcc-14
x86_64                randconfig-003-20260306    gcc-14
x86_64                randconfig-003-20260307    gcc-14
x86_64                randconfig-004-20260306    gcc-14
x86_64                randconfig-004-20260307    gcc-14
x86_64                randconfig-005-20260306    gcc-14
x86_64                randconfig-005-20260307    gcc-14
x86_64                randconfig-006-20260306    gcc-14
x86_64                randconfig-006-20260307    gcc-14
x86_64                randconfig-011-20260306    gcc-14
x86_64                randconfig-011-20260307    gcc-14
x86_64                randconfig-012-20260306    gcc-14
x86_64                randconfig-012-20260307    gcc-14
x86_64                randconfig-013-20260306    gcc-14
x86_64                randconfig-013-20260307    gcc-14
x86_64                randconfig-014-20260306    gcc-14
x86_64                randconfig-014-20260307    gcc-14
x86_64                randconfig-015-20260306    gcc-14
x86_64                randconfig-015-20260307    gcc-14
x86_64                randconfig-016-20260306    gcc-14
x86_64                randconfig-016-20260307    gcc-14
x86_64                randconfig-071-20260306    gcc-14
x86_64                randconfig-071-20260307    gcc-14
x86_64                randconfig-072-20260306    gcc-14
x86_64                randconfig-072-20260307    gcc-14
x86_64                randconfig-073-20260306    gcc-14
x86_64                randconfig-073-20260307    gcc-14
x86_64                randconfig-074-20260306    gcc-14
x86_64                randconfig-074-20260307    gcc-14
x86_64                randconfig-075-20260306    gcc-14
x86_64                randconfig-075-20260307    gcc-14
x86_64                randconfig-076-20260306    gcc-14
x86_64                randconfig-076-20260307    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260306    gcc-9.5.0
xtensa                randconfig-001-20260307    gcc-8.5.0
xtensa                randconfig-002-20260306    gcc-9.5.0
xtensa                randconfig-002-20260307    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
