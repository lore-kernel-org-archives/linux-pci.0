Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101F44D035
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992289; cv=none; b=anzvZxfrQ2NrsjPoMzZy0UHdXFH6FkXFX5xebNO8fiUBP9CrY25okk5MYP2DZ1xTD9TzioXs7rbPnYAPySAMpXI6zmOUkWN4l3UxTu3HvMej5lMxMRyF9D6upz4h40iYoi98sQU/xJrCBM+rI1GI53hXjUEV/x/KNfsejNp0+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992289; c=relaxed/simple;
	bh=OCNpc2g+LCoeTZSoGLiMPfuveEr3Jwire3sCLTVGYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ERYkBNfba9VKwRuiwTmJkDDjuD3o0NMg8HAx7O2EkVLCOBJg9ILE+PdMZjk6ouVsz6b8bdt24WQd5cCcF2l/vCvMzERBUSGBD9Ep3BeKV/LusjmTkXqjIpFZvbHkxhO7vVPibSf9NDlnTrpau0UdLXRg59QuSi1dgPJvpi4Z+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMi346Mo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMi346Mo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782992285; x=1814528285;
  h=date:from:to:cc:subject:message-id;
  bh=OCNpc2g+LCoeTZSoGLiMPfuveEr3Jwire3sCLTVGYWQ=;
  b=JMi346MoExdygMv5IO9zjgPRfoqRXRLMHW8fkfUxC9X9JkcomDneenkU
   LW/8H5gXg5K7XBjdV5jSh8OzGRzjbIPAs4GbppFQbYYTaBQ5+aKmBFh8w
   AM2/zC5i7mR1G4cqn9m92mTrhd5F6w6WlSYQuCr7lTar9xAnFW7KRrz05
   Rembc2aRQ7ee1hQAcHX+J2DA8S5vRi+GLWTEuZhu/Ru7FcKqmNPAXYHXt
   JWhKlF+NJKTBwt3O1563h5j2mkRV74ev4KuewCP1I4gQrdiBOzWGbXjAl
   sALxCxfsxkqeXis1YA6n8I+CqZEwj25nXVcvk/a97kVHaIVcU47KPCM0l
   Q==;
X-CSE-ConnectionGUID: q4wjV52lTQG+9hAfegjRAA==
X-CSE-MsgGUID: jHsf/2geQRSMg7fU2Gevyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87422924"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87422924"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:38:04 -0700
X-CSE-ConnectionGUID: cY37m27sRNCK5ugKCeTD3w==
X-CSE-MsgGUID: jMz8EH7kSwa3T3GTjVFvoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="252993884"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Jul 2026 04:38:03 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wfFk0-00000000AkK-43dR;
	Thu, 02 Jul 2026 11:38:00 +0000
Date: Thu, 02 Jul 2026 19:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 34db32102439d948e0c9aea060e48f979aae827d
Message-ID: <202607021940.Rs14BYye-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 34db32102439d948e0c9aea060e48f979aae827d  MAINTAINERS: Drop Karthikeyan Mitran from Mobiveil PCIe entry

elapsed time: 934m

configs tested: 100
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                                defconfig    clang-22
i386                  randconfig-012-20260702    gcc-13
i386                           randconfig-016    gcc-14
i386                           randconfig-017    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        omega2p_defconfig    clang-17
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260702    gcc-10.5.0
parisc                randconfig-002-20260702    gcc-12.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260702    clang-17
powerpc               randconfig-002-20260702    gcc-8.5.0
powerpc64             randconfig-001-20260702    gcc-15.2.0
powerpc64             randconfig-002-20260702    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260702    gcc-16.1.0
sparc                 randconfig-002-20260702    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260702    clang-23
sparc64               randconfig-002-20260702    gcc-10.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260702    gcc-14
um                    randconfig-002-20260702    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260702    clang-22
x86_64      buildonly-randconfig-002-20260702    gcc-14
x86_64      buildonly-randconfig-003-20260702    clang-22
x86_64      buildonly-randconfig-004-20260702    clang-22
x86_64      buildonly-randconfig-005-20260702    gcc-14
x86_64      buildonly-randconfig-006-20260702    clang-22
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260702    gcc-16.1.0
xtensa                randconfig-002-20260702    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
