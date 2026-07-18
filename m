Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B63168E1
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356222; cv=none; b=U7DVafvX65PdnWgJvZgTbeKNTANrV9LttlQ5m9pkWAD+rfAzGqfUSsA5MGua1pw8YegXthGxaLZFVm8YOM4lRW9QGb1RLCXKYR/J8STkfT1g/GEYU3zPVqWqjyeFNGrRyp9Mr+FuHJVQT5FoZlD/crRdAiAaNEEt5ZkrJ0nYBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356222; c=relaxed/simple;
	bh=8JetehurToMXeyI+8tia933mhhraAZsezvYTt1WZkEQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K3KcM8rN9RiWccuD4ASaXAGZEwh9yA8JzUqGUMpEQUOadjYRqgdm0hx6EvELaz+ird30oo+oYPxxZDPRgvxEptZglO4pW6NzTexOuUdo1ioG+1uo5PmTg5/GiarHNEkT3M1I0ZyyoWlZYuK86pypONTTTbUKegTaW9atEhP0BO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZz3ItoI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZz3ItoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784356220; x=1815892220;
  h=date:from:to:cc:subject:message-id;
  bh=8JetehurToMXeyI+8tia933mhhraAZsezvYTt1WZkEQ=;
  b=JZz3ItoI/yEukLo1S6MhjA4G6bqwBtvexdRCOjtBZYMHsnRM1swm57qf
   MDqqwKSb54HvBxrZwtN2yKdBLH9geHjsovHa0REULMHfN/VdwzkoeW09g
   bz97guMtFoJW0FoUIIgCKQ682DW0aJtNa8haN1u4NfplFqGANn8nROY+Z
   8t9yvEVBfFi167eO315Jww/kbWWeq7qwYU0tlP9848vqy4nmmmrr7JX67
   Ts2I2OVoN+RbcKN2Bz6rJkGfUpYq5fWtIOMk1lyabI1hVUN3/3NbJW/Gk
   gl2M6umnMdONESbtdFn6l44EOLsSWetzNhtfuXoQ7vfqU+IQFkHO3B3Hj
   g==;
X-CSE-ConnectionGUID: /SninoMoSl2ON20oY6NVUQ==
X-CSE-MsgGUID: fSuT8s99T3edGYMd44i1fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96152854"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="96152854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:30:20 -0700
X-CSE-ConnectionGUID: JA2LPyZrTaCaVcCylPZRPA==
X-CSE-MsgGUID: SgX/6q/GTZSoKoxfsatCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="255199943"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 17 Jul 2026 23:30:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkyYy-00000000TVt-2qDI;
	Sat, 18 Jul 2026 06:30:16 +0000
Date: Sat, 18 Jul 2026 14:29:42 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 600e37950c7cfa2c5842f3ea1231c0e808fded6c
Message-ID: <202607181432.9sBb7hCK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 600e37950c7cfa2c5842f3ea1231c0e808fded6c  PCI/pwrctrl: tc9563: Avoid uninterruptible hang on in-use I2C module unload

elapsed time: 736m

configs tested: 62
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260718    gcc-12.5.0
arc                  randconfig-002-20260718    gcc-10.5.0
arm                  randconfig-001-20260718    clang-17
arm                  randconfig-002-20260718    clang-17
arm                  randconfig-003-20260718    gcc-10.5.0
arm                  randconfig-004-20260718    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260718    gcc-14
i386       buildonly-randconfig-002-20260718    gcc-14
i386       buildonly-randconfig-003-20260718    gcc-14
i386       buildonly-randconfig-004-20260718    clang-22
i386       buildonly-randconfig-005-20260718    clang-22
i386       buildonly-randconfig-006-20260718    clang-22
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260718    gcc-14
i386                 randconfig-002-20260718    gcc-14
i386                 randconfig-003-20260718    clang-22
i386                 randconfig-004-20260718    gcc-14
i386                 randconfig-005-20260718    clang-22
i386                 randconfig-006-20260718    clang-22
i386                 randconfig-007-20260718    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260718    clang-18
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-002-20260718    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260718    gcc-9.5.0
parisc               randconfig-002-20260718    gcc-11.5.0
powerpc              randconfig-001-20260718    clang-24
powerpc              randconfig-002-20260718    gcc-16.1.0
powerpc64            randconfig-001-20260718    clang-24
powerpc64            randconfig-002-20260718    clang-17
s390                 randconfig-002-20260718    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260718    gcc-16.1.0
sh                   randconfig-002-20260718    gcc-16.1.0
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260718    gcc-8.5.0
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260718    clang-22
x86_64               randconfig-002-20260718    clang-22
x86_64               randconfig-003-20260718    gcc-14
x86_64               randconfig-004-20260718    gcc-14
x86_64               randconfig-005-20260718    clang-22
x86_64               randconfig-006-20260718    gcc-12
x86_64               randconfig-011-20260718    gcc-14
x86_64               randconfig-012-20260718    clang-22
x86_64               randconfig-013-20260718    clang-22
x86_64               randconfig-014-20260718    gcc-14
x86_64               randconfig-015-20260718    clang-22
x86_64               randconfig-016-20260718    gcc-13
xtensa               randconfig-002-20260718    gcc-8.5.0
xtensa                   smp_lx200_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
