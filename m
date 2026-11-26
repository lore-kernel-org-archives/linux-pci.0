Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795721956;
	b=2GTrj2jtov+o6UDtwxqa+9MZQBEPayyJIRD/cn51QC1Tsl8trBcfO4E4ucdmeu+Gi38F
	 1lN7/Y8A5cyOYDsUV+JMG+P0s01oqItMgqyIOXhONq0RiqmmyXEmUZgsaoYiYRt3+wlRk
	 p6LiwCZrG3XAo7lI97ACBJkQxAstTidbfPeTLt9G4NzcgIaaZyJoARTCRtEA+QyH/OB3y
	 Zhlz0Mrn/yzS6HtNi99n5IQdJheni4lxpjj38OWT1YSP0zXL3NlGzvUFZ7ioQUx5L4LOX
	 dooublUa9muqIh4SvXZ3VmuxqWbUZUJj8/Yr8P6lTpkiBWdCLM+pzgjPrfR+Z55807w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721956;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=ka15/H0CNe0e+zf2NrswNuu8jaeVnbvyNIaZdQzBKqc=;
	b=VFG5o2Kiyl0+JMmy9VeMB0YckUxTW2VHdK08ApG8UvF55itAMwAJ8ZcblbHYlGdWD/2S
	 iBU1DeVR5JX4vEsm1XHh/OwHbhlOeBPD7zICPH+wjrvlHg8wER2DYGsnCu+gqQAsDB81d
	 r9SVnhbIn0PufqLxRgW1Sik7WBafJENicx3LGqHuDQUephl8QKa6k3PeP5gHnZ7LY2VO+
	 fkCHMIMhAgSX6ww07Yx9SiRaLrcmxmnZaiEsRR7m+kH8G8aZ9ToslH4gppPvfEUUWZRZc
	 WRbJ0hJ1oWn5wu6+3tETsaP8lO8F8WFqfd4eTOBDCN+Iu3zcVmmsWCF3BMPCZE9rCHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nI3g5pz5;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EB606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C47EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nI3g5pz5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795721956; x=1827257956;
  h=date:from:to:cc:subject:message-id;
  bh=DcKNeTgovdfGsHv0afZIuGp8ZE5jxuITArOug7lTJJ4=;
  b=nI3g5pz5UHLdQxQg2Nm8uHjgnf/rs9bMvvvzdg7bdws15R8sg6e2AOsR
   HwP4LO0Nj+ibnx0KElD3bGllCGlKwSeJn5abWSpObKf+2tb2YOsj9E7Ns
   GgMf5dWjMVvsE84ryKYLKffBODYBGYE7lnHpWEQ8FHkxFcU922glHECst
   MZcDprpldU0xoZwxLDQ6stj8KBo56HVDHa6PdyEOdjp8X+lOWjOXorSD1
   RTzrkvdPfyi1G/+fW4BhnMX1A/eyGJbOcAplaT+tosv5/d0tHVmDRyv/s
   Vxd3zPvYF7/gEJo1LOSicXepzgb93iWhH0Q5BV9+Qnj545YmUiuaQhMMg
   A==;
X-CSE-ConnectionGUID: BGCJNyBkR7S4i8nxhuOCbQ==
X-CSE-MsgGUID: 087NtiSzRBu+mkZB+AfStA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4495221"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4495221"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 11:39:16 -0800
X-CSE-ConnectionGUID: bzXmJtawS62eG+IsTTuNkQ==
X-CSE-MsgGUID: YhSLsPxKSFConBFrV7U2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12241351"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Nov 2026 11:39:14 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWfJH-00000001Uhu-1u6U;
	Thu, 26 Nov 2026 19:39:11 +0000
Date: Fri, 27 Nov 2026 03:39:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 dd1f6bb875acef47745790b92fe321e15df05139
Message-ID: <20261127033904.9CwaPH4E-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: dd1f6bb875acef47745790b92fe321e15df05139  PCI/AER: Enable baseline capability error reporting

elapsed time: 1476m

configs tested: 347
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                 randconfig-2000-20261125    gcc-8.5.0
alpha                 randconfig-2001-20261125    gcc-8.5.0
alpha                 randconfig-2200-20261125    gcc-10.5.0 smatch
alpha                 randconfig-2200-20261126    gcc-9.5.0  smatch
alpha                randconfig-r2300-20261125    gcc-11.5.0 sparse
alpha                randconfig-r2310-20261126    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-19
arc                               allyesconfig    gcc-16.2.0
arc                   randconfig-2000-20261125    gcc-10.5.0
arc                   randconfig-2001-20261125    gcc-10.5.0
arc                   randconfig-2002-20261125    gcc-10.5.0
arc                   randconfig-2003-20261125    gcc-10.5.0
arc                   randconfig-2004-20261125    gcc-10.5.0
arc                   randconfig-2005-20261125    gcc-10.5.0
arc                   randconfig-2200-20261125    gcc-14.4.0 smatch
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                   randconfig-2000-20261125    clang-17
arm                   randconfig-2000-20261125    clang-22
arm                   randconfig-2001-20261125    clang-22
arm                   randconfig-2002-20261125    clang-17
arm                   randconfig-2002-20261125    clang-22
arm                   randconfig-2200-20261125    clang-21   smatch
arm                  randconfig-r2104-20261125    gcc-16.2.0 cocci
arm                  randconfig-r2108-20261125    gcc-11.5.0 cocci
arm                         spear6xx_defconfig    gcc-16.2.0
arm64                             alldefconfig    gcc-16.2.0
arm64                              allnoconfig    gcc-16.2.0
arm64                 randconfig-2000-20261125    clang-22
arm64                 randconfig-2000-20261125    clang-24
arm64                 randconfig-2001-20261125    clang-22
arm64                 randconfig-2001-20261125    gcc-8.5.0
arm64                 randconfig-2002-20261125    clang-17
arm64                 randconfig-2002-20261125    clang-22
arm64                 randconfig-2200-20261125    gcc-13.5.0 smatch
arm64                 randconfig-2200-20261126    clang-24   smatch
arm64                randconfig-r2303-20261125    clang-17   sparse
arm64                randconfig-r2304-20261125    gcc-11.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                  randconfig-2000-20261125    gcc-14.4.0
csky                  randconfig-2001-20261125    gcc-14.4.0
csky                  randconfig-2200-20261125    gcc-16.2.0 smatch
csky                  randconfig-2200-20261126    gcc-13.5.0 smatch
csky                 randconfig-r2100-20261125    gcc-16.2.0 cocci
csky                 randconfig-r2102-20261125    gcc-14     cocci
csky                 randconfig-r2109-20261125    gcc-11.5.0 cocci
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon               randconfig-1000-20261126    gcc-11.5.0
hexagon               randconfig-1001-20261126    gcc-11.5.0
hexagon               randconfig-2000-20261125    gcc-14.4.0
hexagon               randconfig-2001-20261125    gcc-14.4.0
hexagon               randconfig-2200-20261125    clang-17   smatch
hexagon              randconfig-r2103-20261125    clang-20   cocci
hexagon              randconfig-r2107-20261125    gcc-14     cocci
hexagon              randconfig-r2300-20261125    clang-17   sparse
hexagon              randconfig-r2306-20261125    gcc-8.5.0  sparse
hexagon              randconfig-r2309-20261125    gcc-8.5.0  sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261126    gcc-14
i386        buildonly-randconfig-1001-20261126    gcc-14
i386        buildonly-randconfig-1002-20261126    gcc-14
i386        buildonly-randconfig-1003-20261126    gcc-14
i386        buildonly-randconfig-1004-20261126    gcc-14
i386        buildonly-randconfig-1005-20261126    gcc-14
i386                  randconfig-1000-20261126    clang-22
i386                  randconfig-1001-20261126    clang-22
i386                  randconfig-1002-20261126    clang-22
i386                  randconfig-1003-20261126    clang-22
i386                  randconfig-1004-20261126    clang-22
i386                  randconfig-1005-20261126    clang-22
i386                  randconfig-1006-20261126    clang-22
i386                  randconfig-2000-20261125    gcc-14
i386                  randconfig-2001-20261125    gcc-14
i386                  randconfig-2002-20261125    gcc-14
i386                  randconfig-2003-20261125    gcc-14
i386                  randconfig-2004-20261125    gcc-14
i386                  randconfig-2005-20261125    gcc-14
i386                  randconfig-2100-20261125    clang-22   cocci
i386                  randconfig-2101-20261125    clang-22   cocci
i386                  randconfig-2102-20261125    clang-22   cocci
i386                  randconfig-2103-20261125    clang-22   cocci
i386                  randconfig-2104-20261125    clang-22   cocci
i386                  randconfig-2105-20261125    clang-22   cocci
i386                  randconfig-2200-20261125    clang-22   smatch
i386                  randconfig-2300-20261125    clang-22   sparse
i386                  randconfig-2301-20261125    clang-22   sparse
i386                  randconfig-2302-20261125    clang-22   sparse
i386                 randconfig-r2106-20261125    gcc-14     cocci
i386                 randconfig-r2303-20261125    gcc-11.5.0 sparse
i386                 randconfig-r2304-20261125    gcc-8.5.0  sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    gcc-16.2.0
loongarch             randconfig-1000-20261126    gcc-11.5.0
loongarch             randconfig-1001-20261126    gcc-11.5.0
loongarch             randconfig-2000-20261125    clang-19
loongarch             randconfig-2001-20261125    clang-19
loongarch             randconfig-2200-20261125    clang-18   smatch
loongarch            randconfig-r2100-20261125    clang-20   cocci
loongarch            randconfig-r2102-20261125    gcc-16.2.0 cocci
loongarch            randconfig-r2107-20261125    clang-24   cocci
loongarch            randconfig-r2301-20261125    clang-17   sparse
loongarch            randconfig-r2307-20261126    gcc-10.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261125    gcc-8.5.0
m68k                  randconfig-2001-20261125    gcc-8.5.0
m68k                  randconfig-2200-20261125    gcc-15.3.0 smatch
m68k                 randconfig-r2108-20261125    gcc-16.2.0 cocci
m68k                 randconfig-r2110-20261125    gcc-11.5.0 cocci
m68k                 randconfig-r2302-20261125    clang-17   sparse
m68k                 randconfig-r2302-20261125    gcc-11.5.0 sparse
m68k                 randconfig-r2309-20261125    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze            randconfig-2000-20261125    gcc-8.5.0
microblaze            randconfig-2001-20261125    gcc-8.5.0
microblaze            randconfig-2200-20261125    gcc-8.5.0  smatch
microblaze            randconfig-2200-20261126    gcc-9.5.0  smatch
microblaze           randconfig-r2105-20261125    gcc-16.2.0 cocci
microblaze           randconfig-r2307-20261125    gcc-8.5.0  sparse
microblaze           randconfig-r2308-20261125    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                  randconfig-2000-20261125    gcc-14.4.0
mips                  randconfig-2000-20261125    gcc-16.2.0
mips                  randconfig-2001-20261125    clang-17
mips                  randconfig-2001-20261125    gcc-16.2.0
mips                  randconfig-2002-20261125    clang-24
mips                  randconfig-2002-20261125    gcc-16.2.0
mips                  randconfig-2200-20261125    clang-24   smatch
mips                 randconfig-r2104-20261125    gcc-14     cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                 randconfig-1000-20261126    gcc-11.5.0
nios2                 randconfig-1001-20261126    gcc-11.5.0
nios2                 randconfig-2000-20261125    clang-19
nios2                 randconfig-2001-20261125    clang-19
nios2                 randconfig-2200-20261125    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261126    gcc-9.5.0  smatch
nios2                randconfig-r2101-20261125    clang-20   cocci
nios2                randconfig-r2101-20261125    gcc-16.2.0 cocci
nios2                randconfig-r2103-20261125    gcc-14     cocci
nios2                randconfig-r2104-20261125    clang-20   cocci
nios2                randconfig-r2105-20261125    clang-20   cocci
nios2                randconfig-r2308-20261126    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2000-20261125    gcc-12.5.0
openrisc              randconfig-2000-20261125    gcc-16.2.0
openrisc              randconfig-2001-20261125    gcc-10.5.0
openrisc              randconfig-2001-20261125    gcc-16.2.0
openrisc              randconfig-2002-20261125    gcc-16.2.0
openrisc              randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc             randconfig-r2101-20261125    gcc-14     cocci
openrisc             randconfig-r2306-20261126    gcc-10.5.0 sparse
openrisc             randconfig-r2311-20261126    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-1000-20261126    gcc-13.5.0
parisc                randconfig-1001-20261126    gcc-13.5.0
parisc                randconfig-2000-20261125    clang-19
parisc                randconfig-2001-20261125    clang-19
parisc                randconfig-2200-20261125    gcc-12.5.0 smatch
parisc                randconfig-2200-20261126    gcc-15.3.0 smatch
parisc               randconfig-r2103-20261125    gcc-16.2.0 cocci
parisc               randconfig-r2110-20261125    gcc-14     cocci
parisc               randconfig-r2311-20261125    gcc-10.5.0 sparse
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                  mpc8315_rdb_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261126    gcc-13.5.0
powerpc               randconfig-1001-20261126    gcc-13.5.0
powerpc               randconfig-2000-20261125    gcc-9.5.0
powerpc               randconfig-2001-20261125    gcc-9.5.0
powerpc               randconfig-2002-20261125    gcc-9.5.0
powerpc               randconfig-2200-20261125    gcc-11.5.0 smatch
powerpc              randconfig-r2107-20261125    gcc-11.5.0 cocci
powerpc              randconfig-r2111-20261125    gcc-14     cocci
powerpc              randconfig-r2307-20261125    gcc-8.5.0  sparse
powerpc              randconfig-r2308-20261125    gcc-8.5.0  sparse
powerpc              randconfig-r2310-20261125    gcc-8.5.0  sparse
powerpc64             randconfig-1000-20261126    gcc-13.5.0
powerpc64             randconfig-1001-20261126    gcc-13.5.0
powerpc64             randconfig-2000-20261125    gcc-9.5.0
powerpc64             randconfig-2001-20261125    gcc-9.5.0
powerpc64             randconfig-2002-20261125    gcc-9.5.0
powerpc64             randconfig-2200-20261125    gcc-13.5.0 smatch
powerpc64            randconfig-r2303-20261125    gcc-8.5.0  sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1001-20261126    clang-20
riscv                 randconfig-2000-20261125    gcc-13.5.0
riscv                 randconfig-2000-20261126    gcc-10.5.0
riscv                 randconfig-2001-20261125    gcc-13.5.0
riscv                 randconfig-2001-20261125    gcc-8.5.0
riscv                 randconfig-2001-20261126    gcc-10.5.0
riscv                 randconfig-2002-20261125    gcc-13.5.0
riscv                 randconfig-2002-20261125    gcc-8.5.0
riscv                 randconfig-2002-20261126    gcc-10.5.0
riscv                 randconfig-2003-20261125    gcc-11.5.0
riscv                 randconfig-2003-20261125    gcc-13.5.0
riscv                 randconfig-2003-20261126    gcc-10.5.0
riscv                 randconfig-2004-20261125    gcc-13.5.0
riscv                 randconfig-2004-20261125    gcc-8.5.0
riscv                 randconfig-2004-20261126    gcc-10.5.0
riscv                 randconfig-2005-20261125    clang-24
riscv                 randconfig-2005-20261125    gcc-13.5.0
riscv                 randconfig-2005-20261126    gcc-10.5.0
riscv                 randconfig-2200-20261125    gcc-8.5.0  smatch
riscv                 randconfig-2200-20261126    gcc-8.5.0  smatch
riscv                randconfig-r2111-20261125    gcc-11.5.0 cocci
riscv                randconfig-r2300-20261125    gcc-8.5.0  sparse
riscv                randconfig-r2305-20261125    gcc-11.5.0 sparse
riscv                randconfig-r2311-20261125    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261126    clang-20
s390                  randconfig-1001-20261126    clang-20
s390                  randconfig-2000-20261125    clang-24
s390                  randconfig-2001-20261125    clang-24
s390                  randconfig-2002-20261125    clang-24
s390                  randconfig-2003-20261125    clang-24
s390                  randconfig-2004-20261125    clang-24
s390                  randconfig-2005-20261125    clang-24
s390                  randconfig-2200-20261125    gcc-15.3.0 smatch
s390                 randconfig-r2105-20261125    gcc-14     cocci
s390                 randconfig-r2106-20261125    gcc-11.5.0 cocci
s390                 randconfig-r2305-20261125    gcc-8.5.0  sparse
s390                 randconfig-r2306-20261125    gcc-8.5.0  sparse
s390                 randconfig-r2307-20261125    gcc-9.5.0  sparse
s390                 randconfig-r2310-20261125    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                           polaris_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261126    clang-20
sh                    randconfig-1001-20261126    clang-20
sh                    randconfig-2000-20261125    gcc-14.4.0
sh                    randconfig-2000-20261126    gcc-9.5.0
sh                    randconfig-2001-20261125    gcc-14.4.0
sh                    randconfig-2001-20261126    gcc-9.5.0
sh                    randconfig-2002-20261125    gcc-14.4.0
sh                    randconfig-2002-20261126    gcc-9.5.0
sh                    randconfig-2003-20261125    gcc-14.4.0
sh                    randconfig-2003-20261126    gcc-9.5.0
sh                    randconfig-2004-20261125    gcc-14.4.0
sh                    randconfig-2004-20261126    gcc-9.5.0
sh                    randconfig-2005-20261125    gcc-14.4.0
sh                    randconfig-2005-20261126    gcc-9.5.0
sh                    randconfig-2200-20261125    gcc-14.4.0 smatch
sh                   randconfig-r2110-20261125    gcc-11.5.0 cocci
sh                   randconfig-r2301-20261125    gcc-8.5.0  sparse
sh                   randconfig-r2304-20261125    clang-17   sparse
sh                   randconfig-r2305-20261125    clang-17   sparse
sh                   randconfig-r2308-20261125    gcc-14.4.0 sparse
sh                              shx3_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                 randconfig-2000-20261125    gcc-16.2.0
sparc                 randconfig-2000-20261125    gcc-8.5.0
sparc                 randconfig-2000-20261126    gcc-8.5.0
sparc                 randconfig-2001-20261125    gcc-16.2.0
sparc                 randconfig-2001-20261125    gcc-8.5.0
sparc                 randconfig-2001-20261126    gcc-8.5.0
sparc                 randconfig-2200-20261125    gcc-14.4.0 smatch
sparc                 randconfig-2200-20261126    gcc-13.5.0 smatch
sparc                randconfig-r2309-20261125    gcc-12.5.0 sparse
sparc                randconfig-r2310-20261125    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64               randconfig-2000-20261125    clang-24
sparc64               randconfig-2000-20261125    gcc-8.5.0
sparc64               randconfig-2000-20261126    gcc-8.5.0
sparc64               randconfig-2001-20261125    gcc-8.5.0
sparc64               randconfig-2001-20261126    gcc-8.5.0
sparc64               randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64               randconfig-2200-20261126    gcc-12.5.0 smatch
sparc64              randconfig-r2102-20261125    clang-20   cocci
sparc64              randconfig-r2109-20261125    gcc-15.3.0 cocci
sparc64              randconfig-r2111-20261125    clang-20   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                    randconfig-2000-20261125    clang-17
um                    randconfig-2000-20261125    gcc-8.5.0
um                    randconfig-2000-20261126    gcc-8.5.0
um                    randconfig-2001-20261125    clang-22
um                    randconfig-2001-20261125    gcc-8.5.0
um                    randconfig-2001-20261126    gcc-8.5.0
um                    randconfig-2200-20261125    clang-17   smatch
um                   randconfig-r2100-20261125    gcc-14     cocci
um                   randconfig-r2306-20261125    gcc-8.5.0  sparse
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                                   kexec    clang-22
x86_64                randconfig-2000-20261125    gcc-14
x86_64                randconfig-2001-20261125    gcc-14
x86_64                randconfig-2002-20261125    gcc-14
x86_64                randconfig-2003-20261125    gcc-14
x86_64                randconfig-2004-20261125    gcc-14
x86_64                randconfig-2005-20261125    gcc-14
x86_64                randconfig-2100-20261125    clang-22   cocci
x86_64                randconfig-2101-20261125    clang-22   cocci
x86_64                randconfig-2102-20261125    clang-22   cocci
x86_64                randconfig-2103-20261125    clang-22   cocci
x86_64                randconfig-2104-20261125    clang-22   cocci
x86_64                randconfig-2105-20261125    clang-22   cocci
x86_64                randconfig-2200-20261125    gcc-14     smatch
x86_64                randconfig-2300-20261125    clang-22   sparse
x86_64                randconfig-2301-20261125    clang-22   sparse
x86_64                randconfig-2302-20261125    clang-22   sparse
x86_64               randconfig-r2109-20261125    gcc-14     cocci
x86_64               randconfig-r2302-20261125    gcc-8.5.0  sparse
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
xtensa                randconfig-2000-20261125    gcc-14.4.0
xtensa                randconfig-2001-20261125    gcc-14.4.0
xtensa                randconfig-2200-20261125    gcc-16.2.0 smatch
xtensa               randconfig-r2108-20261125    gcc-14     cocci
xtensa               randconfig-r2301-20261125    gcc-11.5.0 sparse
xtensa               randconfig-r2309-20261126    gcc-10.5.0 sparse
xtensa               randconfig-r2311-20261125    gcc-8.5.0  sparse
xtensa                     xip_kc705_defconfig    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
