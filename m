Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02A344D8B
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033938; cv=none; b=La17YDHqykCQmCMku6lBJjb/2a2we0J6abac+Ln5vbxbyr7/ReeeACf3FYCtyDnAugqAUVUQ/+Rnoh5m9rt+2VJVjsT13ybPDOJYACf+N/+rm5FpCgSHsfVfFoAjdPs9/dx6302UxHNUUvRdfvPsu7yJHtJ9rUuX0KE7GbY659U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033938; c=relaxed/simple;
	bh=WbDsefSrcKMSGGEavBM/EcStloAHdfzDyZQmiLwnovE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IflfwjRZFJAuLrQY4XmIHCxjJpsv/Uwc3hSPdYRnsL+KiN+lUSN49+DGKAHSuPlXhNrIcKYcaTVa1O93Gy7MSqkVEUsBvXFazcgn7TRNeh1wEHzlqYUWqgkfhuzGwZsx35IfC5Bo2VmZfXTjWYAT5eFMNfvn65yzA+A8GE2os+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKKiWy9z; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKKiWy9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033936; x=1805569936;
  h=date:from:to:cc:subject:message-id;
  bh=WbDsefSrcKMSGGEavBM/EcStloAHdfzDyZQmiLwnovE=;
  b=dKKiWy9zy5QuvM8go+jCvrc4+DQkYGNRFV2NQN6EVrFpoY7z0IbBNjry
   wYONAWHb0F2FxnyffRyCzuHhZZfMUobYNIMqGgsxJxnthYYIAlE2dnSxA
   jl2PgVP1FD+++i5EXXfOraq6pocOLKh+sIPf+F4mFjDlSpoeEfXBe9013
   ht+sc1kBTY0L5AvyKJgzfJk+6KqrTHk45GRwZhGN03k+aEBcfHAZ0hUaW
   SSVPPRX88uqtdt2hMdnMgdnAdNOVOcsOp8OBWzKkOgx4pa2/0yLTNJZPu
   nWbiCUj5CYyD3jqPm/FagQCJ9cNbLnRrl0Wt+D2xHAQRyu20gDvvYFfV8
   g==;
X-CSE-ConnectionGUID: NdJZY1AmTNurMJfnus6Bfw==
X-CSE-MsgGUID: HVB0YKTeSLOxlUNFlKUFEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="92703481"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92703481"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:12:15 -0700
X-CSE-ConnectionGUID: 61b20omtQfu3h6Wx4HAv5w==
X-CSE-MsgGUID: eiS8zeNEQ/al4C76woARdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246404608"
Received: from lkp-server02.sh.intel.com (HELO ef9b23065726) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2026 12:12:14 -0700
Received: from kbuild by ef9b23065726 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3fEt-00000000077-2z1t;
	Fri, 20 Mar 2026 19:10:55 +0000
Date: Sat, 21 Mar 2026 03:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-eswin] BUILD SUCCESS
 b593c26d081a4fbeabd34badb0a9e9a971a79cb4
Message-ID: <202603210352.nb8Xj4Ca-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-eswin
branch HEAD: b593c26d081a4fbeabd34badb0a9e9a971a79cb4  PCI: eswin: Add ESWIN PCIe Root Complex driver

elapsed time: 1263m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    clang-23
arc                    allyesconfig    gcc-15.2.0
arc         randconfig-001-20260321    gcc-8.5.0
arc         randconfig-002-20260321    gcc-8.5.0
arm                     allnoconfig    clang-23
arm                     allnoconfig    gcc-15.2.0
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-001-20260321    gcc-8.5.0
arm         randconfig-002-20260321    gcc-8.5.0
arm         randconfig-003-20260321    gcc-8.5.0
arm         randconfig-004-20260321    gcc-8.5.0
arm64                  allmodconfig    clang-19
arm64                  allmodconfig    clang-23
arm64                   allnoconfig    gcc-15.2.0
arm64       randconfig-001-20260321    clang-23
arm64       randconfig-002-20260321    clang-23
arm64       randconfig-003-20260321    clang-23
arm64       randconfig-004-20260321    clang-23
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky        randconfig-001-20260321    clang-23
csky        randconfig-002-20260321    clang-23
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon                 allnoconfig    gcc-15.2.0
hexagon     randconfig-001-20260321    gcc-11.5.0
hexagon     randconfig-002-20260321    gcc-11.5.0
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-15.2.0
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch              allmodconfig    clang-23
loongarch               allnoconfig    clang-23
loongarch               allnoconfig    gcc-15.2.0
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20260321    gcc-11.5.0
loongarch   randconfig-002-20260321    gcc-11.5.0
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
m68k                      defconfig    clang-19
m68k              m5407c3_defconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
microblaze                defconfig    clang-19
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    clang-23
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    clang-23
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    clang-19
nios2       randconfig-001-20260321    gcc-11.5.0
nios2       randconfig-002-20260321    gcc-11.5.0
openrisc               allmodconfig    clang-23
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    clang-23
openrisc                allnoconfig    gcc-15.2.0
openrisc                  defconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    clang-23
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc                    defconfig    gcc-15.2.0
parisc      randconfig-001-20260321    clang-23
parisc      randconfig-002-20260321    clang-23
parisc64                  defconfig    clang-19
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    clang-23
powerpc                 allnoconfig    gcc-15.2.0
powerpc     randconfig-001-20260321    clang-23
powerpc     randconfig-002-20260321    clang-23
powerpc64   randconfig-001-20260321    clang-23
powerpc64   randconfig-002-20260321    clang-23
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv                     defconfig    gcc-15.2.0
riscv       randconfig-001-20260321    clang-23
riscv       randconfig-002-20260321    clang-23
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390                      defconfig    gcc-15.2.0
s390        randconfig-001-20260321    clang-23
s390        randconfig-002-20260321    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    clang-23
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-14
sh          randconfig-001-20260321    clang-23
sh          randconfig-002-20260321    clang-23
sparc                   allnoconfig    clang-23
sparc                   allnoconfig    gcc-15.2.0
sparc                     defconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    gcc-14
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    gcc-14
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                  allnoconfig    clang-23
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    clang-23
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
