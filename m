Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3124B28
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548289; cv=none; b=TUQPAlFZdi0XmKR2GZHmU5ZSvfI4TxMTiPzWVeApItTYv902bYzewJndxJJgxX4FfX9z57BPeNBkQSd8KPj5nwdaqKoQ1aRj+cQ47F2dxi9ynAXl0JrwwXKgYdiu38F5XgcNC/chorULJqh9ApvqPIVjdxpv/iItYiAa2fJgVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548289; c=relaxed/simple;
	bh=oNxiOBtFMXMmIpGNeubxxgXgQMBTpikSL6m+NIz0wmQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E7tctc2PKz4ERaFPjPOe+DRiCBjc27ChlHf0JbVGj8Bil2zzwAKQFx7ubj+Di3zb7CV1qAky4RFTjqKe6rR/1yNskmlL/piA8OyoTbC9XKPhZQlwXEEikpcJO1cRTmHE0YjMBY7bca6PTa0QIG3Gr+qBOzOFgoC118Vhq3f+bbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrQHJGgO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrQHJGgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787548287; x=1819084287;
  h=date:from:to:cc:subject:message-id;
  bh=oNxiOBtFMXMmIpGNeubxxgXgQMBTpikSL6m+NIz0wmQ=;
  b=QrQHJGgO4fCoIaX2GcqOayAYFo0tBPJ2V4tstIBo+/YbTH3wKKsYptb3
   y1Jk0QmyNM8I7mgOHgcVS6kYqpRe18WRTKRkkKIXiAleRYZKaoBga2G/c
   WorDvdkCftC5D0xU0SQ3HwGZL823pWmgAOt9GROa8oJaxiIqSMD+Stjaq
   TybyROzogsLJosHnGHZTJYX4DReQ0GLVvIpp6dTcRNt8uTyJ5aJj0yTZ1
   3Mcm4CjWgewfZ/rLLrpIfRlwVVB544J7SIzP3Yq/P7Qitc+CQxk5f+qbM
   ZV2URZhwj6n9Bemg5eEvkOFgkIxnORPwDcQEzWI8y/MWVCKYzV1D8Jd8X
   A==;
X-CSE-ConnectionGUID: LhmYPL1PQ/mUPYWKUAYnHg==
X-CSE-MsgGUID: pDnBW06tQ3OBsl/eZsMgDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87756015"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87756015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:11:27 -0700
X-CSE-ConnectionGUID: hQKD9pFfTG2Gmbtm82jAQQ==
X-CSE-MsgGUID: uFRubdPERciiTHOq6s6iCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="262616964"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Aug 2026 22:11:25 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyMxq-000000002C1-0A0r;
	Mon, 24 Aug 2026 05:11:19 +0000
Date: Mon, 24 Aug 2026 13:10:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 9324becc398a1f9e67c91a3d652a7c56e5afc7f4
Message-ID: <202608241353.xf64SFDC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 9324becc398a1f9e67c91a3d652a7c56e5afc7f4  Merge branch 'pci/misc'

elapsed time: 2940m

configs tested: 187
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260822    gcc-14.3.0
arc                  randconfig-001-20260824    gcc-16.1.0
arc                  randconfig-002-20260822    gcc-16.1.0
arc                  randconfig-002-20260824    gcc-16.1.0
arm                  randconfig-001-20260822    gcc-16.1.0
arm                  randconfig-001-20260824    gcc-16.1.0
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-002-20260824    gcc-16.1.0
arm                  randconfig-003-20260822    gcc-12.5.0
arm                  randconfig-003-20260824    gcc-16.1.0
arm                  randconfig-004-20260822    clang-24
arm                  randconfig-004-20260824    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260822    gcc-10.5.0
arm64                randconfig-001-20260824    clang-24
arm64                randconfig-002-20260822    gcc-12.5.0
arm64                randconfig-002-20260824    clang-24
arm64                randconfig-003-20260822    clang-24
arm64                randconfig-003-20260824    clang-24
arm64                randconfig-004-20260822    gcc-12.5.0
arm64                randconfig-004-20260824    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    gcc-12.5.0
csky                 randconfig-001-20260824    clang-24
csky                 randconfig-002-20260822    gcc-14.3.0
csky                 randconfig-002-20260824    clang-24
hexagon              randconfig-001-20260822    clang-24
hexagon              randconfig-001-20260824    clang-24
hexagon              randconfig-002-20260822    clang-24
hexagon              randconfig-002-20260824    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260822    clang-22
i386       buildonly-randconfig-001-20260824    clang-22
i386       buildonly-randconfig-002-20260822    clang-22
i386       buildonly-randconfig-002-20260824    clang-22
i386       buildonly-randconfig-003-20260822    clang-22
i386       buildonly-randconfig-003-20260824    clang-22
i386       buildonly-randconfig-004-20260822    gcc-14
i386       buildonly-randconfig-004-20260824    clang-22
i386       buildonly-randconfig-005-20260822    clang-22
i386       buildonly-randconfig-005-20260824    clang-22
i386       buildonly-randconfig-006-20260822    clang-22
i386       buildonly-randconfig-006-20260824    clang-22
i386                 randconfig-001-20260822    gcc-14
i386                 randconfig-001-20260824    gcc-14
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-002-20260824    gcc-14
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-003-20260824    gcc-14
i386                 randconfig-004-20260822    gcc-14
i386                 randconfig-004-20260824    gcc-14
i386                 randconfig-005-20260822    clang-22
i386                 randconfig-005-20260824    gcc-14
i386                 randconfig-006-20260822    clang-22
i386                 randconfig-006-20260824    gcc-14
i386                 randconfig-007-20260822    clang-22
i386                 randconfig-007-20260824    gcc-14
i386                          randconfig-011    clang-22
i386                 randconfig-011-20260822    gcc-14
i386                 randconfig-011-20260824    clang-22
i386                 randconfig-012-20260822    clang-22
i386                 randconfig-012-20260824    clang-22
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-013-20260824    clang-22
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-014-20260824    clang-22
i386                 randconfig-015-20260822    clang-22
i386                 randconfig-015-20260824    clang-22
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-016-20260824    clang-22
i386                 randconfig-017-20260822    gcc-12
i386                 randconfig-017-20260824    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260822    gcc-16.1.0
loongarch            randconfig-001-20260824    clang-24
loongarch            randconfig-002-20260822    gcc-16.1.0
loongarch            randconfig-002-20260824    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-11.5.0
nios2                randconfig-001-20260824    clang-24
nios2                randconfig-002-20260822    gcc-11.5.0
nios2                randconfig-002-20260824    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-001-20260824    gcc-13.4.0
parisc               randconfig-002-20260822    gcc-9.5.0
parisc               randconfig-002-20260824    gcc-13.4.0
powerpc                    ppa8548_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260822    gcc-8.5.0
powerpc              randconfig-001-20260824    gcc-13.4.0
powerpc              randconfig-002-20260822    clang-24
powerpc              randconfig-002-20260824    gcc-13.4.0
powerpc64            randconfig-001-20260822    clang-24
powerpc64            randconfig-001-20260824    gcc-13.4.0
powerpc64            randconfig-002-20260822    gcc-12.5.0
powerpc64            randconfig-002-20260824    gcc-13.4.0
riscv                           alldefconfig    gcc-16.1.0
riscv                         randconfig-001    gcc-15.2.0
riscv                randconfig-001-20260822    clang-17
riscv                randconfig-001-20260824    gcc-15.2.0
riscv                randconfig-002-20260822    gcc-12.5.0
riscv                randconfig-002-20260824    gcc-15.2.0
s390                 randconfig-001-20260822    clang-24
s390                 randconfig-001-20260824    gcc-15.2.0
s390                 randconfig-002-20260822    clang-17
s390                 randconfig-002-20260824    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260822    gcc-16.1.0
sh                   randconfig-001-20260824    gcc-15.2.0
sh                   randconfig-002-20260822    gcc-14.3.0
sh                   randconfig-002-20260824    gcc-15.2.0
sparc                randconfig-001-20260822    gcc-13.4.0
sparc                randconfig-001-20260824    gcc-9.5.0
sparc                randconfig-002-20260822    gcc-15.2.0
sparc                randconfig-002-20260824    gcc-9.5.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-001-20260824    gcc-9.5.0
sparc64              randconfig-002-20260822    clang-24
sparc64              randconfig-002-20260824    gcc-9.5.0
um                   randconfig-001-20260822    gcc-13
um                   randconfig-001-20260824    gcc-9.5.0
um                   randconfig-002-20260822    clang-24
um                   randconfig-002-20260824    gcc-9.5.0
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-001-20260824    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-002-20260824    clang-22
x86_64     buildonly-randconfig-003-20260822    gcc-14
x86_64     buildonly-randconfig-003-20260824    clang-22
x86_64     buildonly-randconfig-004-20260822    gcc-14
x86_64     buildonly-randconfig-004-20260824    clang-22
x86_64     buildonly-randconfig-005-20260822    gcc-14
x86_64     buildonly-randconfig-005-20260824    clang-22
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64     buildonly-randconfig-006-20260824    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260822    clang-22
x86_64               randconfig-001-20260824    gcc-14
x86_64               randconfig-002-20260822    clang-22
x86_64               randconfig-002-20260824    gcc-14
x86_64               randconfig-003-20260822    clang-22
x86_64               randconfig-003-20260824    gcc-14
x86_64               randconfig-004-20260822    clang-22
x86_64               randconfig-004-20260824    gcc-14
x86_64               randconfig-005-20260822    gcc-14
x86_64               randconfig-005-20260824    gcc-14
x86_64               randconfig-006-20260822    gcc-12
x86_64               randconfig-006-20260824    gcc-14
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260822    gcc-14
x86_64               randconfig-011-20260824    clang-22
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-012-20260824    clang-22
x86_64               randconfig-013-20260822    gcc-14
x86_64               randconfig-013-20260824    clang-22
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-014-20260824    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-015-20260824    clang-22
x86_64               randconfig-016-20260822    gcc-14
x86_64               randconfig-016-20260824    clang-22
x86_64               randconfig-071-20260822    gcc-14
x86_64               randconfig-071-20260824    gcc-13
x86_64               randconfig-072-20260822    clang-22
x86_64               randconfig-072-20260824    gcc-13
x86_64               randconfig-073-20260822    gcc-13
x86_64               randconfig-073-20260824    gcc-13
x86_64               randconfig-074-20260822    clang-22
x86_64               randconfig-074-20260824    gcc-13
x86_64               randconfig-075-20260822    gcc-14
x86_64               randconfig-075-20260824    gcc-13
x86_64               randconfig-076-20260822    clang-22
x86_64               randconfig-076-20260824    gcc-13
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260822    gcc-9.5.0
xtensa               randconfig-001-20260824    gcc-9.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0
xtensa               randconfig-002-20260824    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
