Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921213AD1C
	for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779586509; cv=none; b=E2N3KUvSzjUupuaJCC4ahYNL/sK2EV/sR5hTkrxKlhcazT0Wg6nyS5ni3U9OBPSMCvLJhbEycp5oQSRVu51Lif8ODwFtBlr7YyverJ7+e4aUbSiH2Qkeizla2o3Q8B4NRKpmonSFA9DUWcJMy3JYZNLL6MBdjberPw1DvdN9Ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779586509; c=relaxed/simple;
	bh=AtewMhxvTp1hd4ljYSLYkFe/8t7pz0pVlgGQkT+2npI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VxhPWrNbDABq2QBCNFDkctmKV9fLUBu+tIZB0UkJR61RcxVhvvUF/zerjgmb5AOTfDgufKNPTpwRlff+K2Jf1PU5+neIl35bKX2BoG5YmsrO4hIMG+5DVzVfLJU9E+u21A+sIRDu40t3wxxpwHBc1+wICTttb9MuqT0asr493kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2mMLjWp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2mMLjWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779586508; x=1811122508;
  h=date:from:to:cc:subject:message-id;
  bh=AtewMhxvTp1hd4ljYSLYkFe/8t7pz0pVlgGQkT+2npI=;
  b=W2mMLjWp+Lx0ldO51GfbKHElwOZGGZbtV1JAzRX6JCow0kMl4JW7puQB
   XapxlRA6dacZlItrwo3dR1jtqRjH2ZzIvcGl7Booq/BN7p/fZ7+454rS3
   92wJZ6drhk/S9gLKvEDEBwI2ZpHjW7wemjQt//OKcdltVas3V3bF0A0pE
   ThuZS51oXrVP74ddS6DMGej/R7H1ApSPpf5w27VzBm1rE3rtDB58j/oLv
   tL238mIVW2WsYtkBOE2UGS2Bu90TviWxUM+AuqjVGVQdyQOl2Y44DLawI
   0HDoWAaBcKiMPYkd67ko5HIayEVj70acIabpH5fuRTLFVuUAm0CRX+XrY
   w==;
X-CSE-ConnectionGUID: cZnTfsUUS0G28QiKksmQBQ==
X-CSE-MsgGUID: ZjUM2FnsR0Kb8RahBDBrhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="91849575"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="91849575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 18:35:08 -0700
X-CSE-ConnectionGUID: /JOUUS/DT3eWd8a7XpSt8A==
X-CSE-MsgGUID: +9kvkUOPQkiP7f/E6X3moA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="279369504"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 May 2026 18:35:07 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQxk7-000000000Xv-3xs6;
	Sun, 24 May 2026 01:35:03 +0000
Date: Sun, 24 May 2026 09:34:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 748a927e081bffc9a9be17b4d96088515e1c5f01
Message-ID: <202605240958.5sYlcOJt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 748a927e081bffc9a9be17b4d96088515e1c5f01  nvme-pci: Use pci_suspend_retains_context() during suspend

elapsed time: 733m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260524    clang-23
arm64                 randconfig-002-20260524    clang-23
arm64                 randconfig-003-20260524    clang-23
arm64                 randconfig-004-20260524    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260524    gcc-9.5.0
csky                  randconfig-002-20260524    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260524    gcc-8.5.0
hexagon               randconfig-002-20260524    gcc-8.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260524    gcc-14
i386        buildonly-randconfig-002-20260524    gcc-14
i386        buildonly-randconfig-003-20260524    gcc-14
i386        buildonly-randconfig-004-20260524    gcc-14
i386        buildonly-randconfig-005-20260524    gcc-14
i386        buildonly-randconfig-006-20260524    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260524    gcc-8.5.0
loongarch             randconfig-002-20260524    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260524    gcc-8.5.0
nios2                 randconfig-002-20260524    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260524    gcc-15.2.0
parisc                randconfig-002-20260524    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260524    gcc-8.5.0
powerpc               randconfig-002-20260524    clang-23
powerpc64             randconfig-001-20260524    clang-23
powerpc64             randconfig-002-20260524    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                    nommu_virt_defconfig    clang-23
riscv                 randconfig-002-20260524    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260524    clang-20
s390                  randconfig-002-20260524    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260524    gcc-15.2.0
sh                    randconfig-002-20260524    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260524    clang-20
x86_64                randconfig-002-20260524    clang-20
x86_64                randconfig-003-20260524    clang-20
x86_64                randconfig-004-20260524    clang-20
x86_64                randconfig-005-20260524    clang-20
x86_64                randconfig-005-20260524    gcc-14
x86_64                randconfig-006-20260524    clang-20
x86_64                randconfig-006-20260524    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
