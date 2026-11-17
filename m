Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933179;
	b=fhaufRZMSUzBBN7o8xXv/cIOd4T8SxA2P+q4ij51HYS8CWYiebzeM/c7R+E0cLrxzLV8
	 M8YpkSfgZvtaO7EhDvFZILkoP2lCIEFgwdqMxF6nh0AbNwTiGc3aiJI8XWRwHZIfWyIFw
	 3PcdZ6mWyLYAr/FaEg0IRh2N0u7UPwQGjyHhyThhWotqsSrdcXCdR8doGugHY0X45jr6A
	 k98cU8X5/ofCBHdt6aw69qVQOx6n8nFFhH4ghRbliT6Xq5HukoqJkZNNWHKmOp960qupQ
	 3ms0yDpwdXnzCygwyF5ZXS2cU5PuqYClpzDmM3N1TfCm4Cfclf+cDg4EW+Oj+G/zQoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933179;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=WIAhLRI43FFYgXIoih+Q20ASxciDamv7AcrfCOcbSYw=;
	b=Kam63KYXLEvZt0SEe2Lz1G6TO5pKIVjUyV38BvcnvG/pJvJbwba9mUsCdOPvZJowGUsW
	 DBtadOeFR/5Kl/ONbwWIzVjUvhR50CVsXtnRChlGqk5FnW0lr5bbXVKA+yBs/nHwjkc4V
	 27PrZaO24vUb0Ua5scY/Kdr7mj2C7ok8/pY+W9frWMSY8RbAeMkncdV9PtOfjzA6v9p8d
	 Bsx+DcXvMZK/QiFvSIfbQbl81IUD0k1jB8WYVw3TF3T0IqyZTHDAk+qSXF8xK41oZNbKa
	 3p2oGxs1M2I1AecppVzRwp/XMZTV+6o4mptEmJzK1KIWOBQXiN32cwUZpygNur4ev9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MkLNM7zI;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F1606A31C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 16:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 248F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MkLNM7zI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794933179; x=1826469179;
  h=date:from:to:cc:subject:message-id;
  bh=iK5jWYttF1dLizBvCiDt2NRGMwRKhLiVyZYJ3MajhZY=;
  b=MkLNM7zIB4I+I3Q6RFhx2PbwI19jQvyM2LLytD3mDR28pa45zfqliRyA
   Dj7vhRYkGxDdPlC2+tC9EcNpI9zNUZJe1XjoxVZnaD2Dq7rxfBmiMQ0fY
   GkalBWrcIsmLyMfYHNUYGcon896to85U4N60erVGCXXh7HaYxg61BEgoj
   1o1bxdFRrTmIHOn/EM03J8zQYbfOhFKhhWFUedzwZgTf0JnXAFe+MrKej
   ekOG6KjlSBRtsgFnhJmHjiW2GONF9enx1DSQf775muAJl20TFo8ec0Bum
   EmQlT1xxPmUXVPUbEl3myv2s0kDwA+H4njC6bqjMwZ2kiMQCkoVe206Mn
   w==;
X-CSE-ConnectionGUID: 6Fq5XiGeTSOP0yAUVJPKRA==
X-CSE-MsgGUID: KaFmVVC+RpO+JGFeL7KmhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3729883"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3729883"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:32:59 -0800
X-CSE-ConnectionGUID: QNV79QVeR1a40fyHF8a/iQ==
X-CSE-MsgGUID: wdivCRCXRACZAt/NtRzovQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11612426"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 17 Nov 2026 08:32:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTM75-00000001C1W-03sD;
	Tue, 17 Nov 2026 16:32:55 +0000
Date: Wed, 18 Nov 2026 00:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc] BUILD SUCCESS
 7bf2db752515a9020b310984ae3bce1089cfdf20
Message-ID: <20261118003205.qXgSFhER-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 7bf2db752515a9020b310984ae3bce1089cfdf20  PCI: dwc: ultrarisc: Use cached PCIe capability offset

elapsed time: 1393m

configs tested: 174
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    clang-24
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2200-20261116    gcc-15.3.0 smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261117    gcc-13.5.0
arc                   randconfig-1001-20261117    gcc-13.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261117    gcc-13.5.0
arm                   randconfig-1001-20261117    gcc-13.5.0
arm                   randconfig-1002-20261117    gcc-13.5.0
arm                   randconfig-1003-20261117    gcc-13.5.0
arm                   randconfig-2200-20261116    gcc-13.5.0 smatch
arm                            spitz_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261117    gcc-16.2.0
arm64                 randconfig-1001-20261117    gcc-16.2.0
arm64                 randconfig-1002-20261117    gcc-16.2.0
arm64                 randconfig-1003-20261117    gcc-16.2.0
arm64                 randconfig-2200-20261116    gcc-8.5.0  smatch
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261117    gcc-16.2.0
csky                  randconfig-1001-20261117    gcc-16.2.0
csky                  randconfig-2200-20261116    gcc-16.2.0 smatch
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261117    clang-17
hexagon               randconfig-1001-20261117    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261117    clang-22
i386        buildonly-randconfig-1001-20261117    clang-22
i386        buildonly-randconfig-1002-20261117    clang-22
i386        buildonly-randconfig-1003-20261117    clang-22
i386        buildonly-randconfig-1004-20261117    clang-22
i386        buildonly-randconfig-1005-20261117    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261117    gcc-14
i386                  randconfig-1001-20261117    gcc-14
i386                  randconfig-1002-20261117    gcc-14
i386                  randconfig-1003-20261117    gcc-14
i386                  randconfig-1004-20261117    gcc-14
i386                  randconfig-1005-20261117    gcc-14
i386                  randconfig-1006-20261117    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    clang-24
loongarch             randconfig-1000-20261117    clang-17
loongarch             randconfig-1001-20261117    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2200-20261116    gcc-11.5.0 smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    clang-24
mips                           eyeq6_defconfig    clang-24
mips                             gpr_defconfig    clang-24
mips                       maltaaprp_defconfig    clang-24
mips                          rt305x_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261117    clang-17
nios2                 randconfig-1001-20261117    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261117    gcc-9.5.0
parisc                randconfig-1001-20261117    gcc-9.5.0
parisc                randconfig-2200-20261116    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    clang-24
powerpc                       cm5200_defconfig    clang-24
powerpc                       ep88xc_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-1000-20261117    gcc-9.5.0
powerpc               randconfig-1001-20261117    gcc-9.5.0
powerpc                   storcenter_defconfig    clang-24
powerpc64             randconfig-1000-20261117    gcc-9.5.0
powerpc64             randconfig-1001-20261117    gcc-9.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261117    clang-24
riscv                 randconfig-1001-20261117    clang-24
riscv                 randconfig-2200-20261116    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261117    clang-24
s390                  randconfig-1001-20261117    clang-24
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261117    clang-24
sh                    randconfig-1001-20261117    clang-24
sh                    randconfig-2200-20261116    gcc-15.3.0 smatch
sh                            sh2007_defconfig    clang-24
sh                              shx3_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-2200-20261116    gcc-8.5.0  smatch
um                                alldefconfig    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-2200-20261116    gcc-14     smatch
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261117    clang-22
x86_64                randconfig-1001-20261117    clang-22
x86_64                randconfig-1002-20261117    clang-22
x86_64                randconfig-1003-20261117    clang-22
x86_64                randconfig-1004-20261117    clang-22
x86_64                randconfig-1005-20261117    clang-22
x86_64                randconfig-1006-20261117    gcc-14
x86_64                randconfig-1007-20261117    gcc-14
x86_64                randconfig-1008-20261117    gcc-14
x86_64                randconfig-1009-20261117    gcc-14
x86_64                randconfig-1010-20261117    gcc-14
x86_64                randconfig-1011-20261117    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   nommu_kc705_defconfig    clang-24

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
