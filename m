Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D4331EA5
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645938; cv=none; b=FkW1JYYBomHXEwotk+FOIY5Wf/9NI2xxDxuE1eYM7/iu5rxxem8XZj6VOnn83Z0UY+n/6osAK1YrqTn8BoU8CvfAlQ+C8HTyyWl1aWHxU3JoLVtHkNiHC+1UiFfGtlXrwk+WGmb9sPuWYSn6Ttvk44CCPscTjL7tQaz7ynEJk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645938; c=relaxed/simple;
	bh=zhQ4UwQBdUUbVNCcjVxE3DTLFyjDBcRkp0pfl6yrzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CQnXoB5UhhXmFEIdnk9vZFZWxXRR2p3pYd259l8XXp8sGwFsYbuqQ+I8AfmBK1AmjpU9hDXslp9JeK/W8iUf/1OjmhkpkCj9Ekc/W5hV9udSp1TxE1+s+E/g9WbnZMDI27W/MoK55NdMH13mcWHORvAWZV1qen7Ccm14SreLZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SflZ3Nar; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SflZ3Nar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781645937; x=1813181937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zhQ4UwQBdUUbVNCcjVxE3DTLFyjDBcRkp0pfl6yrzgQ=;
  b=SflZ3NarTfJNDG29XcjspIki4mfoy5dGvNykTf5kIVQYEWY3Cwb6hFhi
   U0aPHPmZX6F0uN/IxnVLcItcybmQ6MoGRPkYBjC00foHoBaomGrDMCcWK
   wQCc3Zli0uxwR+ft3yHjUR+6gGjmWabmEPW7QiGYygGkfgBZJgkYp08VV
   3vTBN4yLDKwhjq+4bGmJcTT/tjJC4PQ9j0mDloxEk5TMheyfoxzBE/q0o
   AVLPIcdBjEIJDLwYAggdGB5Z12NG2pNyiBHgqDJW5irNdeRlxFqGo40H8
   JQUF0MWcNNlfKvVLlsASDxWo8+YCeuCez6ozow0C5HF1ZsLCPEKBVVtrN
   w==;
X-CSE-ConnectionGUID: AvGJlvHcRZKtaN8KbZTjyg==
X-CSE-MsgGUID: fexjrfkTQz6ZExdBruIG4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="107870310"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="107870310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 14:38:55 -0700
X-CSE-ConnectionGUID: QofMHNIeQF612hFJ65q+Bg==
X-CSE-MsgGUID: UZnFdrmjSc+jgV0SiuLkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247972488"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Jun 2026 14:38:53 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZbUg-00000000Tm8-1Z0R;
	Tue, 16 Jun 2026 21:38:50 +0000
Date: Wed, 17 Jun 2026 05:38:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/legacy-write-kasan-fix] BUILD SUCCESS
 93c0a81dbefc2fc4d43159826b57f596f6a1ce1c
Message-ID: <202606170522.9kYdRqSH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/legacy-write-kasan-fix
branch HEAD: 93c0a81dbefc2fc4d43159826b57f596f6a1ce1c  PCI/sysfs: Fix read byte order in pci_read_legacy_io()

elapsed time: 814m

configs tested: 349
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-9.5.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                            randconfig-002    gcc-9.5.0
arc                   randconfig-002-20260616    gcc-9.5.0
arc                   randconfig-002-20260617    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    clang-23
arm                            randconfig-001    gcc-9.5.0
arm                   randconfig-001-20260616    gcc-9.5.0
arm                   randconfig-001-20260617    gcc-16.1.0
arm                            randconfig-002    gcc-9.5.0
arm                   randconfig-002-20260616    gcc-9.5.0
arm                   randconfig-002-20260617    gcc-16.1.0
arm                            randconfig-003    gcc-9.5.0
arm                   randconfig-003-20260616    gcc-9.5.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                            randconfig-004    gcc-9.5.0
arm                   randconfig-004-20260616    gcc-9.5.0
arm                   randconfig-004-20260617    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260616    clang-23
arm64                 randconfig-001-20260616    gcc-13.4.0
arm64                 randconfig-001-20260616    gcc-8.5.0
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260616    clang-23
arm64                 randconfig-002-20260616    gcc-13.4.0
arm64                 randconfig-002-20260616    gcc-15.2.0
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260616    clang-23
arm64                 randconfig-003-20260616    gcc-13.4.0
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260616    clang-23
arm64                 randconfig-004-20260616    gcc-11.5.0
arm64                 randconfig-004-20260616    gcc-13.4.0
arm64                 randconfig-004-20260617    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260616    clang-23
csky                  randconfig-001-20260616    gcc-13.4.0
csky                  randconfig-001-20260616    gcc-15.2.0
csky                  randconfig-001-20260617    gcc-12.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260616    clang-23
csky                  randconfig-002-20260616    gcc-13.4.0
csky                  randconfig-002-20260617    gcc-12.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-001-20260616    gcc-11.5.0
hexagon               randconfig-001-20260617    clang-17
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260616    clang-23
hexagon               randconfig-002-20260616    gcc-11.5.0
hexagon               randconfig-002-20260617    clang-17
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260616    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260616    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260616    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260616    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260616    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260616    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260616    clang-22
i386                  randconfig-001-20260616    gcc-14
i386                  randconfig-001-20260617    gcc-13
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-002-20260617    gcc-13
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260616    clang-22
i386                  randconfig-003-20260616    gcc-14
i386                  randconfig-003-20260617    gcc-13
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-004-20260617    gcc-13
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-005-20260617    gcc-13
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260616    clang-22
i386                  randconfig-006-20260616    gcc-14
i386                  randconfig-006-20260617    gcc-13
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260616    gcc-14
i386                  randconfig-007-20260617    gcc-13
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260616    clang-22
i386                  randconfig-011-20260617    clang-22
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260616    clang-22
i386                  randconfig-012-20260617    clang-22
i386                           randconfig-013    clang-22
i386                  randconfig-013-20260616    clang-22
i386                  randconfig-013-20260617    clang-22
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260616    clang-22
i386                  randconfig-014-20260617    clang-22
i386                           randconfig-015    clang-22
i386                  randconfig-015-20260616    clang-22
i386                  randconfig-015-20260617    clang-22
i386                           randconfig-016    clang-22
i386                  randconfig-016-20260616    clang-22
i386                  randconfig-016-20260617    clang-22
i386                           randconfig-017    clang-22
i386                  randconfig-017-20260616    clang-22
i386                  randconfig-017-20260617    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260616    clang-23
loongarch             randconfig-001-20260616    gcc-11.5.0
loongarch             randconfig-001-20260616    gcc-13.4.0
loongarch             randconfig-001-20260617    clang-17
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260616    clang-18
loongarch             randconfig-002-20260616    clang-23
loongarch             randconfig-002-20260616    gcc-11.5.0
loongarch             randconfig-002-20260617    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260616    clang-23
nios2                 randconfig-001-20260616    gcc-11.5.0
nios2                 randconfig-001-20260616    gcc-9.5.0
nios2                 randconfig-001-20260617    clang-17
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260616    clang-23
nios2                 randconfig-002-20260616    gcc-11.5.0
nios2                 randconfig-002-20260616    gcc-8.5.0
nios2                 randconfig-002-20260617    clang-17
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260616    gcc-8.5.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260616    gcc-8.5.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    clang-23
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260616    gcc-8.5.0
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260616    gcc-8.5.0
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260616    gcc-8.5.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260616    gcc-8.5.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260616    gcc-16.1.0
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                 randconfig-002-20260616    gcc-16.1.0
riscv                 randconfig-002-20260617    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260616    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-16.1.0
s390                  randconfig-002-20260616    gcc-16.1.0
s390                  randconfig-002-20260617    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260616    gcc-16.1.0
sh                    randconfig-001-20260617    gcc-16.1.0
sh                    randconfig-002-20260616    gcc-16.1.0
sh                    randconfig-002-20260617    gcc-16.1.0
sh                        sh7785lcr_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260616    gcc-8.5.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260616    gcc-8.5.0
sparc64               randconfig-002-20260617    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260616    gcc-8.5.0
um                    randconfig-001-20260617    gcc-16.1.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260616    gcc-8.5.0
um                    randconfig-002-20260617    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260616    gcc-14
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260616    gcc-14
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260616    gcc-14
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260616    gcc-14
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260616    gcc-14
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260616    gcc-14
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260616    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260616    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260616    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260616    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260616    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260616    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                randconfig-011-20260616    clang-22
x86_64                randconfig-011-20260617    clang-22
x86_64                randconfig-012-20260616    clang-22
x86_64                randconfig-012-20260617    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                randconfig-013-20260617    clang-22
x86_64                randconfig-014-20260616    clang-22
x86_64                randconfig-014-20260617    clang-22
x86_64                randconfig-015-20260616    clang-22
x86_64                randconfig-015-20260617    clang-22
x86_64                randconfig-016-20260616    clang-22
x86_64                randconfig-016-20260617    clang-22
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260616    gcc-13
x86_64                randconfig-071-20260616    gcc-14
x86_64                randconfig-071-20260617    clang-22
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260616    gcc-13
x86_64                randconfig-072-20260616    gcc-14
x86_64                randconfig-072-20260617    clang-22
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260616    gcc-13
x86_64                randconfig-073-20260616    gcc-14
x86_64                randconfig-073-20260617    clang-22
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260616    gcc-13
x86_64                randconfig-074-20260616    gcc-14
x86_64                randconfig-074-20260617    clang-22
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260616    gcc-13
x86_64                randconfig-075-20260616    gcc-14
x86_64                randconfig-075-20260617    clang-22
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260616    gcc-13
x86_64                randconfig-076-20260616    gcc-14
x86_64                randconfig-076-20260617    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260616    gcc-8.5.0
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260616    gcc-8.5.0
xtensa                randconfig-002-20260617    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
