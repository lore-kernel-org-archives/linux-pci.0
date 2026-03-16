Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD936075D
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696155; cv=none; b=A5SLPASRepa5W/d36U4AI46p5/1MZOV8zTlI8kwx/SO/VuSGC6pq1kXVzk0N1I6kWg6e1MBKJlD1tZQL5tsTI7z3hDg/5OmyIGJE6giIygGKr3RtG5hvORtC97vdWz2QGjTG2wUh4jxOt/TpR2kzIxLpCNwa2UM2St1P8Z0bZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696155; c=relaxed/simple;
	bh=9A6u5TEy+zjTYTcMrW9Vhe/9TGzlOJ5IEFaI/Lb+SoQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZC2GgIAMyZTaKCQ89bIEgVPHGOqeGvMR3xQ6KVxWOg4BNK/v5SW3yEvDANpRwj3sZZ6McCQbAVToPzwzZEbQdvBv8e8hYIFq61rAjx71Oc1stW2CG2KRXagJmoofprqLU/Tu3ccnFQd4GZD1hTK/gi07tsibyux5DnfGOD30Pm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cr29AmGJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cr29AmGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773696154; x=1805232154;
  h=date:from:to:cc:subject:message-id;
  bh=9A6u5TEy+zjTYTcMrW9Vhe/9TGzlOJ5IEFaI/Lb+SoQ=;
  b=cr29AmGJHok/bEablqBnCfNT0QFNw8663XMsWOo2vEIYRTUvW4IjMvR5
   yNGHZ4zBh7b9UVcOJXKmSa5pB7ibcLBt6ro8oBud4Gr5dRR7um4KLPP6P
   K8Wf4sihFp4nzqTZc7xvKBDwer6cW4jHXzJ2MKLFYOd4roESThzErSdYb
   HVseE5y1o+VNlw8c3JaUH4eBAxVn7zLx8zpP+MXqnLzrf+sdEaCkjKnpL
   52+WAy54cP2YYpA7TRGHt34gEevj4/MCCzwUCRlGcgQK8tDOnjxnschiu
   rbiN7/HW5F6/eya23F6ywvU+qDMrouWu1Y6iexFrZoPXUXHMiJYsFCESd
   Q==;
X-CSE-ConnectionGUID: WuVsGbhuQq6AMCAYpk4lDw==
X-CSE-MsgGUID: Or7Fr5kTTr+m7fcWZRDORw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92293747"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92293747"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:22:34 -0700
X-CSE-ConnectionGUID: g3HJX8BmTqWEei6aPGfvMg==
X-CSE-MsgGUID: DnDIJ03mQ2ma3TirJy5Kfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217821326"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Mar 2026 14:22:32 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2FOQ-000000001Ja-1mmw;
	Mon, 16 Mar 2026 21:22:30 +0000
Date: Tue, 17 Mar 2026 05:22:21 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-eswin] BUILD SUCCESS
 cbbe59fa04b5d9f8e11138df4591653f7d2f8351
Message-ID: <202603170515.atUQ4d2J-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-eswin
branch HEAD: cbbe59fa04b5d9f8e11138df4591653f7d2f8351  PCI: Add ESWIN PCIe Root Complex driver

elapsed time: 1566m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260317    gcc-9.5.0
arc                   randconfig-002-20260317    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260317    clang-23
arm                   randconfig-002-20260317    clang-23
arm                   randconfig-003-20260317    clang-23
arm                   randconfig-004-20260317    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260316    gcc-11.5.0
arm64                 randconfig-002-20260316    clang-23
arm64                 randconfig-003-20260316    clang-23
arm64                 randconfig-004-20260316    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260316    gcc-15.2.0
csky                  randconfig-002-20260316    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260317    clang-23
hexagon               randconfig-002-20260317    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260317    clang-20
i386        buildonly-randconfig-002-20260317    clang-20
i386        buildonly-randconfig-003-20260317    clang-20
i386        buildonly-randconfig-004-20260317    clang-20
i386        buildonly-randconfig-005-20260317    clang-20
i386        buildonly-randconfig-006-20260317    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    clang-20
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    clang-20
i386                  randconfig-006-20260316    gcc-12
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260317    gcc-14
i386                  randconfig-012-20260317    gcc-14
i386                  randconfig-013-20260317    gcc-14
i386                  randconfig-014-20260317    clang-20
i386                  randconfig-015-20260317    clang-20
i386                  randconfig-016-20260317    gcc-14
i386                  randconfig-017-20260317    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260317    clang-23
loongarch             randconfig-002-20260317    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20260317    gcc-8.5.0
nios2                 randconfig-002-20260317    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-8.5.0
parisc                randconfig-002-20260316    gcc-12.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-23
powerpc               randconfig-001-20260316    clang-23
powerpc               randconfig-002-20260316    clang-23
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260317    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-8.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260316    gcc-8.5.0
sparc64               randconfig-002-20260316    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                    randconfig-001-20260316    gcc-14
um                    randconfig-002-20260316    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260317    clang-20
x86_64      buildonly-randconfig-002-20260317    gcc-14
x86_64      buildonly-randconfig-003-20260317    clang-20
x86_64      buildonly-randconfig-004-20260317    clang-20
x86_64      buildonly-randconfig-005-20260317    clang-20
x86_64      buildonly-randconfig-006-20260317    gcc-14
x86_64                randconfig-001-20260317    gcc-14
x86_64                randconfig-002-20260317    gcc-14
x86_64                randconfig-003-20260317    clang-20
x86_64                randconfig-004-20260317    clang-20
x86_64                randconfig-005-20260317    clang-20
x86_64                randconfig-006-20260317    gcc-14
x86_64                randconfig-011-20260317    gcc-14
x86_64                randconfig-014-20260317    gcc-14
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-14
x86_64                randconfig-073-20260316    gcc-14
x86_64                randconfig-074-20260316    gcc-14
x86_64                randconfig-075-20260316    clang-20
x86_64                randconfig-076-20260316    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260316    gcc-15.2.0
xtensa                randconfig-002-20260316    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
