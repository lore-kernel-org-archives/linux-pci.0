Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26043126BF7
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634675; cv=none; b=YvuBa8YKrT8CEK0zxbOoKje8vD6FHmOtLT+o+2iI2iUZcGAqtgdgcP0TWTgzM79Xi+1elqxgASKdMQpfPgwW3J6SmCP04l3OkvUXU9AUJewjjx6HMj2uLASFxvNpktdVE11mEqlBYf0AamcVmO+OxyAoNSSznF3B3kP9sLbbQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634675; c=relaxed/simple;
	bh=385jsJ10aPz9ybvtn8BF24kLV4GFy7KpsgnBzZv+OBA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P9IwHrAq9DP4K/r8J9AlMLzMCPbOvCkJiUwNgBOn3h0Xq2Gwpt0NUY4XpVwpFsFpdqG6gsOpgJfJTVw95cmZ5OIUFxMqVZDtWXIQrpRU0xPnG9vr5iyaUe+HDqKlVBjsvP1yyAWzLse4SOjiLnRuXOA6S1aSBZOVFlDLQZC53o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWaOeYv0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWaOeYv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785634674; x=1817170674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=385jsJ10aPz9ybvtn8BF24kLV4GFy7KpsgnBzZv+OBA=;
  b=UWaOeYv0UE9OTZ6cJJo1Mehp/Ck6021b4ArZB25ZaMsoK4z+nlUsgLpJ
   x6b72PsEDFGdvmtEWq54+QAJ1Qw+l2kYYv3piirm6VsgE9Gay3r+Va54G
   6R/MVc/GIqCkC5xKlEtENRNZPnSdhBK/Z/fRGP1zTiy/p67CjIUuUc1Tl
   zeU4cMpP8tzNJCyhmciIHVUAdHdS8mUgggT4aI3H6XsX6dvRklxMUor0J
   BCVfoHugmw8IKcS5aglw4q3g/GyMMY+HtQnxcgFl2G2qKNFRfhMbgDzED
   7BRcxQxd2ocC2hYVD5bRKojgMlDQYKDG0lu7lLqV1NNkyXoHfNuTJNt5Q
   w==;
X-CSE-ConnectionGUID: nh4KYg5QTbCgLkSG+3Il5A==
X-CSE-MsgGUID: 6PsjubdxSBSk1vxc2h5OsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="85983981"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="85983981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 18:37:53 -0700
X-CSE-ConnectionGUID: DtZNbR6nR9CrQqLX7Fo+NA==
X-CSE-MsgGUID: HAEKTVemSIS7cTq4o0QJxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="260956815"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Aug 2026 18:37:51 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqL9B-000000004EY-2XiH;
	Sun, 02 Aug 2026 01:37:49 +0000
Date: Sun, 02 Aug 2026 09:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:procfs] BUILD SUCCESS
 92fd60d86b1039f14210ac973e57a0f8641b3dae
Message-ID: <202608020939.vxZpDfH9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git procfs
branch HEAD: 92fd60d86b1039f14210ac973e57a0f8641b3dae  PCI/proc: Use file_ns_capable() when checking config space read access

elapsed time: 747m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260802    gcc-15.2.0
arc                  randconfig-002-20260802    gcc-15.2.0
arm                  randconfig-001-20260802    gcc-15.2.0
arm                  randconfig-002-20260802    gcc-15.2.0
arm                  randconfig-003-20260802    gcc-15.2.0
arm                  randconfig-004-20260802    gcc-15.2.0
arm64                randconfig-001-20260802    gcc-9.5.0
arm64                randconfig-002-20260802    gcc-9.5.0
arm64                randconfig-003-20260802    gcc-9.5.0
arm64                randconfig-004-20260802    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260802    gcc-9.5.0
csky                 randconfig-002-20260802    gcc-9.5.0
hexagon              randconfig-001-20260802    clang-24
hexagon              randconfig-002-20260802    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260802    gcc-14
i386       buildonly-randconfig-002-20260802    gcc-14
i386       buildonly-randconfig-003-20260802    gcc-14
i386       buildonly-randconfig-004-20260802    gcc-14
i386       buildonly-randconfig-005-20260802    gcc-14
i386       buildonly-randconfig-006-20260802    gcc-14
i386                 randconfig-001-20260802    gcc-14
i386                 randconfig-002-20260802    gcc-14
i386                 randconfig-003-20260802    gcc-14
i386                 randconfig-004-20260802    gcc-14
i386                 randconfig-005-20260802    gcc-14
i386                 randconfig-006-20260802    gcc-14
i386                 randconfig-007-20260802    gcc-14
i386                 randconfig-011-20260802    gcc-14
i386                 randconfig-012-20260802    gcc-14
i386                 randconfig-013-20260802    gcc-14
i386                 randconfig-014-20260802    gcc-14
i386                 randconfig-015-20260802    gcc-14
i386                 randconfig-016-20260802    gcc-14
i386                 randconfig-017-20260802    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260802    clang-24
loongarch            randconfig-002-20260802    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260802    clang-24
nios2                randconfig-002-20260802    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260802    gcc-14.3.0
parisc               randconfig-002-20260802    gcc-14.3.0
powerpc                  bluestone_defconfig    clang-24
powerpc              randconfig-001-20260802    gcc-14.3.0
powerpc              randconfig-002-20260802    gcc-14.3.0
powerpc64            randconfig-001-20260802    gcc-14.3.0
powerpc64            randconfig-002-20260802    gcc-14.3.0
riscv                randconfig-001-20260802    gcc-13.4.0
riscv                randconfig-002-20260802    gcc-13.4.0
s390                         debug_defconfig    gcc-16.1.0
s390                 randconfig-001-20260802    gcc-13.4.0
s390                 randconfig-002-20260802    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260802    gcc-13.4.0
sh                   randconfig-002-20260802    gcc-13.4.0
sparc                randconfig-001-20260802    gcc-12.5.0
sparc                randconfig-002-20260802    gcc-12.5.0
sparc64              randconfig-001-20260802    gcc-12.5.0
sparc64              randconfig-002-20260802    gcc-12.5.0
um                   randconfig-001-20260802    gcc-12.5.0
um                   randconfig-002-20260802    gcc-12.5.0
x86_64     buildonly-randconfig-001-20260802    gcc-12
x86_64     buildonly-randconfig-002-20260802    gcc-12
x86_64     buildonly-randconfig-003-20260802    gcc-12
x86_64     buildonly-randconfig-004-20260802    gcc-12
x86_64     buildonly-randconfig-005-20260802    gcc-12
x86_64     buildonly-randconfig-006-20260802    gcc-12
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260802    clang-22
x86_64               randconfig-002-20260802    clang-22
x86_64               randconfig-003-20260802    clang-22
x86_64               randconfig-004-20260802    clang-22
x86_64               randconfig-005-20260802    clang-22
x86_64               randconfig-006-20260802    clang-22
x86_64               randconfig-011-20260802    clang-22
x86_64               randconfig-012-20260802    clang-22
x86_64               randconfig-013-20260802    clang-22
x86_64               randconfig-014-20260802    clang-22
x86_64               randconfig-015-20260802    clang-22
x86_64               randconfig-016-20260802    clang-22
x86_64               randconfig-071-20260802    gcc-12
x86_64               randconfig-072-20260802    gcc-12
x86_64               randconfig-073-20260802    gcc-12
x86_64               randconfig-074-20260802    gcc-12
x86_64               randconfig-075-20260802    gcc-12
x86_64               randconfig-076-20260802    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260802    gcc-12.5.0
xtensa               randconfig-002-20260802    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
