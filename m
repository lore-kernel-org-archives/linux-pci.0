Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAF3A0B20
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142296; cv=none; b=LnPtUbGjqkE1DQ6X+k60XHXkPvIjUxJkfioFzzMB/9J7HfzfCFgdl2Rlnyfkcz/rqzWMSlSFnPwS9yvAmRs0OihbYk36Y7BRi65CIaFAtWjD0vYAXEtfKD6Ugvu5xjzDmilzIDzz9g2EcUEDWwJwrYoU2RdSGGo/pZ82iin5ZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142296; c=relaxed/simple;
	bh=5Z8R0ynpryfFuRaqzms0fMws25/mwCaFzfN+rlnN7/8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pbsfd/PDp0KTb62xIRvn4zxe/XrFw9VBvbHuOxidE740C4BvUaBpysutQOg7imNO6f+wdSjUve5UcYw938C3o1NaqdJBmFDh7s4n0yJ3bxt+kJSM0IQzImnhgRS6q7aDtwLiT/3u8lAdL1K6htr44hP7NXY3F5xd6L9O1JRYCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2DQl+0w; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2DQl+0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772142294; x=1803678294;
  h=date:from:to:cc:subject:message-id;
  bh=5Z8R0ynpryfFuRaqzms0fMws25/mwCaFzfN+rlnN7/8=;
  b=h2DQl+0wSxLRKIw/r6sR2bWdOk8UHJJ29JzQuqDXH68YdvB28sQuPSzi
   J34D127mLZcoXuEm253NWMCJ3xEDVAdmd6Mcu7/kUQOu6P/eIy2X3ziPt
   bb+cV+nRn8bb8nt2C1Jp7u18KXIsjTOHd7WqrvVxPlIgviWOEe5mQrYMy
   MFP/GXSAbq3HCLUJhQD9+EJkHKqIrvGsYcMlx1UYlWIfRs6zZCxpkEbuk
   vj42gIEHAD10hs4HYoKCw2D3S9+W1RtwbjKGd7+od5uYMLdtAN0CaEBvb
   YAZVLJlEIS6KYPliBCB7EMZW7XFvrXOIKUPIpg88pM/VuZPejOHv5AAp2
   g==;
X-CSE-ConnectionGUID: 52uGJdX9Ty64iYYU9PaViw==
X-CSE-MsgGUID: F7FKsiQSTFaDD+qqYS9Kgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83927856"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="83927856"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 13:44:54 -0800
X-CSE-ConnectionGUID: 9Fr7WvEUSqKrlKCigW3jiQ==
X-CSE-MsgGUID: 1YV0jel5Q9O2gTy/aPHcxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="254472065"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2026 13:44:53 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvjA9-000000009uB-2qjv;
	Thu, 26 Feb 2026 21:44:49 +0000
Date: Fri, 27 Feb 2026 05:44:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-rcar-gen4-ep] BUILD SUCCESS
 7f0031b967fd68a1805a16857f5b3b0ca2d32d42
Message-ID: <202602270524.uW3nyVuA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4-ep
branch HEAD: 7f0031b967fd68a1805a16857f5b3b0ca2d32d42  PCI: dwc: rcar-gen4-ep: Mark BAR0 and BAR2 as Resizable BARs

elapsed time: 852m

configs tested: 320
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260226    gcc-15.2.0
arc                   randconfig-001-20260227    gcc-8.5.0
arc                   randconfig-002-20260226    gcc-15.2.0
arc                   randconfig-002-20260227    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    clang-18
arm                           imxrt_defconfig    gcc-15.2.0
arm                   randconfig-001-20260226    gcc-15.2.0
arm                   randconfig-001-20260227    gcc-8.5.0
arm                   randconfig-002-20260226    gcc-15.2.0
arm                   randconfig-002-20260227    gcc-8.5.0
arm                   randconfig-003-20260226    gcc-15.2.0
arm                   randconfig-003-20260227    gcc-8.5.0
arm                   randconfig-004-20260226    gcc-15.2.0
arm                   randconfig-004-20260227    gcc-8.5.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260226    gcc-14.3.0
arm64                 randconfig-001-20260227    clang-23
arm64                 randconfig-002-20260226    gcc-14.3.0
arm64                 randconfig-002-20260226    gcc-8.5.0
arm64                 randconfig-002-20260227    clang-23
arm64                 randconfig-003-20260226    clang-16
arm64                 randconfig-003-20260226    gcc-14.3.0
arm64                 randconfig-003-20260227    clang-23
arm64                 randconfig-004-20260226    clang-23
arm64                 randconfig-004-20260226    gcc-14.3.0
arm64                 randconfig-004-20260227    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260226    gcc-14.3.0
csky                  randconfig-001-20260226    gcc-9.5.0
csky                  randconfig-001-20260227    clang-23
csky                  randconfig-002-20260226    gcc-14.3.0
csky                  randconfig-002-20260227    clang-23
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260226    clang-23
hexagon               randconfig-001-20260227    clang-23
hexagon               randconfig-002-20260226    clang-23
hexagon               randconfig-002-20260227    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260226    gcc-14
i386        buildonly-randconfig-001-20260227    clang-20
i386        buildonly-randconfig-002-20260226    gcc-14
i386        buildonly-randconfig-002-20260227    clang-20
i386        buildonly-randconfig-003-20260226    gcc-14
i386        buildonly-randconfig-003-20260227    clang-20
i386        buildonly-randconfig-004-20260226    gcc-14
i386        buildonly-randconfig-004-20260227    clang-20
i386        buildonly-randconfig-005-20260226    gcc-14
i386        buildonly-randconfig-005-20260227    clang-20
i386        buildonly-randconfig-006-20260226    gcc-14
i386        buildonly-randconfig-006-20260227    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260226    clang-20
i386                  randconfig-001-20260227    clang-20
i386                  randconfig-002-20260226    clang-20
i386                  randconfig-002-20260227    clang-20
i386                  randconfig-003-20260226    clang-20
i386                  randconfig-003-20260227    clang-20
i386                  randconfig-004-20260226    clang-20
i386                  randconfig-004-20260227    clang-20
i386                  randconfig-005-20260226    clang-20
i386                  randconfig-005-20260227    clang-20
i386                  randconfig-006-20260226    clang-20
i386                  randconfig-006-20260227    clang-20
i386                  randconfig-007-20260226    clang-20
i386                  randconfig-007-20260227    clang-20
i386                  randconfig-011-20260226    gcc-14
i386                  randconfig-011-20260227    gcc-14
i386                  randconfig-012-20260226    gcc-14
i386                  randconfig-012-20260227    gcc-14
i386                  randconfig-013-20260226    gcc-14
i386                  randconfig-013-20260227    gcc-14
i386                  randconfig-014-20260226    gcc-14
i386                  randconfig-014-20260227    gcc-14
i386                  randconfig-015-20260226    gcc-14
i386                  randconfig-015-20260227    gcc-14
i386                  randconfig-016-20260226    gcc-14
i386                  randconfig-016-20260227    gcc-14
i386                  randconfig-017-20260226    gcc-14
i386                  randconfig-017-20260227    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260226    clang-23
loongarch             randconfig-001-20260226    gcc-15.2.0
loongarch             randconfig-001-20260227    clang-23
loongarch             randconfig-002-20260226    clang-20
loongarch             randconfig-002-20260226    clang-23
loongarch             randconfig-002-20260227    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-18
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260226    clang-23
nios2                 randconfig-001-20260226    gcc-11.5.0
nios2                 randconfig-001-20260227    clang-23
nios2                 randconfig-002-20260226    clang-23
nios2                 randconfig-002-20260226    gcc-11.5.0
nios2                 randconfig-002-20260227    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                   de0_nano_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260226    clang-16
parisc                randconfig-001-20260226    gcc-14.3.0
parisc                randconfig-001-20260227    clang-17
parisc                randconfig-002-20260226    clang-16
parisc                randconfig-002-20260226    gcc-12.5.0
parisc                randconfig-002-20260227    clang-17
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-18
powerpc               randconfig-001-20260226    clang-16
powerpc               randconfig-001-20260226    gcc-11.5.0
powerpc               randconfig-001-20260227    clang-17
powerpc               randconfig-002-20260226    clang-16
powerpc               randconfig-002-20260227    clang-17
powerpc                  storcenter_defconfig    clang-18
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260226    clang-16
powerpc64             randconfig-001-20260226    gcc-8.5.0
powerpc64             randconfig-001-20260227    clang-17
powerpc64             randconfig-002-20260226    clang-16
powerpc64             randconfig-002-20260226    clang-23
powerpc64             randconfig-002-20260227    clang-17
riscv                            alldefconfig    clang-18
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260226    clang-23
riscv                 randconfig-001-20260226    gcc-15.2.0
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-002-20260227    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260226    clang-23
s390                  randconfig-001-20260226    gcc-15.2.0
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-002-20260226    gcc-15.2.0
s390                  randconfig-002-20260226    gcc-8.5.0
s390                  randconfig-002-20260227    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                             espt_defconfig    clang-18
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                            migor_defconfig    clang-18
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260226    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-002-20260226    gcc-15.2.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260226    gcc-8.5.0
sparc                 randconfig-001-20260227    clang-23
sparc                 randconfig-002-20260226    gcc-8.5.0
sparc                 randconfig-002-20260227    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260226    gcc-8.5.0
sparc64               randconfig-001-20260227    clang-23
sparc64               randconfig-002-20260226    gcc-8.5.0
sparc64               randconfig-002-20260227    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260226    gcc-8.5.0
um                    randconfig-001-20260227    clang-23
um                    randconfig-002-20260226    gcc-8.5.0
um                    randconfig-002-20260227    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260226    gcc-14
x86_64      buildonly-randconfig-001-20260227    gcc-14
x86_64      buildonly-randconfig-002-20260226    gcc-14
x86_64      buildonly-randconfig-002-20260227    gcc-14
x86_64      buildonly-randconfig-003-20260226    gcc-14
x86_64      buildonly-randconfig-003-20260227    gcc-14
x86_64      buildonly-randconfig-004-20260226    gcc-14
x86_64      buildonly-randconfig-004-20260227    gcc-14
x86_64      buildonly-randconfig-005-20260226    gcc-14
x86_64      buildonly-randconfig-005-20260227    gcc-14
x86_64      buildonly-randconfig-006-20260226    gcc-14
x86_64      buildonly-randconfig-006-20260227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260226    gcc-14
x86_64                randconfig-002-20260226    gcc-14
x86_64                randconfig-003-20260226    gcc-14
x86_64                randconfig-004-20260226    gcc-14
x86_64                randconfig-005-20260226    clang-20
x86_64                randconfig-005-20260226    gcc-14
x86_64                randconfig-006-20260226    gcc-14
x86_64                randconfig-011-20260226    gcc-14
x86_64                randconfig-011-20260227    gcc-14
x86_64                randconfig-012-20260226    gcc-14
x86_64                randconfig-012-20260227    gcc-14
x86_64                randconfig-013-20260226    gcc-14
x86_64                randconfig-013-20260227    gcc-14
x86_64                randconfig-014-20260226    gcc-14
x86_64                randconfig-014-20260227    gcc-14
x86_64                randconfig-015-20260226    gcc-14
x86_64                randconfig-015-20260227    gcc-14
x86_64                randconfig-016-20260226    gcc-14
x86_64                randconfig-016-20260227    gcc-14
x86_64                randconfig-071-20260226    clang-20
x86_64                randconfig-071-20260226    gcc-14
x86_64                randconfig-071-20260227    gcc-14
x86_64                randconfig-072-20260226    clang-20
x86_64                randconfig-072-20260226    gcc-14
x86_64                randconfig-072-20260227    gcc-14
x86_64                randconfig-073-20260226    gcc-14
x86_64                randconfig-073-20260227    gcc-14
x86_64                randconfig-074-20260226    clang-20
x86_64                randconfig-074-20260226    gcc-14
x86_64                randconfig-074-20260227    gcc-14
x86_64                randconfig-075-20260226    gcc-13
x86_64                randconfig-075-20260226    gcc-14
x86_64                randconfig-075-20260227    gcc-14
x86_64                randconfig-076-20260226    clang-20
x86_64                randconfig-076-20260226    gcc-14
x86_64                randconfig-076-20260227    gcc-14
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
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260226    gcc-8.5.0
xtensa                randconfig-001-20260227    clang-23
xtensa                randconfig-002-20260226    gcc-8.5.0
xtensa                randconfig-002-20260227    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
