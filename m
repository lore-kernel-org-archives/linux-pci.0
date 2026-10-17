Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFA390CAE
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266629; cv=none; b=Gaau9pikNh13wc/g89ihyBdogAmmdVKGOTipEtk1gZSjew4af7SuHadhKTsxah8cQP1kh9gynjEZZxX8kNTK8Xobg1zMAfvGI98/voUJVNggROoxa9rAvRlcPn23YHE/MdKhiOV9AyxEV6Le2PXNhaU9ktHB4RU/ouv5OmIvbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266629; c=relaxed/simple;
	bh=2TsQz0gu70XpmKAlls6il+7rzYt4hKwMtusQMBwK1RE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XTIz53o2UWIx/x7dn4K2ZTN5xpfrSPpZN8lWNnuEVztc1j53UcE+XjUMksoM+HX29NALA0AYc2xygyeilnUIaRFIZGCYsgo3h2oslv6O92oAyGANiHo0TbtpXLfdSCo8cbe0r+TcuPprQTRKTZeAISs20aYvS1no99uJJFxX7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmXGk4LI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmXGk4LI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792266628; x=1823802628;
  h=date:from:to:cc:subject:message-id;
  bh=2TsQz0gu70XpmKAlls6il+7rzYt4hKwMtusQMBwK1RE=;
  b=PmXGk4LIHnE1bLwq9aOxz7iwre4dS2bU3jeWi0CZxQ6e9qqgBg8yGvJX
   DsLH2GPaXZiXEZny/9VcEjdtvkQytDH5ALwQ9cHdwUIYRQb4D1m99vH7o
   JV4LnqUcqf2gZFr0QQrx3CNSkklOiN4aX+9WPpXG1z+BBIs7jZ8K8Crhh
   5OkrvtTqRTVOqEjs7l+9UeLJz6pnbimTgFv+NS1E0z/2rg6CjULe6mERP
   Bwq1xHhqmhjNjKOEode1/dKnjlkG5FDApKpFRvUyIBCj60RyTIKbYlls+
   HQVDlhuSGSmJdB1hkU2VBvqcmJythk/pyINWPMZUu6O9tSdP2DR4BdZUD
   g==;
X-CSE-ConnectionGUID: B4sDgbX9RQGVqhX/99a/CA==
X-CSE-MsgGUID: 0G18mCqqThCGFGPioNSuxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="902454"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="902454"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:50:27 -0700
X-CSE-ConnectionGUID: njWD0twWRq63nxZStQ/Aww==
X-CSE-MsgGUID: I5aWS+EcRauaGTJrrMsMvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2614251"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Oct 2026 12:49:01 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIAOo-00000000Jgf-14RV;
	Sat, 17 Oct 2026 19:48:58 +0000
Date: Sun, 18 Oct 2026 03:48:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller:dwc-imx6] BUILD SUCCESS
 f845c1e2d2d4506802244ea2a378ae7b04e90bfe
Message-ID: <202610180317.H8QEvdNz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: f845c1e2d2d4506802244ea2a378ae7b04e90bfe  PCI: dwc: Add suspend_poweroff flag for platforms with RC power loss

elapsed time: 1815m

configs tested: 441
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261015    gcc-9.5.0  cocci
alpha                randconfig-r2103-20261015    gcc-9.5.0  cocci
alpha                randconfig-r2104-20261015    gcc-16.1.0 cocci
alpha                randconfig-r2202-20261015    gcc-12.5.0 smatch
alpha                randconfig-r2308-20261015    clang-22   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-2000-20261015    gcc-15.2.0
arc                   randconfig-2000-20261015    gcc-9.5.0
arc                   randconfig-2001-20261015    gcc-15.2.0
arc                  randconfig-r2101-20261015    clang-18   cocci
arc                  randconfig-r2104-20261015    gcc-14.3.0 cocci
arc                  randconfig-r2107-20261015    gcc-12.5.0 cocci
arc                  randconfig-r2107-20261015    gcc-16.1.0 cocci
arc                  randconfig-r2109-20261015    clang-24   cocci
arc                  randconfig-r2304-20261015    gcc-12.5.0 sparse
arc                  randconfig-r2306-20261015    gcc-16.1.0 sparse
arc                  randconfig-r2307-20261015    clang-24   sparse
arc                  randconfig-r2308-20261015    gcc-16.1.0 sparse
arc                  randconfig-r2310-20261015    clang-24   sparse
arc                         vdk_hs38_defconfig    gcc-16.1.0
arm                               alldefconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                        netwinder_defconfig    gcc-16.1.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-2000-20261015    gcc-11.5.0
arm                   randconfig-2000-20261015    gcc-15.2.0
arm                   randconfig-2001-20261015    gcc-15.2.0
arm                   randconfig-2001-20261015    gcc-8.5.0
arm                  randconfig-r2108-20261015    clang-24   cocci
arm                  randconfig-r2200-20261015    clang-18   smatch
arm                  randconfig-r2302-20261015    clang-19   sparse
arm                  randconfig-r2309-20261015    clang-22   sparse
arm                  randconfig-r2311-20261015    gcc-10.5.0 sparse
arm                          socfpga_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1000-20261018    gcc-14.3.0
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1001-20261018    gcc-14.3.0
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1002-20261018    gcc-14.3.0
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-1003-20261018    gcc-14.3.0
arm64                 randconfig-2000-20261015    clang-17
arm64                 randconfig-2000-20261015    gcc-16.1.0
arm64                 randconfig-2001-20261015    clang-17
arm64                 randconfig-2001-20261015    gcc-16.1.0
arm64                randconfig-r2107-20261015    clang-17   cocci
arm64                randconfig-r2303-20261015    clang-17   sparse
arm64                randconfig-r2311-20261015    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1000-20261018    gcc-14.3.0
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-1001-20261018    gcc-14.3.0
csky                  randconfig-2000-20261015    gcc-13.4.0
csky                  randconfig-2000-20261015    gcc-16.1.0
csky                  randconfig-2001-20261015    gcc-16.1.0
csky                 randconfig-r2109-20261015    gcc-9.5.0  cocci
csky                 randconfig-r2110-20261015    gcc-16.1.0 cocci
csky                 randconfig-r2300-20261015    clang-17   sparse
csky                 randconfig-r2300-20261015    gcc-10.5.0 sparse
csky                 randconfig-r2301-20261015    gcc-12.5.0 sparse
csky                 randconfig-r2303-20261015    clang-24   sparse
csky                 randconfig-r2303-20261015    gcc-12.5.0 sparse
csky                 randconfig-r2307-20261015    gcc-16.1.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1000-20261018    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-1001-20261018    clang-21
hexagon               randconfig-2000-20261015    clang-19
hexagon               randconfig-2000-20261015    gcc-16.1.0
hexagon               randconfig-2001-20261015    clang-24
hexagon               randconfig-2001-20261015    gcc-16.1.0
hexagon              randconfig-r2200-20261015    clang-24   smatch
hexagon              randconfig-r2202-20261015    clang-24   smatch
hexagon              randconfig-r2302-20261015    clang-24   sparse
hexagon              randconfig-r2305-20261015    clang-17   sparse
hexagon              randconfig-r2305-20261015    gcc-16.1.0 sparse
hexagon              randconfig-r2306-20261015    clang-24   sparse
hexagon              randconfig-r2308-20261015    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1005-20261017    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261017    clang-22
i386                  randconfig-1001-20261017    clang-22
i386                  randconfig-1002-20261017    clang-22
i386                  randconfig-1003-20261017    clang-22
i386                  randconfig-1004-20261017    clang-22
i386                  randconfig-1005-20261017    clang-22
i386                  randconfig-1006-20261017    clang-22
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-2000-20261015    clang-22
i386                  randconfig-2000-20261015    gcc-15.2.0
i386                  randconfig-2001-20261015    clang-22
i386                  randconfig-2001-20261015    gcc-15.2.0
i386                  randconfig-2100-20261015    gcc-14     cocci
i386                  randconfig-2101-20261015    gcc-14     cocci
i386                  randconfig-2102-20261015    gcc-14     cocci
i386                  randconfig-2103-20261015    gcc-12     cocci
i386                  randconfig-2103-20261015    gcc-14     cocci
i386                  randconfig-2104-20261015    gcc-14     cocci
i386                  randconfig-2105-20261015    gcc-14     cocci
i386                  randconfig-2200-20261015    clang-22   smatch
i386                  randconfig-2300-20261015    clang-22   sparse
i386                  randconfig-2300-20261015    gcc-14     sparse
i386                  randconfig-2301-20261015    gcc-14     sparse
i386                  randconfig-2302-20261015    gcc-14     sparse
i386                 randconfig-r2101-20261015    clang-22   cocci
i386                 randconfig-r2308-20261015    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1000-20261018    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-1001-20261018    clang-21
loongarch             randconfig-2000-20261015    clang-24
loongarch             randconfig-2000-20261015    gcc-8.5.0
loongarch             randconfig-2001-20261015    gcc-16.1.0
loongarch             randconfig-2001-20261015    gcc-8.5.0
loongarch            randconfig-r2102-20261015    clang-18   cocci
loongarch            randconfig-r2105-20261015    gcc-16.1.0 cocci
loongarch            randconfig-r2108-20261015    clang-24   cocci
loongarch            randconfig-r2300-20261015    gcc-16.1.0 sparse
loongarch            randconfig-r2305-20261015    clang-17   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2102-20261015    gcc-8.5.0  cocci
m68k                 randconfig-r2103-20261015    clang-24   cocci
m68k                 randconfig-r2302-20261015    clang-17   sparse
m68k                 randconfig-r2306-20261015    clang-24   sparse
m68k                 randconfig-r2307-20261015    clang-22   sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2100-20261015    clang-18   cocci
microblaze           randconfig-r2301-20261015    clang-17   sparse
microblaze           randconfig-r2306-20261015    clang-22   sparse
microblaze           randconfig-r2309-20261015    clang-24   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    clang-24
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                            ip30_defconfig    clang-24
mips                      loongson2k_defconfig    clang-24
mips                 randconfig-r2100-20261015    clang-24   cocci
mips                 randconfig-r2101-20261015    clang-24   cocci
mips                    sb1250_swarm_defconfig    clang-24
mips                    sb1250_swarm_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1000-20261018    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-1001-20261018    clang-21
nios2                 randconfig-2000-20261015    gcc-8.5.0
nios2                 randconfig-2001-20261015    gcc-8.5.0
nios2                randconfig-r2310-20261015    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2105-20261015    gcc-12.5.0 cocci
openrisc             randconfig-r2300-20261015    clang-24   sparse
openrisc             randconfig-r2301-20261015    gcc-16.1.0 sparse
openrisc             randconfig-r2306-20261015    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-1001-20261018    clang-24
parisc                randconfig-2000-20261015    gcc-11.5.0
parisc                randconfig-2000-20261015    gcc-8.5.0
parisc                randconfig-2001-20261015    gcc-8.5.0
parisc               randconfig-r2201-20261015    gcc-11.5.0 smatch
parisc               randconfig-r2303-20261015    clang-17   sparse
parisc               randconfig-r2303-20261015    gcc-16.1.0 sparse
parisc               randconfig-r2304-20261015    clang-24   sparse
parisc               randconfig-r2311-20261015    clang-22   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261018    clang-24
powerpc               randconfig-2000-20261015    clang-22
powerpc               randconfig-2001-20261015    clang-22
powerpc              randconfig-r2105-20261015    gcc-12.5.0 cocci
powerpc              randconfig-r2106-20261015    clang-24   cocci
powerpc              randconfig-r2108-20261015    clang-18   cocci
powerpc              randconfig-r2111-20261015    gcc-12.5.0 cocci
powerpc              randconfig-r2200-20261015    clang-24   smatch
powerpc              randconfig-r2307-20261015    gcc-10.5.0 sparse
powerpc              randconfig-r2311-20261015    clang-24   sparse
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261018    clang-24
powerpc64             randconfig-2000-20261015    clang-22
powerpc64             randconfig-2001-20261015    clang-22
powerpc64            randconfig-r2103-20261015    clang-18   cocci
powerpc64            randconfig-r2104-20261015    gcc-12.5.0 cocci
powerpc64            randconfig-r2106-20261015    clang-19   cocci
powerpc64            randconfig-r2110-20261015    gcc-12.5.0 cocci
powerpc64            randconfig-r2304-20261015    clang-17   sparse
powerpc64            randconfig-r2305-20261015    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-1001-20261018    clang-17
riscv                 randconfig-2000-20261015    gcc-8.5.0
riscv                 randconfig-2000-20261015    gcc-9.5.0
riscv                 randconfig-2001-20261015    clang-24
riscv                 randconfig-2001-20261015    gcc-9.5.0
riscv                randconfig-r2107-20261015    clang-24   cocci
riscv                randconfig-r2110-20261015    clang-24   cocci
riscv                randconfig-r2200-20261015    clang-17   smatch
riscv                randconfig-r2301-20261015    clang-24   sparse
riscv                randconfig-r2302-20261015    clang-17   sparse
riscv                randconfig-r2305-20261015    gcc-10.5.0 sparse
riscv                randconfig-r2310-20261015    clang-22   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-1001-20261018    clang-17
s390                  randconfig-2000-20261015    clang-24
s390                  randconfig-2000-20261015    gcc-9.5.0
s390                  randconfig-2001-20261015    gcc-14.3.0
s390                  randconfig-2001-20261015    gcc-9.5.0
s390                 randconfig-r2102-20261015    gcc-9.5.0  cocci
s390                 randconfig-r2105-20261015    clang-24   cocci
s390                 randconfig-r2109-20261015    clang-24   cocci
s390                 randconfig-r2110-20261015    gcc-8.5.0  cocci
s390                 randconfig-r2111-20261015    gcc-8.5.0  cocci
s390                 randconfig-r2201-20261015    gcc-8.5.0  smatch
s390                 randconfig-r2301-20261015    clang-17   sparse
s390                 randconfig-r2304-20261015    clang-17   sparse
s390                 randconfig-r2310-20261015    gcc-16.1.0 sparse
s390                        zfcpdump_defconfig    gcc-16.1.0
sh                                alldefconfig    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                           lboxre2_defconfig    gcc-16.1.0
sh                             migor_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-1001-20261018    clang-17
sh                    randconfig-2000-20261015    gcc-9.5.0
sh                    randconfig-2001-20261015    gcc-15.2.0
sh                    randconfig-2001-20261015    gcc-9.5.0
sh                   randconfig-r2103-20261015    gcc-11.5.0 cocci
sh                   randconfig-r2106-20261015    gcc-12.5.0 cocci
sh                   randconfig-r2106-20261015    gcc-16.1.0 cocci
sh                   randconfig-r2108-20261015    gcc-9.5.0  cocci
sh                   randconfig-r2201-20261015    gcc-10.5.0 smatch
sh                   randconfig-r2309-20261015    clang-24   sparse
sh                           rsk7264_defconfig    gcc-16.1.0
sh                           rsk7269_defconfig    clang-24
sh                            sh2007_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1000-20261018    clang-24
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261018    clang-24
sparc                 randconfig-2000-20261015    gcc-13.4.0
sparc                 randconfig-2000-20261015    gcc-15.2.0
sparc                 randconfig-2001-20261015    gcc-15.2.0
sparc                randconfig-r2104-20261015    clang-24   cocci
sparc                randconfig-r2310-20261015    clang-24   sparse
sparc                        sparc32_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1000-20261018    clang-24
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261018    clang-24
sparc64               randconfig-2000-20261015    clang-20
sparc64               randconfig-2000-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261015    gcc-8.5.0
sparc64              randconfig-r2101-20261015    gcc-9.5.0  cocci
sparc64              randconfig-r2102-20261015    clang-24   cocci
sparc64              randconfig-r2111-20261015    clang-24   cocci
sparc64              randconfig-r2202-20261015    gcc-9.5.0  smatch
sparc64              randconfig-r2302-20261015    gcc-16.1.0 sparse
sparc64              randconfig-r2307-20261015    clang-24   sparse
sparc64              randconfig-r2311-20261015    gcc-16.1.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1000-20261018    clang-24
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-1001-20261018    clang-24
um                    randconfig-2000-20261015    clang-24
um                    randconfig-2000-20261015    gcc-15.2.0
um                    randconfig-2001-20261015    gcc-14
um                    randconfig-2001-20261015    gcc-15.2.0
um                   randconfig-r2100-20261015    gcc-14     cocci
um                   randconfig-r2109-20261015    clang-18   cocci
um                   randconfig-r2201-20261015    clang-18   smatch
um                   randconfig-r2300-20261015    clang-17   sparse
um                   randconfig-r2304-20261015    gcc-16.1.0 sparse
um                   randconfig-r2309-20261015    clang-17   sparse
um                   randconfig-r2309-20261015    gcc-16.1.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261017    gcc-14
x86_64      buildonly-randconfig-1001-20261017    gcc-14
x86_64      buildonly-randconfig-1002-20261017    gcc-14
x86_64      buildonly-randconfig-1003-20261017    gcc-14
x86_64      buildonly-randconfig-1004-20261017    gcc-14
x86_64      buildonly-randconfig-1005-20261017    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261017    gcc-14
x86_64                randconfig-1001-20261017    gcc-14
x86_64                randconfig-1002-20261017    gcc-14
x86_64                randconfig-1003-20261017    gcc-14
x86_64                randconfig-1004-20261017    gcc-14
x86_64                randconfig-1005-20261017    gcc-14
x86_64                randconfig-1006-20261017    clang-22
x86_64                randconfig-1007-20261017    clang-22
x86_64                randconfig-1008-20261017    clang-22
x86_64                randconfig-1009-20261017    clang-22
x86_64                randconfig-1010-20261017    clang-22
x86_64                randconfig-1011-20261017    clang-22
x86_64                randconfig-1012-20261017    clang-22
x86_64                randconfig-1013-20261017    clang-22
x86_64                randconfig-1014-20261017    clang-22
x86_64                randconfig-1015-20261017    clang-22
x86_64                randconfig-1016-20261017    clang-22
x86_64                randconfig-1017-20261017    clang-22
x86_64                randconfig-2000-20261015    clang-22
x86_64                randconfig-2001-20261015    clang-22
x86_64                randconfig-2100-20261015    clang-22   cocci
x86_64                randconfig-2101-20261015    clang-22   cocci
x86_64                randconfig-2102-20261015    clang-22   cocci
x86_64                randconfig-2103-20261015    clang-22   cocci
x86_64                randconfig-2104-20261015    clang-22   cocci
x86_64                randconfig-2105-20261015    clang-22   cocci
x86_64                randconfig-2200-20261015    clang-22   smatch
x86_64                randconfig-2300-20261015    clang-22   sparse
x86_64                randconfig-2300-20261015    gcc-14     sparse
x86_64                randconfig-2301-20261015    clang-22   sparse
x86_64                randconfig-2301-20261015    gcc-14     sparse
x86_64                randconfig-2302-20261015    gcc-12     sparse
x86_64                randconfig-2302-20261015    gcc-14     sparse
x86_64               randconfig-r2200-20261015    clang-22   smatch
x86_64               randconfig-r2308-20261015    clang-22   sparse
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
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1000-20261018    clang-24
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261018    clang-24
xtensa                randconfig-2000-20261015    gcc-11.5.0
xtensa                randconfig-2000-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261015    gcc-8.5.0
xtensa               randconfig-r2111-20261015    gcc-16.1.0 cocci
xtensa               randconfig-r2202-20261015    gcc-11.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
