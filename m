Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A92ED141
	for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774684682; cv=none; b=XPppXCUsgk5ndY5Wog9UZVE327ZVEmOzUWtmmfyeUhLvgr5CyNem/zuaKejuuRzqqrDGtRptHQZsR8vh6phP9pJZmBY3NotdO/nhckuxiLJa9doe0HjJpnM17IOKtY7v6GkKADHyx9kEvHPJBoP4RDv8Mqu8Nw9BDf7dKpA0e80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774684682; c=relaxed/simple;
	bh=Dw7tQXeAlNJGsZ76VBIXOC+KwhTy9NHrBFPLOt9RRVg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cmlMrASx9dcp0qHKQgwq602WfJE9XYwPI6dtbb89ewE7aaKz/tN9xYy5xx9VsXuV8hsgHRaLVc2bBYh9DMKHewZ9f/MPmCKADw94e/To4g8zCExX/mXjUW5Mslzl9Tt4aq6kY0O1I3LrAPH4DE+iJhpMrub77d9oXCzbR9jof08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dO4x6zsw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dO4x6zsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774684681; x=1806220681;
  h=date:from:to:cc:subject:message-id;
  bh=Dw7tQXeAlNJGsZ76VBIXOC+KwhTy9NHrBFPLOt9RRVg=;
  b=dO4x6zswAADXFoJOMg0cHXW4vjqxKmr77HTNxHrWS8VYdTXFtNsIkP/k
   WZqtXpt04wWWVdU3IBEY8fDb2plyF7bt6M3t3CjVf6d26NQO6lg1mxMHT
   DhG5q17iwkXBeCdeS3ACBP1KAsvAZoH07QgCWMXlleDKo2SaMhX8LE90F
   wNiW8R0qGUhaOV63JOmaoNM7XsflHj52CoPccquOXMxLo3fEJoNvkNuXI
   OEspjeMkHEjYgWz4js35CF0t0/Hn4s0ljlTYyvhMDxCwtHcVv+sfyJuRf
   TZP7dcRYcsmsomheEt7DjjhoYyASQc0vZ5t7RDQp7QDbwugKk8OVDi78U
   Q==;
X-CSE-ConnectionGUID: rS5LcWPLRtGQi7emEgz9IQ==
X-CSE-MsgGUID: pjrdRiKFS2S0i1c31S9zIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="93330618"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="93330618"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 00:57:59 -0700
X-CSE-ConnectionGUID: 2LFc4S8YRQy3TIYyeXwZ5w==
X-CSE-MsgGUID: jnczVGNXRjGjjJPO8AWaGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="229595121"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Mar 2026 00:57:58 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6OYN-00000000BCz-13ka;
	Sat, 28 Mar 2026 07:57:55 +0000
Date: Sat, 28 Mar 2026 15:57:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 50451816531d66141cafe2347f9a896bd4dcb2b3
Message-ID: <202603281529.tMfrHWUl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 50451816531d66141cafe2347f9a896bd4dcb2b3  Merge branch 'pci/misc'

elapsed time: 758m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260328    gcc-15.2.0
arc                   randconfig-002-20260328    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260328    gcc-15.2.0
arm                   randconfig-002-20260328    gcc-15.2.0
arm                   randconfig-003-20260328    gcc-15.2.0
arm                   randconfig-004-20260328    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260328    gcc-14.3.0
arm64                 randconfig-002-20260328    gcc-14.3.0
arm64                 randconfig-003-20260328    gcc-14.3.0
arm64                 randconfig-004-20260328    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260328    gcc-14.3.0
csky                  randconfig-002-20260328    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260328    gcc-11.5.0
hexagon               randconfig-002-20260328    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260328    clang-20
i386        buildonly-randconfig-002-20260328    clang-20
i386        buildonly-randconfig-002-20260328    gcc-12
i386        buildonly-randconfig-003-20260328    clang-20
i386        buildonly-randconfig-003-20260328    gcc-14
i386        buildonly-randconfig-004-20260328    clang-20
i386        buildonly-randconfig-005-20260328    clang-20
i386        buildonly-randconfig-006-20260328    clang-20
i386        buildonly-randconfig-006-20260328    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260328    clang-20
i386                  randconfig-002-20260328    clang-20
i386                  randconfig-003-20260328    clang-20
i386                  randconfig-004-20260328    clang-20
i386                  randconfig-005-20260328    clang-20
i386                  randconfig-006-20260328    clang-20
i386                  randconfig-007-20260328    clang-20
i386                  randconfig-011-20260328    gcc-13
i386                  randconfig-012-20260328    gcc-13
i386                  randconfig-013-20260328    gcc-13
i386                  randconfig-014-20260328    gcc-13
i386                  randconfig-015-20260328    gcc-13
i386                  randconfig-016-20260328    gcc-13
i386                  randconfig-017-20260328    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260328    gcc-11.5.0
loongarch             randconfig-002-20260328    gcc-11.5.0
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
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260328    gcc-11.5.0
nios2                 randconfig-002-20260328    gcc-11.5.0
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
parisc                randconfig-001-20260328    gcc-10.5.0
parisc                randconfig-002-20260328    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260328    gcc-10.5.0
powerpc               randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260328    gcc-10.5.0
powerpc64             randconfig-002-20260328    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260328    clang-23
riscv                 randconfig-002-20260328    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260328    clang-23
s390                  randconfig-002-20260328    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260328    clang-23
sh                    randconfig-002-20260328    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260328    gcc-14
sparc                 randconfig-002-20260328    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260328    gcc-14
sparc64               randconfig-002-20260328    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260328    gcc-14
um                    randconfig-002-20260328    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260328    clang-20
x86_64      buildonly-randconfig-002-20260328    clang-20
x86_64      buildonly-randconfig-003-20260328    clang-20
x86_64      buildonly-randconfig-004-20260328    clang-20
x86_64      buildonly-randconfig-005-20260328    clang-20
x86_64      buildonly-randconfig-006-20260328    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260328    gcc-14
x86_64                randconfig-002-20260328    gcc-14
x86_64                randconfig-003-20260328    gcc-14
x86_64                randconfig-004-20260328    gcc-14
x86_64                randconfig-005-20260328    gcc-14
x86_64                randconfig-006-20260328    gcc-14
x86_64                randconfig-011-20260328    clang-20
x86_64                randconfig-012-20260328    clang-20
x86_64                randconfig-013-20260328    clang-20
x86_64                randconfig-014-20260328    clang-20
x86_64                randconfig-015-20260328    clang-20
x86_64                randconfig-016-20260328    clang-20
x86_64                randconfig-071-20260328    gcc-12
x86_64                randconfig-072-20260328    gcc-12
x86_64                randconfig-073-20260328    gcc-12
x86_64                randconfig-074-20260328    gcc-12
x86_64                randconfig-075-20260328    gcc-12
x86_64                randconfig-076-20260328    gcc-12
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260328    gcc-14
xtensa                randconfig-002-20260328    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
