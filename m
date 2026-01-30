Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEC2EE262
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806654; cv=none; b=OFIqMNHBLtjyQicV+yn+on+nAru/hSKtaklC0wYIMHA0/hGBlPwh8NgJKgu5h+w2pfO/YpM6kPacGCeCTVoE2O0ZB84jkj/lMckzXx05nAnBDiCZ4SDQ/nvUtm64CF5SCmk+zP9OVJ67idXfG8kQbz86yXidgAoyX/5pUyHplSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806654; c=relaxed/simple;
	bh=MfwBagN47RcZMWTf731TxiSCadk+pHtQdaDKXFHNU7E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HR5tJF0s8HJ52jADdlnFcMDoeEbtWoaI3Go9NL2KEzLoMpaP37h+DlfRKSqdcunAnJb1saFBwJt7xAMrfdcLKWYn4SvUHhLkzN37SgaAV0xQ6xaqyqCbimOzNik7aY3CwJD3eMlhKlWeRCsaUFDGB6OMMEI9mYrlT3vLALNngBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfB3I73V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfB3I73V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769806653; x=1801342653;
  h=date:from:to:cc:subject:message-id;
  bh=MfwBagN47RcZMWTf731TxiSCadk+pHtQdaDKXFHNU7E=;
  b=YfB3I73VYMRaRuFV7YSZSsK6zBoswY3jRaVZJDcgh4gaL4ZWM1g0iWSh
   wTcAkCkWlHs/8zCJB5LQdXP13GimmYtmOUfoT2M8QkMlsTKz72K/6ytLt
   LKv8DMV4u7+BP97zvQJqNTAfgy06ZoBuOZ8qc+FZWB1YPmO65feFWOZbA
   qYKNoFbwQsZ75pZSojK7AtHlChsnaaR9G+YTjtQCBxZJelKYhucFYUEnD
   464229gP5LmMjfNyG6YeEtRKZXFRoisDf1aG62yVUCpY53uJisjNqDg5P
   N7NAGnP7HXfY9861TBQ4Bacra8JcMJk5Z9DIB/KljHWBJXqLDegqf2Eo3
   w==;
X-CSE-ConnectionGUID: d2YX+G4iT6uzeClgp2rw5Q==
X-CSE-MsgGUID: LTy6u6aLQbCWSJYZG1Iwlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71040858"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71040858"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 12:57:32 -0800
X-CSE-ConnectionGUID: a6h8As90TQCDKS50GbrmEA==
X-CSE-MsgGUID: 387nvOKNSVayI1thapzAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="246570293"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Jan 2026 12:57:31 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlvYW-00000000dM2-2uMk;
	Fri, 30 Jan 2026 20:57:28 +0000
Date: Sat, 31 Jan 2026 04:56:40 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 910b91efb8bb39e91a0aa528b967a1c63b200217
Message-ID: <202601310435.owLYElYU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 910b91efb8bb39e91a0aa528b967a1c63b200217  Merge branch 'pci/misc'

elapsed time: 1263m

configs tested: 174
configs skipped: 4

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
arc                   randconfig-001-20260130    gcc-13.4.0
arc                   randconfig-002-20260130    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                         assabet_defconfig    clang-18
arm                                 defconfig    clang-22
arm                            mmp2_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20260130    clang-22
arm                   randconfig-002-20260130    clang-17
arm                   randconfig-003-20260130    clang-22
arm                   randconfig-004-20260130    clang-22
arm                           sama5_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260130    gcc-8.5.0
arm64                 randconfig-002-20260130    gcc-8.5.0
arm64                 randconfig-003-20260130    gcc-8.5.0
arm64                 randconfig-004-20260130    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-15.2.0
csky                  randconfig-002-20260130    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260130    clang-19
hexagon               randconfig-002-20260130    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260130    clang-20
i386        buildonly-randconfig-002-20260130    clang-20
i386        buildonly-randconfig-003-20260130    clang-20
i386        buildonly-randconfig-004-20260130    gcc-14
i386        buildonly-randconfig-005-20260130    clang-20
i386        buildonly-randconfig-006-20260130    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260130    clang-20
i386                  randconfig-002-20260130    clang-20
i386                  randconfig-003-20260130    clang-20
i386                  randconfig-004-20260130    clang-20
i386                  randconfig-005-20260130    gcc-14
i386                  randconfig-006-20260130    clang-20
i386                  randconfig-007-20260130    gcc-14
i386                  randconfig-011-20260130    gcc-14
i386                  randconfig-012-20260130    gcc-14
i386                  randconfig-013-20260130    gcc-14
i386                  randconfig-014-20260130    clang-20
i386                  randconfig-015-20260130    gcc-14
i386                  randconfig-016-20260130    gcc-14
i386                  randconfig-017-20260130    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260130    clang-22
loongarch             randconfig-002-20260130    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                       m5249evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260130    gcc-8.5.0
nios2                 randconfig-002-20260130    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260130    gcc-14.3.0
parisc                randconfig-002-20260130    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260130    gcc-14.3.0
powerpc               randconfig-002-20260130    gcc-10.5.0
powerpc64             randconfig-001-20260130    clang-22
powerpc64             randconfig-002-20260130    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260130    gcc-14.3.0
riscv                 randconfig-002-20260130    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260130    clang-22
s390                  randconfig-002-20260130    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260130    gcc-9.5.0
sh                    randconfig-002-20260130    gcc-13.4.0
sh                           se7712_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260130    gcc-8.5.0
sparc                 randconfig-002-20260130    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260130    clang-22
sparc64               randconfig-002-20260130    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260130    clang-22
um                    randconfig-002-20260130    gcc-13
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260130    clang-20
x86_64      buildonly-randconfig-002-20260130    gcc-14
x86_64      buildonly-randconfig-003-20260130    clang-20
x86_64      buildonly-randconfig-004-20260130    clang-20
x86_64      buildonly-randconfig-005-20260130    clang-20
x86_64      buildonly-randconfig-006-20260130    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260130    clang-20
x86_64                randconfig-002-20260130    gcc-14
x86_64                randconfig-003-20260130    gcc-14
x86_64                randconfig-004-20260130    gcc-14
x86_64                randconfig-005-20260130    gcc-14
x86_64                randconfig-006-20260130    clang-20
x86_64                randconfig-011-20260130    clang-20
x86_64                randconfig-012-20260130    clang-20
x86_64                randconfig-013-20260130    clang-20
x86_64                randconfig-014-20260130    gcc-14
x86_64                randconfig-015-20260130    clang-20
x86_64                randconfig-016-20260130    gcc-14
x86_64                randconfig-071-20260130    clang-20
x86_64                randconfig-072-20260130    clang-20
x86_64                randconfig-073-20260130    clang-20
x86_64                randconfig-074-20260130    clang-20
x86_64                randconfig-075-20260130    clang-20
x86_64                randconfig-076-20260130    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260130    gcc-12.5.0
xtensa                randconfig-002-20260130    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
