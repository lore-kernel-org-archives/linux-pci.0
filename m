Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AA2D0635
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256316; cv=none; b=tVfg2LxXNlfGYDR+f1uXtxnmsaOw97LxUYTWc7mZxib1eBkcjoWGUlcUWSoRrYDiow0Qu+NXNGece1SQchRkfX5I9/5KoFNk1EGlvQC//6NjZsBrGBuHh550f2zX4sfmNr83Sebk1QtWxbjo5Y93LARATy/NnxakX0KG9qgv8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256316; c=relaxed/simple;
	bh=0GiDrGvvqHSuDOyv0ZV7u6XpTnunmZhR3ct/bLUd1CQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LRpqmdKXu49yNPlnI4vAz5GRN1qzcGZ3g4Oxe/E0kc9rQ6qCeyRnuVg1+HZXRG/MolZMreUX2KAd/Bw0j235x+lAlYGyJ52G8jPpfCvLuRXRVqS7QuK2aSxlRCkd4xwBe+g8pqsSXS3gVLGlLhK+06EhIW4W92w94j3AzoZRi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUsig5qh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUsig5qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773256314; x=1804792314;
  h=date:from:to:cc:subject:message-id;
  bh=0GiDrGvvqHSuDOyv0ZV7u6XpTnunmZhR3ct/bLUd1CQ=;
  b=YUsig5qhM4UENwn/5vFl2jzfs9uPtpAierikrfWU5nc7uRBr+0hGMUMW
   Af1pcUk3eBF/iuy7uv6PskKLF1I45Q/JNmhLtk41ndQ2iVfj4spHlBqEh
   Pikdwd7EKFb7lhDhSM+UZJcbk1MSLai/MJk0DaYKEgEAKP7A5pDhtvWte
   nCUK4jV3gEOdXpSvb2efR8Wok4nW/SMJECA7eX1CuR/ctOUeoSvB3gO4f
   uDvCJgGow1a1OIF/cDUh1VNkmx5lSlGTTMor+XQDMABtmA/4u0/deiVpo
   Z0sRzBVLpk/2dJF7XBcOE26Q0QyLmwH8CcyP7KL0pUikG0jY4c0ffomG3
   w==;
X-CSE-ConnectionGUID: qUcE9/MkRvS30sUkZoCwww==
X-CSE-MsgGUID: H4SKFVLXSG+69Ujimopj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74377503"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74377503"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 12:11:54 -0700
X-CSE-ConnectionGUID: AhWg/Um3QUyG+HBi+XNm4Q==
X-CSE-MsgGUID: mshwsT2aQTW0MESgZmNFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="218428403"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Mar 2026 12:11:52 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0OyD-000000001cJ-3Omh;
	Wed, 11 Mar 2026 19:11:49 +0000
Date: Thu, 12 Mar 2026 03:11:39 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-eswin] BUILD SUCCESS
 7a129ac6e31bc0c6d7149fd9c7c78bba7d0e9e42
Message-ID: <202603120333.OfS0wWhf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-eswin
branch HEAD: 7a129ac6e31bc0c6d7149fd9c7c78bba7d0e9e42  PCI: Add ESWIN PCIe Root Complex driver

elapsed time: 749m

configs tested: 136
configs skipped: 2

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
arc                   randconfig-001-20260311    gcc-14.3.0
arc                   randconfig-002-20260311    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260311    clang-23
arm                   randconfig-002-20260311    gcc-8.5.0
arm                   randconfig-003-20260311    clang-16
arm                   randconfig-004-20260311    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260311    clang-23
arm64                 randconfig-002-20260311    clang-23
arm64                 randconfig-003-20260311    gcc-12.5.0
arm64                 randconfig-004-20260311    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260311    gcc-11.5.0
csky                  randconfig-002-20260311    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260311    clang-23
hexagon               randconfig-001-20260312    clang-23
hexagon               randconfig-002-20260311    clang-16
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260311    clang-20
i386        buildonly-randconfig-002-20260311    clang-20
i386        buildonly-randconfig-003-20260311    gcc-14
i386        buildonly-randconfig-004-20260311    clang-20
i386        buildonly-randconfig-005-20260311    gcc-14
i386        buildonly-randconfig-006-20260311    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260311    gcc-14
i386                  randconfig-002-20260311    gcc-14
i386                  randconfig-003-20260311    clang-20
i386                  randconfig-004-20260311    gcc-14
i386                  randconfig-005-20260311    gcc-13
i386                  randconfig-006-20260311    clang-20
i386                  randconfig-007-20260311    clang-20
i386                  randconfig-011-20260311    gcc-14
i386                  randconfig-012-20260311    gcc-14
i386                  randconfig-013-20260311    gcc-14
i386                  randconfig-014-20260311    gcc-14
i386                  randconfig-015-20260311    clang-20
i386                  randconfig-016-20260311    clang-20
i386                  randconfig-017-20260311    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260312    gcc-15.2.0
loongarch             randconfig-002-20260311    gcc-15.2.0
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
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260311    gcc-14.3.0
parisc                randconfig-002-20260311    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-23
powerpc               randconfig-001-20260311    gcc-10.5.0
powerpc               randconfig-002-20260311    gcc-8.5.0
powerpc64             randconfig-001-20260311    clang-23
powerpc64             randconfig-002-20260311    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260311    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260311    gcc-8.5.0
s390                  randconfig-002-20260311    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260311    gcc-15.2.0
sh                    randconfig-002-20260311    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260311    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260311    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260311    clang-20
x86_64                randconfig-002-20260311    gcc-14
x86_64                randconfig-003-20260311    gcc-14
x86_64                randconfig-004-20260311    gcc-14
x86_64                randconfig-005-20260311    gcc-12
x86_64                randconfig-006-20260311    clang-20
x86_64                randconfig-011-20260311    clang-20
x86_64                randconfig-012-20260311    clang-20
x86_64                randconfig-013-20260311    clang-20
x86_64                randconfig-014-20260311    clang-20
x86_64                randconfig-015-20260311    gcc-14
x86_64                randconfig-016-20260311    gcc-13
x86_64                randconfig-071-20260311    gcc-14
x86_64                randconfig-072-20260311    clang-20
x86_64                randconfig-073-20260311    gcc-13
x86_64                randconfig-074-20260311    gcc-13
x86_64                randconfig-075-20260311    gcc-14
x86_64                randconfig-076-20260311    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
