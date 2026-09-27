Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81C41D4F4
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553365; cv=none; b=k73ZBl2L6bNBM7xa50ecbnfx4RqE1CGXU3JMUoPhRTuT3LLsQ4ktt+KW8NZRjo1ODm7FTsfGHdP/lAQR1/aoUiPy7Sx43awl6YpyCssNQxPFzkUoEs3JoYxUUq16bV68RHV2ndP27yPsz/V573hwd2Xy6ACquXRsE6yRSNHPZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553365; c=relaxed/simple;
	bh=BBWvl2+yGeK7HOxgA/QgN5p3Nuv90zOIekorAygJXtM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qXgOnzStIkBqIF/nlH9dpjdYKQ30j44YXPGl7Hw/D1vySn3y6QA92y+m2uabn8VW+VfKz3puJk1SK+qgBPo87nW0CPZ8VuD+E0E8bQ60swRd1rG5P8PKSxM4/BEgx2UFoUt1UtOMZ6utNF9u9/IDTa9yJUSOLEZMYHHUIqtAGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts9gQZjv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts9gQZjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790553361; x=1822089361;
  h=date:from:to:cc:subject:message-id;
  bh=BBWvl2+yGeK7HOxgA/QgN5p3Nuv90zOIekorAygJXtM=;
  b=Ts9gQZjv6DsFJoqib26RJLiaorqY6VktyGDDjI37/KACYy8Aj4IKnjyA
   NSLbI3x24urXJQ7iAAvBwyyOS2X00YBR7SQgvxm7eq6OygvS7/bZy/USp
   etH14DgtAbKBCBgT2SIMJLZCA+OuTT6SWd+2nOpdkxvueyIDhM2vlLaYv
   DvmS7cSGNDhd+MHgtXNWlFwOviI0JuN0mYd1nSo65568OSLhA7KM/jRuB
   H6JYEH2R4H35fvhgj9xnX1OR/dV5Ig147CMamT3JxPaxlYMAJLGblYrmb
   GQGBivC5tOJXJEAQXNJcjs8Swr1sS+xL+mX6emV4RXbTFGwkCSFPOYZBm
   w==;
X-CSE-ConnectionGUID: Q5YF/PN5QSyl74Vz1m4e4g==
X-CSE-MsgGUID: ZGr8Ll7cQzCOErYXGYXeBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90115941"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="90115941"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 16:55:59 -0700
X-CSE-ConnectionGUID: PpMmZMhMSKaDQ7SgW1JBaA==
X-CSE-MsgGUID: l4/+JrwISnqlHQJdhnO+gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="274947879"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Sep 2026 16:55:58 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xAyiq-00000000NHG-0k0e;
	Sun, 27 Sep 2026 23:55:56 +0000
Date: Mon, 28 Sep 2026 07:55:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-rcar-gen4] BUILD SUCCESS
 295657e392df0ccd19e95f3eb7db309ee2aad449
Message-ID: <202609280733.YR3IpuHR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
branch HEAD: 295657e392df0ccd19e95f3eb7db309ee2aad449  PCI: rcar-gen4: Add Application/Local register reset control

elapsed time: 2416m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1001-20260927    gcc-11.5.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                        imx_v6_v7_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1003-20260927    gcc-11.5.0
arm                           sp7021_defconfig    clang-24
arm                           sp7021_defconfig    gcc-11.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1003-20260927    clang-17
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1001-20260927    clang-17
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1000-20260928    gcc-8.5.0
hexagon               randconfig-1001-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260928    gcc-8.5.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1005-20260927    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1013-20260927    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1000-20260928    gcc-8.5.0
loongarch             randconfig-1001-20260927    gcc-11.5.0
loongarch             randconfig-1001-20260928    gcc-8.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    gcc-11.5.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    gcc-11.5.0
mips                           eyeq6_defconfig    clang-24
nios2                             alldefconfig    gcc-11.5.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1000-20260928    gcc-8.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260928    gcc-8.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1000-20260928    clang-24
parisc                randconfig-1001-20260927    clang-24
parisc                randconfig-1001-20260928    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                    lite5200b_defconfig    clang-24
powerpc                      powernv_defconfig    clang-24
powerpc                          ps3_defconfig    clang-24
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1000-20260928    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc               randconfig-1001-20260928    clang-24
powerpc                      tqm8541_defconfig    gcc-11.5.0
powerpc                      tqm8548_defconfig    gcc-11.5.0
powerpc                      tqm8555_defconfig    gcc-11.5.0
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1000-20260928    clang-24
powerpc64             randconfig-1001-20260927    clang-24
powerpc64             randconfig-1001-20260928    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260927    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1001-20260927    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1001-20260927    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1001-20260927    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1001-20260927    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1001-20260927    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1001-20260927    clang-24
xtensa                     smp_lx200_defconfig    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
