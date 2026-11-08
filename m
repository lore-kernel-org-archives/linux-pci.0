Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794139365;
	b=aZ73tq19oWIUlc2BpaCpInvaA22qEcrfkA9deYe9FzTN+79NOKCvL2BqlEaAuF9dg9zS
	 v2rknTO3wfhmMRMuv/OqIDJAHSImSfPhYIDIUInBFrAggCh8TcSYB9uPAxUc6ORDZg3zQ
	 +0glMYX1C2X3dqaeVX/0O7MlWGO3Sj5qClq5M6FzzhcHxUpClEE+yThbPwLW/BjNZN635
	 yfsUMAfjf/iMaPi56ohZ+3zuVVr9x7Vbb5FIllKn39WfdgIk0yj9aXMButSv2RzEScqVt
	 c12rHgJnkMgM8c20jpP9s/J1lW8aTd48ikQ+hTPRXCku5fo29UmyfeBVZoNOkpMkzMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139365;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=s+Zt31ZYxLaCOgw6kvdpkBal4R5za7SnSOxcVPH64Hw=;
	b=wacPwSQ8fEZesg1+hwbIns2+pPhR3ORL6dUmZylnvat32K09sbzMQ8jsSiZDAg3QSvtH
	 Th8nGH4yoXEN+Io88/YROH4x8vG8dIDBM64iPelrnpwKOM5+MK4bfHGMIi/FSVHVNOeQs
	 ipyqNj5NkCyTEzLYKOX6RFLqkAc3cQl/QzIjFRg0WmPkWjCwcNIQKGgVMO6VJB2HzUCGP
	 dhpGWgERd+MDa5BFyq47BLOH6K7q8KbG2pnlk7oG7P0WcH/Gg6fkVStABEwFwt+Zsz61m
	 7l+gv/8n+7ZJfTL6TFYiP+AJpyc8pj28wRXZiyUikTeNNShxWH1MnjqfQ0KeTNsc3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RaYZ3e/P";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287E606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 12:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B287E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RaYZ3e/P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794139363; x=1825675363;
  h=date:from:to:cc:subject:message-id;
  bh=ZmAzZbeKi/rnuXWBfHYy65vJm0ic++SYHebIN7z2qRg=;
  b=RaYZ3e/PaUIPjoVK5fVKC3EbPQ5lCNoA6wgeFmyEM4oYIhfT+J7uo8/u
   zhx3UO2XENqtI350Gcsu9yD79QcMSgFEnztP2zttrRhJi0yigMezzBekV
   CGT/e5u8k9OvNCHSvtGwyA29GL28c0JbHHrqCmZ9f5F5rmBCt1uS3lxfP
   QrkORN6uGc3GRscsLehGAnNxUrxtK3c716bdSyA15K1nL9M+vdbNCjSGr
   ENaif5bVMU2v/erVQZ/XTWuR535cJMio1TDE4Z0ULJNhphvKLyBEVFFoW
   3MDSe6B1jKpAoBaWrF9DDQSR07r4mhiAaU+1fqZOOa09cvpjU+NHxnu9P
   g==;
X-CSE-ConnectionGUID: SJwp9cQQTry4dlyFu117eg==
X-CSE-MsgGUID: /U3itJRvQ+iwBZcUGMQyLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2902734"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2902734"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 04:02:43 -0800
X-CSE-ConnectionGUID: O6SR+TuBSBSwys8tcM0MnQ==
X-CSE-MsgGUID: Qjdph8kkQeiE+Yy/gI0ETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7792552"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2026 04:02:42 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQ1bc-00000000stn-03ui;
	Sun, 08 Nov 2026 12:02:40 +0000
Date: Sun, 08 Nov 2026 20:02:35 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:mt7621] BUILD SUCCESS
 db7c929526a3cb4b41d2371a23703380b309339e
Message-ID: <20261108200235.PwB92WIV-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mt7621
branch HEAD: db7c929526a3cb4b41d2371a23703380b309339e  PCI: mt7621: Fix reset control leak on PHY initialization failure

elapsed time: 839m

configs tested: 192
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261108    gcc-11.5.0
arc                   randconfig-1001-20261108    gcc-11.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    gcc-16.2.0
arm                           ep93xx_defconfig    clang-24
arm                         multi_v7_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261108    gcc-11.5.0
arm                   randconfig-1001-20261108    gcc-11.5.0
arm                   randconfig-1002-20261108    gcc-11.5.0
arm                   randconfig-1003-20261108    gcc-11.5.0
arm                         realview_defconfig    clang-19
arm                            stm32_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                       quartz64_defconfig    clang-24
arm64                       quartz64_defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261108    clang-24
arm64                 randconfig-1001-20261108    clang-24
arm64                 randconfig-1002-20261108    clang-24
arm64                 randconfig-1003-20261108    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261108    clang-24
csky                  randconfig-1001-20261108    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261108    gcc-16.2.0
hexagon               randconfig-1001-20261108    gcc-16.2.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261108    clang-22
i386        buildonly-randconfig-1001-20261108    clang-22
i386        buildonly-randconfig-1002-20261108    clang-22
i386        buildonly-randconfig-1003-20261108    clang-22
i386        buildonly-randconfig-1004-20261108    clang-22
i386        buildonly-randconfig-1005-20261108    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261108    gcc-14
i386                  randconfig-1001-20261108    gcc-14
i386                  randconfig-1002-20261108    gcc-14
i386                  randconfig-1003-20261108    gcc-14
i386                  randconfig-1004-20261108    gcc-14
i386                  randconfig-1005-20261108    gcc-14
i386                  randconfig-1006-20261108    gcc-14
i386                  randconfig-1007-20261108    clang-22
i386                  randconfig-1008-20261108    clang-22
i386                  randconfig-1009-20261108    clang-22
i386                  randconfig-1010-20261108    clang-22
i386                  randconfig-1011-20261108    clang-22
i386                  randconfig-1012-20261108    clang-22
i386                  randconfig-1013-20261108    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261108    gcc-16.2.0
loongarch             randconfig-1001-20261108    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           sun3x_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            gcw0_defconfig    clang-19
mips                         qi_lb60_defconfig    gcc-16.2.0
mips                            xway_defconfig    clang-19
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261108    gcc-16.2.0
nios2                 randconfig-1001-20261108    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-32bit_defconfig    clang-24
parisc                randconfig-1000-20261108    clang-24
parisc                randconfig-1001-20261108    clang-24
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.2.0
powerpc                      akebono_defconfig    clang-19
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261108    clang-24
powerpc               randconfig-1001-20261108    clang-24
powerpc                      taishan_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    gcc-16.2.0
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261108    clang-24
powerpc64             randconfig-1001-20261108    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                         apsh4ad0a_defconfig    clang-19
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                           r7785rp_defconfig    clang-19
sh                           rsk7269_defconfig    clang-24
sh                            se7750_defconfig    clang-24
sh                         sh7763rdp_defconfig    clang-19
sh                             shmin_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261108    gcc-8.5.0
sparc                 randconfig-1001-20261108    gcc-8.5.0
sparc                        sparc32_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261108    gcc-8.5.0
sparc64               randconfig-1001-20261108    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261108    gcc-8.5.0
um                    randconfig-1001-20261108    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261108    gcc-14
x86_64      buildonly-randconfig-1001-20261108    gcc-14
x86_64      buildonly-randconfig-1002-20261108    gcc-14
x86_64      buildonly-randconfig-1003-20261108    gcc-14
x86_64      buildonly-randconfig-1004-20261108    gcc-14
x86_64      buildonly-randconfig-1005-20261108    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261108    gcc-14
x86_64                randconfig-1001-20261108    gcc-14
x86_64                randconfig-1002-20261108    gcc-14
x86_64                randconfig-1003-20261108    gcc-14
x86_64                randconfig-1004-20261108    gcc-14
x86_64                randconfig-1005-20261108    gcc-14
x86_64                randconfig-1006-20261108    clang-22
x86_64                randconfig-1007-20261108    clang-22
x86_64                randconfig-1008-20261108    clang-22
x86_64                randconfig-1009-20261108    clang-22
x86_64                randconfig-1010-20261108    clang-22
x86_64                randconfig-1011-20261108    clang-22
x86_64                randconfig-1012-20261108    clang-22
x86_64                randconfig-1013-20261108    clang-22
x86_64                randconfig-1014-20261108    clang-22
x86_64                randconfig-1015-20261108    clang-22
x86_64                randconfig-1016-20261108    clang-22
x86_64                randconfig-1017-20261108    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261108    gcc-8.5.0
xtensa                randconfig-1001-20261108    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
