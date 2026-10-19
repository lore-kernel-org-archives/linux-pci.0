Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49A377ED9
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380072; cv=none; b=KOa2b1jBMENxlk9cTZ6ViGV7FpiQ1DGyxMzwAYQ/PPNtDacrny4bsX2bZkmOnzUw5JW0ziZowZZccvGg6EaYWTJI+UtrHWbhfCs82msWoLyJLHf1PoIKzRwEm5a8rQHa2y/su917UCU4SQLO0VpVf/Ubfx5SErKvDWY9BmDhE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380072; c=relaxed/simple;
	bh=VJqcRJkBsbTUuoJ1wqVWOWPm/T0jgGTmofyX4yop0E8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MEUGgcAVZdPedxjdrzNOwB34q2IvFlB46RFWoKfXq9ViqmVBvDvLeWR+jv0yDDzQTIJcEkgZF9gjaHkgDv1+y+GhoLR+UH/wYzae/M4cBVlnrd4h9cq3v8O2cSyOVCK7ZatEEU32rD5uOJqC370PrxkeYBO5byTXecJiRTSQri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEc4euKq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEc4euKq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792380069; x=1823916069;
  h=date:from:to:cc:subject:message-id;
  bh=VJqcRJkBsbTUuoJ1wqVWOWPm/T0jgGTmofyX4yop0E8=;
  b=FEc4euKqrFO7exsgQpqyUqggmu7yDR2mB5FtLEB4URIgJJNXja3RbxmC
   nOfcgKSy+6faolz8yLCqrfCh11Cuh062rj0nCj+aUyAc8K5IU7iToNXo3
   JBHbZGiWjFwSmNunZluvcxColiEno986GkpaiqeEgDRB85A1KTHWMsRIr
   Tc3cuFKKKKQKC+BW2rimBA3KC/pYUOZ+U1NnWs8Q/MgHUHHqw4U4TFW+B
   sZF7sNEwIaKDU46KD9nCBX9e/Wz+99dLfl/WHT9YvRjZpwzfo13QY+g6W
   AZ/sTYStmYMkU7g7UYmLyT7vGADT5tPtTLIIflCO16fQKzZwkf2KveGNv
   A==;
X-CSE-ConnectionGUID: +MxjwLkoRH+kqAy3gTvSGQ==
X-CSE-MsgGUID: tO9dVsFPQjSKgGNl8sHKuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="950934"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="950934"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 20:21:08 -0700
X-CSE-ConnectionGUID: A+PqJWO+TSGX5+KbUYiR3A==
X-CSE-MsgGUID: PzuOGapuSBSKJtmsWea3Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2407005"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Oct 2026 20:21:07 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIdvs-00000000LBe-1Nz9;
	Mon, 19 Oct 2026 03:21:04 +0000
Date: Mon, 19 Oct 2026 11:20:50 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 a5401ce3ab2356b7861f53d09205008b7a49d57e
Message-ID: <202610191147.4re5TUlM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: a5401ce3ab2356b7861f53d09205008b7a49d57e  PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

elapsed time: 1296m

configs tested: 195
configs skipped: 8

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
arc                   randconfig-1000-20261019    clang-21
arc                   randconfig-1001-20261019    clang-21
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261019    clang-21
arm                   randconfig-1001-20261019    clang-21
arm                   randconfig-1002-20261019    clang-21
arm                   randconfig-1003-20261019    clang-21
arm                        spear13xx_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261019    clang-24
arm64                 randconfig-1001-20261019    clang-24
arm64                 randconfig-1002-20261019    clang-24
arm64                 randconfig-1003-20261019    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261019    clang-24
csky                  randconfig-1001-20261019    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261019    clang-24
hexagon               randconfig-1001-20261019    clang-24
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261018    clang-22
i386        buildonly-randconfig-1000-20261019    clang-22
i386        buildonly-randconfig-1001-20261018    clang-22
i386        buildonly-randconfig-1001-20261019    clang-22
i386        buildonly-randconfig-1002-20261018    clang-22
i386        buildonly-randconfig-1002-20261019    clang-22
i386        buildonly-randconfig-1003-20261018    clang-22
i386        buildonly-randconfig-1003-20261019    clang-22
i386        buildonly-randconfig-1004-20261018    clang-22
i386        buildonly-randconfig-1004-20261019    clang-22
i386        buildonly-randconfig-1005-20261018    clang-22
i386        buildonly-randconfig-1005-20261019    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261019    clang-22
i386                  randconfig-1001-20261019    clang-22
i386                  randconfig-1002-20261019    clang-22
i386                  randconfig-1003-20261019    clang-22
i386                  randconfig-1004-20261019    clang-22
i386                  randconfig-1005-20261019    clang-22
i386                  randconfig-1006-20261019    clang-22
i386                  randconfig-1007-20261018    gcc-14
i386                  randconfig-1008-20261018    gcc-14
i386                  randconfig-1009-20261018    gcc-14
i386                  randconfig-1010-20261018    gcc-14
i386                  randconfig-1011-20261018    gcc-14
i386                  randconfig-1012-20261018    gcc-14
i386                  randconfig-1013-20261018    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    clang-24
loongarch             randconfig-1000-20261019    clang-24
loongarch             randconfig-1001-20261019    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                             mac_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                        rbtx49xx_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261019    clang-24
nios2                 randconfig-1001-20261019    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1000-20261019    gcc-8.5.0
parisc                randconfig-1001-20261018    clang-24
parisc                randconfig-1001-20261019    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       cm5200_defconfig    clang-24
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1000-20261019    gcc-8.5.0
powerpc               randconfig-1001-20261018    clang-24
powerpc               randconfig-1001-20261019    gcc-8.5.0
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1000-20261019    gcc-8.5.0
powerpc64             randconfig-1001-20261018    clang-24
powerpc64             randconfig-1001-20261019    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1000-20261019    gcc-11.5.0
riscv                 randconfig-1001-20261018    clang-17
riscv                 randconfig-1001-20261019    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1000-20261019    gcc-11.5.0
s390                  randconfig-1001-20261018    clang-17
s390                  randconfig-1001-20261019    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           landisk_defconfig    clang-24
sh                           r7785rp_defconfig    clang-24
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1000-20261019    gcc-11.5.0
sh                    randconfig-1001-20261018    clang-17
sh                    randconfig-1001-20261019    gcc-11.5.0
sh                           rsk7264_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261019    clang-20
sparc                 randconfig-1001-20261019    clang-20
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261019    clang-20
sparc64               randconfig-1001-20261019    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261019    clang-20
um                    randconfig-1001-20261019    clang-20
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261019    clang-22
x86_64      buildonly-randconfig-1001-20261019    clang-22
x86_64      buildonly-randconfig-1002-20261019    clang-22
x86_64      buildonly-randconfig-1003-20261019    clang-22
x86_64      buildonly-randconfig-1004-20261019    clang-22
x86_64      buildonly-randconfig-1005-20261019    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261018    clang-22
x86_64                randconfig-1001-20261018    clang-22
x86_64                randconfig-1002-20261018    clang-22
x86_64                randconfig-1003-20261018    clang-22
x86_64                randconfig-1004-20261018    clang-22
x86_64                randconfig-1005-20261018    clang-22
x86_64                randconfig-1006-20261018    clang-22
x86_64                randconfig-1007-20261018    clang-22
x86_64                randconfig-1008-20261018    clang-22
x86_64                randconfig-1009-20261018    clang-22
x86_64                randconfig-1010-20261018    clang-22
x86_64                randconfig-1011-20261018    clang-22
x86_64                randconfig-1012-20261019    gcc-14
x86_64                randconfig-1013-20261019    gcc-14
x86_64                randconfig-1014-20261019    gcc-14
x86_64                randconfig-1015-20261019    gcc-14
x86_64                randconfig-1016-20261019    gcc-14
x86_64                randconfig-1017-20261019    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261019    clang-20
xtensa                randconfig-1001-20261019    clang-20
xtensa                          virt_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
