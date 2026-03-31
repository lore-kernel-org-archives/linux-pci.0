Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56A3E315A
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961738; cv=none; b=OW7nIqjoeJ3kIEKLik0Hf2WdlbpdsYX8V3hUiCl8SGQJBpW1U2dkagExvTlE/EsCQslwWJ5vL2p+rSEXHpIUGSU/5wQuwn9tYhtrsvvlTR7iLlwsCj+R6JTQGTutjzVl2FgMsBi3GSvbKa2M7u5zgSUmqjv4Qa0G0Vq/5VkYcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961738; c=relaxed/simple;
	bh=JUhtgzELPr5HUJ1w+RcQooSCiSCe8u+U76vZl/vcto8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XlGmNPYBGDsPm2MINa4hsXmEQlP32ALctdgnF0DaYuaKev1fKt2St81kCzhT5dXCMDxECcPY5jo5+rKGBXu2vybyIJk7Cnu+bYbXAdxNfmK5soirSaot0n0wJMSDh6AKleVbKyoxqW9dseP112/TFrFzgQuQqz5YmG9U9jqH5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtnMKANQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtnMKANQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961737; x=1806497737;
  h=date:from:to:cc:subject:message-id;
  bh=JUhtgzELPr5HUJ1w+RcQooSCiSCe8u+U76vZl/vcto8=;
  b=OtnMKANQEzAKCiCld9lux5aDqZqgzSUxMjEtaet8am0FZI394gAj965e
   XUthQNYrtWWrCOW4jpQHTzMZholIa47BzmucWGwAC9Xq73iK6vNNfOFbi
   Uc9ihqN54Muk9neorAtSY/r3S3BALKX5TQtMqVMIuGe5NMZmaWF1L7HPS
   SA3tacDb9uue7PRZAzfoX+rPZQGCsv1lpVcPUkVSsTIQ8Ma7/+AN2vgKA
   +4warVpg5bOpMBzwGFa6TqESutfhvUPZBmRFakixAh3LZgGkHySw5ZO1Z
   p6OKF5EUp9Sezx7L81ehEvjp10i4nXMKGt+DZoe3oDxpK6EgEpjxFOc6l
   w==;
X-CSE-ConnectionGUID: HYS9dVw8SEqqcQfbIosRNA==
X-CSE-MsgGUID: W2bvrZELSjyoY8nreYVRZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75867061"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75867061"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:55:35 -0700
X-CSE-ConnectionGUID: r3vYyQz4QS+ure68Egw9xQ==
X-CSE-MsgGUID: 5R3sFtEXSPuDaq4nnGnh6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="249406947"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 Mar 2026 05:55:33 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Yd1-000000002dH-1GR6;
	Tue, 31 Mar 2026 12:55:31 +0000
Date: Tue, 31 Mar 2026 20:54:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:vga] BUILD SUCCESS
 5b6471fc72a42e6110adca54f46fd2c287dc49d4
Message-ID: <202603312049.cQC3opsy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git vga
branch HEAD: 5b6471fc72a42e6110adca54f46fd2c287dc49d4  PCI/VGA: Fail pci_set_vga_state() if VGA decoding not supported

elapsed time: 745m

configs tested: 183
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260331    clang-23
arc                   randconfig-002-20260331    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260331    clang-23
arm                   randconfig-002-20260331    clang-23
arm                   randconfig-003-20260331    clang-23
arm                   randconfig-004-20260331    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260331    clang-18
arm64                 randconfig-002-20260331    clang-18
arm64                 randconfig-003-20260331    clang-18
arm64                 randconfig-004-20260331    clang-18
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260331    clang-18
csky                  randconfig-002-20260331    clang-18
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260331    gcc-11.5.0
hexagon               randconfig-002-20260331    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260331    clang-20
i386        buildonly-randconfig-002-20260331    clang-20
i386        buildonly-randconfig-003-20260331    clang-20
i386        buildonly-randconfig-004-20260331    clang-20
i386        buildonly-randconfig-005-20260331    clang-20
i386        buildonly-randconfig-006-20260331    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260331    gcc-14
i386                  randconfig-002-20260331    gcc-14
i386                  randconfig-003-20260331    gcc-14
i386                  randconfig-004-20260331    gcc-14
i386                  randconfig-005-20260331    gcc-14
i386                  randconfig-006-20260331    gcc-14
i386                  randconfig-007-20260331    gcc-14
i386                  randconfig-011-20260331    clang-20
i386                  randconfig-012-20260331    clang-20
i386                  randconfig-013-20260331    clang-20
i386                  randconfig-014-20260331    clang-20
i386                  randconfig-015-20260331    clang-20
i386                  randconfig-016-20260331    clang-20
i386                  randconfig-017-20260331    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260331    gcc-11.5.0
loongarch             randconfig-002-20260331    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip32_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260331    gcc-11.5.0
nios2                 randconfig-002-20260331    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260331    clang-23
parisc                randconfig-002-20260331    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260331    clang-23
powerpc               randconfig-002-20260331    clang-23
powerpc64                        alldefconfig    clang-23
powerpc64             randconfig-001-20260331    clang-23
powerpc64             randconfig-002-20260331    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260331    gcc-15.2.0
riscv                 randconfig-002-20260331    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260331    gcc-15.2.0
s390                  randconfig-002-20260331    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260331    gcc-15.2.0
sh                    randconfig-002-20260331    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260331    gcc-15.2.0
sparc                 randconfig-002-20260331    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260331    gcc-15.2.0
sparc64               randconfig-002-20260331    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260331    gcc-15.2.0
um                    randconfig-002-20260331    gcc-15.2.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260331    clang-20
x86_64      buildonly-randconfig-002-20260331    clang-20
x86_64      buildonly-randconfig-003-20260331    clang-20
x86_64      buildonly-randconfig-004-20260331    clang-20
x86_64      buildonly-randconfig-005-20260331    clang-20
x86_64      buildonly-randconfig-006-20260331    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260331    gcc-14
x86_64                randconfig-002-20260331    gcc-14
x86_64                randconfig-003-20260331    gcc-14
x86_64                randconfig-004-20260331    gcc-14
x86_64                randconfig-005-20260331    gcc-14
x86_64                randconfig-006-20260331    gcc-14
x86_64                randconfig-011-20260331    clang-20
x86_64                randconfig-012-20260331    clang-20
x86_64                randconfig-013-20260331    clang-20
x86_64                randconfig-014-20260331    clang-20
x86_64                randconfig-015-20260331    clang-20
x86_64                randconfig-016-20260331    clang-20
x86_64                randconfig-071-20260331    clang-20
x86_64                randconfig-072-20260331    clang-20
x86_64                randconfig-073-20260331    clang-20
x86_64                randconfig-074-20260331    clang-20
x86_64                randconfig-075-20260331    clang-20
x86_64                randconfig-076-20260331    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260331    gcc-15.2.0
xtensa                randconfig-002-20260331    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
