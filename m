Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958476;
	b=o25cGA2g/Ydx7OO1mM0OYW8d3rg8J+NrA+gzgjj+METcJ+ilSmIq05NGx1tH7rFl1sci
	 Zpg6fKfhL2MO3xsoDmUZ4f7WCJAQVhEzExFL+uUh9nRTegY0i3Rj0nCrGFC6u3ZplLJ41
	 hNZR4n7f9ne0ONSoF2z6kUV/uVVFsZidAi/oMHxrgS8rqBJSXqY8iQhEvHmAwuPOrVrsf
	 wTyAVgNstPgk4PXxu4bcYd1dURvhgI0MtrPcT+PMXNjpDltcZglFoXO60NUU5aPEK96bt
	 wSf2xfxEopaD48zpJCZxgXhkq65luMc2xlzFA1+WshnEpsJNp2XpnPnUO0k+WFFDuxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958476;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=+V0jxOnNqM3iwg9E6tuC9iDrIPu/ulqic5/apjTjHCQ=;
	b=orxOnyIjH0qPQHb5aN0WHbqGmhT9a6dV1AnHcEIimuzhm2hF35Ih0wqLLT4TpOjH6X4O
	 +9Ji97elabOmpfSILJP4Ti4DiKydfbPa5tdpI+GSicPwOnWfZmdUQymjhstldZvWG5MDI
	 Av4fvgXycgIQ3FZ8H0BVIZCj0L7DESdiF/4+CwnzrHma+DAZHuGFbb+9dojWtH/k0u9L+
	 yu703fH1+0Ewl4qz1py0dW6ALukGc7f/wpWbAMnXTqgmllcODB5YdMr1TaB8iLQshXO/z
	 CnirO6WhGB4vSPk0hTDY9QK08oY88pJ8npvPRR9lNK6NCACvxh29qL82ycOIEmIEYCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EbZSlsgr;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C97606A328
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 09:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C97606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EbZSlsgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793958475; x=1825494475;
  h=date:from:to:cc:subject:message-id;
  bh=XhHW2clz6husay19ONS4VCGTAh3xWrdv6+ji2lVZUKQ=;
  b=EbZSlsgruYSgFVtwm5LytbYfT1jgFToOdepKDfNosrqzGAnexTkq/mn+
   XvMH2dlCevhatW5DVF6iKiaJ/biUece9JGF22X1WbXlF9f8/n3/I0Uu0D
   AC1l3CIAg9x0XSlg8LN14s5+dvL2OPjOZNQWwWJM6eoNAoX4rrOxh/2JA
   3LeYBDRpzL855ExzWv4pS+vfGjPO0GGOwITklSE+xkZGpVUjXuB2lcLM4
   GbbQrPdYMEYAF08Oj/HoeLyWFTIpzUHRh6GPbOc+zo65BIXxIrPNsnWlf
   fq72p+MISd09kurT/DdcFWs/w95il9NJ7aDxu1TtyYBIjQFUfBZzR9MJn
   w==;
X-CSE-ConnectionGUID: xWXHbHTDS72KthYzMsAM9g==
X-CSE-MsgGUID: RGqPdU9nQnuwtdplE2GltA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2807567"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2807567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 01:47:55 -0800
X-CSE-ConnectionGUID: q6KuMjr0RjWz50XqgLIV8A==
X-CSE-MsgGUID: qcO995B2T9aswbjdsgldJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7281633"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2026 01:47:53 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPGY2-00000000osB-3WTz;
	Fri, 06 Nov 2026 09:47:50 +0000
Date: Fri, 06 Nov 2026 17:47:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:rcar-host] BUILD SUCCESS
 53bf862f48e27c1c4e4fb7e2f515d999eaf1df55
Message-ID: <20261106174721.6qiDbxvC-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-host
branch HEAD: 53bf862f48e27c1c4e4fb7e2f515d999eaf1df55  PCI: rcar-host: Free MSI IRQs on error

elapsed time: 2368m

configs tested: 341
configs skipped: 27

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-19
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                           axs103_defconfig    clang-19
arc                           axs103_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261105    gcc-14.4.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261105    gcc-14.4.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                         vdk_hs38_defconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            imxrt_defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                   randconfig-1000-20261105    gcc-14.4.0
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261105    gcc-14.4.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261105    gcc-14.4.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261105    gcc-14.4.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                          s3c6400_defconfig    gcc-16.2.0
arm                            sama5_defconfig    gcc-16.2.0
arm                        spear13xx_defconfig    gcc-16.2.0
arm                            sunxi_defconfig    clang-17
arm                            sunxi_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261105    gcc-13.5.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261105    gcc-13.5.0
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261105    gcc-13.5.0
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261105    gcc-13.5.0
arm64                 randconfig-1003-20261106    clang-17
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261105    gcc-13.5.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261105    gcc-13.5.0
csky                  randconfig-1001-20261106    clang-17
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261105    clang-24
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261105    clang-24
hexagon               randconfig-1001-20261106    gcc-14.4.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261105    gcc-14
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1001-20261105    gcc-14
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1002-20261105    gcc-14
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1003-20261105    gcc-14
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1004-20261105    gcc-14
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1005-20261105    gcc-14
i386        buildonly-randconfig-1005-20261106    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261105    clang-22
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1001-20261105    clang-22
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1002-20261105    clang-22
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1003-20261105    clang-22
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1004-20261105    clang-22
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1005-20261105    clang-22
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1006-20261105    clang-22
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1007-20261105    clang-22
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1008-20261105    clang-22
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1009-20261105    clang-22
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1010-20261105    clang-22
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261105    clang-22
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261105    clang-22
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261105    clang-22
i386                  randconfig-1013-20261106    gcc-14
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261105    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261105    clang-24
loongarch             randconfig-1001-20261106    gcc-14.4.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           atari_defconfig    clang-17
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    gcc-16.2.0
m68k                         m5307c3_defconfig    gcc-16.2.0
m68k                         m5407c3_defconfig    gcc-16.2.0
m68k                       m54418evb_defconfig    clang-19
m68k                       m54418evb_defconfig    clang-24
m68k                         mvme147_defconfig    clang-24
m68k                          nettel_defconfig    gcc-16.2.0
m68k                           sun3x_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                      cu1830-neo_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    clang-17
mips                           eyeq5_defconfig    gcc-16.2.0
mips                      eyeq6lplus_defconfig    gcc-16.2.0
mips                            ip28_defconfig    gcc-16.2.0
mips                       loongson3_defconfig    gcc-16.2.0
mips                 malta_qemu_32r6_defconfig    clang-17
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    clang-19
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                            mtx1_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    gcc-16.2.0
mips                           rb532_defconfig    clang-24
mips                            xway_defconfig    gcc-16.2.0
nios2                          3c120_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261105    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261105    clang-24
nios2                 randconfig-1001-20261106    gcc-14.4.0
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-11.5.0
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    clang-19
openrisc          de0_nano_multicore_defconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                  simple_smp_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-64bit_defconfig    clang-24
parisc                randconfig-1000-20261105    clang-21
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261105    clang-21
parisc                randconfig-1001-20261106    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                      ep8248e_defconfig    clang-17
powerpc                       ep88xc_defconfig    clang-17
powerpc                     gamecube_defconfig    clang-19
powerpc                       mgcoge_defconfig    clang-17
powerpc                       mgcoge_defconfig    gcc-16.2.0
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                  mpc834x_itx_defconfig    gcc-16.2.0
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                   mpc885_ads_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc                       pmac32_defconfig    gcc-16.2.0
powerpc                      rainier_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261105    clang-21
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261105    clang-21
powerpc               randconfig-1001-20261106    clang-19
powerpc                      tqm8555_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261105    clang-21
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261105    clang-21
powerpc64             randconfig-1001-20261106    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261105    clang-24
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261105    clang-24
riscv                 randconfig-1001-20261106    gcc-14.4.0
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261105    clang-24
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261105    clang-24
s390                  randconfig-1001-20261106    gcc-14.4.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                              espt_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    clang-17
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                           polaris_defconfig    gcc-16.2.0
sh                           r7780mp_defconfig    gcc-16.2.0
sh                           r7785rp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261105    clang-24
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261105    clang-24
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                           rsk7201_defconfig    clang-17
sh                            se7724_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                   sh7785lcr_32bit_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sh                              shx3_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261105    gcc-8.5.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261105    gcc-8.5.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261105    gcc-8.5.0
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261105    gcc-8.5.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261105    gcc-8.5.0
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261105    gcc-8.5.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-19
x86_64                            alldefconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261105    gcc-14
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261105    gcc-14
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261105    gcc-14
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261105    gcc-14
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261105    gcc-14
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261105    gcc-14
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261105    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1001-20261105    clang-22
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1002-20261105    clang-22
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1003-20261105    clang-22
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1004-20261105    clang-22
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1005-20261105    clang-22
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1006-20261105    clang-22
x86_64                randconfig-1006-20261106    clang-22
x86_64                randconfig-1007-20261105    clang-22
x86_64                randconfig-1007-20261106    clang-22
x86_64                randconfig-1008-20261105    clang-22
x86_64                randconfig-1008-20261106    clang-22
x86_64                randconfig-1009-20261105    clang-22
x86_64                randconfig-1009-20261106    clang-22
x86_64                randconfig-1010-20261105    clang-22
x86_64                randconfig-1010-20261106    clang-22
x86_64                randconfig-1011-20261105    clang-22
x86_64                randconfig-1011-20261106    clang-22
x86_64                randconfig-1012-20261105    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261105    clang-22
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261105    clang-22
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261105    clang-22
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261105    clang-22
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261105    clang-22
x86_64                randconfig-1017-20261106    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-11.5.0
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                   nommu_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261105    gcc-8.5.0
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261105    gcc-8.5.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                     xip_kc705_defconfig    clang-17
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
