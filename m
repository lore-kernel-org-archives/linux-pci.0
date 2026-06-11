Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FB2BE65B
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210805; cv=none; b=Q+LADwg/tIRyxfFfra8ZFtpzdx5KVsLmlhSSwFvfIy9f66R0Jk0r13GZe1UBD7gg3S/7jGG8k8zJtx8VIhdYMsH2fWjrGGaJDpXuiAV1q/0uNs/5J7icqOhpBTji1Cz/m70IeTHbdesjrowEDRnHKq6bXQi4Tlu28K+eqrq2IoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210805; c=relaxed/simple;
	bh=9MawrIktE2UT7Dm9JvCpFVPDuxrHhvGUxHRdL+MtJvE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nVhC65euLBJVcToxrSp3Mc8t+7XcMlpxwNYKrt/oeht3/m46sRe+NS/sBm4PzsbWF4jZbw323QjERUuwqWI7F67YsPWN1s9XM/guoLI2siRYSJLJQvRlr+o0eDV96jfC55m7HlKf5z+99PknU5WX+2/Ol1KrqX1k7WB/bw5h1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mm0diggc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mm0diggc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781210803; x=1812746803;
  h=date:from:to:cc:subject:message-id;
  bh=9MawrIktE2UT7Dm9JvCpFVPDuxrHhvGUxHRdL+MtJvE=;
  b=Mm0diggch5yHWlZFB62fEhFYnXtfyVEHcQ5weWKS+yD9UI18+5v4pwyv
   doR0oF3iNIblaNFW4alNlo5Evf3fFtOD30S1QwmSkWgB3Nl+zopkZ9gt4
   yejjhgLwXQD6XWC0EXCKngl5GpEx2LJNkzx4reWZjSv2kHfEg4/ldppTq
   avnKWXcYB2SmenfAj7REjxcYQsFzhb3hbfpVhCjqifwXNLiB+IGzNNAT/
   LOEHIhuFeOJianRBDhRRLzEyc8BrONz+vFUevxJGzZtVIVqn/OEjiMenp
   rgUOeubSdm+U/2laKP5kE6xtT0Z8wtkEzaBxpCjaf+Kv7Qticg2FYxsxi
   A==;
X-CSE-ConnectionGUID: aL7mnL3XQaKiVQOVVR/w1A==
X-CSE-MsgGUID: Nq85hVyUTM+0sNvNHHhOTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84606878"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="84606878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:46:42 -0700
X-CSE-ConnectionGUID: LolZf3tfT7ednhp9dSZfgg==
X-CSE-MsgGUID: DuaF1y3nTbWe9v4YNx6ucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="276793577"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Jun 2026 13:46:41 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXmIQ-00000000Nq3-25uA;
	Thu, 11 Jun 2026 20:46:38 +0000
Date: Fri, 12 Jun 2026 04:46:00 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 843044971a5167087a9484f8f6eec81da30f2a71
Message-ID: <202606120451.XRwnWrad-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 843044971a5167087a9484f8f6eec81da30f2a71  dt-bindings: PCI: mediatek: Add support for EcoNet EN7528

elapsed time: 795m

configs tested: 229
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-14.3.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                            randconfig-002    gcc-14.3.0
arc                   randconfig-002-20260611    gcc-14.3.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                          pxa910_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-14.3.0
arm                   randconfig-001-20260611    gcc-14.3.0
arm                            randconfig-002    gcc-14.3.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                            randconfig-003    gcc-14.3.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260611    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-14.3.0
arm64                 randconfig-001-20260611    gcc-14.3.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260611    gcc-14.3.0
arm64                 randconfig-002-20260612    gcc-13.4.0
arm64                          randconfig-003    gcc-14.3.0
arm64                 randconfig-003-20260611    gcc-14.3.0
arm64                 randconfig-003-20260612    gcc-13.4.0
arm64                          randconfig-004    gcc-14.3.0
arm64                 randconfig-004-20260611    gcc-14.3.0
arm64                 randconfig-004-20260612    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-14.3.0
csky                  randconfig-001-20260611    gcc-14.3.0
csky                  randconfig-001-20260612    gcc-13.4.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260611    gcc-14.3.0
csky                  randconfig-002-20260612    gcc-13.4.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260611    clang-16
hexagon               randconfig-001-20260611    clang-17
hexagon               randconfig-001-20260612    clang-23
hexagon               randconfig-002-20260611    clang-16
hexagon               randconfig-002-20260611    clang-17
hexagon               randconfig-002-20260612    clang-23
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260611    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260611    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260611    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260611    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260611    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260611    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260611    gcc-14
i386                  randconfig-002-20260611    gcc-14
i386                  randconfig-003-20260611    gcc-14
i386                  randconfig-004-20260611    gcc-14
i386                  randconfig-005-20260611    gcc-14
i386                  randconfig-006-20260611    gcc-14
i386                  randconfig-007-20260611    gcc-14
i386                  randconfig-011-20260611    gcc-14
i386                  randconfig-012-20260611    gcc-14
i386                  randconfig-013-20260611    gcc-14
i386                  randconfig-014-20260611    gcc-14
i386                  randconfig-015-20260611    gcc-14
i386                  randconfig-016-20260611    gcc-14
i386                  randconfig-017-20260611    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260611    clang-16
loongarch             randconfig-001-20260611    clang-17
loongarch             randconfig-001-20260612    clang-23
loongarch             randconfig-002-20260611    clang-16
loongarch             randconfig-002-20260611    clang-17
loongarch             randconfig-002-20260612    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
m68k                        m5272c3_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260611    clang-16
nios2                 randconfig-001-20260611    clang-17
nios2                 randconfig-001-20260612    clang-23
nios2                 randconfig-002-20260611    clang-16
nios2                 randconfig-002-20260611    clang-17
nios2                 randconfig-002-20260612    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc                     tqm8540_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260611    gcc-12.5.0
riscv                 randconfig-002-20260611    gcc-12.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260611    gcc-12.5.0
s390                  randconfig-002-20260611    gcc-12.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260611    gcc-12.5.0
sh                    randconfig-002-20260611    gcc-12.5.0
sh                             shx3_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64               randconfig-002-20260611    gcc-15.2.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260611    gcc-15.2.0
um                    randconfig-002-20260611    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260611    gcc-14
x86_64      buildonly-randconfig-002-20260611    gcc-14
x86_64      buildonly-randconfig-003-20260611    gcc-14
x86_64      buildonly-randconfig-004-20260611    gcc-14
x86_64      buildonly-randconfig-005-20260611    gcc-14
x86_64      buildonly-randconfig-006-20260611    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260611    gcc-14
x86_64                randconfig-002-20260611    gcc-14
x86_64                randconfig-003-20260611    gcc-14
x86_64                randconfig-004-20260611    gcc-14
x86_64                randconfig-005-20260611    gcc-14
x86_64                randconfig-006-20260611    gcc-14
x86_64                randconfig-011-20260611    gcc-14
x86_64                randconfig-012-20260611    gcc-14
x86_64                randconfig-013-20260611    gcc-14
x86_64                randconfig-014-20260611    gcc-14
x86_64                randconfig-015-20260611    gcc-14
x86_64                randconfig-016-20260611    gcc-14
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260611    clang-22
x86_64                randconfig-071-20260611    gcc-13
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260611    clang-22
x86_64                randconfig-072-20260611    gcc-13
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260611    clang-22
x86_64                randconfig-073-20260611    gcc-13
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260611    clang-22
x86_64                randconfig-074-20260611    gcc-13
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260611    clang-22
x86_64                randconfig-075-20260611    gcc-13
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260611    clang-22
x86_64                randconfig-076-20260611    gcc-13
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                randconfig-002-20260611    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
