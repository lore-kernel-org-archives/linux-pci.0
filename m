Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CE2C21C7
	for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595886; cv=none; b=msMmZu/qYHKGCtXiHZN5161A73NQE9inQNM5uFI8XTvIpxVu/SsTCi4GBA/AglEddGvP/2aize6WTwzCm4u3uM6QUkBedeW+7OYcSDyRkoAynGZl82w4A7zixM5gtbOep4UiM8xUYSSAcR5GslzdeBE1gj1llrWSgCl9EPWUX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595886; c=relaxed/simple;
	bh=3vW7mk9M8oSKKo6KlKdA1EY1H6Z2UXiCmHSRbiRhNSc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O471Ns7Q0gZWbFlo7D+lFKqaqGNRVuZzJvBeqvmTMQcLazwyRnV0gbWW3ZUr1jHnTkhvrr8qxmT3u4sEcfd51K5KR2s78suSzHW8xFQV9hFSGRlfTma6yWeubwZdpHQmnW8F8FF06ny6XdPAY5ndzD9lUPOiuKosINLc+azwbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCq5sTTm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCq5sTTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779595884; x=1811131884;
  h=date:from:to:cc:subject:message-id;
  bh=3vW7mk9M8oSKKo6KlKdA1EY1H6Z2UXiCmHSRbiRhNSc=;
  b=KCq5sTTmyY3kDDYe3pBl+2KAgFhyIeDT/DpTwXCashOvuFb6sP+QnWxt
   FzdvBsysDXxjCtGrbQd1ZpPyh+Bz4eBXYXL4B4ZB7qpfhqgbj/N4feyV8
   kNkSJQzKuOZjO+caE0hLCl/m3XmKDbgjg62QX+iPVC/IrS4cd2Zayl1za
   KNBHY/N0j74n/kWqcBtVFaua1KJAZ03h+mR0pSk26r2hZ/cgslofBWg1V
   q0yozALe21cjzN8Xy3ow4pWvijBFQqe2CqN58KQW+UJPW9WUGflh2IAVy
   A8d+Z8quCGN9M4pYSJmFlBBqb1UIbfIfBwkIXT0raMHEDueZESgLGhBW9
   w==;
X-CSE-ConnectionGUID: HKXtOc0gR5W5SpZlkZMY1w==
X-CSE-MsgGUID: pa6Rz5I1QXCE28HI+R8nhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="80498405"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="80498405"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 21:11:23 -0700
X-CSE-ConnectionGUID: /JTIX+UuRUOFkpfy7CgiQQ==
X-CSE-MsgGUID: JtxQhR8cQL6O9MxVqFM8VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="237065621"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 May 2026 21:11:22 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wR0BM-000000000h3-2OES;
	Sun, 24 May 2026 04:11:20 +0000
Date: Sun, 24 May 2026 12:11:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 3a97877d13e1a29c50ab15ed0a0aba87b75061dd
Message-ID: <202605241253.jGg7vO4s-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 3a97877d13e1a29c50ab15ed0a0aba87b75061dd  Merge branch 'pci/misc'

elapsed time: 890m

configs tested: 124
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260524    gcc-8.5.0
arc                   randconfig-002-20260524    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                                 defconfig    clang-23
arm                   randconfig-001-20260524    clang-23
arm                   randconfig-002-20260524    gcc-11.5.0
arm                   randconfig-003-20260524    clang-19
arm                   randconfig-004-20260524    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260524    clang-23
arm64                 randconfig-002-20260524    clang-23
arm64                 randconfig-003-20260524    clang-23
arm64                 randconfig-004-20260524    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260524    gcc-9.5.0
csky                  randconfig-002-20260524    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260524    clang-23
hexagon               randconfig-002-20260524    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-004-20260524    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260524    gcc-13.4.0
loongarch             randconfig-002-20260524    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260524    gcc-8.5.0
nios2                 randconfig-002-20260524    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260524    gcc-15.2.0
parisc                randconfig-002-20260524    gcc-12.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260524    gcc-8.5.0
powerpc               randconfig-002-20260524    clang-23
powerpc64             randconfig-001-20260524    clang-23
powerpc64             randconfig-002-20260524    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                               defconfig    clang-23
riscv                 randconfig-002-20260524    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260524    clang-20
s390                  randconfig-002-20260524    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260524    gcc-15.2.0
sh                    randconfig-002-20260524    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260524    gcc-15.2.0
sparc                 randconfig-002-20260524    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260524    clang-23
sparc64               randconfig-002-20260524    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260524    gcc-14
um                    randconfig-002-20260524    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260524    gcc-14
x86_64      buildonly-randconfig-002-20260524    clang-20
x86_64      buildonly-randconfig-003-20260524    clang-20
x86_64      buildonly-randconfig-004-20260524    clang-20
x86_64      buildonly-randconfig-005-20260524    clang-20
x86_64      buildonly-randconfig-006-20260524    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260524    clang-20
x86_64                randconfig-002-20260524    clang-20
x86_64                randconfig-003-20260524    clang-20
x86_64                randconfig-004-20260524    clang-20
x86_64                randconfig-005-20260524    gcc-14
x86_64                randconfig-006-20260524    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260524    gcc-15.2.0
xtensa                randconfig-002-20260524    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
