Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A72BD02
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173317; cv=none; b=ZpiipP1VqSZMCU3HM86pMtG6EGOsR8TGKEF5OPreoQXmDJsKetn66EtGndz3qRR17XZVjpz5kN0RMGYiAqZXvcgW0kC56fG0yejkiCJSbjC+e2IyUEW10dFE6jgIqfkcTjtozs2hamx3XpP55Gpq3idL5NaTUlDXFaxrJkQLBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173317; c=relaxed/simple;
	bh=2uirs7UycipKTF2dvQQiVDJFilRUQDdkE0zdblpgC6c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mZgOgEEis15IHWUEbtoshdv5ArgNZBoJ66LE+hxQYS7tci5IkhDkXwzojQRnz9bjx7m5ZH5dEZit4LWTGFK3eQ0QffiA11Gb8LfaqnyfJT8/QBZsMQEGApHHzEK3e7yrkVSuibJwWF2dmcXViQoT1ZRbvVf2jbqvhh9Ubih4spE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHPZgk31; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHPZgk31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782173315; x=1813709315;
  h=date:from:to:cc:subject:message-id;
  bh=2uirs7UycipKTF2dvQQiVDJFilRUQDdkE0zdblpgC6c=;
  b=KHPZgk31OpmwCT3AcqMYpJJk5TpYdvwqSItuSYPzKujPnCQh9/Fli71y
   eDiHJDUCAo/1DsF9NG31autKLeQrCPzJKwP1Cuxh+ZzjbNDrffRwHNIiS
   v5kZOqUexrjEDzsQVqtf1WYaWXl6Eh1eDvi8lm8qSk1f+KM677YFy0y81
   2XggovNYL9s8Jrvp2sBwLMLSNGoW6U22DOmCepECNOGPeCQqDIfSNj+WR
   OaGtlUyeCQtlPK7rjKu8RVA3Fldy3u5llViK8RGIojLVtkVvoAvlx762a
   bDyIIy4VpXhtoeWu4ow4aYsym0o6cukusHfShb6JezcJ4cYNyjFH6j/SJ
   g==;
X-CSE-ConnectionGUID: xDAjMcHhS6GaE4XDQy4REg==
X-CSE-MsgGUID: fp5qyvwJQWyvc5mUb06khQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82781491"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82781491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 17:08:34 -0700
X-CSE-ConnectionGUID: NTKLZY5nSZSZSWbfULAkiQ==
X-CSE-MsgGUID: 6uROtobeTCGunMLgnGw0fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="254448355"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jun 2026 17:08:33 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbogo-0000000025d-2Ete;
	Tue, 23 Jun 2026 00:08:30 +0000
Date: Tue, 23 Jun 2026 08:07:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mvebu] BUILD SUCCESS
 7cb033507068936f9da3c59e5c31a54e4e8dafa6
Message-ID: <202606230831.bWMzOhTH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mvebu
branch HEAD: 7cb033507068936f9da3c59e5c31a54e4e8dafa6  PCI: mvebu: Use fixed-width interrupt masks to avoid truncation in 64-bit builds

elapsed time: 1276m

configs tested: 299
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260622    gcc-8.5.0
arc                   randconfig-001-20260623    clang-23
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260622    gcc-8.5.0
arc                   randconfig-002-20260623    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260622    gcc-8.5.0
arm                   randconfig-001-20260623    clang-23
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260622    gcc-8.5.0
arm                   randconfig-002-20260623    clang-23
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260622    gcc-8.5.0
arm                   randconfig-003-20260623    clang-23
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260622    gcc-8.5.0
arm                   randconfig-004-20260623    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260622    gcc-8.5.0
arm64                 randconfig-001-20260623    gcc-14.3.0
arm64                 randconfig-002-20260622    gcc-8.5.0
arm64                 randconfig-002-20260623    gcc-14.3.0
arm64                 randconfig-003-20260622    gcc-8.5.0
arm64                 randconfig-003-20260623    gcc-14.3.0
arm64                 randconfig-004-20260622    gcc-8.5.0
arm64                 randconfig-004-20260623    gcc-14.3.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260622    gcc-8.5.0
csky                  randconfig-001-20260623    gcc-14.3.0
csky                  randconfig-002-20260622    gcc-8.5.0
csky                  randconfig-002-20260623    gcc-14.3.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-8.5.0
hexagon               randconfig-001-20260623    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-8.5.0
hexagon               randconfig-002-20260623    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260622    gcc-14
i386        buildonly-randconfig-001-20260623    gcc-14
i386        buildonly-randconfig-002-20260622    gcc-14
i386        buildonly-randconfig-002-20260623    gcc-14
i386        buildonly-randconfig-003-20260622    gcc-14
i386        buildonly-randconfig-003-20260623    gcc-14
i386        buildonly-randconfig-004-20260622    gcc-14
i386        buildonly-randconfig-004-20260623    gcc-14
i386        buildonly-randconfig-005-20260622    gcc-14
i386        buildonly-randconfig-005-20260623    gcc-14
i386        buildonly-randconfig-006-20260622    gcc-14
i386        buildonly-randconfig-006-20260623    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260622    clang-22
i386                  randconfig-001-20260623    clang-22
i386                  randconfig-002-20260622    clang-22
i386                  randconfig-002-20260623    clang-22
i386                  randconfig-003-20260622    clang-22
i386                  randconfig-003-20260623    clang-22
i386                  randconfig-004-20260622    clang-22
i386                  randconfig-004-20260623    clang-22
i386                  randconfig-005-20260622    clang-22
i386                  randconfig-005-20260623    clang-22
i386                  randconfig-006-20260622    clang-22
i386                  randconfig-006-20260623    clang-22
i386                  randconfig-007-20260622    clang-22
i386                  randconfig-007-20260623    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260622    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260622    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260622    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260622    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260622    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260622    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260622    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-8.5.0
loongarch             randconfig-001-20260623    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-8.5.0
loongarch             randconfig-002-20260623    gcc-8.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
m68k                       m5249evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        qi_lb60_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-8.5.0
nios2                 randconfig-001-20260623    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-8.5.0
nios2                 randconfig-002-20260623    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260622    gcc-14.3.0
parisc                randconfig-001-20260623    gcc-11.5.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260622    gcc-14.3.0
parisc                randconfig-002-20260623    gcc-11.5.0
parisc64                            defconfig    clang-23
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260622    gcc-14.3.0
powerpc               randconfig-001-20260623    gcc-11.5.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260622    gcc-14.3.0
powerpc               randconfig-002-20260623    gcc-11.5.0
powerpc64                        alldefconfig    clang-17
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260622    gcc-14.3.0
powerpc64             randconfig-001-20260623    gcc-11.5.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260622    gcc-14.3.0
powerpc64             randconfig-002-20260623    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260622    clang-17
riscv                 randconfig-001-20260623    gcc-8.5.0
riscv                 randconfig-002-20260623    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260622    clang-17
s390                  randconfig-001-20260623    gcc-8.5.0
s390                  randconfig-002-20260622    clang-17
s390                  randconfig-002-20260623    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260622    clang-17
sh                    randconfig-001-20260623    gcc-8.5.0
sh                    randconfig-002-20260622    clang-17
sh                    randconfig-002-20260623    gcc-8.5.0
sh                           se7724_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260622    gcc-16.1.0
sparc                 randconfig-001-20260623    gcc-8.5.0
sparc                          randconfig-002    gcc-16.1.0
sparc                 randconfig-002-20260622    gcc-16.1.0
sparc                 randconfig-002-20260623    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-16.1.0
sparc64               randconfig-001-20260622    gcc-16.1.0
sparc64               randconfig-001-20260623    gcc-8.5.0
sparc64                        randconfig-002    gcc-16.1.0
sparc64               randconfig-002-20260622    gcc-16.1.0
sparc64               randconfig-002-20260623    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-16.1.0
um                    randconfig-001-20260622    gcc-16.1.0
um                    randconfig-001-20260623    gcc-8.5.0
um                             randconfig-002    gcc-16.1.0
um                    randconfig-002-20260622    gcc-16.1.0
um                    randconfig-002-20260623    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260622    clang-22
x86_64      buildonly-randconfig-001-20260623    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260622    clang-22
x86_64      buildonly-randconfig-002-20260623    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260622    clang-22
x86_64      buildonly-randconfig-003-20260623    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260622    clang-22
x86_64      buildonly-randconfig-004-20260623    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260622    clang-22
x86_64      buildonly-randconfig-005-20260623    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260622    clang-22
x86_64      buildonly-randconfig-006-20260623    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260622    clang-22
x86_64                randconfig-002-20260622    clang-22
x86_64                randconfig-003-20260622    clang-22
x86_64                randconfig-004-20260622    clang-22
x86_64                randconfig-005-20260622    clang-22
x86_64                randconfig-006-20260622    clang-22
x86_64                randconfig-011-20260622    clang-22
x86_64                randconfig-012-20260622    clang-22
x86_64                randconfig-013-20260622    clang-22
x86_64                randconfig-014-20260622    clang-22
x86_64                randconfig-015-20260622    clang-22
x86_64                randconfig-016-20260622    clang-22
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260622    gcc-14
x86_64                randconfig-071-20260623    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260622    gcc-14
x86_64                randconfig-072-20260623    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260622    gcc-14
x86_64                randconfig-073-20260623    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260622    gcc-14
x86_64                randconfig-074-20260623    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260622    gcc-14
x86_64                randconfig-075-20260623    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260622    gcc-14
x86_64                randconfig-076-20260623    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260622    gcc-16.1.0
xtensa                randconfig-001-20260623    gcc-8.5.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260622    gcc-16.1.0
xtensa                randconfig-002-20260623    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
