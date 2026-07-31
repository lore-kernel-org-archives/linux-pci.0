Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C252857F0
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468059; cv=none; b=E16Qt96p4KPIXWnWXLnDQ2urbX0Odf5JCRRPD0LsdjjVvG5Ue55UA+KeXMbyj7qbbLtFN+GnibPgqFY06JlLjGYBeKeUelZ4p2zYaTtVeML5Gc1kUbGUXppfZejrK/yni3BqSa4cFAGrrxVkcPRN7/uMrI6QarbcDjurXMJpQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468059; c=relaxed/simple;
	bh=rqmAcoUacd0/wLWWBZoLydAfHsxga5+bSrwJdNhPw84=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ekPVwzC3d+KIDqEb19YJjXqdswMPvuDtUq94Xnc+f/U4jTeeAOd5VAzSNfll3RZCom5kgXk7tECvGb1Lyh3IxlBsBffGts+4I6W31ua1WU2WFT4Dsf+ooV2YbrmiAkOwWlepTAAiyjk6+exLwrH9q29J6+i1j1YLgB0u39A8/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGzkQuJH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGzkQuJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785468056; x=1817004056;
  h=date:from:to:cc:subject:message-id;
  bh=rqmAcoUacd0/wLWWBZoLydAfHsxga5+bSrwJdNhPw84=;
  b=GGzkQuJH+vtLGyBnGRZ0a5/s2ZpmiTwyWcjNweMJlE4DugV6gtHDUj+0
   A8k9rdM9qsmKadPmqKQtU48tvd8Tgjuupc5o3QbeYXkFCGV0olVM66BkR
   rFm5gPKASsAuMhD8vDU2DST92HLnkALjyHSLwBoK0CcYpP4TKlOa35Anx
   nq6shqzSZAkYgPSWZmd/9t1L9v38QH8WLflnNmgzRhlaR9UWJa0OWLkSg
   pzbIssAhfkRRbNsSxpWPwtWNVmhgn9eBFCQzivoSPc+xxFVcw4MwClXz6
   A114yavemXFKYLVpCjPJbSPGkIc5rBAo7r5MHz2GiMO8AbkZf47WgxUZh
   Q==;
X-CSE-ConnectionGUID: 2CD9hiSWQfuLoMqTK8a0rg==
X-CSE-MsgGUID: Pu46BPa+Svi3hHWnU4wlqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97250780"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97250780"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 20:20:55 -0700
X-CSE-ConnectionGUID: 0nEu/+ocS0W+PXRy480Q1g==
X-CSE-MsgGUID: NQhTnI9jQvaNabcIWFU6yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="263954682"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 30 Jul 2026 20:20:54 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpdnR-00000000hrY-0qRI;
	Fri, 31 Jul 2026 03:20:51 +0000
Date: Fri, 31 Jul 2026 11:19:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 21963e6e4e0425b12d3128eea5a5104a3bc909c4
Message-ID: <202607311107.XzFjIHzC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 21963e6e4e0425b12d3128eea5a5104a3bc909c4  PCI/AER: Support Advisory Non-Fatal Errors

elapsed time: 4768m

configs tested: 249
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-8.5.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                           mmp2_defconfig    gcc-16.1.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260729    gcc-8.5.0
arm                  randconfig-004-20260730    gcc-8.5.0
arm                       realview_defconfig    clang-17
arm                          stm32_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-14.3.0
arm64                randconfig-001-20260730    gcc-14.3.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-14.3.0
arm64                randconfig-002-20260730    gcc-14.3.0
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-14.3.0
arm64                randconfig-003-20260730    gcc-14.3.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260729    gcc-14.3.0
arm64                randconfig-004-20260730    gcc-14.3.0
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-14.3.0
csky                 randconfig-001-20260730    gcc-14.3.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-14.3.0
csky                 randconfig-002-20260730    gcc-14.3.0
csky                 randconfig-002-20260730    gcc-15.2.0
hexagon                       randconfig-001    clang-24
hexagon                       randconfig-001    gcc-9.5.0
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260729    gcc-9.5.0
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-001-20260731    clang-22
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-002-20260731    clang-22
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-003-20260731    clang-22
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-004-20260731    clang-22
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-005-20260731    clang-22
i386       buildonly-randconfig-006-20260729    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
i386       buildonly-randconfig-006-20260731    clang-22
i386                          randconfig-001    clang-22
i386                          randconfig-001    gcc-14
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-001-20260730    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-002-20260730    gcc-14
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-003-20260730    gcc-14
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-004-20260730    gcc-14
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-005-20260730    gcc-14
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-006-20260730    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                 randconfig-007-20260730    gcc-14
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-011-20260731    clang-22
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-012-20260731    clang-22
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-013-20260731    clang-22
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-014-20260731    clang-22
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-015-20260731    clang-22
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-016-20260731    clang-22
i386                 randconfig-017-20260729    gcc-14
i386                 randconfig-017-20260730    clang-22
i386                 randconfig-017-20260731    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260729    gcc-9.5.0
loongarch            randconfig-002-20260730    clang-24
m68k                      m5249evb_defconfig    gcc-16.1.0
m68k                       m5272c3_defconfig    gcc-16.1.0
mips                         ath25_defconfig    clang-24
mips                       bcm63xx_defconfig    clang-24
mips                          ip30_defconfig    gcc-16.1.0
mips                     maltaaprp_defconfig    clang-17
mips                       maltaup_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260729    gcc-9.5.0
nios2                randconfig-002-20260730    clang-24
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    clang-24
parisc                        randconfig-001    gcc-14.3.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260729    clang-24
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc                    ksi8560_defconfig    gcc-16.1.0
powerpc                mpc8313_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260729    clang-24
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260729    clang-24
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv            nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                         randconfig-001    gcc-15.2.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                           hp6xx_defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sh                          se7705_defconfig    gcc-16.1.0
sparc                         randconfig-001    clang-24
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-002-20260729    gcc-10.5.0
sparc                randconfig-002-20260730    clang-24
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-002-20260730    clang-24
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260729    gcc-10.5.0
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    clang-22
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-14
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-001-20260730    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-002-20260730    clang-22
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-003-20260730    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-004-20260730    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-005-20260730    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64               randconfig-006-20260730    clang-22
x86_64                        randconfig-011    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260729    gcc-14
x86_64               randconfig-016-20260730    clang-22
x86_64                        randconfig-071    gcc-12
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-071-20260730    gcc-14
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-072-20260730    gcc-14
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-073-20260730    gcc-14
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-074-20260730    gcc-14
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-075-20260730    gcc-14
x86_64               randconfig-076-20260729    gcc-12
x86_64               randconfig-076-20260730    gcc-12
x86_64               randconfig-076-20260730    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-002-20260729    gcc-10.5.0
xtensa               randconfig-002-20260730    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
