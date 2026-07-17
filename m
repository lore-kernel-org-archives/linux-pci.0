Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164DA883F
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246815; cv=none; b=FkQX6InvWINKzjVa+rFEMY1u5E86VYg4cx7dVeqFJDzhiyPbYYCTjrqYX1PA/cusJ7c0x1+eUkdijRG2fhjyo1fm/UuXFn2LX8n6LqfqhQl4yCzUIlanIZ+ZFhCjCyabOhEdVjyCJNUpIhKRRval5pyaDvqUDuJjIm8p0y02M+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246815; c=relaxed/simple;
	bh=CsCio1naoYOdT0MNaxaGipRfsQFcwbmztQPBjZmxvck=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MWn/DgVKHX4o63IjeHg5zgTkWCsaFJiB5zvJidMaA3v93ToJdTv4h18F/KtF9TznUgHTUD4U8iBjJIxMTEOxZNDg8zOwiJojqu/HUvhmPUE5Fhk5JCTVxe8gF9kC+PvtVA4tW6HTx1CEyNCfDj0HeyF/DmaggqORryWmQ60231Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEGZ6P4Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEGZ6P4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784246813; x=1815782813;
  h=date:from:to:cc:subject:message-id;
  bh=CsCio1naoYOdT0MNaxaGipRfsQFcwbmztQPBjZmxvck=;
  b=QEGZ6P4QWrSV4oWJilBdoQfuvQf8fod0r9PW//B/1lDpQ8WAAsuAoqyD
   uGcl4tiiS6E40VXyraD7lQ8fouKXxbDlmyjC5BDLPAFdxgDXG6WjIm1m+
   LP2WGAStO8oxwdhR2jBswfmfMN4zeQMZtuU8VigZfaMV316DmV1xvA4OD
   k5rcjOfHP9TExGxwXXd4KRUfIk5MbImEIgno+kMQpGnMm934Vb6LK4o0J
   5J91dS/PA9q+6eTfTiTmIW//RNtIjhveVeQtzqTkcMZc4ptfS5HWqq6Bn
   5uQSTPnNpVfFeTnyvJV/0w8jH60BM0YR8ZoVIpcEIvV3OU1P87ufdWlRJ
   A==;
X-CSE-ConnectionGUID: yRdu8aKcQZyvstByvOchSA==
X-CSE-MsgGUID: o9yPxYF7SDSe0dqXtmzQbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85114739"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="85114739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 17:06:52 -0700
X-CSE-ConnectionGUID: JnpQ1AE0TEG0pgFxNCJ/zg==
X-CSE-MsgGUID: mK5/+17wSAqbddkrDn9DZA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2026 17:06:51 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkW6L-00000000RZY-0NzT;
	Fri, 17 Jul 2026 00:06:49 +0000
Date: Fri, 17 Jul 2026 08:06:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 c654f3ee611506fadac84f4354995dc5259ecfa9
Message-ID: <202607170810.T7Eq8LhU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: c654f3ee611506fadac84f4354995dc5259ecfa9  PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

elapsed time: 1834m

configs tested: 72
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                     allnoconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
arc         randconfig-001-20260717    gcc-11.5.0
arc         randconfig-002-20260717    gcc-13.4.0
arm                     allnoconfig    clang-17
arm                    allyesconfig    gcc-16.1.0
arm         randconfig-003-20260717    gcc-8.5.0
arm         randconfig-004-20260717    gcc-11.5.0
arm64                  allmodconfig    clang-24
arm64                   allnoconfig    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
csky                    allnoconfig    gcc-16.1.0
hexagon                 allnoconfig    clang-24
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-20
loongarch                 defconfig    clang-24
m68k                   allmodconfig    gcc-16.1.0
m68k                    allnoconfig    gcc-16.1.0
m68k                   allyesconfig    gcc-16.1.0
microblaze              allnoconfig    gcc-16.1.0
microblaze             allyesconfig    gcc-16.1.0
mips                   allmodconfig    gcc-16.1.0
mips                    allnoconfig    gcc-16.1.0
mips                   allyesconfig    gcc-16.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-16.1.0
openrisc                allnoconfig    gcc-16.1.0
parisc                 allmodconfig    gcc-16.1.0
parisc                  allnoconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
parisc      randconfig-001-20260717    gcc-10.5.0
parisc      randconfig-002-20260717    gcc-16.1.0
powerpc                allmodconfig    gcc-16.1.0
powerpc                 allnoconfig    gcc-16.1.0
powerpc     randconfig-001-20260717    gcc-13.4.0
powerpc     randconfig-002-20260717    gcc-11.5.0
powerpc64   randconfig-001-20260717    gcc-15.2.0
powerpc64   randconfig-002-20260717    gcc-8.5.0
riscv                  allmodconfig    clang-24
riscv                   allnoconfig    gcc-16.1.0
riscv                  allyesconfig    clang-24
riscv       randconfig-001-20260717    clang-17
riscv       randconfig-002-20260717    clang-24
s390                   allmodconfig    clang-24
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-16.1.0
s390        randconfig-001-20260717    clang-24
s390        randconfig-002-20260717    clang-20
sh                     allmodconfig    gcc-16.1.0
sh                      allnoconfig    gcc-16.1.0
sh                     allyesconfig    gcc-16.1.0
sh          randconfig-001-20260717    gcc-9.5.0
sh          randconfig-002-20260717    gcc-16.1.0
sparc                   allnoconfig    gcc-16.1.0
sparc64                allmodconfig    clang-20
um                     allmodconfig    clang-17
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-22
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-22
x86_64                rhel-9.4-rust    clang-22
xtensa                  allnoconfig    gcc-16.1.0
xtensa                 allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
