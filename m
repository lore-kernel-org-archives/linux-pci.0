Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83AE47CA62
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131644; cv=none; b=nIKb/8DeSNsn2JZ9zRnUReAtahtYIJMLXFa7w32cMDq/rCMi8qSinwvqwndLlZqTMMyOK7gyXOap0+CT2qm2BAdQRJasE7TZyg+2O3tVzBPQgakR7OPfY/7rl4SJLF/G5yBYyOsZIz074GY6fvNapPHSS6T1q/W95ge/Co1aGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131644; c=relaxed/simple;
	bh=7qbh451PpsoV0rlWvc4rFOBCHDE+NHw9eUbKoBju6eM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LQ6cVPpeY1es7NaGiwCGxY4rP0QZCifOW2MbghvMpkiCo4A8RUgiyOPKSVI5OP/QPIHFtFXHeAz8danXhwodZI2HLVEMZPytIbUZ2O1kySUegLJ398bf4eS+CUD+2QtkOWFNDhfqpwEnNFqjKKb0zKuLM6jN6k/R5YZ4tRO2O94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xw3bQNiz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xw3bQNiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789131625; x=1820667625;
  h=date:from:to:cc:subject:message-id;
  bh=7qbh451PpsoV0rlWvc4rFOBCHDE+NHw9eUbKoBju6eM=;
  b=Xw3bQNiz/6LGjPWwcToTezpG9fYwftElfSHLLPRdinqrJFPu5C3+yQVU
   O48mvUcLfGGY69YtgOFB1x5o3xincm/LCotQtMcd3KTx6RDQeCgko7h86
   MrlGvyduWIZ0Dwb+8VPC2yiHDlqdcy2sumhNgAFi5ov2JsQg3JISWiidr
   Q7JMY7GPubGHr01WJ0ne4f2JTd6ZOaPspejv3hbxnXUMSIscWERDKvd0w
   RiN6xaoO+pWBy3JEgwcSwDb6T7qHhOUbQMTeE+w0VkBH5nuU/L90nBH8m
   eW4MPebKlgKWQh6JaDdJ/8gGDAmAlJn2D6EJAPduveKIhrRZ5XRNKWM6P
   w==;
X-CSE-ConnectionGUID: zWjPUmtpQwSAVNHJX0YNjQ==
X-CSE-MsgGUID: rpNp+Ok3RGmgrFVJTAnfCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88536223"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="88536223"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:00:19 -0700
X-CSE-ConnectionGUID: 6kaWx7U/SNOg4TOZ7c0f8w==
X-CSE-MsgGUID: hPDhfL6nTZqYiNwDwwGk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="277166583"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 11 Sep 2026 06:00:18 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x50rT-000000001Z5-0OZF;
	Fri, 11 Sep 2026 13:00:12 +0000
Date: Fri, 11 Sep 2026 20:59:56 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:misc] BUILD SUCCESS
 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
Message-ID: <202609112052.XnWqSzJI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/misc
branch HEAD: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d  PCI: Remove device links to PHY

elapsed time: 1487m

configs tested: 186
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                          axs103_defconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260911    clang-24
arc                   randconfig-002-20260911    clang-24
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                        clps711x_defconfig    gcc-16.1.0
arm                                 defconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260911    clang-24
arm                   randconfig-002-20260911    clang-24
arm                   randconfig-003-20260911    clang-24
arm                   randconfig-004-20260911    clang-24
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260911    gcc-16.1.0
arm64                 randconfig-002-20260911    gcc-16.1.0
arm64                 randconfig-003-20260911    gcc-16.1.0
arm64                 randconfig-004-20260911    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260911    gcc-16.1.0
csky                  randconfig-002-20260911    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-24
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-24
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260911    gcc-12.5.0
hexagon               randconfig-002-20260911    gcc-12.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260911    clang-22
i386        buildonly-randconfig-002-20260911    clang-22
i386        buildonly-randconfig-002-20260911    gcc-14
i386        buildonly-randconfig-003-20260911    clang-22
i386        buildonly-randconfig-003-20260911    gcc-14
i386        buildonly-randconfig-004-20260911    clang-22
i386        buildonly-randconfig-005-20260911    clang-22
i386        buildonly-randconfig-006-20260911    clang-22
i386        buildonly-randconfig-006-20260911    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260911    clang-22
i386                  randconfig-002-20260911    clang-22
i386                  randconfig-003-20260911    clang-22
i386                  randconfig-004-20260911    clang-22
i386                  randconfig-005-20260911    clang-22
i386                  randconfig-006-20260911    clang-22
i386                  randconfig-007-20260911    clang-22
i386                  randconfig-011-20260911    clang-22
i386                  randconfig-012-20260911    clang-22
i386                  randconfig-013-20260911    clang-22
i386                  randconfig-014-20260911    clang-22
i386                  randconfig-015-20260911    clang-22
i386                  randconfig-016-20260911    clang-22
i386                  randconfig-017-20260911    clang-22
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260911    gcc-12.5.0
loongarch             randconfig-002-20260911    gcc-12.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5275evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      loongson1_defconfig    gcc-16.1.0
mips                      loongson3_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260911    gcc-12.5.0
nios2                 randconfig-002-20260911    gcc-12.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260911    gcc-13.4.0
parisc                randconfig-002-20260911    gcc-11.5.0
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc               randconfig-001-20260911    clang-21
powerpc               randconfig-002-20260911    clang-24
powerpc64             randconfig-001-20260911    gcc-8.5.0
powerpc64             randconfig-002-20260911    clang-24
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260911    gcc-16.1.0
riscv                 randconfig-002-20260911    gcc-16.1.0
s390                             allmodconfig    clang-24
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                          debug_defconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260911    gcc-16.1.0
s390                  randconfig-002-20260911    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260911    gcc-16.1.0
sh                    randconfig-002-20260911    gcc-16.1.0
sh                   rts7751r2dplus_defconfig    gcc-16.1.0
sh                           se7722_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260911    gcc-13.4.0
sparc                 randconfig-002-20260911    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-24
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260911    gcc-13.4.0
sparc64               randconfig-002-20260911    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-24
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260911    gcc-13.4.0
um                    randconfig-002-20260911    gcc-13.4.0
um                           x86_64_defconfig    clang-24
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260911    clang-22
x86_64                randconfig-002-20260911    clang-22
x86_64                randconfig-003-20260911    clang-22
x86_64                randconfig-004-20260911    clang-22
x86_64                randconfig-005-20260911    clang-22
x86_64                randconfig-006-20260911    clang-22
x86_64                randconfig-011-20260911    gcc-14
x86_64                randconfig-012-20260911    gcc-14
x86_64                randconfig-013-20260911    clang-22
x86_64                randconfig-013-20260911    gcc-14
x86_64                randconfig-014-20260911    clang-22
x86_64                randconfig-014-20260911    gcc-14
x86_64                randconfig-015-20260911    clang-22
x86_64                randconfig-015-20260911    gcc-14
x86_64                randconfig-016-20260911    clang-22
x86_64                randconfig-016-20260911    gcc-14
x86_64                randconfig-071-20260911    gcc-14
x86_64                randconfig-072-20260911    gcc-14
x86_64                randconfig-073-20260911    gcc-14
x86_64                randconfig-074-20260911    gcc-14
x86_64                randconfig-075-20260911    gcc-14
x86_64                randconfig-076-20260911    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260911    gcc-13.4.0
xtensa                randconfig-002-20260911    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
