Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7A3932E7
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662282; cv=none; b=PMr3gx9khX1k4LvHIGZWAhFYPzCMGvy/LhVlsyca8pg39pK7L/Wpj1E23r83xAcdGrMhPiO7m4dP2nRKjXmN5oEmdCYVkdel2QP0Vo7W1UxlrjfMm4BCt21TTn8sIltjcbaKrigOu+0D2RFxH4OQI4UHBZK6AeDVLzgFBaLiqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662282; c=relaxed/simple;
	bh=het1uzFLqwxrp/XnfZQbadaTIMqLoSWz5V5FWL4o/Kk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X6s3yNnyM3V6SW7coaB2LPecQF2qbuUVF2kkNBRJwqqZ7Di9OBKwTyS7UjDx2Z5HKbDguMwGaWYc38uv+bwalJkAoh2+4VV5yHtE/rZ9Xk6ycpNcqL5RtyTtKo1VEQmLZ14UoVTDeVeJxJBIAA4aIQwEla1GGMtobhl6f6VFQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU81AEXP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU81AEXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773662280; x=1805198280;
  h=date:from:to:cc:subject:message-id;
  bh=het1uzFLqwxrp/XnfZQbadaTIMqLoSWz5V5FWL4o/Kk=;
  b=BU81AEXPYPM3D6wjGzDmuj/ZG26a0xE6g21sNovSzEeNqgongEJZ+eBX
   f8M2q37DZ37rXxujCDqtqREPFOrT46LLlhCHbzIKdtSZeig6N25RXUlbv
   1/zvU1aredaXSu4J9CSoHTNH6N87D20kdUqsJ86aIeQ3hKUxZmaP9e6oj
   vUbascG0x28goeBuDf+F4xP2bCpwZYG/QYxoS3be3a/GmhY53XJC+XC/k
   3e1a0wYDvxgB+D8OHM1hLDsvx3jgqhPNHsJZNfkhbaPKTP/SPQQHci+Wc
   Ajv+Q16WXRigYCvETp6NWAUwocuVV/XT7Ze5uWgS1HzsmAuHLfbso+6x3
   w==;
X-CSE-ConnectionGUID: C+zE8SydTgmNFDMj+TdBDw==
X-CSE-MsgGUID: QbKR3J/vTz+gW4sMCRN/hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92242627"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92242627"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:58:00 -0700
X-CSE-ConnectionGUID: 4i43vLEJQLu51KBjji+9Hw==
X-CSE-MsgGUID: SzkXa8oXSN+i/n78wUThcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="220935367"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 04:57:59 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w26a3-000000000cS-3vlo;
	Mon, 16 Mar 2026 11:57:55 +0000
Date: Mon, 16 Mar 2026 19:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 0026bb20d12531ca2925b60bf081cc8be910ccf9
Message-ID: <202603161906.crEUkCxE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 0026bb20d12531ca2925b60bf081cc8be910ccf9  PCI: Use pr_warn_once() for ACS parameter parse failure

elapsed time: 1000m

configs tested: 73
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-002-20260316    clang-23
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386        randconfig-001-20260316    gcc-14
i386        randconfig-003-20260316    gcc-14
i386        randconfig-004-20260316    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc      randconfig-001-20260316    gcc-8.5.0
parisc      randconfig-002-20260316    gcc-12.5.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
powerpc     randconfig-001-20260316    clang-23
powerpc     randconfig-002-20260316    clang-23
powerpc64   randconfig-001-20260316    gcc-13.4.0
powerpc64   randconfig-002-20260316    gcc-8.5.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260316    gcc-8.5.0
sparc       randconfig-002-20260316    gcc-12.5.0
sparc64                allmodconfig    clang-23
sparc64     randconfig-001-20260316    gcc-8.5.0
sparc64     randconfig-002-20260316    gcc-15.2.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um          randconfig-001-20260316    gcc-14
um          randconfig-002-20260316    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0
xtensa      randconfig-001-20260316    gcc-15.2.0
xtensa      randconfig-002-20260316    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
