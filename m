Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE8369985
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112953; cv=none; b=LfrLJqROsb4pSn67mec5frCIZuWg4aZSjBO4LK2N19bkLdYHLjvCKVOR8E1tthoT/v3iYf+0YhNUq4gPvZ4uZkLCPh9xmYcn/D96tS7yXfs/2+Tz+dzocwo+cXfCVLbdpmGaq1ulPZDZOm0GcVqSvOuHRnHf5uYIrGNvoEhOe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112953; c=relaxed/simple;
	bh=ZwhNgl25b0zpgyiGwTqWqc3DZ5zPemju8dJtEfFWeLY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ugx/9uCIvVqEpstse/YwKWMs/RFIkxt0Z+xyDuxqyTNd09ZyN9fYW3rbWkwsB9nA15vRxMlJaiogcAtBmxq9QMVrod6g/ggxDe2mg16WPhqw4i2vxzFPbKQRlaBFhfWu8VtETH0faqFakD+LE5nGe3V2ptX707nNTHC3rhtJLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZxdGsBI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZxdGsBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775112952; x=1806648952;
  h=date:from:to:cc:subject:message-id;
  bh=ZwhNgl25b0zpgyiGwTqWqc3DZ5zPemju8dJtEfFWeLY=;
  b=SZxdGsBI4E5mqQc4wZB/UxaB0Np4u48PoktY9gHyCg4bY6bylt64Hm7S
   gu4F/aW3oZj++39dkfY47TL26DTWsDU29QlV89G+IrBUPyeBG1sCm+sqU
   JtJnPelvA1kXNVnOiNIkYeg9ei1OdARbTJwZ1UG4oAozqZyUUg+rED4T7
   l3Zu/X3PiFUIduSG2ePeNaKxT4h3t7bgixAWmf7yLeMOd5PsXhMVgw5di
   J7R+lYhMtaPsT41mlO7npKP4y2X6C2yNBe2pz9TaNltLW4vU/2qT4INod
   8zeFCvL0SvLDcOM7jK89vW4Dg8pPoKoG7zgjYzTRC8Tgio2tIA40ISDub
   g==;
X-CSE-ConnectionGUID: FD7AsJTXSf2QX29l5Nvgow==
X-CSE-MsgGUID: EM8jYuvhTWyuJV58pBOHfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="93748755"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="93748755"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:55:51 -0700
X-CSE-ConnectionGUID: FNO+EaSIQyeLtKu90jyDOA==
X-CSE-MsgGUID: XRQ9xs/GQACX6ncRfuEYtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="230962439"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 01 Apr 2026 23:55:49 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8Bxt-000000000Kn-0CGJ;
	Thu, 02 Apr 2026 06:55:42 +0000
Date: Thu, 02 Apr 2026 11:23:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 50a12cb229395b1166ed21b57e510d8e4e2521ff
Message-ID: <202604021107.RBrMc7Fb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 50a12cb229395b1166ed21b57e510d8e4e2521ff  Merge branch 'pci/misc'

elapsed time: 1615m

configs tested: 156
configs skipped: 7

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
arc                   randconfig-001-20260401    gcc-8.5.0
arc                   randconfig-002-20260401    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    clang-18
arm64                 randconfig-002-20260401    gcc-8.5.0
arm64                 randconfig-003-20260401    gcc-8.5.0
arm64                 randconfig-004-20260401    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-13.4.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260401    clang-23
hexagon               randconfig-002-20260401    clang-17
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    clang-20
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-002-20260401    clang-20
i386                  randconfig-003-20260401    clang-20
i386                  randconfig-004-20260401    gcc-12
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    gcc-14
i386                  randconfig-017-20260401    gcc-14
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         cobalt_defconfig    gcc-15.2.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260401    gcc-8.5.0
nios2                 randconfig-002-20260401    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    clang-18
powerpc64             randconfig-001-20260401    gcc-14.3.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260401    gcc-8.5.0
riscv                 randconfig-002-20260401    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260401    gcc-10.5.0
sh                    randconfig-002-20260401    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260402    gcc-8.5.0
sparc                 randconfig-002-20260402    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260402    gcc-10.5.0
sparc64               randconfig-002-20260402    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260402    gcc-14
um                    randconfig-002-20260402    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260402    clang-20
x86_64      buildonly-randconfig-002-20260402    clang-20
x86_64      buildonly-randconfig-003-20260402    clang-20
x86_64      buildonly-randconfig-004-20260402    clang-20
x86_64      buildonly-randconfig-005-20260402    clang-20
x86_64      buildonly-randconfig-006-20260402    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260401    gcc-14
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    gcc-14
x86_64                randconfig-004-20260401    gcc-14
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    clang-20
x86_64                randconfig-015-20260401    clang-20
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    clang-20
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    clang-20
x86_64                randconfig-076-20260401    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260402    gcc-12.5.0
xtensa                randconfig-002-20260402    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
