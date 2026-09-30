Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73315221F4
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790966; cv=none; b=kZPT7YY4WugjHVI6UxrL6Bkt2VE+5sB2itL42WUB8RbY1pPcPF9d78yVwLVfTnkt+RuNkWSlMiWIr0FMjQWp6tSPnNsM0dhESGuiq0nKm+N4cnTeKYfs+jqqQHtyiYw9eRk8n755fccIZ/I6AFEtH/ATC871sWxwJaMn1jLEtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790966; c=relaxed/simple;
	bh=Wyu5XkYO6SzPcOrMMcpo5CoCbR2oHN2yNtps9AIe6UM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=la8ixg1pRgvYWBSo5tJeifOzZwPVKezHNekJoY9EN4PMrZ/YuUteRG0KNiCBWWJBmSFVcO2jg2Jg1mC0Udrzz8FUlzo26N0lgi4W2PBeJ7+ethfgP5boW9QYCMVpnoG4EVKnRp1wzrSaNJPY6IPdjHiWH7sV2Fm38MrVCqqb4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbFrrCoO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbFrrCoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790964; x=1822326964;
  h=date:from:to:cc:subject:message-id;
  bh=Wyu5XkYO6SzPcOrMMcpo5CoCbR2oHN2yNtps9AIe6UM=;
  b=KbFrrCoOeVXtgSXntDEhtXSt9oqF/gWe5LmV1svazVSA/jTIlLMMuYc4
   MppuKDwOwVgKpogZhxn2mykJEVW3IcbN1lplSW2DW1bM9TCOoQKRaxq+n
   WzuJLSoy+f8/o5zUaBCZt1v4ohlEETnfqD9ShcHsNozqeFHKuCaTl9K2/
   nhKqQbo5v5k68nh/q/JY4Vd2INLcuzOn9cK8n7DT6g/hSEeXXngIzo2Pi
   c7qBkzVjMNI7FqcYFOpOhTGaVS6HIwsZEhWIFkqhSsfmfndnzsaXQu/Ln
   svZ16FFWilvL6gt09lyPffE4qQcdzan+d0NfZnNaQsdu1/Nn/shwtILtF
   Q==;
X-CSE-ConnectionGUID: D+QuyIPPRnK85201Yywszw==
X-CSE-MsgGUID: va5UkHkcRpK0yDWdqsj4Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102909877"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="102909877"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:56:03 -0700
X-CSE-ConnectionGUID: N/JRS2BOTmyLLc1jiExQ5g==
X-CSE-MsgGUID: +oelO7JHThmD9AUYAsjPTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="274956096"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 10:56:02 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xByX9-00000000QyQ-2uc0;
	Wed, 30 Sep 2026 17:55:59 +0000
Date: Thu, 01 Oct 2026 01:55:13 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc] BUILD SUCCESS
 4996364a46e738cc455f5fa9b8b09f2f3348bcc9
Message-ID: <202610010109.zpXmW7lX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 4996364a46e738cc455f5fa9b8b09f2f3348bcc9  PCI: dwc: Remove unused PCIE_ATU_UNR_* register definitions

elapsed time: 2392m

configs tested: 298
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2103-20260930    clang-21   cocci
alpha                randconfig-r2106-20260930    gcc-9.5.0  cocci
alpha                randconfig-r2200-20260930    gcc-11.5.0 smatch
alpha                randconfig-r2202-20260928    gcc-8.5.0  smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2104-20260928    gcc-11.5.0 cocci
arc                  randconfig-r2309-20260930    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                  randconfig-r2100-20260930    clang-21   cocci
arm                  randconfig-r2101-20260928    clang-24   cocci
arm                  randconfig-r2202-20260930    clang-17   smatch
arm                  randconfig-r2300-20260928    clang-17   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    gcc-16.1.0
arm64                randconfig-r2104-20260928    gcc-12.5.0 cocci
arm64                randconfig-r2104-20260930    gcc-9.5.0  cocci
arm64                randconfig-r2301-20260928    clang-17   sparse
arm64                randconfig-r2303-20260928    clang-17   sparse
arm64                randconfig-r2306-20260928    gcc-14.3.0 sparse
arm64                randconfig-r2308-20260928    gcc-14.3.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2107-20260928    gcc-12.5.0 cocci
csky                 randconfig-r2201-20260928    gcc-13.4.0 smatch
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2304-20260928    clang-17   sparse
hexagon              randconfig-r2306-20260928    gcc-16.1.0 sparse
hexagon              randconfig-r2308-20260928    gcc-16.1.0 sparse
hexagon              randconfig-r2308-20260930    clang-24   sparse
i386                              alldefconfig    gcc-16.1.0
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260928    clang-22   cocci
i386                  randconfig-2100-20260928    gcc-14     cocci
i386                  randconfig-2100-20260930    clang-22   cocci
i386                  randconfig-2101-20260928    gcc-14     cocci
i386                  randconfig-2101-20260930    clang-22   cocci
i386                  randconfig-2102-20260928    gcc-12     cocci
i386                  randconfig-2102-20260928    gcc-14     cocci
i386                  randconfig-2102-20260930    clang-22   cocci
i386                  randconfig-2103-20260928    clang-22   cocci
i386                  randconfig-2103-20260928    gcc-14     cocci
i386                  randconfig-2103-20260930    clang-22   cocci
i386                  randconfig-2200-20260928    clang-22   smatch
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260928    clang-22   sparse
i386                  randconfig-2300-20260930    gcc-13     sparse
i386                  randconfig-2301-20260928    clang-22   sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260928    clang-22   sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                 randconfig-r2100-20260928    clang-24   cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2300-20260928    gcc-14.3.0 sparse
loongarch            randconfig-r2301-20260928    gcc-14.3.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2102-20260928    clang-17   cocci
m68k                 randconfig-r2105-20260930    gcc-9.5.0  cocci
m68k                 randconfig-r2307-20260930    clang-24   sparse
m68k                            virt_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2102-20260928    clang-24   cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                          bigsur_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    gcc-16.1.0
mips                 randconfig-r2101-20260930    clang-21   cocci
mips                 randconfig-r2106-20260928    gcc-12.5.0 cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2106-20260928    gcc-11.5.0 cocci
nios2                randconfig-r2200-20260928    gcc-11.5.0 smatch
nios2                randconfig-r2307-20260928    gcc-16.1.0 sparse
nios2                randconfig-r2309-20260928    gcc-14.3.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20260928    gcc-12.5.0 cocci
openrisc             randconfig-r2101-20260928    clang-17   cocci
openrisc             randconfig-r2101-20260928    gcc-10.5.0 cocci
openrisc             randconfig-r2102-20260930    clang-21   cocci
openrisc             randconfig-r2201-20260928    gcc-11.5.0 smatch
openrisc             randconfig-r2302-20260928    gcc-14.3.0 sparse
openrisc             randconfig-r2304-20260928    gcc-14.3.0 sparse
openrisc             randconfig-r2309-20260928    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2105-20260928    gcc-12.5.0 cocci
parisc               randconfig-r2305-20260928    gcc-14.3.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2305-20260928    clang-17   sparse
powerpc                      sequoia_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2100-20260928    clang-17   cocci
powerpc64            randconfig-r2201-20260930    clang-24   smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260928    gcc-8.5.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260928    gcc-8.5.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                randconfig-r2103-20260928    clang-17   cocci
riscv                randconfig-r2306-20260930    clang-24   sparse
riscv                randconfig-r2307-20260928    gcc-14.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260928    gcc-8.5.0
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260928    gcc-8.5.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                 randconfig-r2102-20260928    clang-24   cocci
s390                 randconfig-r2303-20260928    gcc-14.3.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260928    gcc-8.5.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260928    gcc-8.5.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                   randconfig-r2103-20260928    clang-24   cocci
sh                   randconfig-r2201-20260928    gcc-16.1.0 smatch
sh                   randconfig-r2202-20260928    gcc-14.3.0 smatch
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260928    gcc-13.4.0
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260928    gcc-13.4.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                randconfig-r2105-20260928    gcc-11.5.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260928    gcc-13.4.0
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260928    gcc-13.4.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64              randconfig-r2200-20260928    gcc-11.5.0 smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260928    gcc-13.4.0
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260928    gcc-13.4.0
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2103-20260928    clang-17   cocci
um                   randconfig-r2200-20260928    clang-18   smatch
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2100-20260928    gcc-12     cocci
x86_64                randconfig-2100-20260930    clang-22   cocci
x86_64                randconfig-2101-20260928    gcc-12     cocci
x86_64                randconfig-2101-20260930    clang-22   cocci
x86_64                randconfig-2102-20260928    gcc-12     cocci
x86_64                randconfig-2102-20260930    clang-22   cocci
x86_64                randconfig-2103-20260928    gcc-12     cocci
x86_64                randconfig-2103-20260930    clang-22   cocci
x86_64                randconfig-2200-20260928    gcc-14     smatch
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260928    clang-22   sparse
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260928    clang-22   sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2302-20260928    clang-22   sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
x86_64               randconfig-r2107-20260928    gcc-11.5.0 cocci
x86_64               randconfig-r2107-20260930    gcc-9.5.0  cocci
x86_64               randconfig-r2302-20260928    clang-17   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                            rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-2000-20260928    gcc-13.4.0
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2001-20260928    gcc-13.4.0
xtensa                randconfig-2001-20260930    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
