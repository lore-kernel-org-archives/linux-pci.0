Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6C36D500
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553696; cv=none; b=fVYcu6CW18YSt4Y7piRw+m+sCYD6wEI5fwqMcN6lTcSzoso26vXG7ydEggHo9akPdW3qLvXFtKHnnD3TaIF5JcJFgK9KIS+NxGdnG+EYfcJAP0tBFZOwegdxTCUAlOYIvUAYABD2jnM4LBn3FeqXuS3YEvLMXNbw1E99jaZEVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553696; c=relaxed/simple;
	bh=mIdsLgIVQlZOF6GRDa6qjLZw3mPpk692Ly55PbeXj/M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i9v6EIBt626iJxOZArZg8MA3N56/67LQA9wbGT4LFUr1JCAjQ0i3UImOItqel7g+TfYQl42WL0BfS6gOcyZ2b6TC6Mg+kt14iCRxJbUZJkiHkL1oaeSX7zrV0S5ZV79NGxpKIoixR7b25WQYq0TCEucfnxnv1H6yaWfbabRSBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QICYTUm/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QICYTUm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778553694; x=1810089694;
  h=date:from:to:cc:subject:message-id;
  bh=mIdsLgIVQlZOF6GRDa6qjLZw3mPpk692Ly55PbeXj/M=;
  b=QICYTUm/fQyWX66hoSRt63aBkkAFIahh1zdDFZ8waIa7isQ7s+GO6zGD
   bX1ktUnYkTnig1QXpYGWKqBwkMkxMCoihyPe7ny20jnH4JXeu+Sg4dabx
   7iUakgu1pEkIe9eoxHHwvj0sYrj70nIPcSSazM9Bi1I0/tgSOL8tHDma/
   RgoMZPZJHDWIQVc9i1zQ1OKMxZA/aAxeHEYZB/VjjXiYW0WVXgDh2c12+
   ZokwxvcSt1zH/5nQFpPqDdUPGNE+zgk59ADddoma4+YZBHT4yhY8XCNWq
   bjHYmoZ8I5dMzqPD2Qk6Q6ZBfC85g/Wy/3sN111WsIqExn2ht8z9A/HcO
   Q==;
X-CSE-ConnectionGUID: 9Z7vgRugTeiHxxvhQkr1iw==
X-CSE-MsgGUID: 5B3Qk6INQDa7uPu3OsL1CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="89756447"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="89756447"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 19:41:34 -0700
X-CSE-ConnectionGUID: JXuPSy1YQ3Chng4s0bQ/eQ==
X-CSE-MsgGUID: Lt3kKTb3TBuZPA/OOvIVMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234582248"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 19:41:32 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMd3p-000000001Ul-3OzS;
	Tue, 12 May 2026 02:41:29 +0000
Date: Tue, 12 May 2026 10:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 ea72929526dfe6fb1a4c20afc0f2bff3dd0eb6f1
Message-ID: <202605121027.SLh99rGZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: ea72929526dfe6fb1a4c20afc0f2bff3dd0eb6f1  PCI: dwc: Apply ECRC workaround for DesignWare cores prior to 5.10A

elapsed time: 740m

configs tested: 200
configs skipped: 3

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
arc                   randconfig-001-20260512    gcc-11.5.0
arc                   randconfig-002-20260512    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    clang-23
arm                   randconfig-001-20260512    gcc-11.5.0
arm                   randconfig-002-20260512    gcc-11.5.0
arm                   randconfig-003-20260512    gcc-11.5.0
arm                   randconfig-004-20260512    gcc-11.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260512    gcc-14.3.0
arm64                 randconfig-002-20260512    gcc-14.3.0
arm64                 randconfig-003-20260512    gcc-14.3.0
arm64                 randconfig-004-20260512    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260512    gcc-14.3.0
csky                  randconfig-002-20260512    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260512    gcc-10.5.0
hexagon               randconfig-002-20260512    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260512    gcc-14
i386        buildonly-randconfig-002-20260512    gcc-14
i386        buildonly-randconfig-003-20260512    gcc-14
i386        buildonly-randconfig-004-20260512    gcc-14
i386        buildonly-randconfig-005-20260512    gcc-14
i386        buildonly-randconfig-006-20260512    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260512    gcc-14
i386                  randconfig-002-20260512    gcc-14
i386                  randconfig-003-20260512    gcc-14
i386                  randconfig-004-20260512    gcc-14
i386                  randconfig-005-20260512    gcc-14
i386                  randconfig-006-20260512    gcc-14
i386                  randconfig-007-20260512    gcc-14
i386                  randconfig-011-20260512    clang-20
i386                  randconfig-012-20260512    clang-20
i386                  randconfig-013-20260512    clang-20
i386                  randconfig-014-20260512    clang-20
i386                  randconfig-015-20260512    clang-20
i386                  randconfig-016-20260512    clang-20
i386                  randconfig-017-20260512    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260512    gcc-10.5.0
loongarch             randconfig-002-20260512    gcc-10.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-17
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260512    gcc-10.5.0
nios2                 randconfig-002-20260512    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260512    gcc-12.5.0
parisc                randconfig-002-20260512    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260512    gcc-12.5.0
powerpc               randconfig-002-20260512    gcc-12.5.0
powerpc64             randconfig-001-20260512    gcc-12.5.0
powerpc64             randconfig-002-20260512    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260512    gcc-15.2.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260512    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260512    gcc-15.2.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260512    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260512    gcc-15.2.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260512    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260512    gcc-13.4.0
sparc                 randconfig-002-20260512    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260512    gcc-13.4.0
sparc64               randconfig-002-20260512    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260512    gcc-13.4.0
um                    randconfig-002-20260512    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260512    gcc-14
x86_64      buildonly-randconfig-002-20260512    gcc-14
x86_64      buildonly-randconfig-003-20260512    gcc-14
x86_64      buildonly-randconfig-004-20260512    gcc-14
x86_64      buildonly-randconfig-005-20260512    gcc-14
x86_64      buildonly-randconfig-006-20260512    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260512    gcc-14
x86_64                randconfig-002-20260512    gcc-14
x86_64                randconfig-003-20260512    gcc-14
x86_64                randconfig-004-20260512    gcc-14
x86_64                randconfig-005-20260512    gcc-14
x86_64                randconfig-006-20260512    gcc-14
x86_64                randconfig-011-20260512    clang-20
x86_64                randconfig-012-20260512    clang-20
x86_64                randconfig-013-20260512    clang-20
x86_64                randconfig-014-20260512    clang-20
x86_64                randconfig-015-20260512    clang-20
x86_64                randconfig-016-20260512    clang-20
x86_64                randconfig-071-20260512    clang-20
x86_64                randconfig-072-20260512    clang-20
x86_64                randconfig-073-20260512    clang-20
x86_64                randconfig-074-20260512    clang-20
x86_64                randconfig-075-20260512    clang-20
x86_64                randconfig-076-20260512    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260512    gcc-13.4.0
xtensa                randconfig-002-20260512    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
