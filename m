Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70E1EFF8D
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846931; cv=none; b=h+yhYt4yqbQSCXOJWwbRsa/VbFo9IIL/jxYIG6gxajKx+6AkCvG55F8F8kkIRDc+mEVwg9s8SyeJDS2tzwKXAhDk42zCI/RT42U5z9SVlkU5Qsefv7EBxx9nJzKrbbCjklrz2H1IxHUreUaOErGoRdcOE/xebMiYhwu7z0dCkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846931; c=relaxed/simple;
	bh=zq0RutpXwnqX2g+P/uo/XyaRKlxcc/M3f8fWI8hjUik=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R+BmyH6b+ZCkP1s/t0EMkP5HBRw0vXjIy0avo5aQOTzByMK1CqU4saTJCqBp1lSvZoAeaMpdteu6VodeEqU1qXfNdz2VZjy8T1Zjw7meAQVIex767EG5/H8LUP0Tt/+vifSpQAaZG3aL69E9akLRJdnXiZaiCdFCHat0qSDIHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E31g2a2G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E31g2a2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778846929; x=1810382929;
  h=date:from:to:cc:subject:message-id;
  bh=zq0RutpXwnqX2g+P/uo/XyaRKlxcc/M3f8fWI8hjUik=;
  b=E31g2a2GQIWxXhJCU9yL/+QDUeQzvWOY3scvc4bICXFRd39FEt7rC6oW
   JfboKJB02rCxWn/SOMGdMKPgHaQHAd8eyEndg7XOM+eMvEYvFdl7rBHAs
   SshkQL7Xtt4NUtHGPBkg75vYFAdK5606su4K5dpjqdUJh/IUmymIWStZO
   aIBuwAMUH13jEqfGuFkmEDuqnyaj7RNUg6QOQqcRBEOF9hAMFMkswGEm2
   4htYnk/Zju7MyYh4qGbbrc91Zatz0228TannF7zbQgt6li1Uyxpsxc3qc
   qSudIKh1Av+uUU5db4rstwge97j5WpbtaJT0PnJ54+Gg0Gt8LPicusSkC
   A==;
X-CSE-ConnectionGUID: qeCHGdb5S2mbCNtktVLJnw==
X-CSE-MsgGUID: C8aSCMldQtCZIKr9Sh8xdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90904994"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90904994"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:08:49 -0700
X-CSE-ConnectionGUID: 2+zCZzEjQ3WqAQeXvOUlvw==
X-CSE-MsgGUID: DvI6BN1VTKWzDjGXC9LD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232275190"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 15 May 2026 05:08:45 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNrKn-000000001Vj-0Nhd;
	Fri, 15 May 2026 12:08:13 +0000
Date: Fri, 15 May 2026 20:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 87354347c5480a1bcc1198eebeb5a3b08b6665f6
Message-ID: <202605151948.l3D3qnL6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: 87354347c5480a1bcc1198eebeb5a3b08b6665f6  PCI: Drop unnecessary retries when restoring BARs

elapsed time: 917m

configs tested: 235
configs skipped: 4

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260515    clang-23
arc                   randconfig-001-20260515    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260515    clang-23
arc                   randconfig-002-20260515    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260515    clang-23
arm                   randconfig-001-20260515    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260515    clang-23
arm                   randconfig-002-20260515    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260515    clang-23
arm                   randconfig-003-20260515    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260515    clang-23
arm                   randconfig-004-20260515    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260515    gcc-11.5.0
arm64                 randconfig-002-20260515    gcc-11.5.0
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-004-20260515    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-11.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260515    gcc-11.5.0
hexagon               randconfig-001-20260515    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260515    gcc-11.5.0
hexagon               randconfig-002-20260515    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260515    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260515    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260515    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260515    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260515    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260515    gcc-14
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260515    clang-20
i386                           randconfig-002    clang-20
i386                  randconfig-002-20260515    clang-20
i386                           randconfig-003    clang-20
i386                  randconfig-003-20260515    clang-20
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260515    clang-20
i386                           randconfig-005    clang-20
i386                  randconfig-005-20260515    clang-20
i386                           randconfig-006    clang-20
i386                  randconfig-006-20260515    clang-20
i386                           randconfig-007    clang-20
i386                  randconfig-007-20260515    clang-20
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260515    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260515    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260515    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260515    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260515    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260515    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260515    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260515    gcc-11.5.0
loongarch             randconfig-001-20260515    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260515    gcc-11.5.0
loongarch             randconfig-002-20260515    gcc-8.5.0
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260515    gcc-11.5.0
nios2                 randconfig-001-20260515    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260515    gcc-11.5.0
nios2                 randconfig-002-20260515    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260515    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260515    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260515    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260515    gcc-8.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260515    gcc-8.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260515    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260515    gcc-15.2.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260515    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260515    gcc-15.2.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260515    gcc-15.2.0
s390                       zfcpdump_defconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260515    gcc-15.2.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260515    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260515    gcc-8.5.0
sparc                 randconfig-002-20260515    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260515    gcc-8.5.0
sparc64               randconfig-002-20260515    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260515    gcc-8.5.0
um                    randconfig-002-20260515    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260515    gcc-14
x86_64      buildonly-randconfig-002-20260515    gcc-14
x86_64      buildonly-randconfig-003-20260515    gcc-14
x86_64      buildonly-randconfig-004-20260515    gcc-14
x86_64      buildonly-randconfig-005-20260515    gcc-14
x86_64      buildonly-randconfig-006-20260515    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260515    clang-20
x86_64                randconfig-002-20260515    clang-20
x86_64                randconfig-003-20260515    clang-20
x86_64                randconfig-004-20260515    clang-20
x86_64                randconfig-005-20260515    clang-20
x86_64                randconfig-006-20260515    clang-20
x86_64                randconfig-011-20260515    clang-20
x86_64                randconfig-012-20260515    clang-20
x86_64                randconfig-013-20260515    clang-20
x86_64                randconfig-014-20260515    clang-20
x86_64                randconfig-015-20260515    clang-20
x86_64                randconfig-016-20260515    clang-20
x86_64                         randconfig-071    gcc-12
x86_64                randconfig-071-20260515    gcc-12
x86_64                         randconfig-072    gcc-12
x86_64                randconfig-072-20260515    gcc-12
x86_64                         randconfig-073    gcc-12
x86_64                randconfig-073-20260515    gcc-12
x86_64                         randconfig-074    gcc-12
x86_64                randconfig-074-20260515    gcc-12
x86_64                         randconfig-075    gcc-12
x86_64                randconfig-075-20260515    gcc-12
x86_64                         randconfig-076    gcc-12
x86_64                randconfig-076-20260515    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260515    gcc-8.5.0
xtensa                randconfig-002-20260515    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
