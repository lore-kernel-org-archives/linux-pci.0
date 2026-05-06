Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA8472776
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074904; cv=none; b=eWrplUZXl5ILBhVRePwU9ohCf/Kh4Awh64PfsNggi6ZKZ3XxLNWq4+mu22qRqqoY0brRdoq0qfaLUsdM0HS2JGMo6LN3oiHnHmK7VHKRO/SL/r0cbLihpq6sYM6QXMI5kjgpaEROOL9kCY9DVTrMvhLTU62hgDqTbXMMtpUIqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074904; c=relaxed/simple;
	bh=+KaiBpwdt6vTLEcaHnyUsW+wxZrGi92ySWugDvYMil4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GpuJu77krssSzJGhE3560zANy4Y/CnJTXRCBV+e7dxawHEORyPvTOSsAxZtdUaxR8gnMUYnT+E1HpShYPI4VORRPpyRdfVVRCjRHIok9TnxSVFWbgLLiozyaqi//wBfxFc7XwJdGe1AvJgUa4UOHv4LzbNLpkqs+T11fZwT/nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOI6Omzx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOI6Omzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778074903; x=1809610903;
  h=date:from:to:cc:subject:message-id;
  bh=+KaiBpwdt6vTLEcaHnyUsW+wxZrGi92ySWugDvYMil4=;
  b=hOI6OmzxAt8dqmtXzh6UsmyFR+us6R0xuDeZbEcuqB17jE7xki1p2bGa
   dP+ndLdQF79cGlJPFYSzL4bL2vshwGFwyaA1lPNJih6doQdSni1N7Dbb1
   xg6CNAqC1yzDTkc+7QGJ/501rqAWxZQQgUOwZPrS0nAlWRprcrWymlcyY
   G+mNlpjue6eVm4Ekn/388BuEaZikgyzu5DjrQrjiwm9NOm7rnt4cAb+7e
   fVD4jh4cp42JRg3hk3q/YfDqXh/nkcO03QbHW1StYKvHy/lcUYV4zFRRT
   a5yfwTDx0mn/ioleFrGbSBDxAVORDLiUQtD7SIjhI0T8rViypQFjYF5ws
   w==;
X-CSE-ConnectionGUID: W4M25NTYS7KaGbJ34PDdlQ==
X-CSE-MsgGUID: pBDqhyy7STGx8vrj9yiQGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82849492"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82849492"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:41:42 -0700
X-CSE-ConnectionGUID: vkkUC19qR2ueULOxhWMCYw==
X-CSE-MsgGUID: v9LNxTmnTWeqUzwxxRGV3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259838153"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 May 2026 06:41:40 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKcVO-000000000xP-1GAw;
	Wed, 06 May 2026 13:41:38 +0000
Date: Wed, 06 May 2026 21:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 5e6c21c56998e1e58d2f314e70779989ea0fee5d
Message-ID: <202605062125.bdK1JhoE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: 5e6c21c56998e1e58d2f314e70779989ea0fee5d  PCI: switchtec: Add Gen6 Device IDs

elapsed time: 730m

configs tested: 250
configs skipped: 26

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260506    gcc-12.5.0
arc                   randconfig-002-20260506    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260506    gcc-12.5.0
arm                   randconfig-002-20260506    gcc-12.5.0
arm                   randconfig-003-20260506    gcc-12.5.0
arm                   randconfig-004-20260506    gcc-12.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-15.2.0
arm64                 randconfig-001-20260506    gcc-15.2.0
arm64                          randconfig-002    gcc-15.2.0
arm64                 randconfig-002-20260506    gcc-15.2.0
arm64                          randconfig-003    gcc-15.2.0
arm64                 randconfig-003-20260506    gcc-15.2.0
arm64                          randconfig-004    gcc-15.2.0
arm64                 randconfig-004-20260506    gcc-15.2.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-15.2.0
csky                  randconfig-001-20260506    gcc-15.2.0
csky                           randconfig-002    gcc-15.2.0
csky                  randconfig-002-20260506    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260506    clang-23
hexagon               randconfig-001-20260506    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260506    clang-23
hexagon               randconfig-002-20260506    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260506    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260506    clang-20
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260506    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260506    clang-20
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260506    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260506    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260506    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260506    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260506    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260506    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260506    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260506    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260506    gcc-14
i386                  randconfig-011-20260506    clang-20
i386                  randconfig-012-20260506    clang-20
i386                  randconfig-013-20260506    clang-20
i386                  randconfig-014-20260506    clang-20
i386                  randconfig-015-20260506    clang-20
i386                  randconfig-016-20260506    clang-20
i386                  randconfig-017-20260506    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260506    clang-23
loongarch             randconfig-001-20260506    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260506    clang-23
loongarch             randconfig-002-20260506    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         db1xxx_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260506    clang-23
nios2                 randconfig-001-20260506    gcc-11.5.0
nios2                 randconfig-001-20260506    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260506    clang-23
nios2                 randconfig-002-20260506    gcc-11.5.0
nios2                 randconfig-002-20260506    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260506    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260506    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                          g5_defconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260506    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260506    gcc-13.4.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260506    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260506    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260506    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260506    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260506    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260506    gcc-8.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                 kfr2r09-romimage_defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260506    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260506    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260506    gcc-11.5.0
sparc                 randconfig-002-20260506    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260506    gcc-11.5.0
sparc64               randconfig-002-20260506    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260506    gcc-11.5.0
um                    randconfig-002-20260506    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260506    clang-20
x86_64      buildonly-randconfig-002-20260506    clang-20
x86_64      buildonly-randconfig-002-20260506    gcc-14
x86_64      buildonly-randconfig-003-20260506    clang-20
x86_64      buildonly-randconfig-004-20260506    clang-20
x86_64      buildonly-randconfig-005-20260506    clang-20
x86_64      buildonly-randconfig-005-20260506    gcc-14
x86_64      buildonly-randconfig-006-20260506    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260506    clang-20
x86_64                randconfig-001-20260506    gcc-13
x86_64                randconfig-002-20260506    clang-20
x86_64                randconfig-003-20260506    clang-20
x86_64                randconfig-004-20260506    clang-20
x86_64                randconfig-005-20260506    clang-20
x86_64                randconfig-005-20260506    gcc-13
x86_64                randconfig-006-20260506    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260506    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260506    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260506    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260506    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260506    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260506    clang-20
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260506    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260506    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260506    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260506    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260506    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260506    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                randconfig-001-20260506    gcc-11.5.0
xtensa                randconfig-002-20260506    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
