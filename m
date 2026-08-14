Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985135E944
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679487; cv=none; b=gyGye47CtKQzVYNG8nmTImWV1aAMoEmmTRa2ptfxTQK9kRzb92i0Jz+r5t1KxDQ9GtelA/FhSBzy7uC5xp3qu2tTrncH5uvyHtU618wo+rWULDqWJEu3ZA/PipX7nfdsTfHFlmA0b5BGbibd5l2HsFeOGCWs6/YMzRhBkjMdHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679487; c=relaxed/simple;
	bh=GU8bj9ZP8pHgWrNNf4tJYzbR3wziiYofDaVMGR9Z5Rk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dhWhcjBTjJYeGUjW97bOA2pCLqNft0OgZio0Cb0qHQTYkeyoGTfG6ZxOymJA4joNzfklGq3A9NhFIk04wY/fBZP96n4YOts5TBIjVX8HjXdBGjqYfXNoHVKTtnOt0MMVyMbPEq+V9wY15eQcaMD2QqPH/xiFcaM9gMqirkwAV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuUOorJ1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuUOorJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786679484; x=1818215484;
  h=date:from:to:cc:subject:message-id;
  bh=GU8bj9ZP8pHgWrNNf4tJYzbR3wziiYofDaVMGR9Z5Rk=;
  b=VuUOorJ1TxcQEzUUC/odfQr7jY703Lr6X12wqznIqFb4jEQMZgJq6k/F
   hhwskn8ySietqM4A7Nof6xDAuCnwS8YM5AzdId80i7trP7sI40w5+5J51
   S3dP0sQL9eL2QBgf4BX2S/9f5W/65Dxq7TzGTTvg1SgOBx7vgXwfC9PrV
   RWtCuEQgA4Cx7bsilIJXg+oVhEUG2tKxwOGG/67iGGxCCSsY+e6g0qB8F
   fj/VN8gyj5kC7+xqhQrT7CN1RpaKPJIc0QV2SbSv/5noVQ30RNeCv1hhI
   zOEn0nObaUHxv4S5yt7LtPY3BLejwyc5+wdUdMJcJoYsX6zy4qBwkD5of
   w==;
X-CSE-ConnectionGUID: puJ+mqqLQGyXX3s0lRKipg==
X-CSE-MsgGUID: 7AQlrl5mQ+uw4vJ1us7tPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87280060"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87280060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:51:24 -0700
X-CSE-ConnectionGUID: u/1Vsw0+RaSihaQYoEumDg==
X-CSE-MsgGUID: nDUPQ6UaTYOoX0EEYK9pOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260323026"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2026 20:51:22 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuiwx-00000000Xfm-3cmz;
	Fri, 14 Aug 2026 03:51:19 +0000
Date: Fri, 14 Aug 2026 11:50:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wake] BUILD SUCCESS
 071e245ab749c52338ec4eb7fe0a9bb2cee97492
Message-ID: <202608141121.sphUm1x0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wake
branch HEAD: 071e245ab749c52338ec4eb7fe0a9bb2cee97492  PCI: Add support for PCIe WAKE# interrupt

elapsed time: 2428m

configs tested: 114
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-13.4.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-002-20260813    gcc-13.4.0
arm                       keystone_defconfig    gcc-16.1.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260813    gcc-14.3.0
arm64                randconfig-001-20260813    gcc-16.1.0
arm64                randconfig-002-20260813    gcc-14.3.0
arm64                randconfig-002-20260813    gcc-16.1.0
arm64                randconfig-003-20260813    gcc-14.3.0
arm64                randconfig-003-20260813    gcc-16.1.0
arm64                randconfig-004-20260813    gcc-14.3.0
arm64                randconfig-004-20260813    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260813    gcc-14.3.0
csky                 randconfig-001-20260813    gcc-16.1.0
csky                 randconfig-002-20260813    gcc-14.3.0
csky                 randconfig-002-20260813    gcc-16.1.0
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-002-20260813    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260813    gcc-14
i386       buildonly-randconfig-002-20260813    gcc-14
i386       buildonly-randconfig-003-20260813    gcc-14
i386       buildonly-randconfig-004-20260813    gcc-14
i386       buildonly-randconfig-005-20260813    gcc-14
i386       buildonly-randconfig-006-20260813    gcc-14
i386                 randconfig-001-20260813    clang-22
i386                 randconfig-002-20260813    clang-22
i386                 randconfig-003-20260813    clang-22
i386                 randconfig-004-20260813    clang-22
i386                 randconfig-005-20260813    clang-22
i386                 randconfig-006-20260813    clang-22
i386                 randconfig-007-20260813    clang-22
i386                 randconfig-011-20260813    clang-22
i386                 randconfig-012-20260813    clang-22
i386                 randconfig-013-20260813    clang-22
i386                 randconfig-014-20260813    clang-22
i386                 randconfig-015-20260813    clang-22
i386                 randconfig-016-20260813    clang-22
i386                 randconfig-017-20260813    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-002-20260813    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-10.5.0
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-002-20260813    gcc-10.5.0
powerpc                   adder875_defconfig    gcc-16.1.0
powerpc                   amigaone_defconfig    gcc-16.1.0
powerpc                       fsp2_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260813    gcc-10.5.0
riscv                         randconfig-001    gcc-10.5.0
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-002-20260813    gcc-10.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-002-20260813    gcc-10.5.0
sparc                         randconfig-001    clang-20
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-002-20260813    clang-20
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-002-20260813    clang-20
um                   randconfig-001-20260813    clang-20
um                   randconfig-002-20260813    clang-20
x86_64     buildonly-randconfig-001-20260813    gcc-14
x86_64     buildonly-randconfig-002-20260813    gcc-14
x86_64     buildonly-randconfig-003-20260813    gcc-14
x86_64     buildonly-randconfig-004-20260813    gcc-14
x86_64     buildonly-randconfig-005-20260813    gcc-14
x86_64     buildonly-randconfig-006-20260813    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260813    gcc-13
x86_64               randconfig-002-20260813    gcc-13
x86_64               randconfig-003-20260813    gcc-13
x86_64               randconfig-004-20260813    gcc-13
x86_64               randconfig-005-20260813    gcc-13
x86_64               randconfig-006-20260813    gcc-13
x86_64               randconfig-011-20260813    gcc-14
x86_64               randconfig-012-20260813    gcc-14
x86_64               randconfig-013-20260813    gcc-14
x86_64               randconfig-014-20260813    gcc-14
x86_64               randconfig-015-20260813    gcc-14
x86_64               randconfig-016-20260813    gcc-14
x86_64               randconfig-071-20260813    gcc-14
x86_64               randconfig-072-20260813    gcc-14
x86_64               randconfig-073-20260813    gcc-14
x86_64               randconfig-074-20260813    gcc-14
x86_64               randconfig-075-20260813    gcc-14
x86_64               randconfig-076-20260813    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-002-20260813    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
