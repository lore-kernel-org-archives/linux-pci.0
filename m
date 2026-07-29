Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E32F1FC7
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315185; cv=none; b=VeslBiFxhhwHXCsVhiywWb+EuiahBEbDx8IQC+y4PDESg/snsq3ByjOaEbN03dHmeu33xRULHYhzILmFFU6DQHlyXqz25k/xpLN/BCQUDW5leKQQGemnmYlAo0g3mvLuB9lY7n4thx9dbRill1KcI3e3g/rIbNOkNmtgB+RLVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315185; c=relaxed/simple;
	bh=8JoCMUsFTNf0fhCORhvnr2U+KO6zNGavCb+d0Pr7Q9M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ESYdQuAwtfnLUqeZ4c+++eoK4g099uCI9JePlhadZRRDnDRKXd7jqSr9bUMqbepnnfAFKIAt8t9nXAbILl5SaW10fOISKVb+p4tEjUlcNN6cmnOEZdlfkb2mIx9M7vl9XsFsCHlzg4VO17E5qQfPZb4KekdOqcQMSjJYBRK7FWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHpTrJWd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHpTrJWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785315184; x=1816851184;
  h=date:from:to:cc:subject:message-id;
  bh=8JoCMUsFTNf0fhCORhvnr2U+KO6zNGavCb+d0Pr7Q9M=;
  b=SHpTrJWdH4b05ha3tE8sHMeTFuutLELkxBnvWR3OVxkyuF5ThJsjuivT
   fJ50Ty4C5LLiEZfnnMuAu4ZK110Oy/C00OGsmGQL2igNlIytXtumol7tW
   7/Ab/9hE9W9YXdNUtpT1VMVXn3IqYwthEjVYLjjeA3GPwcBgJfPx5uLWe
   YP62510LtFpc7uHPV8vnfCFhPIWoLVJULrYRmHVvxygKdfnMysOprNxiJ
   x3jJqeg4/rEsRVLCDz+qvluHmZ0uyQafW1mepL0O9Nul7rXWi4PkPOHFB
   vKIW7YXzFtcRhXjK7tR3HsCMKHtdNnSrQXEMGAHetbYraFxfQkPIjZh7N
   g==;
X-CSE-ConnectionGUID: Pdaf8aEaRAeqdVnvOGCeZA==
X-CSE-MsgGUID: zIJ6RWOdSaGKuWtBSnfohg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85929165"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85929165"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 01:53:03 -0700
X-CSE-ConnectionGUID: 3eTxA2YARRO7xY0g/uASWw==
X-CSE-MsgGUID: fWzGsTPGQlCnI/hH1dlHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="263445311"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Jul 2026 01:53:02 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wp028-00000000fDL-0FQD;
	Wed, 29 Jul 2026 08:53:00 +0000
Date: Wed, 29 Jul 2026 16:51:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 b9851611bad7cb227c93c1401dca48995a815d94
Message-ID: <202607291622.9s3rruU6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: b9851611bad7cb227c93c1401dca48995a815d94  PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint out of 'tc9563_pwrctrl_ports' enum

elapsed time: 914m

configs tested: 129
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    gcc-8.5.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-15.2.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-13.4.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-11.5.0
arm64                randconfig-004-20260729    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-16.1.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-16.1.0
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-002-20260729    gcc-9.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    clang-22
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    clang-22
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    clang-22
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-001-20260729    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-006-20260729    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260729    clang-22
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-012-20260729    clang-22
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-013-20260729    clang-22
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    clang-22
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    clang-22
i386                 randconfig-017-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-002-20260729    gcc-9.5.0
m68k                       m5272c3_defconfig    gcc-16.1.0
mips                       bcm63xx_defconfig    clang-24
mips                     maltaaprp_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-002-20260729    clang-24
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-002-20260729    clang-24
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-002-20260729    clang-24
riscv            nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                           hp6xx_defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-002-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-10.5.0
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-12
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-002-20260729    gcc-13
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64               randconfig-006-20260729    gcc-14
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-016-20260729    gcc-14
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-076-20260729    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-002-20260729    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
