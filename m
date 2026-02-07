Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BF2857C7
	for <linux-pci@vger.kernel.org>; Sat,  7 Feb 2026 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500460; cv=none; b=YYtsXhBMQye8D7bs7gywNh4bxETjl8/GrrpyImdX8XnZ6pl/dgsAUDJiePygv6/6vCJ2/6mlt0PHqR+czbM+eBTs0b673iQ2tP5uxZUES/j/j8diVnbJdvCgDoWmOCglfuMkjl2GkwIL/Aqu57MRXsnYHW3S+Z9Jzbx1YjF6q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500460; c=relaxed/simple;
	bh=UUQusi2xD2DG/spZA7mmIgR2L1fMyTmv7rkRuAYLjdw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eagyi+5zBUsvov7P4v2VzOb/vGfZnouqqulYMh3NrWkflH922INGhf5np3z8lEpTXj60DeBhepGFRrz9HIlaZ0nSG+9ki2cqzDNG21EFgHClhL+PrDQiXokZPS9xOl33S9O+Wh/OsVymkX9RNiM+DQikIpwHfuLvFNMDjaE6x/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/xLs7wz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/xLs7wz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770500459; x=1802036459;
  h=date:from:to:cc:subject:message-id;
  bh=UUQusi2xD2DG/spZA7mmIgR2L1fMyTmv7rkRuAYLjdw=;
  b=P/xLs7wz+d5Zhrzt7l6vc1ATRRAtHY3RhMNqtmlwG3b8M8tuhqzjGKC8
   z0d8gMi4LJJbDjxZ2WYsOFrfO4q0xsNrfhcyOBRTO9URL6QACOPBUks5Q
   Z/uR55T1JwbjHqEkUvUevt7Hj4KEbtfBoaOKuzN6gKDYGnCvv77a6lQtK
   daM28JyIlYPAspvMfCulHI8+uJq9uJpojRoJU8xEvGqYhmoP5MW6V1rZ9
   CjA/RUXVzpvDRHruUWunvs1u7CMP8ldWKrjitNLVumKeLQuLdLBTQQK+5
   yT6VH9cdUXyfRUmHXfSluTwS/Sm69GN9xzpxmCaEPrlC77DvH4udto9v3
   Q==;
X-CSE-ConnectionGUID: 8Nb+lUiuSci+TPAakPVCfQ==
X-CSE-MsgGUID: 4Ne1MCQ+RKqk3gp5C4vmkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="81988067"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="81988067"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 13:40:58 -0800
X-CSE-ConnectionGUID: 845z91M3Qp+Y0NzKcJ3iqg==
X-CSE-MsgGUID: CYUWsneuSECN1UJbssK7FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="210925929"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Feb 2026 13:40:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voq2w-00000000ltk-3WPG;
	Sat, 07 Feb 2026 21:40:54 +0000
Date: Sun, 08 Feb 2026 05:40:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 dff645f564c38332502140f3ef643f659114c45f
Message-ID: <202602080522.LEvrokyx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: dff645f564c38332502140f3ef643f659114c45f  Merge branch 'pci/misc'

elapsed time: 1265m

configs tested: 164
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260207    gcc-9.5.0
arc                   randconfig-002-20260207    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                            dove_defconfig    gcc-15.2.0
arm                   randconfig-001-20260207    gcc-10.5.0
arm                   randconfig-002-20260207    gcc-12.5.0
arm                   randconfig-003-20260207    gcc-8.5.0
arm                   randconfig-004-20260207    gcc-8.5.0
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260207    clang-22
arm64                 randconfig-002-20260207    clang-22
arm64                 randconfig-003-20260207    gcc-14.3.0
arm64                 randconfig-004-20260207    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260207    gcc-15.2.0
csky                  randconfig-002-20260207    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260207    clang-22
hexagon               randconfig-002-20260207    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260207    gcc-14
i386        buildonly-randconfig-002-20260207    clang-20
i386        buildonly-randconfig-003-20260207    clang-20
i386        buildonly-randconfig-004-20260207    clang-20
i386        buildonly-randconfig-005-20260207    clang-20
i386        buildonly-randconfig-006-20260207    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260207    clang-20
i386                  randconfig-002-20260207    clang-20
i386                  randconfig-003-20260207    clang-20
i386                  randconfig-004-20260207    clang-20
i386                  randconfig-005-20260207    clang-20
i386                  randconfig-006-20260207    clang-20
i386                  randconfig-007-20260207    clang-20
i386                  randconfig-011-20260207    gcc-14
i386                  randconfig-012-20260207    gcc-14
i386                  randconfig-013-20260207    gcc-12
i386                  randconfig-014-20260207    clang-20
i386                  randconfig-015-20260207    gcc-14
i386                  randconfig-016-20260207    clang-20
i386                  randconfig-017-20260207    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260207    gcc-13.4.0
loongarch             randconfig-002-20260207    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260207    gcc-10.5.0
nios2                 randconfig-002-20260207    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260207    gcc-14.3.0
parisc                randconfig-002-20260207    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20260207    gcc-10.5.0
powerpc               randconfig-002-20260207    gcc-15.2.0
powerpc64             randconfig-001-20260207    clang-22
powerpc64             randconfig-002-20260207    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260207    clang-18
riscv                 randconfig-002-20260207    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260207    gcc-8.5.0
s390                  randconfig-002-20260207    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260207    gcc-15.2.0
sh                    randconfig-002-20260207    gcc-12.5.0
sh                            shmin_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260207    gcc-8.5.0
sparc                 randconfig-002-20260207    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260207    gcc-14.3.0
sparc64               randconfig-002-20260207    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260207    clang-22
um                    randconfig-002-20260207    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260207    clang-20
x86_64      buildonly-randconfig-002-20260207    gcc-14
x86_64      buildonly-randconfig-003-20260207    gcc-14
x86_64      buildonly-randconfig-004-20260207    clang-20
x86_64      buildonly-randconfig-005-20260207    clang-20
x86_64      buildonly-randconfig-006-20260207    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260207    gcc-14
x86_64                randconfig-002-20260207    gcc-14
x86_64                randconfig-003-20260207    clang-20
x86_64                randconfig-004-20260207    clang-20
x86_64                randconfig-005-20260207    clang-20
x86_64                randconfig-006-20260207    clang-20
x86_64                randconfig-011-20260207    gcc-14
x86_64                randconfig-012-20260207    gcc-14
x86_64                randconfig-013-20260207    gcc-14
x86_64                randconfig-014-20260207    clang-20
x86_64                randconfig-015-20260207    gcc-14
x86_64                randconfig-016-20260207    gcc-14
x86_64                randconfig-071-20260207    gcc-14
x86_64                randconfig-072-20260207    clang-20
x86_64                randconfig-073-20260207    clang-20
x86_64                randconfig-074-20260207    gcc-13
x86_64                randconfig-075-20260207    clang-20
x86_64                randconfig-076-20260207    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260207    gcc-8.5.0
xtensa                randconfig-002-20260207    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
