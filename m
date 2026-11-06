Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968233;
	b=nYONTZaKaqRC/fzpvQOe9J5ZTmzouxjeM3XXN6lulIIh+p6Xeydh6XtzIU7Rw4i0HtUp
	 A0qHVYKNi7N4rwbqhh/JHwNIOMp5H/SaNPcrjeFvFCpGuMPpG1O3+jHGFfZobfMeuYPF2
	 XD4metomOepVVjBZfGl1QzvaCk5i/q30VMVOYW6bwoVQagp2b6FRyK6QmBzGMRzdAZVsF
	 Hmpdb2GSpQ/dzaCH9o7UOQw9oXfGUjjWqQdD8YILJWaA/RT82n7CV0P/18jJkaxVlEQsv
	 LQhm4dyGQPG7VawgAhKVxTz2OBDud0jyoRjH77ponpyQDxhFKTnY1X2qUcan9o3u7UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=vveSG7jlwChXKzQ6UjFEA4KgrHVWQL9/csYDmDUzDU4=;
	b=ixY8af+r6ec+/r3Ufyil/R5qyfWr8c4K+MhCRZ7v6NLdQxPLMVq96u79iT49X3WuEcA4
	 h37O1xJ/DyV0A12MWUqrDYvlOF3cPSf9n2E3e5XMCWBQCU8DJsX0fDltrl0KGNRj7krkV
	 Z7Ia1N5euICP5oH2IB0YYOeSBtlNBLeyJjJvcTwOkYWElZXGimGGy2Sub6In4vWI1RKjB
	 6n+ukuBFginPBniFHkl4+Lv9qRf1Cd8N7ZWbVDxAG6qoANCH7LPQomBeROjdFUbS+2vsd
	 YOVFCrj086Ks49o6TpdFRFeWizQE7V6R8A5uxoYG2aWkLHqGMvCBAN6wC9WCDdQjvBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XRtkzlx9;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BDC606A329
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 12:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BDC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XRtkzlx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793968232; x=1825504232;
  h=date:from:to:cc:subject:message-id;
  bh=IYDko73glwRUdo2WV2LXFu+l8S69nCbq3IfHh2EkcqI=;
  b=XRtkzlx9Vic1oE7TlX5E05VIB040J9LmoGS+qJMJ59OwFvui0s7Z/VkS
   Vl6BGEsofQePkv9mYLKyh2Ej3VtD6skOlFhpqtDhX07NMPFgtn0jD78V8
   W2/ROo1L5fM2gW4QktykYE+9IA6Y7BuAKNCdhWxp/VU8q08mkvs47jnCa
   K+lYdVQrXZ2wHhEWJxJVvAqdHyEfJhGyvfGUqUGjMF4dr75zRtgAmUVd6
   pcQszkbkskcjF1V0HMgPePAM0FD7IRJ1Bzg0hiVtBKSlSGjno34kmtPc+
   0JjpyvkLMz4p/TnHNG7HkHIF+4jLgWIaTPpqj4vqDYYv+wOVS/filkKP1
   w==;
X-CSE-ConnectionGUID: yt/owUnnTfGDYO8CYGLb9Q==
X-CSE-MsgGUID: X7Gt8ssaSEaTCMWyEk1R2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2801573"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2801573"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 04:30:32 -0800
X-CSE-ConnectionGUID: T8Q1JfpwRUWuj95Vcunpag==
X-CSE-MsgGUID: rPZlt2F6SmKiQvxwKW3YQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7431115"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Nov 2026 04:30:30 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPJ5P-00000000pFx-2J8d;
	Fri, 06 Nov 2026 12:30:27 +0000
Date: Fri, 06 Nov 2026 20:29:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 28ca588893b7bf6b3b3748704787dde0682ce0e9
Message-ID: <20261106202944.U6RKTLXm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: 28ca588893b7bf6b3b3748704787dde0682ce0e9  PCI: switchtec: Fix PCI device reference leak on probe failure

elapsed time: 1024m

configs tested: 559
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261105    gcc-15.3.0
alpha                 randconfig-2000-20261106    gcc-8.5.0
alpha                 randconfig-2001-20261105    gcc-15.3.0
alpha                 randconfig-2001-20261106    gcc-8.5.0
alpha                 randconfig-2200-20261105    gcc-9.5.0  smatch
alpha                 randconfig-2200-20261106    gcc-14.4.0 smatch
alpha                randconfig-r2102-20261105    clang-17   cocci
alpha                randconfig-r2105-20261106    gcc-11.5.0 cocci
alpha                randconfig-r2105-20261106    gcc-16.2.0 cocci
alpha                randconfig-r2111-20261106    clang-24   cocci
alpha                randconfig-r2304-20261106    gcc-12     sparse
alpha                randconfig-r2308-20261105    gcc-8.5.0  sparse
alpha                randconfig-r2311-20261105    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                           axs103_defconfig    clang-19
arc                                  defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                   randconfig-2000-20261105    gcc-8.5.0
arc                   randconfig-2000-20261106    gcc-12.5.0
arc                   randconfig-2001-20261105    gcc-8.5.0
arc                   randconfig-2001-20261106    gcc-12.5.0
arc                   randconfig-2002-20261105    gcc-8.5.0
arc                   randconfig-2002-20261106    gcc-12.5.0
arc                   randconfig-2003-20261105    gcc-8.5.0
arc                   randconfig-2003-20261106    gcc-12.5.0
arc                   randconfig-2004-20261105    gcc-8.5.0
arc                   randconfig-2004-20261106    gcc-12.5.0
arc                   randconfig-2005-20261105    gcc-8.5.0
arc                   randconfig-2005-20261106    gcc-12.5.0
arc                   randconfig-2200-20261105    gcc-8.5.0  smatch
arc                   randconfig-2200-20261106    gcc-10.5.0 smatch
arc                  randconfig-r2101-20261105    gcc-8.5.0  cocci
arc                  randconfig-r2106-20261106    clang-24   cocci
arc                  randconfig-r2106-20261106    gcc-14.4.0 cocci
arc                  randconfig-r2107-20261106    clang-24   cocci
arc                  randconfig-r2109-20261105    gcc-16.2.0 cocci
arc                  randconfig-r2301-20261106    gcc-8.5.0  sparse
arc                  randconfig-r2307-20261106    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                   randconfig-2000-20261105    clang-24
arm                   randconfig-2000-20261106    gcc-9.5.0
arm                   randconfig-2001-20261105    clang-24
arm                   randconfig-2001-20261106    gcc-9.5.0
arm                   randconfig-2002-20261105    clang-24
arm                   randconfig-2002-20261106    gcc-9.5.0
arm                   randconfig-2200-20261105    gcc-15.3.0 smatch
arm                   randconfig-2200-20261106    clang-17   smatch
arm                  randconfig-r2104-20261105    clang-24   cocci
arm                  randconfig-r2104-20261106    gcc-16.2.0 cocci
arm                  randconfig-r2108-20261105    gcc-16.2.0 cocci
arm                  randconfig-r2111-20261106    gcc-8.5.0  cocci
arm                  randconfig-r2304-20261106    gcc-8.5.0  sparse
arm                              rpc_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261106    clang-17
arm64                 randconfig-2000-20261105    clang-24
arm64                 randconfig-2000-20261106    gcc-9.5.0
arm64                 randconfig-2001-20261105    clang-24
arm64                 randconfig-2001-20261106    gcc-9.5.0
arm64                 randconfig-2002-20261105    clang-24
arm64                 randconfig-2002-20261106    gcc-9.5.0
arm64                 randconfig-2200-20261105    clang-20   smatch
arm64                 randconfig-2200-20261106    clang-24   smatch
arm64                randconfig-r2100-20261106    gcc-10.5.0 cocci
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261106    clang-17
csky                  randconfig-2000-20261105    clang-24
csky                  randconfig-2000-20261106    clang-24
csky                  randconfig-2001-20261105    clang-24
csky                  randconfig-2001-20261106    clang-24
csky                  randconfig-2200-20261105    gcc-9.5.0  smatch
csky                  randconfig-2200-20261106    gcc-10.5.0 smatch
csky                 randconfig-r2105-20261105    clang-17   cocci
csky                 randconfig-r2105-20261105    clang-24   cocci
csky                 randconfig-r2106-20261105    gcc-16.2.0 cocci
csky                 randconfig-r2108-20261106    clang-24   cocci
csky                 randconfig-r2108-20261106    gcc-8.5.0  cocci
hexagon                           alldefconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261106    gcc-14.4.0
hexagon               randconfig-2000-20261105    clang-24
hexagon               randconfig-2000-20261106    clang-24
hexagon               randconfig-2001-20261105    clang-24
hexagon               randconfig-2001-20261106    clang-24
hexagon               randconfig-2200-20261105    clang-17   smatch
hexagon               randconfig-2200-20261106    clang-24   smatch
hexagon              randconfig-r2101-20261105    clang-17   cocci
hexagon              randconfig-r2102-20261105    clang-24   cocci
hexagon              randconfig-r2105-20261105    clang-24   cocci
hexagon              randconfig-r2106-20261106    gcc-8.5.0  cocci
hexagon              randconfig-r2109-20261106    gcc-14.4.0 cocci
hexagon              randconfig-r2110-20261105    gcc-16.2.0 cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1005-20261106    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261106    gcc-14
i386                  randconfig-2000-20261105    clang-22
i386                  randconfig-2000-20261106    gcc-14
i386                  randconfig-2001-20261105    clang-22
i386                  randconfig-2001-20261106    gcc-14
i386                  randconfig-2002-20261105    clang-22
i386                  randconfig-2002-20261106    gcc-14
i386                  randconfig-2003-20261105    clang-22
i386                  randconfig-2003-20261106    gcc-14
i386                  randconfig-2004-20261105    clang-22
i386                  randconfig-2004-20261106    gcc-14
i386                  randconfig-2005-20261105    clang-22
i386                  randconfig-2005-20261106    gcc-14
i386                  randconfig-2100-20261105    gcc-14     cocci
i386                  randconfig-2100-20261106    clang-22   cocci
i386                  randconfig-2101-20261105    gcc-14     cocci
i386                  randconfig-2101-20261106    clang-22   cocci
i386                  randconfig-2102-20261105    gcc-14     cocci
i386                  randconfig-2102-20261106    clang-22   cocci
i386                  randconfig-2103-20261105    gcc-14     cocci
i386                  randconfig-2103-20261106    clang-22   cocci
i386                  randconfig-2104-20261105    gcc-14     cocci
i386                  randconfig-2104-20261106    clang-22   cocci
i386                  randconfig-2105-20261105    gcc-14     cocci
i386                  randconfig-2105-20261106    clang-22   cocci
i386                  randconfig-2200-20261105    clang-22   smatch
i386                  randconfig-2200-20261106    clang-22   smatch
i386                  randconfig-2300-20261105    clang-22   sparse
i386                  randconfig-2300-20261106    clang-22   sparse
i386                  randconfig-2301-20261105    clang-22   sparse
i386                  randconfig-2301-20261106    clang-22   sparse
i386                  randconfig-2302-20261105    clang-22   sparse
i386                  randconfig-2302-20261106    clang-22   sparse
i386                 randconfig-r2103-20261105    clang-24   cocci
i386                 randconfig-r2109-20261106    gcc-8.5.0  cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261106    gcc-14.4.0
loongarch             randconfig-2000-20261105    gcc-16.2.0
loongarch             randconfig-2000-20261106    clang-19
loongarch             randconfig-2001-20261105    gcc-16.2.0
loongarch             randconfig-2001-20261106    clang-19
loongarch             randconfig-2200-20261105    gcc-16.2.0 smatch
loongarch             randconfig-2200-20261106    clang-24   smatch
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-24
m68k                       m54418evb_defconfig    clang-19
m68k                          nettel_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261105    gcc-15.3.0
m68k                  randconfig-2000-20261106    gcc-8.5.0
m68k                  randconfig-2001-20261105    gcc-15.3.0
m68k                  randconfig-2001-20261106    gcc-8.5.0
m68k                  randconfig-2200-20261105    gcc-8.5.0  smatch
m68k                  randconfig-2200-20261106    gcc-11.5.0 smatch
m68k                 randconfig-r2102-20261105    gcc-8.5.0  cocci
m68k                 randconfig-r2103-20261106    gcc-10.5.0 cocci
m68k                 randconfig-r2104-20261106    gcc-10.5.0 cocci
m68k                 randconfig-r2110-20261106    gcc-8.5.0  cocci
m68k                 randconfig-r2303-20261106    gcc-8.5.0  sparse
m68k                 randconfig-r2306-20261106    gcc-10.5.0 sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261105    gcc-15.3.0
microblaze            randconfig-2000-20261106    gcc-8.5.0
microblaze            randconfig-2001-20261105    gcc-15.3.0
microblaze            randconfig-2001-20261106    gcc-8.5.0
microblaze            randconfig-2200-20261105    gcc-9.5.0  smatch
microblaze            randconfig-2200-20261106    gcc-14.4.0 smatch
microblaze           randconfig-r2100-20261106    gcc-11.5.0 cocci
microblaze           randconfig-r2102-20261106    gcc-16.2.0 cocci
microblaze           randconfig-r2103-20261105    clang-17   cocci
microblaze           randconfig-r2105-20261106    gcc-10.5.0 cocci
microblaze           randconfig-r2107-20261105    gcc-16.2.0 cocci
microblaze           randconfig-r2108-20261106    gcc-14.4.0 cocci
microblaze           randconfig-r2309-20261106    gcc-10.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                          db1xxx_defconfig    gcc-16.2.0
mips                       loongson3_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    clang-19
mips                  randconfig-2000-20261105    gcc-9.5.0
mips                  randconfig-2000-20261106    gcc-8.5.0
mips                  randconfig-2001-20261105    gcc-9.5.0
mips                  randconfig-2001-20261106    gcc-8.5.0
mips                  randconfig-2002-20261105    gcc-9.5.0
mips                  randconfig-2002-20261106    gcc-8.5.0
mips                  randconfig-2200-20261105    gcc-11.5.0 smatch
mips                  randconfig-2200-20261106    clang-17   smatch
mips                 randconfig-r2104-20261105    gcc-8.5.0  cocci
mips                 randconfig-r2104-20261106    gcc-11.5.0 cocci
mips                 randconfig-r2107-20261105    gcc-16.2.0 cocci
mips                 randconfig-r2110-20261106    clang-24   cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261106    gcc-14.4.0
nios2                 randconfig-2000-20261105    gcc-16.2.0
nios2                 randconfig-2000-20261106    clang-19
nios2                 randconfig-2001-20261105    gcc-16.2.0
nios2                 randconfig-2001-20261106    clang-19
nios2                 randconfig-2200-20261105    gcc-9.5.0  smatch
nios2                 randconfig-2200-20261106    gcc-10.5.0 smatch
nios2                randconfig-r2102-20261106    gcc-10.5.0 cocci
nios2                randconfig-r2111-20261106    clang-24   cocci
nios2                randconfig-r2300-20261106    gcc-12     sparse
nios2                randconfig-r2310-20261105    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    clang-19
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    clang-24
openrisc                   or1klitex_defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261105    gcc-9.5.0
openrisc              randconfig-2000-20261106    gcc-8.5.0
openrisc              randconfig-2001-20261105    gcc-9.5.0
openrisc              randconfig-2001-20261106    gcc-8.5.0
openrisc              randconfig-2002-20261105    gcc-9.5.0
openrisc              randconfig-2002-20261106    gcc-8.5.0
openrisc              randconfig-2200-20261105    gcc-16.2.0 smatch
openrisc              randconfig-2200-20261106    gcc-16.2.0 smatch
openrisc             randconfig-r2100-20261105    clang-24   cocci
openrisc             randconfig-r2102-20261106    gcc-11.5.0 cocci
openrisc             randconfig-r2104-20261105    clang-17   cocci
openrisc             randconfig-r2106-20261106    clang-24   cocci
openrisc             randconfig-r2111-20261105    gcc-16.2.0 cocci
openrisc             randconfig-r2310-20261106    gcc-10.5.0 sparse
openrisc                  simple_smp_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261106    clang-19
parisc                randconfig-2000-20261105    gcc-16.2.0
parisc                randconfig-2000-20261106    clang-19
parisc                randconfig-2001-20261105    gcc-16.2.0
parisc                randconfig-2001-20261106    clang-19
parisc                randconfig-2200-20261105    gcc-15.3.0 smatch
parisc                randconfig-2200-20261106    gcc-12.5.0 smatch
parisc               randconfig-r2109-20261106    clang-24   cocci
parisc               randconfig-r2305-20261106    gcc-8.5.0  sparse
parisc               randconfig-r2306-20261105    gcc-8.5.0  sparse
parisc               randconfig-r2307-20261105    gcc-15.3.0 sparse
parisc               randconfig-r2308-20261105    gcc-15.3.0 sparse
parisc               randconfig-r2308-20261106    gcc-10.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      ep8248e_defconfig    clang-24
powerpc                       ep88xc_defconfig    clang-17
powerpc                     gamecube_defconfig    clang-19
powerpc                      kmeter1_defconfig    gcc-16.2.0
powerpc                       mgcoge_defconfig    clang-17
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                   mpc885_ads_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261106    clang-19
powerpc               randconfig-2000-20261105    clang-18
powerpc               randconfig-2000-20261106    gcc-8.5.0
powerpc               randconfig-2001-20261105    clang-18
powerpc               randconfig-2001-20261106    gcc-8.5.0
powerpc               randconfig-2002-20261105    clang-18
powerpc               randconfig-2002-20261106    gcc-8.5.0
powerpc               randconfig-2200-20261105    clang-17   smatch
powerpc               randconfig-2200-20261106    clang-24   smatch
powerpc              randconfig-r2101-20261106    gcc-11.5.0 cocci
powerpc              randconfig-r2111-20261106    gcc-14.4.0 cocci
powerpc                      redwood_defconfig    gcc-16.2.0
powerpc                     sam440ep_defconfig    gcc-16.2.0
powerpc                      tqm8555_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261106    clang-19
powerpc64             randconfig-2000-20261105    clang-18
powerpc64             randconfig-2000-20261106    gcc-8.5.0
powerpc64             randconfig-2001-20261105    clang-18
powerpc64             randconfig-2001-20261106    gcc-8.5.0
powerpc64             randconfig-2002-20261105    clang-18
powerpc64             randconfig-2002-20261106    gcc-8.5.0
powerpc64             randconfig-2200-20261105    clang-24   smatch
powerpc64             randconfig-2200-20261106    gcc-8.5.0  smatch
powerpc64            randconfig-r2101-20261106    gcc-16.2.0 cocci
powerpc64            randconfig-r2102-20261105    clang-24   cocci
powerpc64            randconfig-r2103-20261105    gcc-8.5.0  cocci
powerpc64            randconfig-r2307-20261105    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261106    gcc-14.4.0
riscv                 randconfig-2000-20261105    clang-24
riscv                 randconfig-2000-20261106    gcc-13.5.0
riscv                 randconfig-2001-20261105    clang-24
riscv                 randconfig-2001-20261106    gcc-13.5.0
riscv                 randconfig-2002-20261105    clang-24
riscv                 randconfig-2002-20261106    gcc-13.5.0
riscv                 randconfig-2003-20261105    clang-24
riscv                 randconfig-2003-20261106    gcc-13.5.0
riscv                 randconfig-2004-20261105    clang-24
riscv                 randconfig-2004-20261106    gcc-13.5.0
riscv                 randconfig-2005-20261105    clang-24
riscv                 randconfig-2005-20261106    gcc-13.5.0
riscv                 randconfig-2200-20261105    clang-24   smatch
riscv                 randconfig-2200-20261106    gcc-11.5.0 smatch
riscv                randconfig-r2100-20261105    gcc-8.5.0  cocci
riscv                randconfig-r2300-20261106    gcc-8.5.0  sparse
riscv                randconfig-r2305-20261106    gcc-12     sparse
riscv                randconfig-r2309-20261105    gcc-8.5.0  sparse
riscv                randconfig-r2311-20261105    gcc-15.3.0 sparse
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261106    gcc-14.4.0
s390                  randconfig-2000-20261105    clang-24
s390                  randconfig-2000-20261106    gcc-8.5.0
s390                  randconfig-2001-20261105    clang-24
s390                  randconfig-2001-20261106    gcc-8.5.0
s390                  randconfig-2002-20261105    clang-24
s390                  randconfig-2002-20261106    gcc-8.5.0
s390                  randconfig-2003-20261105    clang-24
s390                  randconfig-2003-20261106    gcc-8.5.0
s390                  randconfig-2004-20261105    clang-24
s390                  randconfig-2004-20261106    gcc-8.5.0
s390                  randconfig-2005-20261105    clang-24
s390                  randconfig-2005-20261106    gcc-8.5.0
s390                  randconfig-2200-20261105    clang-24   smatch
s390                  randconfig-2200-20261106    clang-18   smatch
s390                 randconfig-r2108-20261105    gcc-16.2.0 cocci
s390                 randconfig-r2109-20261106    clang-24   cocci
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-17
sh                             migor_defconfig    clang-24
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                    randconfig-2000-20261105    gcc-16.2.0
sh                    randconfig-2000-20261106    gcc-16.2.0
sh                    randconfig-2001-20261105    gcc-16.2.0
sh                    randconfig-2001-20261106    gcc-16.2.0
sh                    randconfig-2002-20261105    gcc-16.2.0
sh                    randconfig-2002-20261106    gcc-16.2.0
sh                    randconfig-2003-20261105    gcc-16.2.0
sh                    randconfig-2003-20261106    gcc-16.2.0
sh                    randconfig-2004-20261105    gcc-16.2.0
sh                    randconfig-2004-20261106    gcc-16.2.0
sh                    randconfig-2005-20261105    gcc-16.2.0
sh                    randconfig-2005-20261106    gcc-16.2.0
sh                    randconfig-2200-20261105    gcc-13.5.0 smatch
sh                    randconfig-2200-20261106    gcc-16.2.0 smatch
sh                   randconfig-r2101-20261105    clang-24   cocci
sh                   randconfig-r2103-20261106    gcc-11.5.0 cocci
sh                   randconfig-r2309-20261105    gcc-15.3.0 sparse
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc                 randconfig-2000-20261105    clang-24
sparc                 randconfig-2000-20261106    gcc-8.5.0
sparc                 randconfig-2001-20261105    clang-24
sparc                 randconfig-2001-20261106    gcc-8.5.0
sparc                 randconfig-2200-20261105    gcc-16.2.0 smatch
sparc                 randconfig-2200-20261106    gcc-8.5.0  smatch
sparc                randconfig-r2101-20261105    clang-24   cocci
sparc                randconfig-r2107-20261106    gcc-14.4.0 cocci
sparc                randconfig-r2110-20261106    gcc-14.4.0 cocci
sparc                randconfig-r2302-20261106    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
sparc64               randconfig-2000-20261105    clang-24
sparc64               randconfig-2000-20261106    gcc-8.5.0
sparc64               randconfig-2001-20261105    clang-24
sparc64               randconfig-2001-20261106    gcc-8.5.0
sparc64               randconfig-2200-20261105    gcc-8.5.0  smatch
sparc64               randconfig-2200-20261106    gcc-8.5.0  smatch
sparc64              randconfig-r2100-20261105    clang-24   cocci
sparc64              randconfig-r2104-20261105    clang-24   cocci
sparc64              randconfig-r2302-20261106    gcc-12     sparse
sparc64              randconfig-r2311-20261106    gcc-10.5.0 sparse
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                    randconfig-2000-20261105    clang-24
um                    randconfig-2000-20261106    gcc-8.5.0
um                    randconfig-2001-20261105    clang-24
um                    randconfig-2001-20261106    gcc-8.5.0
um                    randconfig-2200-20261105    clang-19   smatch
um                    randconfig-2200-20261106    gcc-13     smatch
um                   randconfig-r2100-20261105    clang-17   cocci
um                   randconfig-r2101-20261106    gcc-10.5.0 cocci
um                   randconfig-r2103-20261105    clang-24   cocci
um                   randconfig-r2103-20261106    gcc-16.2.0 cocci
um                   randconfig-r2108-20261106    clang-24   cocci
um                   randconfig-r2110-20261106    clang-24   cocci
um                   randconfig-r2111-20261105    gcc-16.2.0 cocci
um                   randconfig-r2303-20261106    gcc-12     sparse
um                   randconfig-r2306-20261105    gcc-15.3.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-19
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1006-20261106    clang-22
x86_64                randconfig-1007-20261106    clang-22
x86_64                randconfig-1008-20261106    clang-22
x86_64                randconfig-1009-20261106    clang-22
x86_64                randconfig-1010-20261106    clang-22
x86_64                randconfig-1011-20261106    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261106    gcc-14
x86_64                randconfig-2000-20261105    gcc-14
x86_64                randconfig-2000-20261106    gcc-14
x86_64                randconfig-2001-20261105    gcc-14
x86_64                randconfig-2001-20261106    gcc-14
x86_64                randconfig-2002-20261105    gcc-14
x86_64                randconfig-2002-20261106    gcc-14
x86_64                randconfig-2003-20261105    gcc-14
x86_64                randconfig-2003-20261106    gcc-14
x86_64                randconfig-2004-20261105    gcc-14
x86_64                randconfig-2004-20261106    gcc-14
x86_64                randconfig-2005-20261105    gcc-14
x86_64                randconfig-2005-20261106    gcc-14
x86_64                randconfig-2100-20261105    gcc-14     cocci
x86_64                randconfig-2100-20261106    clang-22   cocci
x86_64                randconfig-2101-20261105    gcc-14     cocci
x86_64                randconfig-2101-20261106    clang-22   cocci
x86_64                randconfig-2102-20261105    gcc-14     cocci
x86_64                randconfig-2102-20261106    clang-22   cocci
x86_64                randconfig-2103-20261105    gcc-14     cocci
x86_64                randconfig-2103-20261106    clang-22   cocci
x86_64                randconfig-2104-20261105    gcc-14     cocci
x86_64                randconfig-2104-20261106    clang-22   cocci
x86_64                randconfig-2105-20261105    gcc-14     cocci
x86_64                randconfig-2105-20261106    clang-22   cocci
x86_64                randconfig-2200-20261105    clang-22   smatch
x86_64                randconfig-2200-20261106    gcc-14     smatch
x86_64                randconfig-2300-20261105    clang-22   sparse
x86_64                randconfig-2300-20261106    clang-22   sparse
x86_64                randconfig-2301-20261105    clang-22   sparse
x86_64                randconfig-2301-20261106    clang-22   sparse
x86_64                randconfig-2302-20261105    clang-22   sparse
x86_64                randconfig-2302-20261106    clang-22   sparse
x86_64               randconfig-r2107-20261106    clang-24   cocci
x86_64               randconfig-r2107-20261106    gcc-8.5.0  cocci
x86_64               randconfig-r2109-20261105    gcc-16.2.0 cocci
x86_64               randconfig-r2301-20261106    gcc-12     sparse
x86_64               randconfig-r2310-20261105    gcc-15.3.0 sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   nommu_kc705_defconfig    clang-24
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                randconfig-2000-20261105    clang-24
xtensa                randconfig-2000-20261106    clang-24
xtensa                randconfig-2001-20261105    clang-24
xtensa                randconfig-2001-20261106    clang-24
xtensa                randconfig-2200-20261105    gcc-8.5.0  smatch
xtensa                randconfig-2200-20261106    gcc-8.5.0  smatch
xtensa               randconfig-r2100-20261106    gcc-16.2.0 cocci
xtensa               randconfig-r2105-20261105    gcc-8.5.0  cocci
xtensa               randconfig-r2106-20261105    gcc-16.2.0 cocci
xtensa                     xip_kc705_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
