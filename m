Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA851946DA
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659057; cv=none; b=hZDwIuBx+B9WYNeJ+2wqJcIK3RMFreZy1BbNCXMgXvTpdWH/6imhQ+SFRnYRyu5JN2HZ7BU4E5FvOURIEoFM2X5mnY/HQGArbP6VoPMg6VNiL6caON4FOIPZtR7jaQRWzgvVthmYQj78+koyNkL5bXdjPu3ieS/Pv+m6ua4yjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659057; c=relaxed/simple;
	bh=ae/CPin5Vw9nqRzAFT5h4mcTDiSnv8XsSGIzGfpfb8s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZQkhBrmJN1rf09/uhlTPjI79AwcVMnyhgBdd76i9Rf9WusP+HDTkRo6dkDHn2Au5WF3otcKWUIjA0mGV15YK8kkYQ42WotaW6wFUNMVX7GVWV1qG9McCh8XF4+Rm2uMfcOldl2+20dopB4gFieC8fTLJ5lLZqt8xq6unHQinLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFYRqFiZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFYRqFiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772659053; x=1804195053;
  h=date:from:to:cc:subject:message-id;
  bh=ae/CPin5Vw9nqRzAFT5h4mcTDiSnv8XsSGIzGfpfb8s=;
  b=aFYRqFiZdvl3fOmd/oXmomwMgbsxxZM7phjeRGySzhNR/iBLLaa1261Z
   Ssk8TV47FdxC/ZEZIgvJmSVMvkhZnnHNoEzkyvEyTM91ytFLKRKw4NCfQ
   +p/1ZzeMOh0J1LFr7MGgG/6liOicFuGiT1yAaxlMsUuGKPeZOuFy4K3r4
   tq2Kx5+UG8FT0CoE+s11vlWjqlo8X20M6MByrhnibo7mLtnmVksA7iEOx
   Fff9YWZ6m1XsL3KyEyazkZVm4bnL4Pzs3u48mIQKlgjEazt7HmvcveQb/
   ernGWFXicUqnn2Gwi71HAuGy44zu6LcN9lSPagsYtr2/3u/XmiMsnvTRZ
   g==;
X-CSE-ConnectionGUID: YtYddzFzQuewBpwnKe87Og==
X-CSE-MsgGUID: Kgn+PRWiT7CgeNhjentIYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84369670"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="84369670"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 13:17:33 -0800
X-CSE-ConnectionGUID: w+awnfF4Rmup18wtTxOShw==
X-CSE-MsgGUID: tQWJ+p6jQH+qdkvbSq1+Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215781440"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Mar 2026 13:17:32 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxtaz-000000004Vl-0Kuq;
	Wed, 04 Mar 2026 21:17:29 +0000
Date: Thu, 05 Mar 2026 05:17:25 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 d799984233a50abd2667a7d17a9a710a3f10ebe2
Message-ID: <202603050517.PMUAadC0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: d799984233a50abd2667a7d17a9a710a3f10ebe2  PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup

elapsed time: 872m

configs tested: 177
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260304    clang-23
arc                   randconfig-002-20260304    clang-23
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260304    clang-23
arm                   randconfig-002-20260304    clang-23
arm                   randconfig-003-20260304    clang-23
arm                   randconfig-004-20260304    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260304    gcc-15.2.0
arm64                 randconfig-002-20260304    gcc-15.2.0
arm64                 randconfig-003-20260304    gcc-15.2.0
arm64                 randconfig-004-20260304    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260304    gcc-15.2.0
csky                  randconfig-002-20260304    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260304    gcc-15.2.0
hexagon               randconfig-002-20260304    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260304    gcc-14
i386        buildonly-randconfig-001-20260305    clang-20
i386        buildonly-randconfig-002-20260304    gcc-14
i386        buildonly-randconfig-002-20260305    clang-20
i386        buildonly-randconfig-003-20260304    gcc-14
i386        buildonly-randconfig-003-20260305    clang-20
i386        buildonly-randconfig-004-20260304    gcc-14
i386        buildonly-randconfig-004-20260305    clang-20
i386        buildonly-randconfig-005-20260304    gcc-14
i386        buildonly-randconfig-005-20260305    clang-20
i386        buildonly-randconfig-006-20260304    gcc-14
i386        buildonly-randconfig-006-20260305    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260304    clang-20
i386                  randconfig-002-20260304    clang-20
i386                  randconfig-003-20260304    clang-20
i386                  randconfig-004-20260304    clang-20
i386                  randconfig-005-20260304    clang-20
i386                  randconfig-006-20260304    clang-20
i386                  randconfig-007-20260304    clang-20
i386                  randconfig-011-20260304    gcc-14
i386                  randconfig-012-20260304    gcc-14
i386                  randconfig-013-20260304    gcc-14
i386                  randconfig-014-20260304    gcc-14
i386                  randconfig-015-20260304    gcc-14
i386                  randconfig-016-20260304    gcc-14
i386                  randconfig-017-20260304    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260304    gcc-15.2.0
loongarch             randconfig-002-20260304    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260304    gcc-15.2.0
nios2                 randconfig-002-20260304    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260304    gcc-8.5.0
parisc                randconfig-002-20260304    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260304    gcc-8.5.0
powerpc               randconfig-002-20260304    gcc-8.5.0
powerpc64             randconfig-001-20260304    gcc-8.5.0
powerpc64             randconfig-002-20260304    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260304    clang-23
riscv                 randconfig-001-20260305    clang-23
riscv                 randconfig-002-20260304    clang-23
riscv                 randconfig-002-20260305    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260304    clang-23
s390                  randconfig-001-20260305    clang-23
s390                  randconfig-002-20260304    clang-23
s390                  randconfig-002-20260305    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260304    clang-23
sh                    randconfig-001-20260305    clang-23
sh                    randconfig-002-20260304    clang-23
sh                    randconfig-002-20260305    clang-23
sh                           se7751_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260304    gcc-14
x86_64      buildonly-randconfig-002-20260304    gcc-14
x86_64      buildonly-randconfig-003-20260304    gcc-14
x86_64      buildonly-randconfig-004-20260304    gcc-14
x86_64      buildonly-randconfig-005-20260304    gcc-14
x86_64      buildonly-randconfig-006-20260304    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260304    clang-20
x86_64                randconfig-002-20260304    clang-20
x86_64                randconfig-003-20260304    clang-20
x86_64                randconfig-004-20260304    clang-20
x86_64                randconfig-005-20260304    clang-20
x86_64                randconfig-006-20260304    clang-20
x86_64                randconfig-011-20260304    gcc-14
x86_64                randconfig-012-20260304    gcc-14
x86_64                randconfig-013-20260304    gcc-14
x86_64                randconfig-014-20260304    gcc-14
x86_64                randconfig-015-20260304    gcc-14
x86_64                randconfig-016-20260304    gcc-14
x86_64                randconfig-071-20260304    clang-20
x86_64                randconfig-072-20260304    clang-20
x86_64                randconfig-073-20260304    clang-20
x86_64                randconfig-074-20260304    clang-20
x86_64                randconfig-075-20260304    clang-20
x86_64                randconfig-076-20260304    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
