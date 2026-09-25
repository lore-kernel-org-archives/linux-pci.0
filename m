Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B73148C9
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334476; cv=none; b=HDQUGPZN1IuF2MpgPrFe1+7QWoFgtSm3oft2Leas8Ybcv60yjBDYQH1PTVbhxM8Gle0itX6mI1xI3I4GaO06flVBfmgHYRHVnzJAtSEDgPBhr81T9D6KDBLObpx4DIaEW4I632G8EmVnmuREsnzXAUAyk9Dhaf3+YO/j4x6Cg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334476; c=relaxed/simple;
	bh=zh1Am4k9Vl9rrDpCX765CdwK7SCCZ/sA3W2+3Iiei8E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DbdSi6sxBBcpYbgB76nELHJnZWWwslfyCZYlXXncLpxWmikJyVeaFAXImwlZiHdwtjGuIggmlGOg2ulRiI8CAozU3TcGmQpDxQysVAeUX89iYYsgvTXSl1oU4lVSWAu2Cp0+n5npSXi35p2cj/S6Py+t4BmlU5JsLJoUSwZOPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPtQqcKP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPtQqcKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790334474; x=1821870474;
  h=date:from:to:cc:subject:message-id;
  bh=zh1Am4k9Vl9rrDpCX765CdwK7SCCZ/sA3W2+3Iiei8E=;
  b=KPtQqcKPbwIVt074AX4/kWMDYeeLIs5oqE68hUzta8E9loZDr/zV5Nr7
   LwpgpNd7Q5C2TCQ+MCUFJOZKpx+73lwON3PvdillKH+5zAraXmH+DV0Lu
   irgKPnbt3762eLsHFcYNwp/fsrHi3rD3vDdwh+QbdEpNbskB3IXyIcnM9
   AwWSVJM0IwAx3ErF7Avhy8NYQ/JBMsHXI7zbOE924VlnCi8T8tXxONNHG
   lK72jqiycxiq6ManU1OGih0lXKgWvTpHCC79JCvElGI0k8Z5EyEoC9wI1
   TxWByOQwVfDJ1ruWHvvvy1SQ3BZxHZofa8mg4bhjYsiANjzHIlh9MyVm9
   w==;
X-CSE-ConnectionGUID: mkdlEvT6THelIsj+Bpykhw==
X-CSE-MsgGUID: R9YAV2mERRmrN2q2SzGC2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90982146"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90982146"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 04:07:54 -0700
X-CSE-ConnectionGUID: 3OxLeymtSuOycp1OQ3ne9w==
X-CSE-MsgGUID: wZgfemBrQEm1sYau4aaG8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273541248"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Sep 2026 04:07:52 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xA3mQ-00000000KUs-1rjO;
	Fri, 25 Sep 2026 11:07:50 +0000
Date: Fri, 25 Sep 2026 19:06:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 708e96caa199c863b5601f30a0aeaad7fbc53b0f
Message-ID: <202609251951.NNDhX6zz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 708e96caa199c863b5601f30a0aeaad7fbc53b0f  arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller

elapsed time: 1133m

configs tested: 251
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20260924    gcc-11.5.0 cocci
alpha                randconfig-r2103-20260924    gcc-11.5.0 cocci
alpha                randconfig-r2106-20260924    gcc-14     cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260925    clang-24
arc                   randconfig-1001-20260925    clang-24
arc                  randconfig-r1301-20260925    gcc-11.5.0 sparse
arc                            tb10x_defconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           pxa910_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260925    clang-24
arm                   randconfig-1001-20260925    clang-24
arm                   randconfig-1002-20260925    clang-24
arm                   randconfig-1003-20260925    clang-24
arm                  randconfig-r1309-20260925    clang-22   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260925    clang-24
arm64                 randconfig-1001-20260925    clang-24
arm64                 randconfig-1002-20260925    clang-24
arm64                 randconfig-1003-20260925    clang-24
arm64                randconfig-r2101-20260924    gcc-8.5.0  cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260925    clang-24
csky                  randconfig-1001-20260925    clang-24
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260925    gcc-9.5.0
hexagon               randconfig-1001-20260925    gcc-9.5.0
hexagon              randconfig-r2107-20260924    gcc-14     cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260925    clang-22
i386        buildonly-randconfig-1001-20260925    clang-22
i386        buildonly-randconfig-1002-20260925    clang-22
i386        buildonly-randconfig-1003-20260925    clang-22
i386        buildonly-randconfig-1004-20260925    clang-22
i386        buildonly-randconfig-1005-20260925    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260925    clang-22
i386                  randconfig-1001-20260925    clang-22
i386                  randconfig-1002-20260925    clang-22
i386                  randconfig-1003-20260925    clang-22
i386                  randconfig-1004-20260925    clang-22
i386                  randconfig-1005-20260925    clang-22
i386                  randconfig-1006-20260925    clang-22
i386                  randconfig-1007-20260925    gcc-12
i386                  randconfig-1008-20260925    gcc-12
i386                  randconfig-1009-20260925    gcc-12
i386                  randconfig-1010-20260925    gcc-12
i386                  randconfig-1011-20260925    gcc-12
i386                  randconfig-1012-20260925    gcc-12
i386                  randconfig-1013-20260925    gcc-12
i386                  randconfig-1300-20260925    clang-22   sparse
i386                  randconfig-1301-20260925    clang-22   sparse
i386                  randconfig-1302-20260925    clang-22   sparse
i386                  randconfig-2100-20260924    clang-22   cocci
i386                  randconfig-2101-20260924    gcc-14     cocci
i386                  randconfig-2102-20260924    clang-22   cocci
i386                  randconfig-2103-20260924    gcc-14     cocci
i386                  randconfig-2200-20260924    clang-22   smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260925    gcc-9.5.0
loongarch             randconfig-1001-20260925    gcc-9.5.0
loongarch            randconfig-r1308-20260925    clang-22   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2201-20260924    gcc-8.5.0  smatch
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r1304-20260925    gcc-11.5.0 sparse
microblaze           randconfig-r2101-20260924    gcc-11.5.0 cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20260924    clang-22   cocci
mips                 randconfig-r2103-20260924    clang-19   cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260925    gcc-9.5.0
nios2                 randconfig-1001-20260925    gcc-9.5.0
nios2                randconfig-r1302-20260925    gcc-11.5.0 sparse
nios2                randconfig-r2102-20260924    gcc-8.5.0  cocci
nios2                randconfig-r2105-20260924    gcc-14     cocci
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2200-20260924    gcc-13.4.0 smatch
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260925    clang-24
parisc                randconfig-1001-20260925    clang-24
parisc               randconfig-r1307-20260925    clang-22   sparse
parisc               randconfig-r2201-20260924    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260925    clang-24
powerpc               randconfig-1001-20260925    clang-24
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260925    clang-24
powerpc64             randconfig-1001-20260925    clang-24
powerpc64            randconfig-r1303-20260925    gcc-11.5.0 sparse
powerpc64            randconfig-r2106-20260924    clang-24   cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260925    clang-24
riscv                 randconfig-1001-20260925    clang-24
riscv                 randconfig-2000-20260924    clang-24
riscv                 randconfig-2001-20260924    clang-24
riscv                 randconfig-2001-20260924    gcc-8.5.0
riscv                randconfig-r2104-20260924    gcc-12.5.0 cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260925    clang-24
s390                  randconfig-1001-20260925    clang-24
s390                  randconfig-2000-20260924    clang-24
s390                  randconfig-2000-20260924    gcc-14.3.0
s390                  randconfig-2001-20260924    clang-24
s390                 randconfig-r2107-20260924    gcc-8.5.0  cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260925    clang-24
sh                    randconfig-1001-20260925    clang-24
sh                    randconfig-2000-20260924    clang-24
sh                    randconfig-2000-20260924    gcc-16.1.0
sh                    randconfig-2001-20260924    clang-24
sh                    randconfig-2001-20260924    gcc-13.4.0
sh                   randconfig-r2202-20260924    gcc-14.3.0 smatch
sh                            sh2007_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260925    gcc-12
sparc                 randconfig-1001-20260925    gcc-12
sparc                 randconfig-2000-20260924    gcc-11.5.0
sparc                 randconfig-2000-20260924    gcc-13.4.0
sparc                 randconfig-2001-20260924    gcc-13.4.0
sparc                randconfig-r1300-20260925    gcc-11.5.0 sparse
sparc                randconfig-r1305-20260925    gcc-11.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260925    gcc-12
sparc64               randconfig-1001-20260925    gcc-12
sparc64               randconfig-2000-20260924    clang-20
sparc64               randconfig-2000-20260924    gcc-13.4.0
sparc64               randconfig-2001-20260924    clang-20
sparc64               randconfig-2001-20260924    gcc-13.4.0
sparc64              randconfig-r2100-20260924    gcc-11.5.0 cocci
sparc64              randconfig-r2105-20260924    clang-20   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260925    gcc-12
um                    randconfig-1001-20260925    gcc-12
um                    randconfig-2000-20260924    clang-24
um                    randconfig-2000-20260924    gcc-13.4.0
um                    randconfig-2001-20260924    clang-17
um                    randconfig-2001-20260924    gcc-13.4.0
um                   randconfig-r2202-20260924    gcc-14     smatch
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260925    clang-22
x86_64      buildonly-randconfig-1001-20260925    clang-22
x86_64      buildonly-randconfig-1002-20260925    clang-22
x86_64      buildonly-randconfig-1003-20260925    clang-22
x86_64      buildonly-randconfig-1004-20260925    clang-22
x86_64      buildonly-randconfig-1005-20260925    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260925    gcc-14
x86_64                randconfig-1001-20260925    gcc-14
x86_64                randconfig-1002-20260925    gcc-14
x86_64                randconfig-1003-20260925    gcc-14
x86_64                randconfig-1004-20260925    gcc-14
x86_64                randconfig-1005-20260925    gcc-14
x86_64                randconfig-1006-20260925    clang-22
x86_64                randconfig-1007-20260925    clang-22
x86_64                randconfig-1008-20260925    clang-22
x86_64                randconfig-1009-20260925    clang-22
x86_64                randconfig-1010-20260925    clang-22
x86_64                randconfig-1011-20260925    clang-22
x86_64                randconfig-1012-20260925    clang-22
x86_64                randconfig-1013-20260925    clang-22
x86_64                randconfig-1014-20260925    clang-22
x86_64                randconfig-1015-20260925    clang-22
x86_64                randconfig-1016-20260925    clang-22
x86_64                randconfig-1017-20260925    clang-22
x86_64                randconfig-1300-20260925    clang-22   sparse
x86_64                randconfig-1301-20260925    clang-22   sparse
x86_64                randconfig-1302-20260925    clang-22   sparse
x86_64                randconfig-2100-20260924    clang-22   cocci
x86_64                randconfig-2100-20260924    gcc-14     cocci
x86_64                randconfig-2101-20260924    clang-22   cocci
x86_64                randconfig-2102-20260924    clang-22   cocci
x86_64                randconfig-2103-20260924    clang-22   cocci
x86_64                randconfig-2200-20260924    clang-22   smatch
x86_64               randconfig-r1306-20260925    clang-22   sparse
x86_64               randconfig-r2104-20260924    gcc-14     cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260925    gcc-12
xtensa                randconfig-1001-20260925    gcc-12
xtensa                randconfig-2000-20260924    gcc-13.4.0
xtensa                randconfig-2001-20260924    gcc-11.5.0
xtensa                randconfig-2001-20260924    gcc-13.4.0
xtensa                     xip_kc705_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
