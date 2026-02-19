Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8712882C9
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488089; cv=none; b=u2Kji8/XeCA2jJUeGoqGx4HJybMp1WBeE1GNOk5fe6Uu4elNSufKfwo/U7HCMGJIVIFv0TqvleOB+Gib2J54J2RgwiAbmhgW/2l+Tx+CJUJ2/QRXXJ0hTI5yEHrbqzXJdijiq6nmGtcut6be+5plf1kNhAGcv0+9Knn9+69FgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488089; c=relaxed/simple;
	bh=dGQe5FzuMqlx4RMTkq9nDz+0RunNL3asYWLrmxftf8k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ei6aMiJ2j9I3qGYX8d7CbV0eY5gidzJsUzjdNTBzC1ZaDhVrVIRaFXEMNv8q6tw/+A7ONDKNmdSUpuQqFHdWiNtklNTe+gXlfvN4kogMVUdgZ9rJqvNDO5PgR54Yp/vVg45escK3S7PB8a4aTnEOz7pdpGk6bLtH6CNEZPYoxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy5fakLR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy5fakLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771488087; x=1803024087;
  h=date:from:to:cc:subject:message-id;
  bh=dGQe5FzuMqlx4RMTkq9nDz+0RunNL3asYWLrmxftf8k=;
  b=Iy5fakLRMSo3TPVa05IpLr1RE/x2duqtnaEO53gWF6qZUGv/LH7YJXfT
   0giDHhHIvpehfeSYutR2MwhrBzg/csKgbyc7D38y6dd1cgVEEfKxAfCxF
   ssLJO2XMNL73yBWLMTaonH2BrBpkNHWc/48NwDGh+RpfxoxbjaVjWlYaf
   cIsWY8ndbGKmNI8gYZWuhh00bqcvHZzSQUTTfNOjH0QqTYVGZzy6N+PxR
   YQuuoARdrOS2kxO/eRMVkllJqmonheCiOdEqp0YY1PRUI3c+CTqBw0wAO
   h6XstQvBz5+bJ3KB2O6YM8wp9+lmzJfZjz3h7At0x4K1hRDD6HYh1BDR2
   w==;
X-CSE-ConnectionGUID: bgYbBTPTRYu4FC7Lh983+Q==
X-CSE-MsgGUID: BFAoizQiQF6vQVFa9KwtGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="98031214"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="98031214"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 00:01:26 -0800
X-CSE-ConnectionGUID: 6Glr01UPTomgRWMHCM9D6A==
X-CSE-MsgGUID: jN1TJWZoRdeHcgd+ZfpCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218971831"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2026 00:01:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsyyR-0000000132s-0rhw;
	Thu, 19 Feb 2026 08:01:23 +0000
Date: Thu, 19 Feb 2026 16:00:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 a7b3343bbb57a2487254765714167900b5371c41
Message-ID: <202602191641.r6ilZX5Z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: a7b3343bbb57a2487254765714167900b5371c41  PCI: endpoint: pci-epf-test: Select configfs

elapsed time: 828m

configs tested: 283
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
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260219    clang-23
arc                   randconfig-001-20260219    gcc-9.5.0
arc                   randconfig-002-20260219    clang-23
arc                   randconfig-002-20260219    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                     davinci_all_defconfig    clang-23
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    clang-18
arm                       imx_v4_v5_defconfig    clang-18
arm                            mps2_defconfig    clang-23
arm                        multi_v5_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    clang-18
arm                        neponset_defconfig    clang-23
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260219    clang-23
arm                   randconfig-001-20260219    gcc-15.2.0
arm                   randconfig-002-20260219    clang-23
arm                   randconfig-003-20260219    clang-23
arm                   randconfig-004-20260219    clang-23
arm                   randconfig-004-20260219    gcc-13.4.0
arm                         s5pv210_defconfig    gcc-15.2.0
arm                         vf610m4_defconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260219    clang-23
arm64                 randconfig-001-20260219    gcc-8.5.0
arm64                 randconfig-002-20260219    gcc-8.5.0
arm64                 randconfig-003-20260219    gcc-8.5.0
arm64                 randconfig-004-20260219    gcc-14.3.0
arm64                 randconfig-004-20260219    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260219    gcc-15.2.0
csky                  randconfig-001-20260219    gcc-8.5.0
csky                  randconfig-002-20260219    gcc-12.5.0
csky                  randconfig-002-20260219    gcc-8.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260219    clang-17
hexagon               randconfig-001-20260219    clang-23
hexagon               randconfig-002-20260219    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260219    gcc-14
i386        buildonly-randconfig-002-20260219    gcc-14
i386        buildonly-randconfig-003-20260219    gcc-14
i386        buildonly-randconfig-004-20260219    gcc-14
i386        buildonly-randconfig-005-20260219    clang-20
i386        buildonly-randconfig-005-20260219    gcc-14
i386        buildonly-randconfig-006-20260219    clang-20
i386        buildonly-randconfig-006-20260219    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260219    gcc-14
i386                  randconfig-002-20260219    gcc-14
i386                  randconfig-003-20260219    gcc-14
i386                  randconfig-004-20260219    gcc-14
i386                  randconfig-005-20260219    gcc-14
i386                  randconfig-006-20260219    gcc-14
i386                  randconfig-007-20260219    gcc-14
i386                  randconfig-011-20260219    clang-20
i386                  randconfig-011-20260219    gcc-14
i386                  randconfig-012-20260219    clang-20
i386                  randconfig-013-20260219    clang-20
i386                  randconfig-013-20260219    gcc-14
i386                  randconfig-014-20260219    clang-20
i386                  randconfig-014-20260219    gcc-13
i386                  randconfig-015-20260219    clang-20
i386                  randconfig-015-20260219    gcc-13
i386                  randconfig-016-20260219    clang-20
i386                  randconfig-016-20260219    gcc-14
i386                  randconfig-017-20260219    clang-20
i386                  randconfig-017-20260219    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260219    clang-17
loongarch             randconfig-001-20260219    gcc-15.2.0
loongarch             randconfig-002-20260219    clang-17
loongarch             randconfig-002-20260219    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                       m5475evb_defconfig    gcc-15.2.0
m68k                          multi_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-23
mips                         bigsur_defconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-23
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-23
mips                          malta_defconfig    clang-23
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260219    clang-17
nios2                 randconfig-001-20260219    gcc-11.5.0
nios2                 randconfig-002-20260219    clang-17
nios2                 randconfig-002-20260219    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-23
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260219    clang-23
parisc                randconfig-001-20260219    gcc-15.2.0
parisc                randconfig-002-20260219    clang-23
parisc                randconfig-002-20260219    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-18
powerpc                          g5_defconfig    clang-23
powerpc                  iss476-smp_defconfig    clang-18
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260219    clang-23
powerpc               randconfig-001-20260219    gcc-8.5.0
powerpc               randconfig-002-20260219    clang-23
powerpc                     tqm8541_defconfig    clang-23
powerpc64             randconfig-001-20260219    clang-23
powerpc64             randconfig-002-20260219    clang-23
powerpc64             randconfig-002-20260219    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-23
riscv                    nommu_virt_defconfig    clang-23
riscv                 randconfig-001-20260219    clang-17
riscv                 randconfig-002-20260219    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260219    clang-17
s390                  randconfig-002-20260219    clang-17
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260219    clang-17
sh                    randconfig-002-20260219    clang-17
sh                          rsk7264_defconfig    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7705_defconfig    clang-18
sh                            titan_defconfig    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260219    gcc-15.2.0
sparc                 randconfig-001-20260219    gcc-8.5.0
sparc                 randconfig-002-20260219    gcc-15.2.0
sparc                 randconfig-002-20260219    gcc-8.5.0
sparc64                          alldefconfig    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260219    clang-23
sparc64               randconfig-001-20260219    gcc-8.5.0
sparc64               randconfig-002-20260219    clang-23
sparc64               randconfig-002-20260219    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260219    clang-18
um                    randconfig-001-20260219    gcc-8.5.0
um                    randconfig-002-20260219    clang-23
um                    randconfig-002-20260219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260219    gcc-14
x86_64      buildonly-randconfig-002-20260219    gcc-14
x86_64      buildonly-randconfig-003-20260219    gcc-14
x86_64      buildonly-randconfig-004-20260219    gcc-14
x86_64      buildonly-randconfig-005-20260219    gcc-14
x86_64      buildonly-randconfig-006-20260219    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260219    clang-20
x86_64                randconfig-002-20260219    clang-20
x86_64                randconfig-003-20260219    clang-20
x86_64                randconfig-004-20260219    clang-20
x86_64                randconfig-005-20260219    clang-20
x86_64                randconfig-006-20260219    clang-20
x86_64                randconfig-011-20260219    gcc-14
x86_64                randconfig-012-20260219    gcc-14
x86_64                randconfig-013-20260219    gcc-14
x86_64                randconfig-014-20260219    gcc-14
x86_64                randconfig-015-20260219    gcc-14
x86_64                randconfig-016-20260219    gcc-14
x86_64                randconfig-071-20260219    clang-20
x86_64                randconfig-071-20260219    gcc-14
x86_64                randconfig-072-20260219    gcc-14
x86_64                randconfig-073-20260219    gcc-14
x86_64                randconfig-074-20260219    gcc-14
x86_64                randconfig-075-20260219    clang-20
x86_64                randconfig-075-20260219    gcc-14
x86_64                randconfig-076-20260219    clang-20
x86_64                randconfig-076-20260219    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260219    gcc-15.2.0
xtensa                randconfig-001-20260219    gcc-8.5.0
xtensa                randconfig-002-20260219    gcc-8.5.0
xtensa                    xip_kc705_defconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
