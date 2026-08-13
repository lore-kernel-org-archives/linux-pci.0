Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87680327BFB
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587991; cv=none; b=qhSXia5e3NJf6bqILYPYIX/ffD6XSpGHRnwQ/W38P+EBtTdmd4SKYRXWRpbROYfCo1vCnFSkZghMWnSXzQwGJJeQoLOx7vq9abdEDFDQBMC/J273UJBhzYFgsCKwfoepkcl/EbU7E8fRupdqRefFtUGZYci9gTw/d9zmo2M4TQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587991; c=relaxed/simple;
	bh=WtLo3CkhChCWI8nKMgpzlCbViGF9IrKc4x8cfTMRTP0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hL2KUwFIbZ9qQNz6WJznN8FFGfiMghblNS6OM64fl2CnMN8ypQ32gA4lBrKwn66IbNYR6oAnWK/f7qwIajWwXCFarBhyKg1qUr8TdwqueC3l4AcIdZ2O5KJ+U3NB2J0GcumyvLgX3pbAj74EBRVCi6k/AtX+J5jnP77msgkIn7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dl+9P0G8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dl+9P0G8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786587989; x=1818123989;
  h=date:from:to:cc:subject:message-id;
  bh=WtLo3CkhChCWI8nKMgpzlCbViGF9IrKc4x8cfTMRTP0=;
  b=dl+9P0G894HQh1IuN6yh21+3fnNI8s0rlN0sp1oUbX634GzNmYZAA0+q
   z0NZdywCK6CPZUCOmnqrGrEW9lUjjA0Optvh/hZbu8Fa5809JV5mLCPWZ
   cSDgBuzuNcdTaKFh7tEpxYN6pW9wLpKm4TF/QxFqp72aQ4UTYgi1nK+0B
   1rN9f3LlcM8D9HeNw+Bu/d3BDBY0Drb8LsiK/hZC/G46Ua/q6w8fQJMBx
   zmDLCNI/yKapax2FaOxtpDZHkvWKrEvfB5jk+YgCNHhF1IPcxKAGvp/5i
   QWqha/VKAhIWMTeqxamUTd8YegNIL5ur3vM1B1T1mhzTwsT62CG6QtBcj
   w==;
X-CSE-ConnectionGUID: FILNnBTzRF6VubeWoL7LVg==
X-CSE-MsgGUID: NXJdF1JlSxaVFMCoplHMvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87176005"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87176005"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 19:26:28 -0700
X-CSE-ConnectionGUID: tL+UUrHwS1iRODVqTARn9A==
X-CSE-MsgGUID: ui/sS9OsRsy8a0AQFc+4Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268987619"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2026 19:26:27 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuL9E-00000000SXI-2hIF;
	Thu, 13 Aug 2026 02:26:24 +0000
Date: Thu, 13 Aug 2026 10:25:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-ultrarisc] BUILD SUCCESS
 22a415e623e9ebc79cf0b5c83064af8aa11acdd7
Message-ID: <202608131015.UVIk91GQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-ultrarisc
branch HEAD: 22a415e623e9ebc79cf0b5c83064af8aa11acdd7  PCI: ultrarisc: Use module_platform_driver()

elapsed time: 2416m

configs tested: 147
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                    nsimosci_hs_defconfig    gcc-16.1.0
arc                           randconfig-001    gcc-12.5.0
arc                  randconfig-001-20260812    gcc-12.5.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-002-20260812    gcc-12.5.0
arc                  randconfig-002-20260813    gcc-13.4.0
arm                    am200epdkit_defconfig    gcc-16.1.0
arm                       keystone_defconfig    gcc-16.1.0
arm                  randconfig-001-20260812    gcc-12.5.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-002-20260812    gcc-12.5.0
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-003-20260812    gcc-12.5.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-004-20260812    gcc-12.5.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260812    gcc-10.5.0
arm64                randconfig-001-20260812    gcc-14.3.0
arm64                randconfig-002-20260812    gcc-10.5.0
arm64                randconfig-002-20260812    gcc-14.3.0
arm64                randconfig-003-20260812    gcc-10.5.0
arm64                randconfig-003-20260812    gcc-14.3.0
arm64                randconfig-004-20260812    gcc-10.5.0
arm64                randconfig-004-20260812    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260812    gcc-10.5.0
csky                 randconfig-001-20260812    gcc-14.3.0
csky                 randconfig-002-20260812    gcc-10.5.0
csky                 randconfig-002-20260812    gcc-14.3.0
hexagon              randconfig-001-20260812    gcc-11.5.0
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-002-20260812    gcc-11.5.0
hexagon              randconfig-002-20260813    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260812    clang-22
i386       buildonly-randconfig-002-20260812    clang-22
i386       buildonly-randconfig-003-20260812    clang-22
i386       buildonly-randconfig-004-20260812    clang-22
i386       buildonly-randconfig-005-20260812    clang-22
i386       buildonly-randconfig-006-20260812    clang-22
i386                 randconfig-001-20260812    clang-22
i386                 randconfig-002-20260812    clang-22
i386                 randconfig-003-20260812    clang-22
i386                 randconfig-004-20260812    clang-22
i386                 randconfig-005-20260812    clang-22
i386                 randconfig-006-20260812    clang-22
i386                 randconfig-007-20260812    clang-22
i386                          randconfig-011    gcc-12
i386                 randconfig-011-20260812    gcc-12
i386                 randconfig-012-20260812    gcc-12
i386                 randconfig-013-20260812    gcc-12
i386                 randconfig-014-20260812    gcc-12
i386                 randconfig-015-20260812    gcc-12
i386                 randconfig-016-20260812    gcc-12
i386                 randconfig-017-20260812    gcc-12
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260812    gcc-11.5.0
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-002-20260812    gcc-11.5.0
loongarch            randconfig-002-20260813    gcc-11.5.0
mips                    cu1000-neo_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260812    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-002-20260812    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260812    clang-17
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-002-20260812    clang-17
parisc               randconfig-002-20260813    gcc-10.5.0
powerpc              randconfig-001-20260812    clang-17
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-002-20260812    clang-17
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc64            randconfig-001-20260812    clang-17
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260812    clang-17
powerpc64            randconfig-002-20260813    gcc-10.5.0
riscv                randconfig-001-20260812    clang-24
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-002-20260812    clang-24
riscv                randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-001-20260812    clang-24
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-002-20260812    clang-24
s390                 randconfig-002-20260813    gcc-10.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260812    clang-24
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-002-20260812    clang-24
sh                   randconfig-002-20260813    gcc-10.5.0
sparc                         randconfig-001    gcc-13.4.0
sparc                randconfig-001-20260812    gcc-13.4.0
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-002-20260812    gcc-13.4.0
sparc                randconfig-002-20260813    clang-20
sparc64              randconfig-001-20260812    gcc-13.4.0
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-002-20260812    gcc-13.4.0
sparc64              randconfig-002-20260813    clang-20
um                   randconfig-001-20260812    gcc-13.4.0
um                   randconfig-001-20260813    clang-20
um                   randconfig-002-20260812    gcc-13.4.0
um                   randconfig-002-20260813    clang-20
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260812    gcc-14
x86_64     buildonly-randconfig-002-20260812    gcc-14
x86_64     buildonly-randconfig-003-20260812    gcc-14
x86_64     buildonly-randconfig-004-20260812    gcc-14
x86_64     buildonly-randconfig-005-20260812    gcc-14
x86_64     buildonly-randconfig-006-20260812    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260812    clang-22
x86_64               randconfig-002-20260812    clang-22
x86_64               randconfig-003-20260812    clang-22
x86_64               randconfig-004-20260812    clang-22
x86_64               randconfig-005-20260812    clang-22
x86_64               randconfig-006-20260812    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260812    clang-22
x86_64               randconfig-012-20260812    clang-22
x86_64               randconfig-013-20260812    clang-22
x86_64               randconfig-014-20260812    clang-22
x86_64               randconfig-015-20260812    clang-22
x86_64               randconfig-016-20260812    clang-22
x86_64               randconfig-071-20260812    clang-22
x86_64               randconfig-072-20260812    clang-22
x86_64               randconfig-073-20260812    clang-22
x86_64               randconfig-074-20260812    clang-22
x86_64               randconfig-075-20260812    clang-22
x86_64               randconfig-076-20260812    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260812    gcc-13.4.0
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-002-20260812    gcc-13.4.0
xtensa               randconfig-002-20260813    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
