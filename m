Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F331F4CB3
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963361; cv=none; b=HmiTglKrxPTBw3npdF9ofN7EghAIE7q3oUVGTaKoArNv6kWq8gPmRA2uyhd5iF+o8KeLbG1LcJDaec3IXABjL/ZZ2L+Tp5D+0i8E/UNTs7PttEZ02bX/czZE9c5eboAH/52qUjNTlRlYvfnGfmSyKcjPyGEmRMbE+D/rvU8MuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963361; c=relaxed/simple;
	bh=0dicrLjXKI7O1LJOXI8GJLdOiqRZK0XKccblQULpII8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=imRrhVIIfXsmfy9zgI1o8jAYRLdF+cSecQuEz+r5HdnSPlDS1MtIi32kbXkhNm+Zh5/27Isw4ExOSFQ9gdQdp1BoyBW3XuVnh4+rUoYRv2+kHfQiqQpsyCxjWAthQLbv3UaV+LLvllLO1j8knC+BRfNSTc8386K45tQV/szavs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGdHUorN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGdHUorN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784963361; x=1816499361;
  h=date:from:to:cc:subject:message-id;
  bh=0dicrLjXKI7O1LJOXI8GJLdOiqRZK0XKccblQULpII8=;
  b=LGdHUorNnltfnRoFwoghENKJJCnrInFwO44dB/oH2OZLWPmQ7M5WAUEs
   2daTs73SROzR0XKHxMrfRFt4eTULLPpr5LjFNRJwJsYv1VoHUmAKnu4vw
   +9xAqfgJKEy2CEvAqKYt0enZCojiSW7qncHNKG8QRqP3t9nDYj9eczWbw
   ZOzoMcqws/u3kwuEiXh93xCNSW5y2HBl67Ucd1PO5lSjHjgmPqJ2ektIz
   X60Jjphg3QXEDIeqc2BKqU74B/kW3Qc6gIWvKW1hcAYose7RJOVo2D9oZ
   uVbMfhdZbPOpfj+SFjAqE5ACij80udfw8os7YqBj++IevdHWPyhJtr2Rm
   A==;
X-CSE-ConnectionGUID: b82LUvO9QHK0lxTeRUzdvQ==
X-CSE-MsgGUID: vh96uy32TouMATSl9Jf9GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="103030511"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="103030511"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 00:09:20 -0700
X-CSE-ConnectionGUID: KdOSNcUbRIes5aVpNnNsFw==
X-CSE-MsgGUID: 1qzQ2mgERJSUWlrMTSTKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="262422897"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 25 Jul 2026 00:09:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnWVL-00000000bXW-3P6T;
	Sat, 25 Jul 2026 07:09:06 +0000
Date: Sat, 25 Jul 2026 15:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 894a78088fc3ddf7e582c814294afa4311900ccc
Message-ID: <202607251552.ryKNBcxy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: 894a78088fc3ddf7e582c814294afa4311900ccc  PCI/P2PDMA: Add Nvidia Vera Rubin to whitelist

elapsed time: 1013m

configs tested: 61
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260725    gcc-11.5.0
arc                  randconfig-002-20260725    gcc-8.5.0
arm                  randconfig-001-20260725    gcc-8.5.0
arm                  randconfig-002-20260725    clang-21
arm                  randconfig-003-20260725    gcc-10.5.0
arm                  randconfig-004-20260725    gcc-15.2.0
arm64                randconfig-001-20260725    clang-24
arm64                randconfig-002-20260725    gcc-13.4.0
arm64                randconfig-003-20260725    clang-24
arm64                randconfig-004-20260725    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260725    gcc-9.5.0
csky                 randconfig-002-20260725    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-002-20260725    gcc-14
i386       buildonly-randconfig-004-20260725    clang-22
i386       buildonly-randconfig-005-20260725    gcc-14
i386       buildonly-randconfig-006-20260725    gcc-14
i386                 randconfig-011-20260725    gcc-14
i386                 randconfig-012-20260725    gcc-14
loongarch                          defconfig    clang-24
nios2                        3c120_defconfig    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260725    gcc-10.5.0
riscv                randconfig-001-20260725    gcc-8.5.0
riscv                randconfig-002-20260725    gcc-8.5.0
s390                 randconfig-001-20260725    gcc-10.5.0
s390                 randconfig-002-20260725    gcc-16.1.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260725    gcc-16.1.0
sh                   randconfig-002-20260725    gcc-11.5.0
sparc                randconfig-001-20260725    gcc-16.1.0
sparc                randconfig-002-20260725    gcc-8.5.0
sparc64              randconfig-001-20260725    gcc-8.5.0
sparc64              randconfig-002-20260725    gcc-10.5.0
um                   randconfig-001-20260725    gcc-14
um                   randconfig-002-20260725    clang-24
x86_64     buildonly-randconfig-001-20260725    clang-22
x86_64     buildonly-randconfig-002-20260725    clang-22
x86_64     buildonly-randconfig-003-20260725    clang-22
x86_64     buildonly-randconfig-004-20260725    gcc-12
x86_64     buildonly-randconfig-006-20260725    gcc-14
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260725    gcc-14
x86_64               randconfig-072-20260725    gcc-14
x86_64               randconfig-073-20260725    gcc-14
x86_64               randconfig-074-20260725    gcc-14
x86_64               randconfig-075-20260725    gcc-14
x86_64               randconfig-076-20260725    clang-22
xtensa               randconfig-001-20260725    gcc-16.1.0
xtensa               randconfig-002-20260725    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
