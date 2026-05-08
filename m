Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C192F8EA7
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252832; cv=none; b=YOtJQyFPxoIpk8b129RvrUT1K7Xd4OIvW83354NAeOV3LPVeRyo+2G/ri2XnoUPCHAjLZcFZ2h4ldMjH/t0OnM0SVsmduGtd11/uIO2ZvdbJIxrshCGuRAvG8/JX2e7UHw0v+rFJBk3Qh5JAB6dFgjkmDTs8C4vLMs4NE5nCJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252832; c=relaxed/simple;
	bh=HITS7KuP9/c5TFfA3SsKlfvAMNs9A6v5yzFnT28Uz5A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DWZT0xywjkRF7qMjpbPlhPVZO8miKdmIE9kp8Q4ylIUvqxlS1ZvCzOEaruIEjJK3o+f/m/wv0lNkCgEnMq86POkcnkRV52vwkbjki9PX1QN6/LdibZRgQKE7x0MhD0bBBZ1C6YYS766Jtgva/6SrODK7/dkNm0okbZ2KB2d6Kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXZhRaHD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXZhRaHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778252831; x=1809788831;
  h=date:from:to:cc:subject:message-id;
  bh=HITS7KuP9/c5TFfA3SsKlfvAMNs9A6v5yzFnT28Uz5A=;
  b=cXZhRaHD3VCgdVcwqpnVguZwKnAe607pxNorOLo4gYOoDtR7cu9dYMYP
   8fyiMupNVOZxCFBDiIA5WKMI5hY0I4qYClAkYApmNWoaRg8xsQ/OCDrRK
   rmHfr6odx0uHq5nDci/5o8MyXNeNFshSogAdBTuYiHgC+sDbZYvgj7iSa
   9OktUdlGHwxnXdlGyiyn4PJM4okBvXn3o2B+VKNOQEd96FwdOQwPjbx6c
   kW7oZwjUjzlQGfvahxzR8dkCk5L+XXStsczM9C/okqZqC+ProqJnals2Q
   UuiOTaVZoSFhpyG7GWDgAzzvgeXNNC7c+cfpsOtTjISfAjhCJhCX4f/1e
   Q==;
X-CSE-ConnectionGUID: h/N8clS8QKS8yXVuC+syjA==
X-CSE-MsgGUID: asfE6iuPTFiKgWmE8vrAXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79264648"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79264648"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:07:11 -0700
X-CSE-ConnectionGUID: urSe9mqpTqWRURCrTv/uHA==
X-CSE-MsgGUID: rldO7fqSR2G22Kedma4s5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236905359"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 May 2026 08:07:09 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLMnC-000000000Dn-2FIv;
	Fri, 08 May 2026 15:07:06 +0000
Date: Fri, 08 May 2026 23:06:50 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-intel-gw] BUILD SUCCESS
 5d14a593359d668475540a8b0ddd4489c71c8a3b
Message-ID: <202605082345.rZfha8vy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-intel-gw
branch HEAD: 5d14a593359d668475540a8b0ddd4489c71c8a3b  dt-bindings: PCI: intel,lgm-pcie: Add 'atu' resource

elapsed time: 821m

configs tested: 232
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260508    gcc-12.5.0
arc                   randconfig-001-20260508    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260508    gcc-12.5.0
arc                   randconfig-002-20260508    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260508    gcc-12.5.0
arm                   randconfig-001-20260508    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260508    gcc-12.5.0
arm                   randconfig-002-20260508    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260508    gcc-12.5.0
arm                   randconfig-003-20260508    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260508    gcc-12.5.0
arm                   randconfig-004-20260508    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260508    gcc-14.3.0
arm64                 randconfig-002-20260508    gcc-14.3.0
arm64                 randconfig-003-20260508    gcc-14.3.0
arm64                 randconfig-004-20260508    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260508    gcc-14.3.0
csky                  randconfig-002-20260508    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260508    clang-23
hexagon               randconfig-002-20260508    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260508    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260508    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260508    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260508    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260508    gcc-14
i386                  randconfig-002-20260508    gcc-14
i386                  randconfig-003-20260508    gcc-14
i386                  randconfig-004-20260508    gcc-14
i386                  randconfig-005-20260508    gcc-14
i386                  randconfig-006-20260508    gcc-14
i386                  randconfig-007-20260508    gcc-14
i386                  randconfig-011-20260508    gcc-13
i386                  randconfig-012-20260508    gcc-13
i386                  randconfig-013-20260508    gcc-13
i386                  randconfig-014-20260508    gcc-13
i386                  randconfig-015-20260508    gcc-13
i386                  randconfig-016-20260508    gcc-13
i386                  randconfig-017-20260508    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260508    clang-23
loongarch             randconfig-002-20260508    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      loongson3_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-23
mips                         rt305x_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260508    clang-23
nios2                 randconfig-002-20260508    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-002-20260508    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260508    gcc-9.5.0
powerpc               randconfig-002-20260508    gcc-9.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260508    gcc-9.5.0
powerpc64             randconfig-002-20260508    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260508    clang-23
riscv                 randconfig-002-20260508    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260508    clang-23
s390                  randconfig-002-20260508    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260508    clang-23
sh                    randconfig-002-20260508    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260508    gcc-12
sparc                 randconfig-002-20260508    gcc-12
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260508    gcc-12
sparc64               randconfig-002-20260508    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260508    gcc-12
um                    randconfig-002-20260508    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260508    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260508    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260508    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260508    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260508    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260508    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260508    clang-20
x86_64                randconfig-002-20260508    clang-20
x86_64                randconfig-003-20260508    clang-20
x86_64                randconfig-004-20260508    clang-20
x86_64                randconfig-005-20260508    clang-20
x86_64                randconfig-006-20260508    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260508    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260508    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260508    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260508    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260508    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260508    gcc-14
x86_64                randconfig-071-20260508    gcc-14
x86_64                randconfig-072-20260508    gcc-14
x86_64                randconfig-073-20260508    gcc-14
x86_64                randconfig-074-20260508    gcc-14
x86_64                randconfig-075-20260508    gcc-14
x86_64                randconfig-076-20260508    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260508    gcc-12
xtensa                randconfig-002-20260508    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
