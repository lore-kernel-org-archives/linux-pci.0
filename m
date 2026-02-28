Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A622D73A7
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276163; cv=none; b=Sp7Qy9IXRHj6XncafOfOFU2aPyUvlzhX+qWCO8zCw3z74EaTWxvld1KTyAYmhPvyVbgsnhLImF2qKPHwwRGGed6atl0rjvPT4gnkEHzB2iN2St6ADKhZCrrvafroJF4k14KXeLOLiJLz2J/djsCia+YL1Yw8i3Kjgw8WDxzHurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276163; c=relaxed/simple;
	bh=pQPHMHBUPwcElzs6HXVe8UvAwFVytjyK01/RF24cO7w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Nx8ISZKG18Fs6CJKW88bLdrfHhvBfqNiStPdWnsT6FbVRGB9mvwuQW7vfSGO5P6LrivuAT3DVKzAR77gHYhx1Tw4BlwUrpc3WOTfSwp3OwNnMLa3iiT9xeBtH8U14TBJHgCo/3amHeZ4xUtYHbrZ7t1qwTZklX3L3jddYVwC8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGDnlN7H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGDnlN7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772276162; x=1803812162;
  h=date:from:to:cc:subject:message-id;
  bh=pQPHMHBUPwcElzs6HXVe8UvAwFVytjyK01/RF24cO7w=;
  b=aGDnlN7HhHbzHeoHOs2qRH6HEPXcFxMD8c7g3ObG/DkA/nENkFNIwkFh
   y0cpER5gCmD2wa4wT0ir6bFSXANPAT4k3m/mrqyYHKou56HYZzOShj9VI
   Fy6YDWe3hvfHs2jAocR+MK8+bkVzTIDeqs7sDGO5xBr5nY8wsZy0AoQMr
   TOnam/t9KnnzOfBbtpRqhIvhbndEMpL4Bi62+KuDMNX3CgcCMA43tpDbB
   nOEX/AwjLD6NZRZ5+dEBeqUjcrAlG9C4ApcI376MGwKW9oBFnzCHsLPRN
   ixG5Ywkup0YlPPyRRpYTNubNplZpij/B5HNkMsGiAm06M6nTG7ZgXPa9p
   A==;
X-CSE-ConnectionGUID: QIsVbIn8R3etoYXZqOxMkA==
X-CSE-MsgGUID: 6xPlvP81TQesJIW6u9C8nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="90926572"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="90926572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:56:01 -0800
X-CSE-ConnectionGUID: 5fbBc/dAQKuHuwfnUBsuBg==
X-CSE-MsgGUID: 138B6kuHQbObDQtQXeuWHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="240158680"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Feb 2026 02:56:00 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwHyx-00000000BTT-0RGR;
	Sat, 28 Feb 2026 10:55:45 +0000
Date: Sat, 28 Feb 2026 18:54:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 39195990e4c093c9eecf88f29811c6de29265214
Message-ID: <202602281814.oMlxoAEc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 39195990e4c093c9eecf88f29811c6de29265214  PCI: Correct PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value

elapsed time: 1085m

configs tested: 165
configs skipped: 5

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
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260228    gcc-14.3.0
arc                   randconfig-002-20260228    gcc-8.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260228    clang-16
arm                   randconfig-002-20260228    clang-23
arm                   randconfig-003-20260228    clang-23
arm                   randconfig-004-20260228    gcc-11.5.0
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260228    clang-23
arm64                 randconfig-002-20260228    gcc-8.5.0
arm64                 randconfig-003-20260228    clang-23
arm64                 randconfig-004-20260228    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260228    gcc-15.2.0
csky                  randconfig-002-20260228    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260228    clang-23
hexagon               randconfig-002-20260228    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260228    clang-20
i386        buildonly-randconfig-002-20260228    gcc-14
i386        buildonly-randconfig-003-20260228    clang-20
i386        buildonly-randconfig-004-20260228    clang-20
i386        buildonly-randconfig-005-20260228    clang-20
i386        buildonly-randconfig-006-20260228    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260228    gcc-13
i386                  randconfig-002-20260228    gcc-14
i386                  randconfig-003-20260228    gcc-14
i386                  randconfig-004-20260228    clang-20
i386                  randconfig-005-20260228    clang-20
i386                  randconfig-006-20260228    clang-20
i386                  randconfig-007-20260228    gcc-14
i386                  randconfig-011-20260228    gcc-14
i386                  randconfig-012-20260228    gcc-14
i386                  randconfig-013-20260228    clang-20
i386                  randconfig-014-20260228    clang-20
i386                  randconfig-015-20260228    clang-20
i386                  randconfig-016-20260228    clang-20
i386                  randconfig-017-20260228    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260228    clang-23
loongarch             randconfig-002-20260228    gcc-15.2.0
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
mips                         bigsur_defconfig    gcc-15.2.0
mips                       rbtx49xx_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260228    gcc-11.5.0
nios2                 randconfig-002-20260228    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.2.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260228    gcc-9.5.0
parisc                randconfig-002-20260228    gcc-9.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260228    clang-23
powerpc               randconfig-002-20260228    gcc-8.5.0
powerpc64             randconfig-001-20260228    gcc-12.5.0
powerpc64             randconfig-002-20260228    gcc-10.5.0
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                    nommu_virt_defconfig    clang-23
riscv                 randconfig-001-20260228    gcc-11.5.0
riscv                 randconfig-002-20260228    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260228    gcc-8.5.0
s390                  randconfig-002-20260228    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260228    gcc-15.2.0
sh                    randconfig-002-20260228    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260228    gcc-12.5.0
sparc                 randconfig-002-20260228    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260228    gcc-15.2.0
sparc64               randconfig-002-20260228    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260228    clang-20
um                    randconfig-002-20260228    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260228    gcc-14
x86_64      buildonly-randconfig-002-20260228    gcc-14
x86_64      buildonly-randconfig-003-20260228    clang-20
x86_64      buildonly-randconfig-004-20260228    clang-20
x86_64      buildonly-randconfig-005-20260228    gcc-14
x86_64      buildonly-randconfig-006-20260228    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260228    clang-20
x86_64                randconfig-002-20260228    gcc-14
x86_64                randconfig-003-20260228    clang-20
x86_64                randconfig-004-20260228    gcc-14
x86_64                randconfig-005-20260228    gcc-14
x86_64                randconfig-006-20260228    gcc-14
x86_64                randconfig-011-20260228    clang-20
x86_64                randconfig-012-20260228    clang-20
x86_64                randconfig-013-20260228    gcc-13
x86_64                randconfig-014-20260228    gcc-14
x86_64                randconfig-015-20260228    clang-20
x86_64                randconfig-016-20260228    gcc-14
x86_64                randconfig-071-20260228    clang-20
x86_64                randconfig-072-20260228    gcc-14
x86_64                randconfig-073-20260228    gcc-14
x86_64                randconfig-074-20260228    gcc-14
x86_64                randconfig-075-20260228    clang-20
x86_64                randconfig-076-20260228    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260228    gcc-8.5.0
xtensa                randconfig-002-20260228    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
